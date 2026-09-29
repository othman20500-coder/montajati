# طبقات الخريطة الأساسية (Natural Earth)

خريطة الأساس التاريخية لمحرّك MapLibre: يابسة وأنهار فقط، **بلا طرق ولا حدود سياسية حديثة**
(القاعدة 7: لا يُعرض حدٌّ سياسيّ تاريخيّ، والمرساة تقريبية تُعرض كذلك).

## الملفات والرخصة
| الملف | المحتوى | المصدر | الرخصة |
|---|---|---|---|
| `land.geojson` | مضلّعات اليابسة | Natural Earth 1:50m Physical (`ne_50m_land`) | **ملك عام (Public Domain)** — بلا قيود |
| `rivers.geojson` | مجاري الأنهار الرئيسة | Natural Earth 1:50m (`ne_50m_rivers_lake_centerlines`) | **ملك عام (Public Domain)** |

Natural Earth بيانات ملك عام صراحةً: «no permission is needed to use Natural Earth. Crediting the authors is unnecessary». المصدر: naturalearthdata.com، ونسخة GeoJSON من مستودع `nvkelso/natural-earth-vector` على GitHub.

## المعالجة
البيانات الأصلية عالمية (~1.6MB لليابسة). قُصَّت على نطاق الأندلس والمغرب
`[-11, 29, 6, 45]` (خط الطول/العرض) بخوارزمية Sutherland–Hodgman، وقُرِّبت الإحداثيات
إلى 3 منازل، فصغُر المجموع إلى ~13KB. لا تحرير يدويّ للأشكال.

## إعادة التوليد
```
python3 andalus/data/geo/build_geo.py
```
يحتاج وصولًا للشبكة (يجلب من GitHub raw). ليس جزءًا من بوابة CI (لا شبكة فيها)؛
الملفات المولَّدة مُلتزَمة في المستودع. الإحداثيات تقريبية، ولا يُشتقّ منها حدٌّ سياسيّ.
