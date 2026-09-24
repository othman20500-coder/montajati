#!/usr/bin/env python3
from __future__ import annotations
import argparse, json, sqlite3, sys
from datetime import date, datetime

def connect(path):
    con=sqlite3.connect(path); con.row_factory=sqlite3.Row; con.execute('PRAGMA foreign_keys=ON'); return con

def main():
    ap=argparse.ArgumentParser(); ap.add_argument('--db',default='andalus_atlas_v1_2.sqlite'); ap.add_argument('--json-out')
    a=ap.parse_args(); checks=[]
    with connect(a.db) as con:
        integrity=con.execute('PRAGMA integrity_check').fetchone()[0]
        checks.append(('sqlite_integrity',integrity=='ok',integrity,'ok'))
        fk=len(con.execute('PRAGMA foreign_key_check').fetchall())
        checks.append(('foreign_keys',fk==0,fk,0))
        orphan_sources=con.execute('''SELECT COUNT(*) FROM claim_sources cs LEFT JOIN sources s ON s.source_id=cs.source_id WHERE s.source_id IS NULL''').fetchone()[0]
        checks.append(('claim_source_links',orphan_sources==0,orphan_sources,0))
        orphan_evidence=con.execute('''SELECT COUNT(*) FROM claim_evidence ce LEFT JOIN evidence e ON e.evidence_id=ce.evidence_id WHERE e.evidence_id IS NULL''').fetchone()[0]
        checks.append(('claim_evidence_links',orphan_evidence==0,orphan_evidence,0))
        claims_missing_evidence=con.execute('''SELECT COUNT(*) FROM claims c WHERE NOT EXISTS(SELECT 1 FROM claim_evidence ce WHERE ce.claim_id=c.claim_id)''').fetchone()[0]
        checks.append(('claims_have_evidence',claims_missing_evidence==0,claims_missing_evidence,0))
        claims_missing_source=con.execute('''SELECT COUNT(*) FROM claims c WHERE NOT EXISTS(SELECT 1 FROM claim_sources cs WHERE cs.claim_id=c.claim_id)''').fetchone()[0]
        checks.append(('claims_have_sources',claims_missing_source==0,claims_missing_source,0))
        quiz_orphans=con.execute('''SELECT COUNT(*) FROM quiz_items q LEFT JOIN claims c ON c.claim_id=q.claim_id WHERE c.claim_id IS NULL''').fetchone()[0]
        checks.append(('quiz_claim_links',quiz_orphans==0,quiz_orphans,0))
        step_orphans=con.execute('''SELECT COUNT(*) FROM learning_module_steps s LEFT JOIN claims c ON c.claim_id=s.claim_id WHERE s.claim_id IS NOT NULL AND c.claim_id IS NULL''').fetchone()[0]
        checks.append(('learning_claim_links',step_orphans==0,step_orphans,0))
        owners=con.execute("SELECT COUNT(*) FROM maintenance_owners WHERE status='نشط'").fetchone()[0]
        checks.append(('owner_roles',owners>=6,owners,'>=6'))
        unowned=con.execute("SELECT COUNT(*) FROM maintenance_rules WHERE status='نشط' AND (owner_role IS NULL OR owner_role='')").fetchone()[0]
        checks.append(('maintenance_ownership',unowned==0,unowned,0))
        watch=con.execute('SELECT COUNT(*) FROM source_watchlist WHERE active=1').fetchone()[0]
        checks.append(('critical_watchlist',watch>=8,watch,'>=8'))
        missing_health=con.execute('''SELECT COUNT(*) FROM source_watchlist w WHERE w.active=1 AND NOT EXISTS (SELECT 1 FROM source_health h WHERE h.source_id=w.source_id)''').fetchone()[0]
        checks.append(('watchlist_health_snapshot',missing_health==0,missing_health,0))
        bad_health=con.execute("SELECT COUNT(*) FROM source_health h JOIN source_watchlist w ON w.source_id=h.source_id WHERE w.active=1 AND h.checked_at=(SELECT MAX(h2.checked_at) FROM source_health h2 WHERE h2.source_id=h.source_id) AND h.status NOT IN ('OK','OK_WITH_REDIRECT','OK_WITH_FALLBACK')").fetchone()[0]
        checks.append(('critical_source_usable',bad_health==0,bad_health,0))
        orphan_att=con.execute("SELECT COUNT(*) FROM attestations t LEFT JOIN assertions a USING(assertion_id) WHERE a.assertion_id IS NULL").fetchone()[0]
        checks.append(('attestation_assertion_links',orphan_att==0,orphan_att,0))
        no_att=con.execute("SELECT COUNT(*) FROM assertions a WHERE NOT EXISTS(SELECT 1 FROM attestations t WHERE t.assertion_id=a.assertion_id)").fetchone()[0]
        checks.append(('assertions_have_attestations',no_att==0,no_att,0))
        open_conf=con.execute("SELECT COUNT(*) FROM assertions WHERE status='متعارض — يحتاج قرارًا'").fetchone()[0]
        checks.append(('no_unresolved_conflicts',open_conf==0,open_conf,0))
        bad_quote=con.execute("SELECT COUNT(*) FROM attestations WHERE quote IS NULL OR quote='' OR locator IS NULL OR locator=''").fetchone()[0]
        checks.append(('attestation_quote_and_locator',bad_quote==0,bad_quote,0))
        ten_logic=con.execute("""SELECT COUNT(*) FROM tenures t JOIN entities p ON p.entity_id=t.person_id WHERE (t.start_year>t.end_year)
          OR (p.end_date GLOB '[0-9][0-9][0-9][0-9]' AND t.end_year>CAST(p.end_date AS INT))
          OR (p.start_date GLOB '[0-9][0-9][0-9][0-9]' AND t.start_year<CAST(p.start_date AS INT))""").fetchone()[0]
        checks.append(('tenure_date_logic',ten_logic==0,ten_logic,0))
        per_logic=con.execute("SELECT COUNT(*) FROM periods WHERE NOT(start_earliest<=start_latest AND end_earliest<=end_latest)").fetchone()[0]
        checks.append(('period_bounds_logic',per_logic==0,per_logic,0))
        hijacked=con.execute("SELECT COUNT(*) FROM sources WHERE url LIKE '%ibntufayl.org%' OR url LIKE '%relmin.eu%'").fetchone()[0]
        checks.append(('no_hijacked_domains',hijacked==0,hijacked,0))
        xw=con.execute("SELECT COUNT(*) FROM id_crosswalk x LEFT JOIN entities e ON e.entity_id=x.release_id WHERE e.entity_id IS NULL").fetchone()[0]
        checks.append(('crosswalk_targets_exist',xw==0,xw,0))
        missing_place_source=con.execute("SELECT COUNT(*) FROM place_geometry WHERE coordinate_source IS NULL OR coordinate_source=''").fetchone()[0]
        checks.append(('place_coordinate_provenance',missing_place_source==0,missing_place_source,0))
        missing_conf=con.execute("SELECT COUNT(*) FROM claims WHERE confidence IS NULL OR confidence=''").fetchone()[0]
        checks.append(('claim_confidence',missing_conf==0,missing_conf,0))
        missing_verified=con.execute("SELECT COUNT(*) FROM claims WHERE last_verified IS NULL OR last_verified=''").fetchone()[0]
        checks.append(('claim_last_verified',missing_verified==0,missing_verified,0))
        gates_total=con.execute('SELECT COUNT(*) FROM release_gates').fetchone()[0]
        gates_pass=con.execute("SELECT COUNT(*) FROM release_gates WHERE status='PASS'").fetchone()[0]
        checks.append(('release_gates',gates_total==8 and gates_pass==8,f'{gates_pass}/{gates_total}','8/8'))
        ready=con.execute("SELECT release_ready FROM release_manifest WHERE version='v1.2'").fetchone()
        ready=ready[0] if ready else 0
        checks.append(('release_manifest',ready==1,ready,1))
    result={'version':'v1.2','passed':sum(1 for _,ok,_,_ in checks if ok),'total':len(checks),'checks':[{'name':n,'pass':ok,'observed':obs,'target':target} for n,ok,obs,target in checks]}
    result['status']='PASS' if result['passed']==result['total'] else 'FAIL'
    print(json.dumps(result,ensure_ascii=False,indent=2))
    if a.json_out:
        open(a.json_out,'w',encoding='utf-8').write(json.dumps(result,ensure_ascii=False,indent=2))
    raise SystemExit(0 if result['status']=='PASS' else 1)
if __name__=='__main__': main()
