# منصة الأندلس: طبقة البيانات والخدمة (v1.2)

القواعد الملزمة في `CLAUDE.md` بجذر المستودع (قسم «قواعد منصة الأندلس»). مصدر الحقيقة: `andalus_handoff/seed/` ← هذه القاعدة ← التصدير الثابت.

| الأمر | ما يفعله |
|---|---|
| `python platform/tools/migrate_v1_2.py --db platform/db/andalus.sqlite` | يُنشئ القاعدة من `db/schema.sql` إن لم توجد، ويُدخل أو يحدّث 43 جدولًا من `seed/json` بالمفتاح الأساسي (يعمل أكثر من مرة دون تكرار)، ويحقن مطابقة معرّفات النموذج الأولي، ويتحقق من `table_counts.json` |
| `python platform/tools/migrate_v1_2.py --db … --check-only` | يتحقق من الأعداد فقط |
| `--additions platform/seed/additions` (افتراضي) | ملحقات البذور المحلية بعد v1.2 (انظر `platform/seed/additions/README.md`): تُطبَّق بعد بذور الحزمة، وتُرفض إن كررت مفتاحًا منها، وتُضاف أعدادها إلى الأعداد المتوقعة. مجلد غير موجود = قاعدة v1.2 صِرفة |
| `python andalus_handoff/tests/andalus_qa_v1_2.py --db platform/db/andalus.sqlite` | فحوص الجودة الـ26 (بوابة الدمج) |
| `python platform/tools/export_static.py --db platform/db/andalus.sqlite --out andalus/data/graph.js` | يولّد طبقة بيانات النموذج الثابت من الحالات القابلة للنشر فقط |
| `python -m unittest discover -s platform/tests -v` | الترحيل (تكرار وتطابق)، الانحدار (22 على قاعدة v1.2 صِرفة بأعدادها الدقيقة، ثم على قاعدة المنصة بشرط ألا ينكمش العقد)، بوابة الأدلة، فحوص المراجعة (9) واختباراتها (14) واختبارات خدمة المراجعة |
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

## النشر على Render (`render.yaml` في جذر المستودع)

الخدمة `andalus-review`: عند كل إقلاع يُشغَّل الترحيل على القرص الدائم `/var/data/andalus.sqlite` (يعمل أكثر من مرة دون تكرار) ثم الخدمة على `$PORT`، وفحص الصحة على `/api/v1/release/status`. بعد أول نشر يُنشأ حساب صاحب المشروع من صدفة الخدمة (`create-user … --role owner`) ثم حسابات المراجعين؛ كلمات المرور لا تُكتب في المستودع. ربط المستودع بـRender وإنشاء الخدمة من الملف يتمان من لوحة Render ولا يمكن إجراؤهما من هنا.

بوابة CI في `.github/workflows/andalus-ci.yml`: ترحيل مرتين، فحوص الجودة، تطابق التصدير، والاختبارات؛ أي فشل يمنع الدمج. **حماية الفرع** (اشتراط نجاح `andalus-ci` قبل الدمج) تُفعَّل من إعدادات GitHub ولا يمكن ضبطها من هنا.

- التصدير يضم أيضًا `ATLAS` (طبقات `atlas_layers` وأعضاؤها، مظاريف `atlas_zones` بوسمها الكارتوغرافي، سياسة الإصدار، مصادر الحدود المرشحة، ومجموعات إسنادات كل نموذج، والمسارات `routes` بمحطاتها)، ويربط كل حدث بقصصه ومساراته عبر الادعاء ← الإسناد ← الهدف؛ فتُعرض القصة على الخريطة مرحلةً مرحلة (`#/atlas?story=…&step=…`) وكل مرحلة بشواهدها والمصدر الأولي مقدَّم لواجهة الأطلس الموحّد في `andalus/index.html#/atlas`، المبنية مكوّناتٍ بالاسترشاد بالنموذج المرجعي دون نسخه.
- `andalus/data/graph.js` مولَّد؛ لا يُحرَّر يدويًا. `andalus/data/graph.prototype.js` هو النموذج البحثي القديم (مستوى بحث، بلا شواهد حرفية) ولا يُحمَّل في الواجهة العامة (القرار 2).
- إضافة أي محتوى تاريخي تمر بمهارة `andalus-evidence` وتُكتب في القاعدة، ثم يُعاد التصدير.
