# عقد خدمة القراءة v1.2

الخدمة المرجعية: `spec/reference_api_v1_2.py` (Python قياسية، بلا اعتماديات). التشغيل:

```
python spec/reference_api_v1_2.py --db seed/andalus_atlas_v1_2.sqlite --port 8787
```

كل مسار يعيد JSON. عينة استجابة كل مسار في `spec/api_samples/<name>.json` بصيغة `[status, body]`.

| المسار | الوصف | العينة | عدد العناصر في الاختبار |
|---|---|---|---|
| `/api/v1/release/status` | حالة الإصدار الأحدث | `release.json` | — |
| `/api/v1/maintenance/owners` | أدوار الصيانة | `owners.json` | 6 |
| `/api/v1/sources/health` | صحة المصادر المراقبة | `source-health.json` | 8 |
| `/api/v1/maintenance/runs` | سجل تشغيل الصيانة | `maintenance-runs.json` | 1 |
| `/api/v1/learning/modules` | الوحدات التعليمية الجاهزة | `modules.json` | 6 |
| `/api/v1/quiz` | أسئلة التقويم مربوطة بالادعاءات | `quiz.json` | 15 |
| `/api/v1/places` | الأماكن مع الإحداثية وجودتها | `places.json` | 46 |
| `/api/v1/map.geojson` | الأماكن بصيغة GeoJSON | `map.json` | 46 |
| `/api/v1/stories` | قصص الأطلس ومحطاتها | `stories.json` | 4 |
| `/api/v1/claims` | ادعاءات النواة المنشورة | `claims.json` | 29 |
| `/api/v1/claims/ATLAS-CLM01` | تفصيل ادعاء: مصادره وأدلته وشواهده | `claim-detail.json` | — |
| `/api/v1/periods` | العصور بحدودها المبكرة والمتأخرة | `periods.json` | 11 |
| `/api/v1/tenures` | مدد الولاية | `tenures.json` | 17 |
| `/api/v1/events` | الأحداث التاريخية | `events.json` | 21 |
| `/api/v1/persons/PER-034` | شخص مع ولاياته وأجزاء اسمه | `person.json` | — |
| `/api/v1/assertions` | الإسنادات (يقبل ?model=cordoba|granada) | `assertions-granada.json` | 33 |
| `/api/v1/assertions/AST-G28` | إسناد مع شواهده | `assertion-detail.json` | — |
| `/api/v1/crosswalk` | مطابقة معرّفات الفرع بمعرّفات الإصدار | `crosswalk.json` | 19 |
| `/api/v1/claims/CLM-001` | ادعاء مع شواهد الإسنادات المرتبطة | `claim-with-attestations.json` | — |
| `/api/v1/search?q=قرطبة` | بحث نصي (?q= إلزامي، وإلا 400) | `search.json` | 4 |

## قواعد يلتزم بها أي تنفيذ جديد
- المسارات والحقول بالأسماء نفسها، أو بإصدار جديد (`/api/v2`) مع إبقاء v1.
- الإسناد لا يُعاد للواجهة العامة إلا إذا كانت حالته قابلة للنشر (انظر CLAUDE.md، القاعدة 4).
- `/release/status` يعيد أحدث إصدار (مرتبًا بتاريخ الإصدار ثم برقمه تنازليًا).
- يجب أن ينجح التنفيذ الجديد في كل ما في `tests/andalus_api_regression_v1_2.json`.
