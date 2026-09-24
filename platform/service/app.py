#!/usr/bin/env python3
"""خدمة منصة الأندلس: مسارات القراءة v1.2 + خاصية المراجعة بالعين بالدخول والصلاحيات.

بايثون قياسي فقط. التشغيل:
  python platform/service/app.py serve --db platform/db/andalus.sqlite --port 8787
  python platform/service/app.py create-user --db … --username othman --name "عثمان الشهري" --role owner --password …
  python platform/service/app.py create-user --db … --username sara --name "سارة" --role reviewer --password …

الصلاحيات (spec/review/README.md):
- أي مستخدم مسجّل: POST /api/v1/reviewers/me (بيانات المراجع).
- صاحب المشروع (role=owner) وحده: POST /api/v1/reviewers/{id}/approval {approved, note_ar}.
- المراجع المعتمد وقت الحكم وحده: PUT/DELETE /api/v1/attestations/{id}/reviews/me {verdict, note_ar}
  (403 لغير المعتمد، 422 لحكم بفرق أو عدم مطابقة بلا ملاحظة).
- عند بلوغ الشاهد «معتمد بالعين» يُكتب في attestations.verbatim_check «مطابق بالعين: <المراجعان وتخصصاهما>، <التاريخ>»،
  وتُحفظ القيمة السابقة في attestation_verbatim_history وتُستعاد إذا زالت الحالة (سحب اعتماد أو حكم مخالف).
"""
from __future__ import annotations
import argparse, hashlib, importlib.util, json, os, secrets, sqlite3, sys
from datetime import datetime, timedelta, timezone
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from urllib.parse import urlparse, parse_qs

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, "..", ".."))
SPEC = os.path.join(ROOT, "andalus_handoff", "spec")
STATIC = os.path.join(HERE, "static")
VERDICTS = ("مطابق", "مطابق بفرق يسير", "غير مطابق")
EYE_LABEL = "مطابق بالعين"
NEEDS_EYE_SQL = ("(verbatim_check LIKE '%WebFetch%' OR verbatim_check LIKE '%صورة%' OR verbatim_check LIKE '%OCR%' "
                 "OR verbatim_check LIKE '%PDF%' OR verbatim_check LIKE '%بصري%' OR verbatim_check LIKE 'مطابق بالعين%')")


def _load(name, path):
    spec = importlib.util.spec_from_file_location(name, path)
    mod = importlib.util.module_from_spec(spec); spec.loader.exec_module(mod); return mod


base_api = _load("reference_api_v1_2", os.path.join(SPEC, "reference_api_v1_2.py"))
review_api = _load("reference_review_api", os.path.join(SPEC, "review", "reference_review_api.py"))


def now_iso():
    """طابع زمني بدقة الميكروثانية حتى يبقى ترتيب الاعتماد والحكم والسحب صارمًا في الفحوص"""
    return datetime.now(timezone.utc).isoformat(timespec="microseconds").replace("+00:00", "Z")


def connect(path):
    con = sqlite3.connect(path); con.row_factory = sqlite3.Row; con.execute("PRAGMA foreign_keys=ON"); return con


def rows(con, sql, p=()):
    return [dict(r) for r in con.execute(sql, p)]


def one(con, sql, p=()):
    r = con.execute(sql, p).fetchone(); return dict(r) if r else None


# ---------------------------------------------------------------- المستخدمون والجلسات
def hash_password(pw, salt=None):
    salt = salt or secrets.token_hex(16)
    h = hashlib.pbkdf2_hmac("sha256", pw.encode("utf-8"), bytes.fromhex(salt), 120_000).hex()
    return salt, h


def create_user(con, username, display_name, role, password):
    if role not in ("owner", "reviewer"):
        raise ValueError("role must be owner|reviewer")
    salt, h = hash_password(password)
    uid = "usr:" + hashlib.sha1(username.encode()).hexdigest()[:12]
    con.execute("""INSERT INTO platform_users(user_id,username,display_name,role,password_salt,password_hash,created_at,active)
                   VALUES(?,?,?,?,?,?,?,1) ON CONFLICT(username) DO UPDATE SET display_name=excluded.display_name, role=excluded.role,
                   password_salt=excluded.password_salt, password_hash=excluded.password_hash, active=1""",
                (uid, username, display_name, role, salt, h, now_iso()))
    con.commit(); return uid


def login(con, username, password):
    u = one(con, "SELECT * FROM platform_users WHERE username=? AND active=1", (username,))
    if not u: return None
    _, h = hash_password(password, u["password_salt"])
    if not secrets.compare_digest(h, u["password_hash"]): return None
    tok = secrets.token_urlsafe(32)
    exp = (datetime.now(timezone.utc) + timedelta(days=30)).isoformat(timespec="microseconds").replace("+00:00", "Z")
    con.execute("INSERT INTO platform_sessions(token,user_id,created_at,expires_at) VALUES(?,?,?,?)", (tok, u["user_id"], now_iso(), exp))
    con.commit(); return {"token": tok, "user": public_user(u)}


def public_user(u):
    return {"user_id": u["user_id"], "username": u["username"], "display_name": u["display_name"], "role": u["role"]}


def current_user(con, headers):
    auth = headers.get("Authorization", "")
    if not auth.startswith("Bearer "): return None
    s = one(con, "SELECT s.*, u.username, u.display_name, u.role, u.active FROM platform_sessions s JOIN platform_users u USING(user_id) WHERE token=?",
            (auth[7:].strip(),))
    if not s or not s["active"] or s["expires_at"] < now_iso(): return None
    return s


# ---------------------------------------------------------------- منطق المراجعة
def reviewer_approved(con, reviewer_id):
    r = one(con, "SELECT approved FROM v_reviewer_current WHERE reviewer_id=?", (reviewer_id,))
    return bool(r and r["approved"] == 1)


def sync_verbatim(con, att_ids, when=None):
    """يكتب أو يستعيد وصف «مطابق بالعين» بحسب الحالة المحسوبة من العرض v_attestation_review_status."""
    when = when or now_iso(); changed = []
    for att in set(att_ids):
        st = one(con, "SELECT review_status FROM v_attestation_review_status WHERE attestation_id=?", (att,))
        cur = one(con, "SELECT verbatim_check FROM attestations WHERE attestation_id=?", (att,))
        if not st or not cur: continue
        vc = cur["verbatim_check"] or ""
        if st["review_status"] == "معتمد بالعين":
            if not vc.startswith(EYE_LABEL):
                names = rows(con, """SELECT c.full_name, c.field FROM attestation_reviews r JOIN v_reviewer_current c USING(reviewer_id)
                                     WHERE r.attestation_id=? AND c.approved=1 AND r.verdict='مطابق' ORDER BY r.reviewed_at""", (att,))
                label = f"{EYE_LABEL}: " + "، ".join(f'{n["full_name"]} ({n["field"]})' for n in names) + f"، {when[:10]}"
                con.execute("INSERT OR REPLACE INTO attestation_verbatim_history(attestation_id,previous_verbatim_check,written_verbatim_check,changed_at) VALUES(?,?,?,?)",
                            (att, vc, label, when))
                con.execute("UPDATE attestations SET verbatim_check=? WHERE attestation_id=?", (label, att))
                changed.append((att, "labelled"))
        elif vc.startswith(EYE_LABEL):
            h = one(con, "SELECT * FROM attestation_verbatim_history WHERE attestation_id=? AND restored_at IS NULL ORDER BY changed_at DESC LIMIT 1", (att,))
            prev = h["previous_verbatim_check"] if h else "لم أتحقق"
            con.execute("UPDATE attestations SET verbatim_check=? WHERE attestation_id=?", (prev, att))
            if h: con.execute("UPDATE attestation_verbatim_history SET restored_at=? WHERE attestation_id=? AND changed_at=?", (when, att, h["changed_at"]))
            changed.append((att, "restored"))
    return changed


def set_review(con, user, att_id, verdict, note):
    rid = user["user_id"]
    if not one(con, "SELECT 1 FROM attestations WHERE attestation_id=?", (att_id,)): return 404, {"error": "attestation_not_found"}
    if not one(con, "SELECT 1 FROM reviewers WHERE reviewer_id=?", (rid,)): return 403, {"error": "reviewer_not_registered", "message_ar": "سجّل بيانات المراجع أولًا"}
    if not reviewer_approved(con, rid): return 403, {"error": "reviewer_not_approved", "message_ar": "لا يحكم إلا مراجع معتمد من صاحب المشروع"}
    if verdict not in VERDICTS: return 422, {"error": "bad_verdict", "allowed": list(VERDICTS)}
    if verdict != "مطابق" and not (note or "").strip(): return 422, {"error": "note_required", "message_ar": "الحكم بفرق أو بعدم المطابقة يلزمه ملاحظة فيها الفرق أو النص الصحيح وموضعه"}
    when = now_iso()
    con.execute("""INSERT INTO attestation_reviews(attestation_id,reviewer_id,verdict,note_ar,reviewed_at,source) VALUES(?,?,?,?,?,'platform')
                   ON CONFLICT(attestation_id,reviewer_id) DO UPDATE SET verdict=excluded.verdict, note_ar=excluded.note_ar, reviewed_at=excluded.reviewed_at, source='platform'""",
                (att_id, rid, verdict, (note or "").strip() or None, when))
    sync_verbatim(con, [att_id], when); con.commit()
    return 200, attestation_reviews(con, att_id, user)


def delete_review(con, user, att_id):
    n = con.execute("DELETE FROM attestation_reviews WHERE attestation_id=? AND reviewer_id=?", (att_id, user["user_id"])).rowcount
    sync_verbatim(con, [att_id]); con.commit()
    return (200, attestation_reviews(con, att_id, user)) if n else (404, {"error": "review_not_found"})


def upsert_profile(con, user, body):
    name = (body.get("full_name") or user["display_name"] or "").strip(); field = (body.get("field") or "").strip()
    if not name or not field: return 422, {"error": "name_and_field_required", "message_ar": "الاسم والتخصص إلزاميان"}
    con.execute("""INSERT INTO reviewers(reviewer_id,source,full_name,degree,field,org,langs,declaration,registered_at) VALUES(?,'platform',?,?,?,?,?,?,?)
                   ON CONFLICT(reviewer_id) DO UPDATE SET full_name=excluded.full_name, degree=excluded.degree, field=excluded.field, org=excluded.org,
                   langs=excluded.langs, declaration=COALESCE(excluded.declaration, reviewers.declaration)""",
                (user["user_id"], name, body.get("degree"), field, body.get("org"), body.get("langs"), body.get("declaration"), now_iso()))
    con.commit(); return 200, me(con, user)


def set_approval(con, owner, reviewer_id, approved, note):
    if not one(con, "SELECT 1 FROM reviewers WHERE reviewer_id=?", (reviewer_id,)): return 404, {"error": "reviewer_not_found"}
    when = now_iso()
    con.execute("INSERT INTO reviewer_approvals(reviewer_id,approved,decided_by,decided_at,note_ar) VALUES(?,?,?,?,?)",
                (reviewer_id, 1 if approved else 0, owner["display_name"], when, note))
    atts = [r["attestation_id"] for r in rows(con, "SELECT attestation_id FROM attestation_reviews WHERE reviewer_id=?", (reviewer_id,))]
    sync_verbatim(con, atts, when); con.commit()
    return 200, one(con, "SELECT * FROM v_reviewer_current WHERE reviewer_id=?", (reviewer_id,))


def me(con, user):
    d = {"user": public_user(user), "profile": one(con, "SELECT * FROM v_reviewer_current WHERE reviewer_id=?", (user["user_id"],))}
    d["approved"] = bool(d["profile"] and d["profile"]["approved"] == 1)
    d["my_reviews"] = {r["attestation_id"]: {"verdict": r["verdict"], "note_ar": r["note_ar"], "reviewed_at": r["reviewed_at"]}
                       for r in rows(con, "SELECT * FROM attestation_reviews WHERE reviewer_id=?", (user["user_id"],))}
    return d


def attestation_reviews(con, att_id, user=None):
    st, d = review_api.dispatch(con, f"/api/v1/attestations/{att_id}/reviews", {})
    if st == 200 and user:
        d["mine"] = one(con, "SELECT verdict, note_ar, reviewed_at FROM attestation_reviews WHERE attestation_id=? AND reviewer_id=?", (att_id, user["user_id"]))
        d["verbatim_check"] = one(con, "SELECT verbatim_check FROM attestations WHERE attestation_id=?", (att_id,))["verbatim_check"]
    return d


def queue(con, q, user=None):
    sql = f"""SELECT t.attestation_id, t.assertion_id, t.source_id, t.locator, t.quote, t.stance, t.verbatim_check, t.note_ar, t.url, t.source_kind,
                     a.kind, a.value_ar, a.target_id, s.label AS source_label, st.review_status, st.n_ok, st.n_minor, st.n_bad
              FROM attestations t JOIN assertions a USING(assertion_id) JOIN sources s USING(source_id)
              JOIN v_attestation_review_status st USING(attestation_id) WHERE {NEEDS_EYE_SQL}"""
    p = []
    if q.get("status"): sql += " AND st.review_status=?"; p.append(q["status"][0])
    sql += " ORDER BY t.attestation_id"
    items = rows(con, sql, p)
    mine = {}
    if user:
        mine = {r["attestation_id"]: r for r in rows(con, "SELECT attestation_id, verdict, note_ar FROM attestation_reviews WHERE reviewer_id=?", (user["user_id"],))}
    for it in items:
        it["method"] = "img" if "صورة" in (it["verbatim_check"] or "") or "بصري" in (it["verbatim_check"] or "") else "ocr" if "OCR" in (it["verbatim_check"] or "") else "web"
        it["mine"] = mine.get(it["attestation_id"])
        it["reviews"] = rows(con, """SELECT r.verdict, r.note_ar, r.reviewed_at, c.full_name, c.field FROM attestation_reviews r JOIN v_reviewer_current c USING(reviewer_id)
                                     WHERE r.attestation_id=? AND c.approved=1 ORDER BY r.reviewed_at""", (it["attestation_id"],))
    return 200, items


def admin_reviewers(con):
    return 200, rows(con, """SELECT c.*, u.username, (SELECT COUNT(*) FROM attestation_reviews r WHERE r.reviewer_id=c.reviewer_id) AS review_count,
                             (SELECT decided_at FROM reviewer_approvals a WHERE a.reviewer_id=c.reviewer_id ORDER BY decided_at DESC, approval_id DESC LIMIT 1) AS last_decision_at
                             FROM v_reviewer_current c LEFT JOIN platform_users u ON u.user_id=c.reviewer_id ORDER BY c.full_name""")


# ---------------------------------------------------------------- التوجيه
def dispatch(con, method, path, q, headers, body):
    p = [x for x in path.split("/") if x]
    user = current_user(con, headers)
    if p[:2] != ["api", "v1"]:
        return 404, {"error": "not_found"}
    r = p[2:]
    if method == "POST" and r == ["auth", "login"]:
        d = login(con, (body.get("username") or "").strip(), body.get("password") or "")
        return (200, d) if d else (401, {"error": "bad_credentials"})
    if method == "POST" and r == ["auth", "logout"]:
        if user: con.execute("DELETE FROM platform_sessions WHERE token=?", (user["token"],)); con.commit()
        return 200, {"ok": True}
    if r == ["auth", "me"]:
        return (200, me(con, user)) if user else (401, {"error": "unauthenticated"})
    if r == ["reviews", "queue"] and method == "GET":
        return queue(con, q, user)
    if method == "POST" and r == ["reviewers", "me"]:
        if not user: return 401, {"error": "unauthenticated"}
        return upsert_profile(con, user, body)
    if method == "GET" and r == ["reviewers", "all"]:
        if not user or user["role"] != "owner": return 403, {"error": "owner_only"}
        return admin_reviewers(con)
    if method == "POST" and len(r) == 3 and r[0] == "reviewers" and r[2] == "approval":
        if not user: return 401, {"error": "unauthenticated"}
        if user["role"] != "owner": return 403, {"error": "owner_only", "message_ar": "صاحب المشروع وحده يعتمد المراجعين"}
        return set_approval(con, user, r[1], bool(body.get("approved")), body.get("note_ar"))
    if len(r) == 4 and r[0] == "attestations" and r[2] == "reviews" and r[3] == "me":
        if not user: return 401, {"error": "unauthenticated"}
        if method == "PUT": return set_review(con, user, r[1], body.get("verdict"), body.get("note_ar"))
        if method == "DELETE": return delete_review(con, user, r[1])
        return 405, {"error": "method_not_allowed"}
    if method == "GET" and len(r) == 3 and r[0] == "attestations" and r[2] == "reviews":
        d = attestation_reviews(con, r[1], user); return (200, d) if "error" not in d else (404, d)
    if method == "GET":
        return review_api.dispatch(con, path, q)
    return 405, {"error": "method_not_allowed"}


class Handler(BaseHTTPRequestHandler):
    db_path = None

    def _send(self, st, data, ctype="application/json; charset=utf-8"):
        body = data if isinstance(data, bytes) else json.dumps(data, ensure_ascii=False, indent=2).encode()
        self.send_response(st); self.send_header("Content-Type", ctype); self.send_header("Content-Length", str(len(body)))
        self.send_header("Cache-Control", "no-store"); self.end_headers(); self.wfile.write(body)

    def _handle(self, method):
        u = urlparse(self.path)
        if u.path in ("/", "/review", "/review/"):
            with open(os.path.join(STATIC, "review.html"), "rb") as f: return self._send(200, f.read(), "text/html; charset=utf-8")
        body = {}
        n = int(self.headers.get("Content-Length") or 0)
        if n:
            try: body = json.loads(self.rfile.read(n).decode("utf-8") or "{}")
            except json.JSONDecodeError: return self._send(400, {"error": "bad_json"})
        con = connect(self.db_path)
        try: st, data = dispatch(con, method, u.path, parse_qs(u.query), self.headers, body)
        finally: con.close()
        self._send(st, data)

    def do_GET(self): self._handle("GET")
    def do_POST(self): self._handle("POST")
    def do_PUT(self): self._handle("PUT")
    def do_DELETE(self): self._handle("DELETE")
    def log_message(self, *a): pass


def make_server(db_path, host="127.0.0.1", port=8787):
    Handler.db_path = db_path
    return ThreadingHTTPServer((host, port), Handler)


def main():
    ap = argparse.ArgumentParser(); sub = ap.add_subparsers(dest="cmd", required=True)
    s = sub.add_parser("serve"); s.add_argument("--db", required=True); s.add_argument("--port", type=int, default=8787); s.add_argument("--host", default="127.0.0.1")
    c = sub.add_parser("create-user"); c.add_argument("--db", required=True); c.add_argument("--username", required=True); c.add_argument("--name", required=True)
    c.add_argument("--role", choices=["owner", "reviewer"], required=True); c.add_argument("--password", required=True)
    a = ap.parse_args()
    if a.cmd == "create-user":
        con = connect(a.db); uid = create_user(con, a.username, a.name, a.role, a.password); print(json.dumps({"user_id": uid, "role": a.role}, ensure_ascii=False)); return
    srv = make_server(a.db, a.host, a.port)
    print(f"http://{a.host}:{a.port}/review"); srv.serve_forever()


if __name__ == "__main__":
    main()
