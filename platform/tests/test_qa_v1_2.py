"""بوابة الجودة: فحوص الحزمة الـ26 كما هي، على قاعدة المنصة. لا يُدمج شيء قبل نجاحها كلها."""
import json, os, subprocess, sys, unittest

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
QA = os.path.join(ROOT, "andalus_handoff", "tests", "andalus_qa_v1_2.py")
DB = os.environ.get("ANDALUS_DB", os.path.join(ROOT, "platform", "db", "andalus.sqlite"))


class QAv12(unittest.TestCase):
    def test_all_26_checks_pass(self):
        p = subprocess.run([sys.executable, QA, "--db", DB], capture_output=True, text=True)
        result = json.loads(p.stdout)
        failed = [c["name"] for c in result["checks"] if not c["pass"]]
        self.assertEqual(result["total"], 26)
        self.assertEqual(failed, [], f"فحوص فاشلة: {failed}")
        self.assertEqual(p.returncode, 0)


if __name__ == "__main__":
    unittest.main()
