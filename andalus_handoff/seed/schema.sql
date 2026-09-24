CREATE VIEW v_assertion_status AS SELECT a.*, (SELECT COUNT(*) FROM attestations t WHERE t.assertion_id=a.assertion_id) attestation_count,
  (SELECT COUNT(*) FROM attestations t WHERE t.assertion_id=a.assertion_id AND t.verbatim_check LIKE 'مطابق حرفيًا%') verbatim_ok FROM assertions a;

CREATE VIEW v_claim_detail AS
SELECT c.claim_id,c.canonical_wording_ar,c.verdict,c.confidence,c.status,c.last_verified,
       COUNT(DISTINCT cs.source_id) AS source_count,
       COUNT(DISTINCT ce.evidence_id) AS evidence_count,
       COUNT(DISTINCT cent.entity_id) AS entity_count
FROM claims c
LEFT JOIN claim_sources cs ON cs.claim_id=c.claim_id
LEFT JOIN claim_evidence ce ON ce.claim_id=c.claim_id
LEFT JOIN claim_entities cent ON cent.claim_id=c.claim_id
GROUP BY c.claim_id;

CREATE VIEW v_entity_graph_degree AS
SELECT e.entity_id,e.entity_type,e.preferred_name_ar,
       (SELECT COUNT(*) FROM relations r WHERE r.subject_id=e.entity_id OR r.object_id=e.entity_id) AS relation_degree,
       (SELECT COUNT(*) FROM claim_entities ce WHERE ce.entity_id=e.entity_id) AS claim_degree
FROM entities e;

CREATE VIEW v_learning_modules AS
SELECT m.*,
 (SELECT COUNT(*) FROM learning_module_steps s WHERE s.module_id=m.module_id) AS step_count,
 (SELECT COUNT(*) FROM quiz_items q WHERE q.module_id=m.module_id) AS quiz_count
FROM learning_modules m;

CREATE VIEW v_places_atlas AS
SELECT vp.*, m.period_group,m.theme,m.historical_status,m.display_priority,m.note_ar
FROM v_places_geo vp
LEFT JOIN atlas_place_metadata m ON m.entity_id=vp.entity_id;

CREATE VIEW v_places_geo AS
SELECT e.entity_id,e.preferred_name_ar,e.preferred_name_latn,e.notes,
       g.lat,g.lon,g.geometry_type,g.spatial_quality,g.anchor_type,g.coordinate_source,g.last_verified,
       (SELECT COUNT(*) FROM claim_entities ce WHERE ce.entity_id=e.entity_id) AS claim_count
FROM entities e JOIN place_geometry g ON g.entity_id=e.entity_id
WHERE e.entity_type='Place';

CREATE VIEW v_quiz_ready AS
SELECT q.*, c.confidence AS claim_confidence, c.status AS claim_status
FROM quiz_items q JOIN claims c ON c.claim_id=q.claim_id;

CREATE VIEW v_tenures AS SELECT t.*, p.preferred_name_ar person_name, pol.preferred_name_ar polity_name FROM tenures t
  JOIN entities p ON p.entity_id=t.person_id JOIN entities pol ON pol.entity_id=t.polity_id;

CREATE TABLE assertion_claim_links(assertion_id TEXT NOT NULL, claim_id TEXT NOT NULL, relation TEXT, PRIMARY KEY(assertion_id, claim_id),
  FOREIGN KEY(assertion_id) REFERENCES assertions(assertion_id), FOREIGN KEY(claim_id) REFERENCES claims(claim_id));

CREATE TABLE assertions(assertion_id TEXT PRIMARY KEY, target_id TEXT NOT NULL, field TEXT NOT NULL, kind TEXT, value_ar TEXT NOT NULL, value_before TEXT,
  status TEXT NOT NULL, resolution_ar TEXT, todo_ar TEXT, model TEXT NOT NULL, last_verified TEXT NOT NULL);

CREATE TABLE atlas_layer_members (
  layer_id TEXT NOT NULL,
  entity_id TEXT NOT NULL,
  role TEXT,
  PRIMARY KEY(layer_id,entity_id),
  FOREIGN KEY(layer_id) REFERENCES atlas_layers(layer_id),
  FOREIGN KEY(entity_id) REFERENCES entities(entity_id)
);

CREATE TABLE atlas_layers (
  layer_id TEXT PRIMARY KEY,
  label_ar TEXT NOT NULL,
  layer_type TEXT NOT NULL,
  description_ar TEXT,
  min_year INTEGER,
  max_year INTEGER,
  cartographic_status TEXT
);

CREATE TABLE atlas_place_metadata (
  entity_id TEXT PRIMARY KEY,
  period_group TEXT NOT NULL,
  theme TEXT NOT NULL,
  historical_status TEXT NOT NULL,
  display_priority INTEGER NOT NULL DEFAULT 50,
  note_ar TEXT,
  FOREIGN KEY(entity_id) REFERENCES entities(entity_id)
);

CREATE TABLE atlas_stories (
  story_id TEXT PRIMARY KEY,
  title_ar TEXT NOT NULL,
  summary_ar TEXT,
  period_label TEXT,
  warning_ar TEXT
);

CREATE TABLE atlas_story_steps (
  story_id TEXT NOT NULL,
  ordinal INTEGER NOT NULL,
  place_entity_id TEXT,
  claim_id TEXT,
  title_ar TEXT,
  narrative_ar TEXT,
  PRIMARY KEY(story_id,ordinal),
  FOREIGN KEY(story_id) REFERENCES atlas_stories(story_id),
  FOREIGN KEY(place_entity_id) REFERENCES entities(entity_id),
  FOREIGN KEY(claim_id) REFERENCES claims(claim_id)
);

CREATE TABLE atlas_zones (
  zone_id TEXT PRIMARY KEY,
  label_ar TEXT NOT NULL,
  min_year INTEGER,
  max_year INTEGER,
  theme TEXT,
  cartographic_status TEXT NOT NULL,
  geometry_geojson TEXT NOT NULL,
  note_ar TEXT
);

CREATE TABLE attestations(attestation_id TEXT PRIMARY KEY, assertion_id TEXT NOT NULL, source_id TEXT NOT NULL, source_kind TEXT, locator TEXT NOT NULL,
  quote TEXT NOT NULL, stance TEXT NOT NULL, verbatim_check TEXT, note_ar TEXT, url TEXT, checked_on TEXT NOT NULL,
  FOREIGN KEY(assertion_id) REFERENCES assertions(assertion_id), FOREIGN KEY(source_id) REFERENCES sources(source_id));

CREATE TABLE boundary_sources (
  boundary_source_id TEXT PRIMARY KEY,
  label TEXT NOT NULL,
  url TEXT NOT NULL,
  coverage TEXT,
  rights_status TEXT,
  evidence_grade TEXT,
  intended_use TEXT,
  qa_rule TEXT,
  last_checked TEXT
);

CREATE TABLE change_log(
  change_id TEXT PRIMARY KEY,
  changed_at TEXT NOT NULL,
  component TEXT NOT NULL,
  change_type TEXT NOT NULL,
  summary_ar TEXT NOT NULL,
  source_or_ticket TEXT,
  version TEXT NOT NULL
);

CREATE TABLE claim_entities (
  claim_id TEXT NOT NULL,
  entity_id TEXT NOT NULL,
  role TEXT,
  PRIMARY KEY (claim_id, entity_id, role),
  FOREIGN KEY(claim_id) REFERENCES claims(claim_id),
  FOREIGN KEY(entity_id) REFERENCES entities(entity_id)
);

CREATE TABLE claim_evidence (
  claim_id TEXT NOT NULL,
  evidence_id TEXT NOT NULL,
  relation TEXT,
  ordinal INTEGER NOT NULL DEFAULT 1,
  PRIMARY KEY (claim_id, evidence_id),
  FOREIGN KEY(claim_id) REFERENCES claims(claim_id),
  FOREIGN KEY(evidence_id) REFERENCES evidence(evidence_id)
);

CREATE TABLE claim_sources (
  claim_id TEXT NOT NULL,
  source_id TEXT NOT NULL,
  ordinal INTEGER NOT NULL DEFAULT 1,
  PRIMARY KEY (claim_id, source_id),
  FOREIGN KEY (claim_id) REFERENCES claims(claim_id),
  FOREIGN KEY (source_id) REFERENCES sources(source_id)
);

CREATE TABLE claims (
  claim_id TEXT PRIMARY KEY,
  original_claim TEXT,
  verdict TEXT NOT NULL,
  canonical_wording_ar TEXT NOT NULL,
  evidence_type TEXT,
  evidence_relation TEXT,
  confidence TEXT,
  status TEXT,
  last_verified TEXT,
  version TEXT
);

CREATE TABLE entities (
  entity_id TEXT PRIMARY KEY,
  entity_type TEXT NOT NULL,
  preferred_name_ar TEXT,
  preferred_name_latn TEXT,
  start_date TEXT,
  end_date TEXT,
  notes TEXT
);

CREATE TABLE entity_aliases (
  alias_id TEXT PRIMARY KEY,
  entity_id TEXT NOT NULL,
  alias TEXT NOT NULL,
  script TEXT,
  language TEXT,
  normalized TEXT,
  FOREIGN KEY(entity_id) REFERENCES entities(entity_id)
);

CREATE TABLE event_persons(event_id TEXT NOT NULL, person_id TEXT NOT NULL, PRIMARY KEY(event_id, person_id),
  FOREIGN KEY(event_id) REFERENCES historical_events(event_id), FOREIGN KEY(person_id) REFERENCES entities(entity_id));

CREATE TABLE evidence (
  evidence_id TEXT PRIMARY KEY,
  evidence_type TEXT NOT NULL,
  label_ar TEXT NOT NULL,
  date_text TEXT,
  place_entity_id TEXT,
  description_ar TEXT,
  confidence TEXT,
  source_id TEXT,
  FOREIGN KEY(place_entity_id) REFERENCES entities(entity_id),
  FOREIGN KEY(source_id) REFERENCES sources(source_id)
);

CREATE TABLE historical_events(event_id TEXT PRIMARY KEY, title_ar TEXT NOT NULL, start_year INTEGER, end_year INTEGER, precision TEXT, hijri TEXT,
  place_id TEXT, period_id TEXT, polity_id TEXT, confidence TEXT, legacy_refs TEXT,
  FOREIGN KEY(place_id) REFERENCES entities(entity_id), FOREIGN KEY(period_id) REFERENCES periods(period_id), FOREIGN KEY(polity_id) REFERENCES entities(entity_id));

CREATE TABLE id_crosswalk(branch_id TEXT NOT NULL, release_id TEXT NOT NULL, entity_kind TEXT, match_basis TEXT, distance_km REAL,
  PRIMARY KEY(branch_id, release_id), FOREIGN KEY(release_id) REFERENCES entities(entity_id));

CREATE TABLE learning_module_steps (
  module_id TEXT NOT NULL,
  ordinal INTEGER NOT NULL,
  step_type TEXT NOT NULL,
  title_ar TEXT NOT NULL,
  body_ar TEXT NOT NULL,
  claim_id TEXT,
  place_entity_id TEXT,
  interaction_hint TEXT,
  PRIMARY KEY(module_id,ordinal),
  FOREIGN KEY(module_id) REFERENCES learning_modules(module_id),
  FOREIGN KEY(claim_id) REFERENCES claims(claim_id),
  FOREIGN KEY(place_entity_id) REFERENCES entities(entity_id)
);

CREATE TABLE learning_modules (
  module_id TEXT PRIMARY KEY,
  title_ar TEXT NOT NULL,
  summary_ar TEXT NOT NULL,
  level TEXT NOT NULL,
  estimated_minutes INTEGER,
  period_label TEXT,
  learning_objectives_json TEXT,
  status TEXT NOT NULL,
  version TEXT NOT NULL
);

CREATE TABLE maintenance_owners(
  owner_role TEXT PRIMARY KEY,
  responsibility_ar TEXT NOT NULL,
  scope TEXT NOT NULL,
  backup_role TEXT,
  escalation_days INTEGER NOT NULL,
  status TEXT NOT NULL
);

CREATE TABLE maintenance_rules (
  rule_id TEXT PRIMARY KEY,
  target_scope TEXT NOT NULL,
  cadence_days INTEGER,
  trigger_condition TEXT,
  action_ar TEXT NOT NULL,
  severity TEXT NOT NULL,
  next_review TEXT,
  status TEXT NOT NULL
, owner_role TEXT);

CREATE TABLE maintenance_runs(
  run_id TEXT PRIMARY KEY,
  run_date TEXT NOT NULL,
  run_type TEXT NOT NULL,
  result TEXT NOT NULL,
  checks_run INTEGER NOT NULL,
  failures INTEGER NOT NULL,
  note_ar TEXT
);

CREATE TABLE periods(period_id TEXT PRIMARY KEY, label_ar TEXT NOT NULL, label_en TEXT, start_earliest INTEGER NOT NULL, start_latest INTEGER NOT NULL,
  end_earliest INTEGER NOT NULL, end_latest INTEGER NOT NULL, hijri TEXT, spatial TEXT, note_ar TEXT, parent_id TEXT,
  CHECK(start_earliest<=start_latest AND end_earliest<=end_latest AND start_earliest<=end_latest));

CREATE TABLE person_name_parts(entity_id TEXT PRIMARY KEY, ism TEXT, kunya TEXT, nasab TEXT, nisba TEXT, laqab TEXT, origin TEXT NOT NULL,
  FOREIGN KEY(entity_id) REFERENCES entities(entity_id));

CREATE TABLE place_geometry (
  entity_id TEXT PRIMARY KEY,
  lat REAL NOT NULL,
  lon REAL NOT NULL,
  geometry_type TEXT NOT NULL DEFAULT 'Point',
  spatial_quality TEXT NOT NULL,
  anchor_type TEXT,
  coordinate_source TEXT,
  last_verified TEXT,
  FOREIGN KEY(entity_id) REFERENCES entities(entity_id)
);

CREATE TABLE qa_test_runs (
  qa_id TEXT PRIMARY KEY,
  run_date TEXT NOT NULL,
  gate TEXT NOT NULL,
  test_name TEXT NOT NULL,
  result TEXT NOT NULL,
  observed_value TEXT,
  target_value TEXT,
  note_ar TEXT
);

CREATE TABLE quiz_items (
  quiz_id TEXT PRIMARY KEY,
  module_id TEXT NOT NULL,
  ordinal INTEGER NOT NULL,
  question_type TEXT NOT NULL,
  prompt_ar TEXT NOT NULL,
  choices_json TEXT NOT NULL,
  correct_index INTEGER NOT NULL,
  explanation_ar TEXT NOT NULL,
  claim_id TEXT NOT NULL,
  difficulty TEXT NOT NULL,
  status TEXT NOT NULL,
  FOREIGN KEY(module_id) REFERENCES learning_modules(module_id),
  FOREIGN KEY(claim_id) REFERENCES claims(claim_id)
);

CREATE TABLE relations (
  relation_id TEXT PRIMARY KEY,
  subject_id TEXT NOT NULL,
  predicate TEXT NOT NULL,
  object_id TEXT NOT NULL,
  confidence TEXT,
  claim_id TEXT,
  FOREIGN KEY (subject_id) REFERENCES entities(entity_id),
  FOREIGN KEY (object_id) REFERENCES entities(entity_id),
  FOREIGN KEY (claim_id) REFERENCES claims(claim_id)
);

CREATE TABLE release_gates (
  gate_id TEXT PRIMARY KEY,
  label_ar TEXT NOT NULL,
  status TEXT NOT NULL,
  evidence_ar TEXT,
  last_checked TEXT NOT NULL
);

CREATE TABLE release_manifest(
  version TEXT PRIMARY KEY,
  release_date TEXT NOT NULL,
  knowledge_base_version TEXT NOT NULL,
  db_version TEXT NOT NULL,
  api_version TEXT NOT NULL,
  atlas_version TEXT NOT NULL,
  learning_version TEXT NOT NULL,
  gates_pass INTEGER NOT NULL,
  gates_total INTEGER NOT NULL,
  release_ready INTEGER NOT NULL,
  manifest_sha256 TEXT,
  note_ar TEXT
);

CREATE TABLE release_scope(
 scope_id TEXT PRIMARY KEY, component TEXT NOT NULL, included INTEGER NOT NULL,
 policy_ar TEXT NOT NULL, gate_effect TEXT NOT NULL);

CREATE TABLE route_stops (
  route_id TEXT NOT NULL,
  ordinal INTEGER NOT NULL,
  place_entity_id TEXT,
  person_entity_id TEXT,
  work_entity_id TEXT,
  note TEXT,
  PRIMARY KEY(route_id, ordinal),
  FOREIGN KEY(route_id) REFERENCES routes(route_id),
  FOREIGN KEY(place_entity_id) REFERENCES entities(entity_id),
  FOREIGN KEY(person_entity_id) REFERENCES entities(entity_id),
  FOREIGN KEY(work_entity_id) REFERENCES entities(entity_id)
);

CREATE TABLE routes (
  route_id TEXT PRIMARY KEY,
  label_ar TEXT NOT NULL,
  route_type TEXT,
  start_date TEXT,
  end_date TEXT,
  claim_id TEXT,
  notes TEXT,
  FOREIGN KEY(claim_id) REFERENCES claims(claim_id)
);

CREATE TABLE source_dependencies (
  dependency_id TEXT PRIMARY KEY,
  upstream TEXT NOT NULL,
  downstream TEXT NOT NULL,
  relation_type TEXT,
  period TEXT,
  claim_or_use TEXT,
  reference TEXT,
  confidence TEXT,
  url TEXT
);

CREATE TABLE source_health(
  source_id TEXT NOT NULL,
  checked_at TEXT NOT NULL,
  status TEXT NOT NULL,
  method TEXT NOT NULL,
  observed TEXT,
  fallback_url TEXT,
  next_check TEXT,
  PRIMARY KEY(source_id,checked_at),
  FOREIGN KEY(source_id) REFERENCES sources(source_id)
);

CREATE TABLE source_rights (
  source_id TEXT PRIMARY KEY,
  license_label TEXT,
  license_url TEXT,
  reuse_note TEXT,
  last_verified TEXT,
  FOREIGN KEY(source_id) REFERENCES sources(source_id)
);

CREATE TABLE source_watchlist(
  source_id TEXT PRIMARY KEY,
  priority TEXT NOT NULL,
  owner_role TEXT NOT NULL,
  check_cadence_days INTEGER NOT NULL,
  expected_access TEXT NOT NULL,
  fallback_strategy_ar TEXT,
  active INTEGER NOT NULL DEFAULT 1,
  FOREIGN KEY(source_id) REFERENCES sources(source_id),
  FOREIGN KEY(owner_role) REFERENCES maintenance_owners(owner_role)
);

CREATE TABLE sources (
  source_id TEXT PRIMARY KEY,
  label TEXT,
  url TEXT UNIQUE NOT NULL,
  domain TEXT,
  publisher TEXT,
  source_class TEXT,
  last_checked TEXT
);

CREATE TABLE tenures(tenure_id TEXT PRIMARY KEY, person_id TEXT NOT NULL, polity_id TEXT NOT NULL, role TEXT, start_year INTEGER, end_year INTEGER,
  precision TEXT, note_ar TEXT, FOREIGN KEY(person_id) REFERENCES entities(entity_id), FOREIGN KEY(polity_id) REFERENCES entities(entity_id));

CREATE INDEX idx_atlas_meta_period ON atlas_place_metadata(period_group);

CREATE INDEX idx_atlas_meta_status ON atlas_place_metadata(historical_status);

CREATE INDEX idx_claim_entities_entity ON claim_entities(entity_id);

CREATE INDEX idx_claim_sources_source ON claim_sources(source_id);

CREATE INDEX idx_claims_confidence ON claims(confidence);

CREATE INDEX idx_claims_status ON claims(status);

CREATE INDEX idx_entities_type ON entities(entity_type);

CREATE INDEX idx_evidence_source ON evidence(source_id);

CREATE INDEX idx_place_geometry_lat_lon ON place_geometry(lat, lon);

CREATE INDEX idx_relations_object ON relations(object_id);

CREATE INDEX idx_relations_subject ON relations(subject_id);

