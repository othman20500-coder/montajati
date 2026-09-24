#!/usr/bin/env python3
from __future__ import annotations
import argparse, json, sqlite3
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from urllib.parse import urlparse, parse_qs

def connect(path):
    con=sqlite3.connect(path); con.row_factory=sqlite3.Row; return con
def rows(con,sql,p=()): return [dict(r) for r in con.execute(sql,p).fetchall()]
def one(con,sql,p=()):
    r=con.execute(sql,p).fetchone(); return dict(r) if r else None

def module_detail(con,module_id):
    m=one(con,"SELECT * FROM v_learning_modules WHERE module_id=?",(module_id,))
    if not m: return None
    try: m["learning_objectives"]=json.loads(m.pop("learning_objectives_json"))
    except: pass
    m["steps"]=rows(con,"""SELECT s.*,c.canonical_wording_ar,c.confidence,e.preferred_name_ar place_name,
      g.lat,g.lon FROM learning_module_steps s
      LEFT JOIN claims c ON c.claim_id=s.claim_id
      LEFT JOIN entities e ON e.entity_id=s.place_entity_id
      LEFT JOIN place_geometry g ON g.entity_id=s.place_entity_id
      WHERE s.module_id=? ORDER BY s.ordinal""",(module_id,))
    q=rows(con,"SELECT * FROM v_quiz_ready WHERE module_id=? ORDER BY ordinal",(module_id,))
    for x in q: x["choices"]=json.loads(x.pop("choices_json"))
    m["quiz"]=q
    return m

def claim_detail(con,cid):
    c=one(con,"SELECT * FROM claims WHERE claim_id=?",(cid,))
    if not c: return None
    c["sources"]=rows(con,"""SELECT s.*,sr.license_label,sr.license_url,sr.reuse_note
      FROM claim_sources cs JOIN sources s ON s.source_id=cs.source_id
      LEFT JOIN source_rights sr ON sr.source_id=s.source_id WHERE cs.claim_id=? ORDER BY cs.ordinal""",(cid,))
    c["evidence"]=rows(con,"""SELECT e.*,ce.relation FROM claim_evidence ce JOIN evidence e ON e.evidence_id=ce.evidence_id
      WHERE ce.claim_id=? ORDER BY ce.ordinal""",(cid,))
    c["attestations"]=rows(con,"""SELECT l.relation link,t.*,s.label source_label FROM assertion_claim_links l
      JOIN attestations t ON t.assertion_id=l.assertion_id JOIN sources s ON s.source_id=t.source_id WHERE l.claim_id=? ORDER BY t.attestation_id""",(cid,))
    return c

def dispatch(con,path,q):
    p=[x for x in path.replace("/api/v1/","",1).split("/") if x]
    if p==["learning","modules"]:
        data=rows(con,"SELECT * FROM v_learning_modules WHERE status='جاهز' ORDER BY module_id")
        for x in data:
            try: x["learning_objectives"]=json.loads(x.pop("learning_objectives_json"))
            except: pass
        return 200,data
    if len(p)==3 and p[:2]==["learning","modules"]:
        d=module_detail(con,p[2]); return (200,d) if d else (404,{"error":"module_not_found"})
    if p==["quiz"]:
        sql="SELECT * FROM v_quiz_ready WHERE status='جاهز'"; params=[]
        if q.get("module"): sql+=" AND module_id=?"; params.append(q["module"][0])
        sql+=" ORDER BY module_id,ordinal"
        data=rows(con,sql,params)
        for x in data: x["choices"]=json.loads(x.pop("choices_json"))
        return 200,data
    if p==["maintenance"]:
        return 200,rows(con,"SELECT * FROM maintenance_rules ORDER BY severity DESC,rule_id")
    if p==["qa","latest"]:
        return 200,rows(con,"SELECT * FROM qa_test_runs ORDER BY qa_id")
    if p==["release-gates"]:
        return 200,rows(con,"SELECT * FROM release_gates ORDER BY gate_id")
    if p==["release","status"]:
        m=one(con,"SELECT * FROM release_manifest ORDER BY release_date DESC, version DESC LIMIT 1") or {}
        m["gates"]=rows(con,"SELECT * FROM release_gates ORDER BY gate_id")
        return 200,m
    if p==["maintenance","owners"]:
        return 200,rows(con,"SELECT * FROM maintenance_owners ORDER BY owner_role")
    if p==["sources","health"]:
        return 200,rows(con,"""SELECT w.priority,w.owner_role,w.check_cadence_days,s.source_id,s.label,s.url,h.checked_at,h.status,h.method,h.observed,h.fallback_url,h.next_check
          FROM source_watchlist w JOIN sources s ON s.source_id=w.source_id
          LEFT JOIN source_health h ON h.source_id=s.source_id
          AND h.checked_at=(SELECT MAX(h2.checked_at) FROM source_health h2 WHERE h2.source_id=s.source_id)
          WHERE w.active=1 ORDER BY CASE w.priority WHEN 'P1' THEN 1 ELSE 2 END,s.source_id""")
    if p==["maintenance","runs"]:
        return 200,rows(con,"SELECT * FROM maintenance_runs ORDER BY run_date DESC,run_id DESC")
    if p==["places"]:
        return 200,rows(con,"SELECT * FROM v_places_atlas ORDER BY COALESCE(display_priority,0) DESC,preferred_name_ar")
    if p==["map.geojson"]:
        fs=[]
        for r in rows(con,"SELECT * FROM v_places_atlas ORDER BY COALESCE(display_priority,0) DESC"):
            fs.append({"type":"Feature","id":r["entity_id"],"geometry":{"type":"Point","coordinates":[r["lon"],r["lat"]]},
                       "properties":{k:r.get(k) for k in ["entity_id","preferred_name_ar","preferred_name_latn","spatial_quality","anchor_type","claim_count","period_group","theme","historical_status","display_priority"]}})
        return 200,{"type":"FeatureCollection","features":fs}
    if p==["stories"]:
        return 200,rows(con,"""SELECT s.*,(SELECT COUNT(*) FROM atlas_story_steps st WHERE st.story_id=s.story_id) step_count FROM atlas_stories s ORDER BY story_id""")
    if p==["claims"]:
        return 200,rows(con,"SELECT * FROM claims ORDER BY claim_id")
    if len(p)==2 and p[0]=="claims":
        d=claim_detail(con,p[1]); return (200,d) if d else (404,{"error":"claim_not_found"})
    if p==["search"]:
        term=(q.get("q") or [""])[0].strip()
        if not term: return 400,{"error":"q_required"}
        t=f"%{term}%"
        return 200,rows(con,"""SELECT entity_id,entity_type,preferred_name_ar,preferred_name_latn FROM entities
          WHERE preferred_name_ar LIKE ? OR preferred_name_latn LIKE ? ORDER BY entity_type,preferred_name_ar LIMIT 50""",(t,t))
    if p==["periods"]:
        return 200,rows(con,"SELECT * FROM periods ORDER BY start_earliest")
    if p==["tenures"]:
        return 200,rows(con,"SELECT * FROM v_tenures ORDER BY start_year")
    if p==["events"]:
        return 200,rows(con,"SELECT * FROM historical_events ORDER BY COALESCE(start_year,9999)")
    if len(p)==2 and p[0]=="persons":
        d=one(con,"SELECT * FROM entities WHERE entity_id=? AND entity_type='Person'",(p[1],))
        if not d: return 404,{"error":"person_not_found"}
        d["name_parts"]=one(con,"SELECT * FROM person_name_parts WHERE entity_id=?",(p[1],))
        d["tenures"]=rows(con,"SELECT * FROM v_tenures WHERE person_id=? ORDER BY start_year",(p[1],))
        d["assertions"]=rows(con,"SELECT * FROM v_assertion_status WHERE target_id=?",(p[1],))
        return 200,d
    if p==["assertions"]:
        sql="SELECT * FROM v_assertion_status"; params=[]
        if q.get("model"): sql+=" WHERE model=?"; params.append(q["model"][0])
        return 200,rows(con,sql+" ORDER BY assertion_id",params)
    if len(p)==2 and p[0]=="assertions":
        d=one(con,"SELECT * FROM v_assertion_status WHERE assertion_id=?",(p[1],))
        if not d: return 404,{"error":"assertion_not_found"}
        d["attestations"]=rows(con,"SELECT t.*,s.label source_label FROM attestations t JOIN sources s USING(source_id) WHERE assertion_id=? ORDER BY attestation_id",(p[1],))
        d["claims"]=rows(con,"SELECT * FROM assertion_claim_links WHERE assertion_id=?",(p[1],))
        return 200,d
    if p==["crosswalk"]:
        return 200,rows(con,"SELECT * FROM id_crosswalk ORDER BY entity_kind,branch_id")
    return 404,{"error":"endpoint_not_found"}

class Handler(BaseHTTPRequestHandler):
    db_path="andalus_atlas_v1_2.sqlite"
    def do_GET(self):
        u=urlparse(self.path)
        with connect(self.db_path) as con: st,data=dispatch(con,u.path,parse_qs(u.query))
        body=json.dumps(data,ensure_ascii=False,indent=2).encode()
        self.send_response(st); self.send_header("Content-Type","application/json; charset=utf-8")
        self.send_header("Access-Control-Allow-Origin","*"); self.send_header("Content-Length",str(len(body)))
        self.end_headers(); self.wfile.write(body)
    def log_message(self,*a): pass

def main():
    ap=argparse.ArgumentParser(); ap.add_argument("--db",default="andalus_atlas_v1_2.sqlite"); ap.add_argument("--port",type=int,default=8787)
    a=ap.parse_args(); Handler.db_path=a.db
    server=ThreadingHTTPServer(("127.0.0.1",a.port),Handler)
    print(f"http://127.0.0.1:{a.port}/api/v1/release/status"); server.serve_forever()
if __name__=="__main__": main()
