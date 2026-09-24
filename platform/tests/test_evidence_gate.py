"""بوابة الأدلة (CLAUDE.md، قسم الاختبارات): يُمنع دمج أي تعديل فيه ادعاء بلا شاهد، أو شاهد بلا نص وموضع،
أو رابط في النطاقات المستولى عليها. ويُضاف: لا تُصدَّر حالة غير قابلة للنشر إلى طبقة الواجهة."""
import os, re, sqlite3, unittest

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
DB = os.environ.get("ANDALUS_DB", os.path.join(ROOT, "platform", "db", "andalus.sqlite"))
GRAPH = os.path.join(ROOT, "andalus", "data", "graph.js")
HIJACKED = ["ibntufayl.org", "relmin.eu"]
PUBLISHABLE = {"موثّق", "صُحح وموثّق", "حُسم الخلاف", "موثّق جزئيًا"}
ALLOWED_STATUSES = PUBLISHABLE | {"متعارض", "متعارض — يحتاج قرارًا", "ينتظر شاهدًا"}


class EvidenceGate(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.con = sqlite3.connect(DB)

    def test_every_claim_has_source_or_evidence_or_assertion(self):
        rows = self.con.execute("""SELECT claim_id FROM claims c WHERE NOT EXISTS (SELECT 1 FROM claim_sources s WHERE s.claim_id=c.claim_id)
            AND NOT EXISTS (SELECT 1 FROM claim_evidence e WHERE e.claim_id=c.claim_id)
            AND NOT EXISTS (SELECT 1 FROM assertion_claim_links l WHERE l.claim_id=c.claim_id)""").fetchall()
        self.assertEqual(rows, [], "ادعاءات بلا شاهد ولا مصدر ولا إسناد")

    def test_every_assertion_has_attestation(self):
        rows = self.con.execute("SELECT assertion_id FROM assertions a WHERE NOT EXISTS (SELECT 1 FROM attestations t WHERE t.assertion_id=a.assertion_id)").fetchall()
        self.assertEqual(rows, [], "إسنادات بلا شاهد")

    def test_attestations_have_quote_and_locator(self):
        rows = self.con.execute("SELECT attestation_id FROM attestations WHERE quote IS NULL OR trim(quote)='' OR locator IS NULL OR trim(locator)=''").fetchall()
        self.assertEqual(rows, [], "شواهد بلا نص أو موضع")

    def test_assertion_statuses_are_from_the_approved_list(self):
        bad = [r[0] for r in self.con.execute("SELECT DISTINCT status FROM assertions") if r[0] not in ALLOWED_STATUSES]
        self.assertEqual(bad, [], "حالات إسناد خارج القائمة المعتمدة (القاعدة 4)")

    def test_no_hijacked_domains_anywhere(self):
        for table, col in [("sources", "url"), ("attestations", "url"), ("source_rights", "license_url"), ("boundary_sources", "url")]:
            for d in HIJACKED:
                n = self.con.execute(f"SELECT COUNT(*) FROM {table} WHERE {col} LIKE ?", (f"%{d}%",)).fetchone()[0]
                self.assertEqual(n, 0, f"{table}.{col} يحوي {d}")

    def test_exported_layer_contains_only_publishable_statuses(self):
        self.assertTrue(os.path.exists(GRAPH))
        js = open(GRAPH, encoding="utf-8").read()
        self.assertIn("مولَّدة آليًا", js, "graph.js يجب أن يكون مولَّدًا لا محرّرًا يدويًا")
        for s in ["ينتظر شاهدًا", "متعارض — يحتاج قرارًا"]:
            self.assertNotIn(f'"v12_status": "{s}"', js)
        for d in HIJACKED:
            self.assertNotIn(d, js)

    def test_exported_claims_all_have_sources(self):
        js = open(GRAPH, encoding="utf-8").read()
        m = re.search(r"const CLAIMS = (\{.*?\});\nconst ENTITIES", js, re.S)
        self.assertIsNotNone(m)
        import json
        claims = json.loads(m.group(1))
        empty = [k for k, v in claims.items() if not v.get("sources")]
        self.assertEqual(empty, [], "ادعاءات مصدَّرة بلا مصادر")


if __name__ == "__main__":
    unittest.main()
