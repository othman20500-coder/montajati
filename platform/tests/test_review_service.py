"""اختبارات خاصية المراجعة بالعين في خدمة المنصة: الدخول، الصلاحيات، الأحكام، حساب الحالة، الشارة، وسحب الاعتماد."""
import importlib.util, json, os, shutil, sqlite3, subprocess, sys, tempfile, threading, unittest, urllib.request, urllib.error, warnings

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
APP = os.path.join(ROOT, "platform", "service", "app.py")
DB0 = os.path.join(ROOT, "platform", "db", "andalus.sqlite")
QA = os.path.join(ROOT, "andalus_handoff", "tests", "andalus_review_qa.py")


def load_app():
    spec = importlib.util.spec_from_file_location("andalus_app", APP)
    mod = importlib.util.module_from_spec(spec); spec.loader.exec_module(mod); return mod


class ReviewService(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        warnings.simplefilter("ignore", ResourceWarning)
        cls.tmp = tempfile.mkdtemp(); cls.db = os.path.join(cls.tmp, "t.sqlite"); shutil.copy(DB0, cls.db)
        cls.app = load_app()
        con = cls.app.connect(cls.db)
        cls.app.create_user(con, "owner", "صاحب المشروع (تجريبي)", "owner", "pw-owner")
        cls.app.create_user(con, "r1", "مراجع تجريبي أ", "reviewer", "pw1")
        cls.app.create_user(con, "r2", "مراجع تجريبي ب", "reviewer", "pw2")
        cls.app.create_user(con, "r3", "مراجع غير معتمد", "reviewer", "pw3")
        con.close()
        cls.srv = cls.app.make_server(cls.db, "127.0.0.1", 0); cls.port = cls.srv.server_address[1]
        threading.Thread(target=cls.srv.serve_forever, daemon=True).start()

    @classmethod
    def tearDownClass(cls):
        cls.srv.shutdown(); shutil.rmtree(cls.tmp, ignore_errors=True)

    def call(self, method, path, body=None, token=None):
        req = urllib.request.Request(f"http://127.0.0.1:{self.port}{path}", method=method, data=json.dumps(body).encode() if body is not None else None,
                                     headers={"Content-Type": "application/json", **({"Authorization": "Bearer " + token} if token else {})})
        try:
            with urllib.request.urlopen(req) as r: return r.status, json.loads(r.read().decode())
        except urllib.error.HTTPError as e:
            return e.code, json.loads(e.read().decode() or "{}")

    def login(self, u, p):
        st, d = self.call("POST", "/api/v1/auth/login", {"username": u, "password": p}); self.assertEqual(st, 200); return d["token"]

    def test_full_flow(self):
        A = "ATT-004"
        st, d = self.call("POST", "/api/v1/auth/login", {"username": "r1", "password": "wrong"}); self.assertEqual(st, 401)
        owner, r1, r2, r3 = self.login("owner", "pw-owner"), self.login("r1", "pw1"), self.login("r2", "pw2"), self.login("r3", "pw3")
        # القائمة تُقرأ بلا دخول وتحوي كل شاهد يحتاج مطابقة بالعين (57 في v1.2 + ما أُضيف بقراءة بصرية أو OCR في الملحقات)
        con = sqlite3.connect(self.db); expected = con.execute(f"SELECT COUNT(*) FROM attestations WHERE {self.app.NEEDS_EYE_SQL}").fetchone()[0]; con.close()
        self.assertGreaterEqual(expected, 57)
        st, q = self.call("GET", "/api/v1/reviews/queue"); self.assertEqual(st, 200); self.assertEqual(len(q), expected)
        # لا حكم قبل التسجيل ثم لا حكم قبل الاعتماد (403)
        st, _ = self.call("PUT", f"/api/v1/attestations/{A}/reviews/me", {"verdict": "مطابق"}, r1); self.assertEqual(st, 403)
        for tok, field in [(r1, "تاريخ الأندلس"), (r2, "تحقيق المخطوطات"), (r3, "تاريخ")]:
            st, _ = self.call("POST", "/api/v1/reviewers/me", {"degree": "دكتوراه", "field": field}, tok); self.assertEqual(st, 200)
        st, _ = self.call("POST", "/api/v1/reviewers/me", {"degree": "دكتوراه", "field": ""}, r1); self.assertEqual(st, 422)
        st, _ = self.call("PUT", f"/api/v1/attestations/{A}/reviews/me", {"verdict": "مطابق"}, r1); self.assertEqual(st, 403)
        # الاعتماد لصاحب المشروع وحده
        st, me1 = self.call("GET", "/api/v1/auth/me", token=r1); rid1 = me1["user"]["user_id"]
        st, me2 = self.call("GET", "/api/v1/auth/me", token=r2); rid2 = me2["user"]["user_id"]
        st, _ = self.call("POST", f"/api/v1/reviewers/{rid1}/approval", {"approved": True}, r2); self.assertEqual(st, 403)
        st, _ = self.call("POST", f"/api/v1/reviewers/{rid1}/approval", {"approved": True, "note_ar": "اختبار"}, owner); self.assertEqual(st, 200)
        st, _ = self.call("POST", f"/api/v1/reviewers/{rid2}/approval", {"approved": True}, owner); self.assertEqual(st, 200)
        st, pub = self.call("GET", "/api/v1/reviewers"); self.assertEqual({r["reviewer_id"] for r in pub}, {rid1, rid2}, "غير المعتمد لا يُعرض للعموم")
        # 422 لحكم بفرق بلا ملاحظة
        st, d = self.call("PUT", f"/api/v1/attestations/{A}/reviews/me", {"verdict": "مطابق بفرق يسير", "note_ar": ""}, r1); self.assertEqual(st, 422)
        st, d = self.call("PUT", f"/api/v1/attestations/{A}/reviews/me", {"verdict": "لا أعرف"}, r1); self.assertEqual(st, 422)
        # مراجع واحد ← يحتاج مراجعًا ثانيًا
        st, d = self.call("PUT", f"/api/v1/attestations/{A}/reviews/me", {"verdict": "مطابق"}, r1); self.assertEqual(st, 200); self.assertEqual(d["review_status"], "يحتاج مراجعًا ثانيًا")
        con = sqlite3.connect(self.db)
        before = con.execute("SELECT verbatim_check FROM attestations WHERE attestation_id=?", (A,)).fetchone()[0]
        self.assertFalse(before.startswith("مطابق بالعين"))
        # الثاني ← معتمد بالعين + الشارة تُكتب في verbatim_check مع المراجعَين وتخصصيهما والتاريخ
        st, d = self.call("PUT", f"/api/v1/attestations/{A}/reviews/me", {"verdict": "مطابق"}, r2); self.assertEqual(d["review_status"], "معتمد بالعين")
        vc = con.execute("SELECT verbatim_check FROM attestations WHERE attestation_id=?", (A,)).fetchone()[0]
        self.assertTrue(vc.startswith("مطابق بالعين:"), vc); self.assertIn("مراجع تجريبي أ (تاريخ الأندلس)", vc); self.assertIn("مراجع تجريبي ب", vc)
        self.assertEqual(con.execute("SELECT previous_verbatim_check FROM attestation_verbatim_history WHERE attestation_id=? AND restored_at IS NULL", (A,)).fetchone()[0], before)
        # فحوص المراجعة الـ9 تنجح
        p = subprocess.run([sys.executable, QA, "--db", self.db], capture_output=True, text=True); self.assertEqual(p.returncode, 0, [c for c in json.loads(p.stdout)["checks"] if not c["pass"]])
        # حكم مخالف من معتمد ← غير مطابق، وتُستعاد قيمة verbatim_check
        st, _ = self.call("POST", "/api/v1/reviewers/me", {"degree": "ماجستير", "field": "تاريخ"}, r3)
        st, me3 = self.call("GET", "/api/v1/auth/me", token=r3); rid3 = me3["user"]["user_id"]
        self.call("POST", f"/api/v1/reviewers/{rid3}/approval", {"approved": True}, owner)
        st, d = self.call("PUT", f"/api/v1/attestations/{A}/reviews/me", {"verdict": "غير مطابق", "note_ar": "النص الصحيح: … ص74"}, r3); self.assertEqual(d["review_status"], "غير مطابق")
        con = sqlite3.connect(self.db)
        self.assertEqual(con.execute("SELECT verbatim_check FROM attestations WHERE attestation_id=?", (A,)).fetchone()[0], before)
        # سحب حكمه ← يعود معتمدًا بالعين
        st, d = self.call("DELETE", f"/api/v1/attestations/{A}/reviews/me", token=r3); self.assertEqual(d["review_status"], "معتمد بالعين")
        # سحب اعتماد مراجع ← يحتاج مراجعًا ثانيًا وتُستعاد القيمة
        st, _ = self.call("POST", f"/api/v1/reviewers/{rid2}/approval", {"approved": False, "note_ar": "اختبار السحب"}, owner)
        st, d = self.call("GET", f"/api/v1/attestations/{A}/reviews"); self.assertEqual(d["review_status"], "يحتاج مراجعًا ثانيًا")
        con = sqlite3.connect(self.db)
        self.assertEqual(con.execute("SELECT verbatim_check FROM attestations WHERE attestation_id=?", (A,)).fetchone()[0], before)
        self.assertEqual(con.execute("SELECT COUNT(*) FROM reviewer_approvals WHERE reviewer_id=?", (rid2,)).fetchone()[0], 2, "الاعتماد سجل لا يُحذف منه")
        p = subprocess.run([sys.executable, QA, "--db", self.db], capture_output=True, text=True); self.assertEqual(p.returncode, 0, [c for c in json.loads(p.stdout)["checks"] if not c["pass"]])
        # مسارات القراءة v1.2 ما زالت تعمل من الخدمة نفسها
        st, d = self.call("GET", "/api/v1/periods"); self.assertEqual((st, len(d)), (200, 11))
        from urllib.parse import quote
        st, d = self.call("GET", "/api/v1/reviews/status?status=" + quote("معتمد بالعين")); self.assertEqual(st, 200); self.assertTrue(all(x["review_status"] == "معتمد بالعين" for x in d))
        # صفحة المراجعة تُقدَّم
        with urllib.request.urlopen(f"http://127.0.0.1:{self.port}/review") as r: self.assertIn("مراجعة الشواهد بالعين", r.read().decode())


if __name__ == "__main__":
    unittest.main()
