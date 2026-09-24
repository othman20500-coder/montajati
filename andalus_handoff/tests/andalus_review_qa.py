#!/usr/bin/env python3
"""فحوص خاصية المراجعة بالعين. تُشغَّل بعد spec/review/schema_review.sql على قاعدة v1.2.

python tests/andalus_review_qa.py --db <path>
يخرج JSON بالنتيجة، ورمز خروج 1 إذا فشل أي فحص.
"""
import argparse, json, sqlite3, sys

CHECKS = [
    ('review_tables_present',
     "SELECT 3 - COUNT(*) FROM sqlite_master WHERE type='table' AND name IN ('reviewers','reviewer_approvals','attestation_reviews')",
     'الجداول الثلاثة موجودة'),
    ('reviews_attestation_exists',
     "SELECT COUNT(*) FROM attestation_reviews r LEFT JOIN attestations t USING(attestation_id) WHERE t.attestation_id IS NULL",
     'كل حكم على شاهد موجود'),
    ('reviews_reviewer_exists',
     "SELECT COUNT(*) FROM attestation_reviews r LEFT JOIN reviewers v USING(reviewer_id) WHERE v.reviewer_id IS NULL",
     'كل حكم لمراجع مسجّل'),
    ('reviewer_profile_complete',
     "SELECT COUNT(*) FROM reviewers WHERE trim(COALESCE(full_name,''))='' OR trim(COALESCE(field,''))=''",
     'لكل مراجع اسم وتخصص'),
    ('review_by_approved_reviewer',
     """SELECT COUNT(*) FROM attestation_reviews r
        WHERE COALESCE((SELECT a.approved FROM reviewer_approvals a
                        WHERE a.reviewer_id = r.reviewer_id AND a.decided_at <= r.reviewed_at
                        ORDER BY a.decided_at DESC, a.approval_id DESC LIMIT 1), 0) <> 1
          AND r.source <> 'excel'""",
     'كل حكم من المنصة أو صفحة المراجعة صدر ومراجعه معتمد وقت الحكم'),
    ('approval_decider_recorded',
     "SELECT COUNT(*) FROM reviewer_approvals WHERE trim(COALESCE(decided_by,''))='' OR trim(COALESCE(decided_at,''))=''",
     'لكل قرار اعتماد صاحبه وتاريخه'),
    ('non_match_has_note',
     "SELECT COUNT(*) FROM attestation_reviews WHERE verdict <> 'مطابق' AND trim(COALESCE(note_ar,''))=''",
     'كل حكم بفرق أو بعدم مطابقة معه ملاحظة'),
    ('eye_verified_label_backed',
     """SELECT COUNT(*) FROM attestations t JOIN v_attestation_review_status s USING(attestation_id)
        WHERE t.verbatim_check LIKE '%مطابق بالعين%' AND s.review_status <> 'معتمد بالعين'""",
     'لا يوصف شاهد بأنه «مطابق بالعين» إلا بحكم مراجعَين معتمدَين دون مخالف'),
    ('one_review_per_reviewer',
     "SELECT COUNT(*) FROM (SELECT attestation_id, reviewer_id FROM attestation_reviews GROUP BY 1,2 HAVING COUNT(*)>1)",
     'حكم واحد لكل مراجع على كل شاهد'),
]


def run(db_path):
    con = sqlite3.connect(db_path)
    out = []
    for name, sql, desc in CHECKS:
        try:
            bad = con.execute(sql).fetchone()[0]
        except sqlite3.Error as e:
            out.append({'check': name, 'pass': False, 'value': str(e), 'target': 0, 'desc': desc}); continue
        out.append({'check': name, 'pass': bad == 0, 'value': bad, 'target': 0, 'desc': desc})
    passed = sum(c['pass'] for c in out)
    return {'status': 'PASS' if passed == len(out) else 'FAIL', 'passed': passed, 'total': len(out), 'checks': out}


if __name__ == '__main__':
    ap = argparse.ArgumentParser(); ap.add_argument('--db', required=True)
    res = run(ap.parse_args().db)
    print(json.dumps(res, ensure_ascii=False, indent=1))
    sys.exit(0 if res['status'] == 'PASS' else 1)
