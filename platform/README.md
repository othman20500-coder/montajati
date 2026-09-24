# منصة الأندلس: طبقة البيانات والخدمة (v1.2)

القواعد الملزمة في `CLAUDE.md` بجذر المستودع (قسم «قواعد منصة الأندلس»). مصدر الحقيقة: `andalus_handoff/seed/` ← هذه القاعدة ← التصدير الثابت.

| الأمر | ما يفعله |
|---|---|
| `python platform/tools/migrate_v1_2.py --db platform/db/andalus.sqlite` | يُنشئ القاعدة من `db/schema.sql` إن لم توجد، ويُدخل أو يحدّث 43 جدولًا من `seed/json` بالمفتاح الأساسي (يعمل أكثر من مرة دون تكرار)، ويحقن مطابقة معرّفات النموذج الأولي، ويتحقق من `table_counts.json` |
| `python platform/tools/migrate_v1_2.py --db … --check-only` | يتحقق من الأعداد فقط |
| `python andalus_handoff/tests/andalus_qa_v1_2.py --db platform/db/andalus.sqlite` | فحوص الجودة الـ26 (بوابة الدمج) |
| `python platform/tools/export_static.py --db platform/db/andalus.sqlite --out andalus/data/graph.js` | يولّد طبقة بيانات النموذج الثابت من الحالات القابلة للنشر فقط |
| `python -m unittest discover -s platform/tests -v` | الترحيل (تكرار وتطابق)، الانحدار (22)، بوابة الأدلة، فحوص المراجعة (9) واختباراتها (14) واختبارات خدمة المراجعة |
| `python andalus_handoff/tests/andalus_review_qa.py --db platform/db/andalus.sqlite` | فحوص خاصية المراجعة الـ9 |
| `python andalus_handoff/spec/reference_api_v1_2.py --db platform/db/andalus.sqlite --port 8787` | الخدمة المرجعية محليًا |

## خاصية المراجعة بالعين (`service/`)

| الأمر | ما يفعله |
|---|---|
| `python platform/service/app.py create-user --db platform/db/andalus.sqlite --username othman --name "عثمان الشهري" --role owner --password …` | حساب صاحب المشروع (يعتمد المراجعين) |
| `python platform/service/app.py create-user … --role reviewer` | حساب مراجع (يسجّل بياناته ثم ينتظر الاعتماد) |
| `python platform/service/app.py serve --db platform/db/andalus.sqlite --port 8787` | الخدمة: مسارات القراءة v1.2 + مسارات المراجعة + شاشة المراجعة ولوحة الاعتماد على `/review` |
| `python platform/tools/import_reviews.py --artifact-dir <تصدير صفحة المراجعة> --owner "…"` أو `--excel form.xlsx` | نقل الأحكام السابقة (يعمل أكثر من مرة دون تكرار)، ثم أعد التصدير الثابت |

القواعد المنفذة (`andalus_handoff/spec/review/README.md`): صاحب المشروع وحده يعتمد أو يسحب (سجل لا يُحذف)؛ المراجع المعتمد وقت الحكم وحده يحكم (403 لغيره)؛ الحكم بفرق أو عدم مطابقة يلزمه ملاحظة (422)؛ حكم واحد لكل مراجع على كل شاهد يعدّله أو يسحبه؛ الحالة تُحسب من `v_attestation_review_status`؛ عند «معتمد بالعين» يُكتب في `attestations.verbatim_check` «مطابق بالعين: المراجعان وتخصصاهما، التاريخ» وتُحفظ القيمة السابقة في `attestation_verbatim_history` وتُستعاد إذا زالت الحالة. الشارة تظهر في طبقة الأدلة بالنموذج الثابت بعد إعادة التصدير.

قائمة المراجعة (`/api/v1/reviews/queue`) = الشواهد التي فُحصت عبر WebFetch أو صور الصفحات أو OCR أو PDF: 57 شاهدًا، مطابقة لقائمة صفحة المراجعة على claude.ai.

بوابة CI في `.github/workflows/andalus-ci.yml`: ترحيل مرتين، فحوص الجودة، تطابق التصدير، والاختبارات؛ أي فشل يمنع الدمج. **حماية الفرع** (اشتراط نجاح `andalus-ci` قبل الدمج) تُفعَّل من إعدادات GitHub ولا يمكن ضبطها من هنا.

- `andalus/data/graph.js` مولَّد؛ لا يُحرَّر يدويًا. `andalus/data/graph.prototype.js` هو النموذج البحثي القديم (مستوى بحث، بلا شواهد حرفية) ولا يُحمَّل في الواجهة العامة (القرار 2).
- إضافة أي محتوى تاريخي تمر بمهارة `andalus-evidence` وتُكتب في القاعدة، ثم يُعاد التصدير.
