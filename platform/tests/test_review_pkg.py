"""بوابة CI لخاصية المراجعة كما سلّمتها الحزمة: 9 فحوص جودة على قاعدة المنصة، و14 اختبارًا في test_review_feature.py."""
import json, os, subprocess, sys, unittest

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
H = os.path.join(ROOT, "andalus_handoff")
DB = os.environ.get("ANDALUS_DB", os.path.join(ROOT, "platform", "db", "andalus.sqlite"))


class ReviewPackageGates(unittest.TestCase):
    def test_review_qa_9_checks(self):
        p = subprocess.run([sys.executable, os.path.join(H, "tests", "andalus_review_qa.py"), "--db", DB], capture_output=True, text=True)
        r = json.loads(p.stdout); self.assertEqual((r["total"], r["status"]), (9, "PASS"), r)

    def test_review_feature_14_tests(self):
        try:
            import openpyxl  # noqa: F401
        except ImportError:
            self.fail("openpyxl مطلوب لاختبارات استمارة Excel: pip install openpyxl")
        p = subprocess.run([sys.executable, os.path.join(H, "tests", "test_review_feature.py")], capture_output=True, text=True, cwd=H)
        r = json.loads(p.stdout); self.assertEqual((r["total"], r["status"]), (14, "PASS"), r)


if __name__ == "__main__":
    unittest.main()
