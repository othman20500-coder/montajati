import json, os, sqlite3, subprocess, sys, tempfile, unittest

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
MIGRATE = os.path.join(ROOT, "platform", "tools", "migrate_v1_2.py")
SEED = os.path.join(ROOT, "andalus_handoff", "seed")


def run_migrate(db):
    p = subprocess.run([sys.executable, MIGRATE, "--db", db], capture_output=True, text=True)
    return p.returncode, json.loads(p.stdout)


class MigrationIsIdempotent(unittest.TestCase):
    def test_two_runs_do_not_duplicate(self):
        with tempfile.TemporaryDirectory() as d:
            db = os.path.join(d, "t.sqlite")
            code1, r1 = run_migrate(db)
            self.assertEqual(code1, 0, r1.get("problems"))
            self.assertTrue(r1["fresh"])
            code2, r2 = run_migrate(db)
            self.assertEqual(code2, 0, r2.get("problems"))
            self.assertFalse(r2["fresh"])
            self.assertEqual(sum(v["inserted"] for v in r2["tables"].values()), 0, "التشغيل الثاني يجب ألا يُدخل صفًا جديدًا")
            sys.path.insert(0, os.path.dirname(MIGRATE))
            from migrate_v1_2 import expected_counts, DEFAULT_ADDITIONS
            expected = expected_counts(SEED, DEFAULT_ADDITIONS)
            con = sqlite3.connect(db)
            for table, n in expected.items():
                got = con.execute(f'SELECT COUNT(*) FROM "{table}"').fetchone()[0]
                self.assertEqual(got, n, table)
            self.assertGreater(con.execute("SELECT COUNT(*) FROM prototype_crosswalk").fetchone()[0], 50)
            self.assertEqual(len(con.execute("PRAGMA foreign_key_check").fetchall()), 0)

    def test_committed_db_matches_seed(self):
        db = os.path.join(ROOT, "platform", "db", "andalus.sqlite")
        self.assertTrue(os.path.exists(db), "قاعدة المنصة غير موجودة؛ شغّل الترحيل")
        p = subprocess.run([sys.executable, MIGRATE, "--db", db, "--check-only"], capture_output=True, text=True)
        self.assertEqual(p.returncode, 0, p.stdout)


if __name__ == "__main__":
    unittest.main()
