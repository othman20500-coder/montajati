"""اختبارات الانحدار الـ22 لعقد الخدمة v1.2: إرسال مباشر إلى دالة dispatch في الخدمة المرجعية دون شبكة."""
import importlib.util, json, os, sqlite3, unittest
from urllib.parse import urlparse, parse_qs

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
API = os.path.join(ROOT, "andalus_handoff", "spec", "reference_api_v1_2.py")
REG = os.path.join(ROOT, "andalus_handoff", "tests", "andalus_api_regression_v1_2.json")
DB = os.environ.get("ANDALUS_DB", os.path.join(ROOT, "platform", "db", "andalus.sqlite"))


def load_api():
    spec = importlib.util.spec_from_file_location("reference_api_v1_2", API)
    mod = importlib.util.module_from_spec(spec); spec.loader.exec_module(mod)
    return mod


class APIRegression(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.api = load_api()
        cls.reg = json.load(open(REG, encoding="utf-8"))
        cls.con = cls.api.connect(DB)

    def test_regression_suite(self):
        failures = []
        for t in self.reg["tests"]:
            u = urlparse(t["path"])
            st, body = self.api.dispatch(self.con, u.path, parse_qs(u.query))
            items = len(body) if isinstance(body, list) else (len(body.get("features", [])) if isinstance(body, dict) and "features" in body else None)
            if st != t["status"]:
                failures.append(f'{t["name"]}: الحالة {st} ≠ {t["status"]}')
            if t.get("items") is not None and items != t["items"]:
                failures.append(f'{t["name"]}: العناصر {items} ≠ {t["items"]}')
        self.assertEqual(len(self.reg["tests"]), 22)
        self.assertEqual(failures, [])

    def test_search_requires_q(self):
        st, body = self.api.dispatch(self.con, "/api/v1/search", {})
        self.assertEqual(st, 400)

    def test_samples_shape(self):
        """عينات spec/api_samples تبقى بصيغة [status, body] ومفاتيح الجسم موجودة في الاستجابة الحية."""
        sd = os.path.join(ROOT, "andalus_handoff", "spec", "api_samples")
        for name, path in [("release.json", "/api/v1/release/status"), ("periods.json", "/api/v1/periods"), ("person.json", "/api/v1/persons/PER-034")]:
            st_s, body_s = json.load(open(os.path.join(sd, name), encoding="utf-8"))
            st, body = self.api.dispatch(self.con, path, {})
            self.assertEqual(st, st_s, name)
            if isinstance(body_s, dict):
                self.assertTrue(set(body_s.keys()) <= set(body.keys()), name)


if __name__ == "__main__":
    unittest.main()
