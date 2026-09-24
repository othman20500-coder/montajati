-- امتدادات المنصة على مخطط v1.2 (لا تعدّل جدولًا قائمًا)
-- مطابقة معرّفات النموذج الأولي (andalus/data/graph.prototype.js) بمعرّفات الإصدار؛ منفصلة عن id_crosswalk (مطابقة فرع الأدلة) حفاظًا على عقد الخدمة
CREATE TABLE IF NOT EXISTS prototype_crosswalk (
  prototype_id TEXT NOT NULL,
  release_id TEXT NOT NULL,
  entity_kind TEXT,
  match_basis TEXT,
  PRIMARY KEY (prototype_id, release_id)
);

-- سجل قيمة verbatim_check قبل أن تكتبها خاصية المراجعة («مطابق بالعين: …») حتى تُستعاد عند سحب الاعتماد أو تغيّر الحالة
CREATE TABLE IF NOT EXISTS attestation_verbatim_history (
  attestation_id TEXT NOT NULL,
  previous_verbatim_check TEXT,
  written_verbatim_check TEXT,
  changed_at TEXT NOT NULL,
  restored_at TEXT,
  PRIMARY KEY (attestation_id, changed_at)
);

-- مستخدمو المنصة (الدخول والصلاحيات): owner يعتمد المراجعين؛ reviewer يسجّل بياناته ويحكم بعد اعتماده
CREATE TABLE IF NOT EXISTS platform_users (
  user_id TEXT PRIMARY KEY,
  username TEXT NOT NULL UNIQUE,
  display_name TEXT NOT NULL,
  role TEXT NOT NULL CHECK (role IN ('owner','reviewer')),
  password_salt TEXT NOT NULL,
  password_hash TEXT NOT NULL,
  created_at TEXT NOT NULL,
  active INTEGER NOT NULL DEFAULT 1
);
CREATE TABLE IF NOT EXISTS platform_sessions (
  token TEXT PRIMARY KEY,
  user_id TEXT NOT NULL REFERENCES platform_users(user_id),
  created_at TEXT NOT NULL,
  expires_at TEXT NOT NULL
);
