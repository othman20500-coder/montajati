#!/usr/bin/env python3
"""غلاف لنقل أحكام المراجعة إلى قاعدة المنصة بسكربت الحزمة tools/import_reviews.py (يعمل أكثر من مرة دون تكرار).

المصدر الأول: صفحة المراجعة على claude.ai (مراجعة شواهد الأندلس، https://claude.ai/artifact/FEq5ichdkMzcqXrxxPtXi1)
  تُصدَّر مجموعاتها reviewers وapprovals وreviews بأداة ArtifactData (list مع out_dir) إلى مجلد، ثم:
  python platform/tools/import_reviews.py --artifact-dir <المجلد> --owner "عثمان الشهري"
المصدر الثاني: استمارات Excel معادة من مراجعين خارجيين:
  python platform/tools/import_reviews.py --excel form1.xlsx form2.xlsx
بعده: python platform/tools/export_static.py … لتحديث شارة «مطابق بالعين» في الواجهة.
"""
import argparse, os, subprocess, sys

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
ap = argparse.ArgumentParser()
ap.add_argument("--db", default=os.path.join(ROOT, "platform", "db", "andalus.sqlite"))
ap.add_argument("--artifact-dir"); ap.add_argument("--excel", nargs="*", default=[]); ap.add_argument("--owner", default="صاحب المشروع")
a = ap.parse_args()
cmd = [sys.executable, os.path.join(ROOT, "andalus_handoff", "tools", "import_reviews.py"), "--db", a.db,
       "--schema", os.path.join(ROOT, "platform", "db", "schema_review.sql"), "--owner", a.owner]
if a.artifact_dir: cmd += ["--artifact-dir", a.artifact_dir]
if a.excel: cmd += ["--excel", *a.excel]
sys.exit(subprocess.call(cmd))
