#!/usr/bin/env python3
"""يولّد طبقة بيانات النموذج الثابت (andalus/data/graph.js) من قاعدة المنصة.

- لا يُصدَّر إلا ما حالته قابلة للنشر (القاعدة 4): موثّق، صُحح وموثّق، حُسم الخلاف، وموثّق جزئيًا (بتنبيه).
- كل جملة تاريخية في الناتج تحمل إسنادها وشواهده كما في القاعدة؛ لا يُضاف نص من عند السكربت.
- المعرّفات هي معرّفات الإصدار (PER-… PLC-… EVT-… PRD-…).

الاستخدام: python platform/tools/export_static.py --db platform/db/andalus.sqlite --out andalus/data/graph.js
"""
from __future__ import annotations
import argparse, json, re, sqlite3, os
from datetime import date

PUBLISHABLE = {"موثّق": "fact", "صُحح وموثّق": "fact", "حُسم الخلاف": "fact", "موثّق جزئيًا": "partial"}
ERA_COLORS = {"PRD-01": "var(--era-wulat)", "PRD-02": "var(--era-imara)", "PRD-03": "var(--era-khilafa)", "PRD-03a": "var(--era-khilafa)",
              "PRD-04": "var(--era-tawaif)", "PRD-05": "var(--era-murabit)", "PRD-05a": "var(--era-tawaif)", "PRD-06": "var(--era-muwahhid)",
              "PRD-06a": "var(--era-tawaif)", "PRD-07": "var(--era-nasrid)", "PRD-08": "var(--era-morisco)"}
TYPE_MAP = {"Person": "Person", "Place": "Place", "Polity": "Polity", "Work": "Work", "Object": "Artifact", "Manuscript": "Document",
            "DigitalResource": "Resource", "Language": "Language"}


def tier_of(source_class: str | None) -> str:
    s = (source_class or "").lower()
    if "primary" in s: return "أولي"
    if "peer" in s or "academic" in s or "monograph" in s or "scholarship" in s: return "A"
    if "institutional" in s or "museum" in s or "heritage" in s or "research" in s or "library" in s or "curated" in s: return "B"
    if "general" in s or "reference" in s or "geospatial" in s or s == "book": return "C"
    return "—"


def year_of(s):
    if not s: return None, None
    m = re.match(r"^(\d{3,4})", str(s))
    if not m: return None, str(s)
    y = int(m.group(1))
    note = None
    if "?" in str(s) or str(s).endswith("s") or "c" in str(s): note = f"القيمة في القاعدة: {s}"
    return y, note


def verdict_status(verdict: str | None, status: str | None) -> str:
    v = verdict or ""
    if v.startswith("غير مثبت") or v.startswith("مرفوض"): return "myth"
    if status and "مراجعة" in status: return "partial"
    if v.strip() == "مقبول": return "fact"
    if v.startswith("مقبول"): return "partial"
    return "partial"


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--db", required=True)
    ap.add_argument("--out", required=True)
    a = ap.parse_args()
    con = sqlite3.connect(a.db); con.row_factory = sqlite3.Row
    R = lambda sql, p=(): [dict(r) for r in con.execute(sql, p)]

    # ---- العصور
    eras = []
    for p in R("SELECT * FROM periods ORDER BY start_earliest, period_id"):
        eras.append({"id": p["period_id"], "name": p["label_ar"], "en": p["label_en"],
                     "from": p["start_earliest"], "to": p["end_latest"], "start_latest": p["start_latest"], "end_earliest": p["end_earliest"],
                     "hijri": p["hijri"], "note": p["note_ar"], "sub": bool(p["parent_id"]) or p["period_id"].endswith("a"),
                     "c": ERA_COLORS.get(p["period_id"], "var(--muted)")})

    # ---- المصادر (التقييم مستقل عن الحقوق: القاعدة 5 و6)
    rights = {r["source_id"]: r for r in R("SELECT * FROM source_rights")}
    sources = {}
    for s in R("SELECT * FROM sources"):
        rt = rights.get(s["source_id"], {})
        sources[s["source_id"]] = {"title": s["label"], "author": s["publisher"] or "", "year": "—", "pub": s["domain"] or "",
                                   "tier": tier_of(s["source_class"]), "kind": s["source_class"] or "", "lang": "",
                                   "url": s["url"], "url_checked": s["last_checked"] or "", "rights": rt.get("license_label") or "غير معروف",
                                   "rights_note": rt.get("reuse_note") or ""}

    # ---- الادعاءات من الإسنادات (القابلة للنشر فقط) مع شواهدها
    has_review = bool(R("SELECT 1 FROM sqlite_master WHERE type='view' AND name='v_attestation_review_status'"))
    rstatus = {r["attestation_id"]: r["review_status"] for r in R("SELECT attestation_id, review_status FROM v_attestation_review_status")} if has_review else {}
    rnames = {}
    if has_review:
        for r in R("""SELECT r.attestation_id, c.full_name, c.field FROM attestation_reviews r JOIN v_reviewer_current c USING(reviewer_id)
                      WHERE c.approved=1 AND r.verdict='مطابق' ORDER BY r.reviewed_at"""):
            rnames.setdefault(r["attestation_id"], []).append(f'{r["full_name"]} ({r["field"]})')
    atts = {}
    for t in R("SELECT * FROM attestations ORDER BY attestation_id"):
        atts.setdefault(t["assertion_id"], []).append({"id": t["attestation_id"], "src": t["source_id"], "loc": t["locator"], "quote": t["quote"],
                                                       "stance": t["stance"], "source_kind": t["source_kind"], "verbatim": t["verbatim_check"],
                                                       "note": t["note_ar"], "url": t["url"], "checked_on": t["checked_on"],
                                                       "review_status": rstatus.get(t["attestation_id"], "لم يُراجع"), "eye_reviewers": rnames.get(t["attestation_id"], [])})
    claims = {}
    assertions_by_target = {}
    for A in R("SELECT * FROM assertions ORDER BY assertion_id"):
        st = PUBLISHABLE.get(A["status"])
        if not st:
            continue  # متعارض / ينتظر شاهدًا: لا يُنشر
        claims[A["assertion_id"]] = {"text": f'{A["kind"]}: {A["value_ar"]}', "status": st, "v12_status": A["status"], "field": A["field"],
                                     "target": A["target_id"], "value_before": A["value_before"], "resolution": A["resolution_ar"], "todo": A["todo_ar"],
                                     "model": A["model"], "last_verified": A["last_verified"],
                                     "sources": [{"src": x["src"], "loc": x["loc"] or "", "quote": x["quote"], "stance": x["stance"], "source_kind": x["source_kind"],
                                                  "verbatim": x["verbatim"], "note": x["note"], "url": x["url"], "checked_on": x["checked_on"], "att": x["id"],
                                                  "review_status": x["review_status"], "eye_reviewers": x["eye_reviewers"]}
                                                 for x in atts.get(A["assertion_id"], [])],
                                     "counter": [{"position": x["quote"], "sources": [{"src": x["src"], "loc": x["loc"] or ""}]}
                                                 for x in atts.get(A["assertion_id"], []) if (x["stance"] or "").startswith("يخالف")]}
        assertions_by_target.setdefault(A["target_id"], []).append(A["assertion_id"])

    # ---- ادعاءات النواة (claims) بمصادرها وشواهد إسناداتها
    csrc = {}
    for r in R("SELECT * FROM claim_sources ORDER BY claim_id, ordinal"):
        csrc.setdefault(r["claim_id"], []).append({"src": r["source_id"], "loc": "—"})
    clinks = {}
    for r in R("SELECT * FROM assertion_claim_links"):
        clinks.setdefault(r["claim_id"], []).append(r["assertion_id"])
    cents = {}
    for r in R("SELECT * FROM claim_entities"):
        cents.setdefault(r["claim_id"], []).append((r["entity_id"], r["role"]))
    for C in R("SELECT * FROM claims ORDER BY claim_id"):
        st = verdict_status(C["verdict"], C["status"])
        srcs = list(csrc.get(C["claim_id"], []))
        for aid in clinks.get(C["claim_id"], []):
            srcs += claims.get(aid, {}).get("sources", [])
        claims[C["claim_id"]] = {"text": C["canonical_wording_ar"], "status": st, "v12_status": f'{C["verdict"]} · {C["status"]}', "field": "claim",
                                 "target": None, "confidence": C["confidence"], "original": C["original_claim"], "last_verified": C["last_verified"],
                                 "sources": srcs, "counter": []}

    # ---- الكيانات
    geom = {g["entity_id"]: g for g in R("SELECT * FROM place_geometry")}
    meta = {m["entity_id"]: m for m in R("SELECT * FROM atlas_place_metadata")}
    parts = {p["entity_id"]: p for p in R("SELECT * FROM person_name_parts")}
    aliases = {}
    for al in R("SELECT * FROM entity_aliases"):
        aliases.setdefault(al["entity_id"], []).append(al["alias"])
    tenures = R("SELECT * FROM tenures ORDER BY start_year")
    ten_by_person, ten_by_polity = {}, {}
    for t in tenures:
        ten_by_person.setdefault(t["person_id"], []).append(t); ten_by_polity.setdefault(t["polity_id"], []).append(t)
    relations = R("SELECT * FROM relations")
    ev_persons = R("SELECT * FROM event_persons")
    entities = []
    ent_rows = R("SELECT * FROM entities ORDER BY entity_id")
    names = {e["entity_id"]: e["preferred_name_ar"] for e in ent_rows}

    def summary_for(target_id):
        out = []
        for aid in assertions_by_target.get(target_id, []):
            out.append([claims[aid]["text"], aid])
        return out

    claim_entity_summary = {}
    for cid, lst in cents.items():
        if cid not in claims: continue
        for eid, role in lst:
            claim_entity_summary.setdefault(eid, []).append([claims[cid]["text"], cid])

    for e in ent_rows:
        et = TYPE_MAP.get(e["entity_type"])
        if not et: continue
        eid = e["entity_id"]
        born, bnote = year_of(e["start_date"]); died, dnote = year_of(e["end_date"])
        o = {"id": eid, "type": et, "name": {"ar": e["preferred_name_ar"], "en": e["preferred_name_latn"] or ""}, "summary": [], "edges": [],
             "notes": e["notes"]}
        if aliases.get(eid): o["name"]["variants"] = aliases[eid]
        o["summary"] += summary_for(eid)
        o["summary"] += claim_entity_summary.get(eid, [])
        if et == "Person":
            o["born"], o["died"] = born, died
            if bnote or dnote: o["dates_note"] = "؛ ".join(x for x in [bnote, dnote] if x)
            if eid in parts:
                p = parts[eid]; o["name"]["parts"] = {k: p[k] for k in ["ism", "kunya", "nasab", "nisba", "laqab"] if p.get(k)}
            roles = []
            for t in ten_by_person.get(eid, []):
                span = f'{t["start_year"] or "؟"}–{t["end_year"] or "؟"}'
                o["edges"].append(["ruled", t["polity_id"], span])
                if t["role"] and t["role"] not in roles: roles.append(t["role"])
                o["summary"] += [[f'ولاية {t["role"]} في {names.get(t["polity_id"], t["polity_id"])} ({span}): {claims[aid]["text"]}', aid]
                                  for aid in assertions_by_target.get(t["tenure_id"], [])]
            o["roles"] = roles
            for ep in ev_persons:
                if ep["person_id"] == eid: o["edges"].append(["participated_in", ep["event_id"], "طرف"])
            yrs = [y for y in [born, died] if y] or [t["start_year"] for t in ten_by_person.get(eid, []) if t["start_year"]]
            o["era"] = era_of(eras, yrs[0]) if yrs else None
        elif et == "Place":
            g = geom.get(eid); m = meta.get(eid, {})
            o["lat"] = g["lat"] if g else None; o["lon"] = g["lon"] if g else None
            o["spatial_quality"] = g["spatial_quality"] if g else None; o["coordinate_source"] = g["coordinate_source"] if g else None
            o["anchor_type"] = g["anchor_type"] if g else None
            hs = m.get("historical_status") or ""
            o["kind"] = hs if hs and not re.match(r"^[A-Za-z0-9_\-]+$", hs) else "مكان"; o["historical_status"] = hs or None; o["theme"] = m.get("theme"); o["period_group"] = m.get("period_group")
            o["display_priority"] = m.get("display_priority") or 0; o["place_note"] = m.get("note_ar")
            o["founded"] = None; o["control"] = []
            if born: o["from"] = born
            if died: o["to"] = died
        elif et == "Polity":
            o["from"], o["to"] = born, died; o["capital"] = None
            o["rulers"] = [{"person": t["person_id"], "role": t["role"], "from": t["start_year"], "to": t["end_year"], "precision": t["precision"]} for t in ten_by_polity.get(eid, [])]
        elif et in ("Work", "Artifact", "Document"):
            if born: o["year"] = born
            o["author"] = ""
            o["holding"] = {"institution": "غير معروف", "license": "غير معروف"}
        for r in relations:
            if r["subject_id"] == eid: o["edges"].append([r["predicate"], r["object_id"], r["confidence"] or ""])
        entities.append(o)

    # ---- الأحداث
    for ev in R("SELECT * FROM historical_events ORDER BY start_year"):
        o = {"id": ev["event_id"], "type": "Event", "name": {"ar": ev["title_ar"]}, "year": ev["start_year"], "kind": "حدث", "era": ev["period_id"],
             "place": ev["place_id"], "polity": ev["polity_id"], "hijri": ev["hijri"], "precision": ev["precision"], "confidence": ev["confidence"],
             "weight": 3 if (ev["confidence"] or "").startswith("عالٍ") else 2, "summary": summary_for(ev["event_id"]), "edges": []}
        if ev["end_year"] and ev["end_year"] != ev["start_year"]: o["end"] = ev["end_year"]
        entities.append(o)

    # ---- القصص والوحدات والأسئلة
    stories = []
    for s in R("SELECT * FROM atlas_stories ORDER BY story_id"):
        steps = R("SELECT * FROM atlas_story_steps WHERE story_id=? ORDER BY ordinal", (s["story_id"],))
        stories.append({"id": s["story_id"], "title": s["title_ar"], "summary": s["summary_ar"], "period": s["period_label"], "warning": s["warning_ar"],
                        "steps": [{"title": x["title_ar"], "text": x["narrative_ar"], "place": x["place_entity_id"], "claim": x["claim_id"]} for x in steps]})
    quiz = []
    for q in R("SELECT * FROM v_quiz_ready WHERE status='جاهز' ORDER BY module_id, ordinal"):
        try: choices = json.loads(q["choices_json"])
        except Exception: choices = []
        quiz.append({"id": q["quiz_id"], "module": q["module_id"], "type": q["question_type"], "prompt": q["prompt_ar"], "choices": choices,
                     "correct": q["correct_index"], "explanation": q["explanation_ar"], "claim": q["claim_id"], "difficulty": q["difficulty"]})
    modules = R("SELECT module_id,title_ar,summary_ar,level,estimated_minutes,period_label,status FROM v_learning_modules WHERE status='جاهز' ORDER BY module_id")
    release = R("SELECT version,release_date,gates_pass,gates_total FROM release_manifest ORDER BY release_date DESC, version DESC LIMIT 1")

    # ---- الأطلس: طبقات موضوعية ومظاريف تحليلية (ليست حدودًا سياسية: القاعدة 7 وSCOPE-004)
    layers = R("SELECT * FROM atlas_layers ORDER BY min_year")
    members = {}
    for m in R("SELECT * FROM atlas_layer_members"):
        members.setdefault(m["layer_id"], []).append({"place": m["entity_id"], "role": m["role"]})
    for l in layers: l["members"] = members.get(l["layer_id"], [])
    zones = []
    for z in R("SELECT * FROM atlas_zones ORDER BY min_year"):
        try: g = json.loads(z["geometry_geojson"])
        except Exception: g = None
        zones.append({"id": z["zone_id"], "label": z["label_ar"], "from": z["min_year"], "to": z["max_year"], "theme": z["theme"],
                      "status": z["cartographic_status"], "note": z["note_ar"], "geometry": g})
    scope = R("SELECT scope_id, component, included, policy_ar FROM release_scope ORDER BY scope_id")
    boundary_sources = R("SELECT boundary_source_id, label, url, coverage, rights_status, evidence_grade, intended_use, qa_rule FROM boundary_sources")
    models = []
    for mid in [r["model"] for r in R("SELECT DISTINCT model FROM assertions WHERE model IS NOT NULL AND model<>'all' ORDER BY model")]:
        asts = [aid for aid, c in claims.items() if c.get("model") == mid]
        ev_years = sorted({e["year"] for e in entities if e["type"] == "Event" and any(c in asts for _, c in e["summary"])})
        models.append({"id": mid, "assertions": asts, "todos": [{"id": aid, "todo": claims[aid]["todo"], "text": claims[aid]["text"]} for aid in asts if claims[aid].get("todo")],
                       "years": ev_years, "places": sorted({claims[a]["target"] for a in asts if claims[a]["target"] and claims[a]["target"].startswith("PLC")})})
    # ---- المسارات (routes/route_stops) وربط القصص والمسارات بالأحداث عبر الادعاء ← الإسناد ← الهدف
    routes = []
    for r in R("SELECT * FROM routes ORDER BY route_id"):
        stops = R("SELECT * FROM route_stops WHERE route_id=? ORDER BY ordinal", (r["route_id"],))
        routes.append({"id": r["route_id"], "label": r["label_ar"], "type": r["route_type"], "from": r["start_date"], "to": r["end_date"], "claim": r["claim_id"],
                       "note": r["notes"], "stops": [{"n": x["ordinal"], "place": x["place_entity_id"], "person": x["person_entity_id"], "work": x["work_entity_id"], "note": x["note"]} for x in stops]})
    claim_targets = {}
    for cid, aids in clinks.items():
        for aid in aids:
            t = claims.get(aid, {}).get("target")
            if t: claim_targets.setdefault(cid, set()).add(t)
    event_ids = {o["id"] for o in entities if o["type"] == "Event"}
    for o in entities:
        if o["type"] != "Event": continue
        o["stories"] = sorted({st["id"] for st in stories if any(o["id"] in claim_targets.get(x["claim"], ()) for x in st["steps"])})
        o["routes"] = sorted({r["id"] for r in routes if o["id"] in claim_targets.get(r["claim"], ())})
    atlas = {"layers": layers, "zones": zones, "scope": scope, "boundary_sources": boundary_sources, "models": models, "routes": routes}

    ids = {o["id"] for o in entities}
    # تحقق اتساق قبل الكتابة
    problems = []
    for o in entities:
        for e in o["edges"]:
            if e[1] not in ids: problems.append(f'{o["id"]}: هدف حافة غير موجود {e[1]}')
        for t, c in o["summary"]:
            if c not in claims: problems.append(f'{o["id"]}: ادعاء غير موجود {c}')
        if o["type"] == "Event" and o.get("place") and o["place"] not in ids: problems.append(f'{o["id"]}: مكان غير موجود')
    for cid, c in claims.items():
        for s in c["sources"]:
            if s["src"] not in sources: problems.append(f"{cid}: مصدر غير موجود {s['src']}")
    if problems:
        raise SystemExit("مشكلات اتساق:\n" + "\n".join(problems))

    J = lambda x: json.dumps(x, ensure_ascii=False)
    out = f"""/* =========================================================
   طبقة بيانات منصة الأندلس — مولَّدة آليًا من قاعدة {release[0]['version'] if release else '؟'} (تاريخ الإصدار {release[0]['release_date'] if release else '؟'}).
   لا تُحرَّر يدويًا: عدّل القاعدة عبر مهارة andalus-evidence ثم شغّل platform/tools/export_static.py.
   يُصدَّر فقط ما حالته قابلة للنشر (موثّق، صُحح وموثّق، حُسم الخلاف، موثّق جزئيًا بتنبيه).
   ========================================================= */
const RELEASE = {J(release[0] if release else {})};
const ERAS = {J(eras)};
const SOURCES = {J(sources)};
const CLAIMS = {J(claims)};
const ENTITIES = {J(entities)};
const STORIES = {J(stories)};
const MODULES = {J(modules)};
const QUIZ = {J(quiz)};
const ATLAS = {J(atlas)};
const E = {{}}; for (const o of ENTITIES) E[o.id] = o;
function add(o) {{ E[o.id] = o; return o; }}
"""
    os.makedirs(os.path.dirname(os.path.abspath(a.out)), exist_ok=True)
    open(a.out, "w", encoding="utf-8").write(out)
    print(json.dumps({"eras": len(eras), "sources": len(sources), "claims": len(claims), "entities": len(entities), "stories": len(stories), "quiz": len(quiz),
                      "by_type": {t: sum(1 for o in entities if o["type"] == t) for t in sorted({o["type"] for o in entities})},
                      "by_status": {s: sum(1 for c in claims.values() if c["status"] == s) for s in sorted({c["status"] for c in claims.values()})}}, ensure_ascii=False))


def era_of(eras, y):
    top = [e for e in eras if not e["sub"]]
    cur = None
    for e in top:
        if e["start_latest"] <= y: cur = e["id"]
    return cur


if __name__ == "__main__":
    main()
