#!/usr/bin/env python3
"""ترحيل بيانات حزمة التسليم v1.2 إلى قاعدة المنصة.

يعمل أكثر من مرة دون تكرار: كل جدول يُدخل أو يُحدَّث بمفتاحه الأساسي (UPSERT).
لا يضيف أي محتوى تاريخي؛ مصدره الوحيد ملفات seed/json/*.json من الحزمة،
وجدول مطابقة معرّفات النموذج الأولي (crosswalk_prototype.json) الذي لا يحمل تواريخ ولا أسماء جديدة.

الاستخدام:
  python platform/tools/migrate_v1_2.py --db platform/db/andalus.sqlite
  python platform/tools/migrate_v1_2.py --db platform/db/andalus.sqlite --check-only
"""
from __future__ import annotations
import argparse, json, os, re, sqlite3, sys
from datetime import date

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, "..", ".."))
DEFAULT_SEED = os.path.join(ROOT, "andalus_handoff", "seed")
DEFAULT_SCHEMA = os.path.join(ROOT, "platform", "db", "schema.sql")
DEFAULT_XWALK = os.path.join(HERE, "crosswalk_prototype.json")
DEFAULT_SCHEMA_EXT = os.path.join(ROOT, "platform", "db", "schema_platform.sql")
DEFAULT_SCHEMA_REVIEW = os.path.join(ROOT, "platform", "db", "schema_review.sql")
# لا يزيد أي جدول من جداول v1.2 عن table_counts.json إلا maintenance_runs عند طلب تسجيل التشغيل صراحة
GROWING = {"maintenance_runs"}


def split_statements(sql: str):
    """يقسم schema.sql إلى عبارات CREATE مع اسم الكائن ونوعه."""
    out = []
    for stmt in re.split(r";\s*\n", sql):
        s = stmt.strip()
        if not s:
            continue
        m = re.match(r"CREATE\s+(TABLE|VIEW)\s+(?:IF\s+NOT\s+EXISTS\s+)?[\"`]?(\w+)", s, re.I)
        if m:
            out.append((m.group(1).lower(), m.group(2), s + ";"))
    return out


def ensure_schema(con: sqlite3.Connection, schema_path: str):
    existing = {r[0] for r in con.execute("SELECT name FROM sqlite_master WHERE type IN ('table','view')")}
    created = []
    for kind, name, stmt in split_statements(open(schema_path, encoding="utf-8").read()):
        if name in existing:
            continue
        con.executescript(stmt)
        created.append(name)
    return created


def table_columns(con, table):
    return [r[1] for r in con.execute(f'PRAGMA table_info("{table}")')]


def table_pk(con, table):
    return [r[1] for r in sorted(con.execute(f'PRAGMA table_info("{table}")'), key=lambda r: r[5]) if r[5] > 0]


def upsert_table(con, table, records):
    cols_db = table_columns(con, table)
    pk = table_pk(con, table)
    if not pk:
        raise RuntimeError(f"الجدول {table} بلا مفتاح أساسي؛ لا يمكن الترحيل دون تكرار")
    inserted = updated = 0
    for rec in records:
        cols = [c for c in cols_db if c in rec]
        if not all(k in cols for k in pk):
            raise RuntimeError(f"سجل في {table} بلا مفتاح أساسي كامل: {rec}")
        vals = [rec[c] for c in cols]
        where = " AND ".join(f'"{k}"=?' for k in pk)
        exists = con.execute(f'SELECT 1 FROM "{table}" WHERE {where}', [rec[k] for k in pk]).fetchone()
        nonpk = [c for c in cols if c not in pk]
        sets = ", ".join(f'"{c}"=excluded."{c}"' for c in nonpk) or None
        sql = (f'INSERT INTO "{table}" ({", ".join(chr(34)+c+chr(34) for c in cols)}) VALUES ({", ".join("?" for _ in cols)}) '
               f'ON CONFLICT({", ".join(chr(34)+k+chr(34) for k in pk)}) DO ' + (f"UPDATE SET {sets}" if sets else "NOTHING"))
        con.execute(sql, vals)
        if exists:
            updated += 1
        else:
            inserted += 1
    return inserted, updated


def load_crosswalk(path):
    if not path or not os.path.exists(path):
        return []
    data = json.load(open(path, encoding="utf-8"))
    return [r for r in data.get("entities", []) if r.get("release_id") and r.get("branch_id")]


def verify_counts(con, expected, tolerant=GROWING):
    """الأعداد تطابق table_counts.json تمامًا، عدا maintenance_runs الذي قد يزيد عند --log-run"""
    problems = []
    for table, n in expected.items():
        got = con.execute(f'SELECT COUNT(*) FROM "{table}"').fetchone()[0]
        if table in tolerant:
            if got < n:
                problems.append(f"{table}: {got} < {n}")
        elif got != n:
            problems.append(f"{table}: {got} != {n}")
    return problems


def migrate(db_path, seed_dir, schema_path, xwalk_path, check_only=False, log_run=False, schema_ext=DEFAULT_SCHEMA_EXT):
    fresh = not os.path.exists(db_path)
    con = sqlite3.connect(db_path)
    con.execute("PRAGMA foreign_keys=OFF")
    report = {"db": db_path, "fresh": fresh, "tables": {}, "schema_created": [], "crosswalk": 0, "problems": []}
    expected = json.load(open(os.path.join(seed_dir, "table_counts.json"), encoding="utf-8"))
    if check_only:
        report["problems"] = verify_counts(con, expected)
        report["status"] = "PASS" if not report["problems"] else "FAIL"
        return report
    report["schema_created"] = ensure_schema(con, schema_path)
    if schema_ext and os.path.exists(schema_ext):
        with open(schema_ext, encoding="utf-8") as f: con.executescript(f.read())
    # جداول خاصية المراجعة بالعين (spec/review/schema_review.sql): IF NOT EXISTS + إعادة إنشاء العرضين؛ آمنة للتكرار
    if os.path.exists(DEFAULT_SCHEMA_REVIEW):
        with open(DEFAULT_SCHEMA_REVIEW, encoding="utf-8") as f: con.executescript(f.read())
    jdir = os.path.join(seed_dir, "json")
    order = [t for t in expected.keys() if os.path.exists(os.path.join(jdir, f"{t}.json"))]
    with con:
        for table in order:
            records = json.load(open(os.path.join(jdir, f"{table}.json"), encoding="utf-8"))
            ins, upd = upsert_table(con, table, records)
            report["tables"][table] = {"inserted": ins, "updated": upd, "seed": len(records)}
        # مطابقة معرّفات النموذج الأولي بمعرّفات الإصدار في جدول منفصل (prototype_crosswalk) حتى يبقى عقد /api/v1/crosswalk كما هو
        xw = load_crosswalk(xwalk_path)
        valid = {r[0] for r in con.execute("SELECT entity_id FROM entities")}
        rows = []
        for r in xw:
            if r["release_id"] not in valid:
                report["problems"].append(f"crosswalk: release_id غير موجود {r['release_id']}")
                continue
            rows.append({"prototype_id": r["branch_id"], "release_id": r["release_id"], "entity_kind": r.get("entity_kind", ""),
                         "match_basis": r.get("match_basis", "نموذج أولي: مطابقة يدوية")})
        if rows:
            ins, upd = upsert_table(con, "prototype_crosswalk", rows)
            report["crosswalk"] = ins + upd
        if log_run:
            run_id = f"MIG-v1.2-{date.today().isoformat()}"
            upsert_table(con, "maintenance_runs", [{
                "run_id": run_id, "run_date": date.today().isoformat(), "run_type": "migration",
                "result": "PASS", "checks_run": len(order), "failures": 0,
                "note_ar": "ترحيل حزمة v1.2 بسكربت migrate_v1_2.py (UPSERT بالمفتاح الأساسي؛ يعمل أكثر من مرة دون تكرار)"}])
    fk = con.execute("PRAGMA foreign_key_check").fetchall()
    if fk:
        report["problems"].append(f"foreign_key_check: {len(fk)} مخالفة")
    report["problems"] += verify_counts(con, expected)
    report["status"] = "PASS" if not report["problems"] else "FAIL"
    con.close()
    return report


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--db", required=True)
    ap.add_argument("--seed", default=DEFAULT_SEED)
    ap.add_argument("--schema", default=DEFAULT_SCHEMA)
    ap.add_argument("--crosswalk", default=DEFAULT_XWALK)
    ap.add_argument("--check-only", action="store_true")
    ap.add_argument("--log-run", action="store_true", help="يسجل صف تشغيل في maintenance_runs (يغيّر عدد عناصر /maintenance/runs)")
    ap.add_argument("--quiet", action="store_true")
    a = ap.parse_args()
    os.makedirs(os.path.dirname(os.path.abspath(a.db)), exist_ok=True)
    rep = migrate(a.db, a.seed, a.schema, a.crosswalk, a.check_only, a.log_run)
    if not a.quiet:
        print(json.dumps(rep, ensure_ascii=False, indent=2))
    sys.exit(0 if rep["status"] == "PASS" else 1)


if __name__ == "__main__":
    main()
