-- خاصية المراجعة بالعين: مراجعون متخصصون يعتمدهم صاحب المشروع، وأحكامهم على الشواهد.
-- تُضاف إلى قاعدة v1.2 دون تعديل أي جدول قائم. آمنة للتشغيل أكثر من مرة.

CREATE TABLE IF NOT EXISTS reviewers (
  reviewer_id   TEXT PRIMARY KEY,               -- art:<معرّف صفحة المراجعة> | xl:<بصمة> | usr:<معرّف المنصة>
  source        TEXT NOT NULL CHECK (source IN ('artifact','excel','platform')),
  full_name     TEXT NOT NULL CHECK (length(trim(full_name)) > 0),
  degree        TEXT,                           -- دكتوراه | ماجستير | بكالوريوس | غير ذلك
  field         TEXT NOT NULL CHECK (length(trim(field)) > 0),  -- التخصص الدقيق
  org           TEXT,
  langs         TEXT,
  declaration   TEXT,                           -- نص الإقرار الموقّع (استمارة Excel)
  registered_at TEXT NOT NULL
);

-- سجل لا يُحذف منه: كل اعتماد أو سحب اعتماد صف جديد.
CREATE TABLE IF NOT EXISTS reviewer_approvals (
  approval_id  INTEGER PRIMARY KEY AUTOINCREMENT,
  reviewer_id  TEXT NOT NULL REFERENCES reviewers(reviewer_id),
  approved     INTEGER NOT NULL CHECK (approved IN (0,1)),
  decided_by   TEXT NOT NULL,                   -- صاحب المشروع
  decided_at   TEXT NOT NULL,
  note_ar      TEXT,
  UNIQUE (reviewer_id, decided_at, approved)
);

CREATE TABLE IF NOT EXISTS attestation_reviews (
  review_id      INTEGER PRIMARY KEY AUTOINCREMENT,
  attestation_id TEXT NOT NULL REFERENCES attestations(attestation_id),
  reviewer_id    TEXT NOT NULL REFERENCES reviewers(reviewer_id),
  verdict        TEXT NOT NULL CHECK (verdict IN ('مطابق','مطابق بفرق يسير','غير مطابق')),
  note_ar        TEXT,                          -- الفرق، أو النص الصحيح وموضعه
  reviewed_at    TEXT NOT NULL,
  source         TEXT NOT NULL CHECK (source IN ('artifact','excel','platform')),
  UNIQUE (attestation_id, reviewer_id)          -- حكم واحد لكل مراجع على كل شاهد (يُحدَّث ولا يُكرر)
);

-- الاعتماد الحالي لكل مراجع: آخر قرار.
DROP VIEW IF EXISTS v_reviewer_current;
CREATE VIEW v_reviewer_current AS
SELECT r.reviewer_id, r.full_name, r.degree, r.field, r.org, r.source,
       COALESCE((SELECT a.approved FROM reviewer_approvals a WHERE a.reviewer_id = r.reviewer_id
                 ORDER BY a.decided_at DESC, a.approval_id DESC LIMIT 1), 0) AS approved
FROM reviewers r;

-- حالة المراجعة لكل شاهد، بأحكام المراجعين المعتمدين حاليًا فقط.
-- القاعدة: معتمد بالعين = مراجعان معتمدان حكما «مطابق» ولا حكم مخالف.
DROP VIEW IF EXISTS v_attestation_review_status;
CREATE VIEW v_attestation_review_status AS
WITH v AS (
  SELECT ar.attestation_id, ar.verdict
  FROM attestation_reviews ar JOIN v_reviewer_current rc USING (reviewer_id)
  WHERE rc.approved = 1
), c AS (
  SELECT t.attestation_id,
         SUM(CASE WHEN v.verdict = 'مطابق' THEN 1 ELSE 0 END)           AS n_ok,
         SUM(CASE WHEN v.verdict = 'مطابق بفرق يسير' THEN 1 ELSE 0 END) AS n_minor,
         SUM(CASE WHEN v.verdict = 'غير مطابق' THEN 1 ELSE 0 END)       AS n_bad
  FROM attestations t LEFT JOIN v USING (attestation_id)
  GROUP BY t.attestation_id
)
SELECT attestation_id, COALESCE(n_ok,0) n_ok, COALESCE(n_minor,0) n_minor, COALESCE(n_bad,0) n_bad,
  CASE WHEN COALESCE(n_bad,0)   > 0 THEN 'غير مطابق'
       WHEN COALESCE(n_minor,0) > 0 THEN 'خلاف أو فرق'
       WHEN COALESCE(n_ok,0)   >= 2 THEN 'معتمد بالعين'
       WHEN COALESCE(n_ok,0)    = 1 THEN 'يحتاج مراجعًا ثانيًا'
       ELSE 'لم يُراجع' END AS review_status
FROM c;
