#!/usr/bin/env python3
"""مسارات القراءة لخاصية المراجعة، فوق الخدمة المرجعية v1.2.

python spec/review/reference_review_api.py --db <قاعدة فيها جداول المراجعة> --port 8788
مسارات الكتابة (التسجيل، الاعتماد، الحكم) موصوفة في api_review.md وتُبنى في المنصة مع الدخول والصلاحيات.
"""
import argparse, importlib.util, json, os, sqlite3
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from urllib.parse import urlparse, parse_qs

HERE = os.path.dirname(os.path.abspath(__file__))
_spec = importlib.util.spec_from_file_location('base', os.path.join(HERE, '..', 'reference_api_v1_2.py'))
base = importlib.util.module_from_spec(_spec); _spec.loader.exec_module(base)


def rows(con, sql, args=()):
    return [dict(r) for r in con.execute(sql, args)]


def dispatch(con, path, q):
    p = [x for x in path.split('/') if x][2:]  # بعد /api/v1
    if p == ['reviewers']:
        # لا تُعرض بيانات من لم يُعتمد للعموم
        return 200, rows(con, "SELECT reviewer_id, full_name, degree, field, org FROM v_reviewer_current WHERE approved=1 ORDER BY full_name")
    if p == ['reviews', 'status']:
        sql = """SELECT s.*, t.assertion_id, t.source_id FROM v_attestation_review_status s JOIN attestations t USING(attestation_id)"""
        args = []
        if q.get('status'):
            sql += ' WHERE s.review_status = ?'; args.append(q['status'][0])
        return 200, rows(con, sql + ' ORDER BY s.attestation_id', args)
    if len(p) == 3 and p[0] == 'attestations' and p[2] == 'reviews':
        st = con.execute('SELECT * FROM v_attestation_review_status WHERE attestation_id=?', (p[1],)).fetchone()
        if not st:
            return 404, {'error': 'attestation_not_found'}
        d = dict(st)
        d['reviews'] = rows(con, """SELECT r.verdict, r.note_ar, r.reviewed_at, r.source, c.full_name, c.degree, c.field, c.org
                                    FROM attestation_reviews r JOIN v_reviewer_current c USING(reviewer_id)
                                    WHERE r.attestation_id=? AND c.approved=1 ORDER BY r.reviewed_at""", (p[1],))
        return 200, d
    return base.dispatch(con, path, q)


class Handler(BaseHTTPRequestHandler):
    db_path = None
    def do_GET(self):
        u = urlparse(self.path)
        con = sqlite3.connect(self.db_path); con.row_factory = sqlite3.Row
        try:
            st, data = dispatch(con, u.path, parse_qs(u.query))
        finally:
            con.close()
        body = json.dumps(data, ensure_ascii=False, indent=2).encode()
        self.send_response(st); self.send_header('Content-Type', 'application/json; charset=utf-8')
        self.send_header('Content-Length', str(len(body))); self.end_headers(); self.wfile.write(body)
    def log_message(self, *a): pass


if __name__ == '__main__':
    ap = argparse.ArgumentParser(); ap.add_argument('--db', required=True); ap.add_argument('--port', type=int, default=8788)
    a = ap.parse_args(); Handler.db_path = a.db
    ThreadingHTTPServer(('127.0.0.1', a.port), Handler).serve_forever()
