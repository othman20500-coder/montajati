# منصة الأندلس: طبقة البيانات والخدمة (v1.2)

القواعد الملزمة في `CLAUDE.md` بجذر المستودع (قسم «قواعد منصة الأندلس»). مصدر الحقيقة: `andalus_handoff/seed/` ← هذه القاعدة ← التصدير الثابت.

| الأمر | ما يفعله |
|---|---|
| `python platform/tools/migrate_v1_2.py --db platform/db/andalus.sqlite` | يُنشئ القاعدة من `db/schema.sql` إن لم توجد، ويُدخل أو يحدّث 43 جدولًا من `seed/json` بالمفتاح الأساسي (يعمل أكثر من مرة دون تكرار)، ويحقن مطابقة معرّفات النموذج الأولي، ويتحقق من `table_counts.json` |
| `python platform/tools/migrate_v1_2.py --db … --check-only` | يتحقق من الأعداد فقط |
| `python andalus_handoff/tests/andalus_qa_v1_2.py --db platform/db/andalus.sqlite` | فحوص الجودة الـ26 (بوابة الدمج) |
| `python platform/tools/export_static.py --db platform/db/andalus.sqlite --out andalus/data/graph.js` | يولّد طبقة بيانات النموذج الثابت من الحالات القابلة للنشر فقط |
| `python -m unittest discover -s platform/tests -v` | الترحيل (تكرار وتطابق)، الانحدار (22)، بوابة الأدلة |
| `python andalus_handoff/spec/reference_api_v1_2.py --db platform/db/andalus.sqlite --port 8787` | الخدمة المرجعية محليًا |

بوابة CI في `.github/workflows/andalus-ci.yml`: ترحيل مرتين، فحوص الجودة، تطابق التصدير، والاختبارات؛ أي فشل يمنع الدمج. **حماية الفرع** (اشتراط نجاح `andalus-ci` قبل الدمج) تُفعَّل من إعدادات GitHub ولا يمكن ضبطها من هنا.

- `andalus/data/graph.js` مولَّد؛ لا يُحرَّر يدويًا. `andalus/data/graph.prototype.js` هو النموذج البحثي القديم (مستوى بحث، بلا شواهد حرفية) ولا يُحمَّل في الواجهة العامة (القرار 2).
- إضافة أي محتوى تاريخي تمر بمهارة `andalus-evidence` وتُكتب في القاعدة، ثم يُعاد التصدير.
