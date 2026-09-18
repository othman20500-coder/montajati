# منتجاتي

موقع ثابت من صفحتين (`index.html` و`office.html`) وصور في `assets/`. لا يوجد بناء ولا حزم ولا خادم. التفاصيل في `README.md`.

## الأوامر

- تدقيق HTML (الأداة تُثبَّت تلقائياً في جلسات الويب عبر `.claude/hooks/session-start.sh`):
  `html-validate index.html office.html`
- معاينة محلية:
  `python3 -m http.server 8000` ثم افتح `http://localhost:8000/index.html`
- فحص سريع بأن الصفحتين تُقدَّمان:
  `python3 -m http.server 8000 & sleep 1; curl -sfo /dev/null http://localhost:8000/index.html && curl -sfo /dev/null http://localhost:8000/office.html && echo OK; kill %1`

## ملاحظات

- المحتوى يُعدَّل من كتلتي `PROJECTS` و`SITE` في `index.html` وكتلة `DATA` في `office.html`.
- `office.html` يحوي مسارات محلية ولا يُنشر على Netlify.
