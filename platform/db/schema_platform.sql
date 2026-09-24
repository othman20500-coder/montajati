-- امتدادات المنصة على مخطط v1.2 (لا تعدّل جدولًا قائمًا)
-- مطابقة معرّفات النموذج الأولي (andalus/data/graph.prototype.js) بمعرّفات الإصدار؛ منفصلة عن id_crosswalk (مطابقة فرع الأدلة) حفاظًا على عقد الخدمة
CREATE TABLE IF NOT EXISTS prototype_crosswalk (
  prototype_id TEXT NOT NULL,
  release_id TEXT NOT NULL,
  entity_kind TEXT,
  match_basis TEXT,
  PRIMARY KEY (prototype_id, release_id)
);
