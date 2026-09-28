# نشر منصة الأندلس على cPanel عبر Git

هذا الدليل يربط استضافة cPanel بمستودع GitHub، فيُنشر الموقع بسحب واحد بعد كل دمج في `main`.

الموقع ثابت بالكامل (بلا خادم ولا قاعدة بيانات): صفحة `index.html` تقرأ بياناتها من
`data/graph.js` و`data/graph.evidence.js`. التنقّل داخل الصفحة بعناوين هاش (`#/atlas`…)
فلا يحتاج أي إعادة توجيه على الخادم.

## ما الذي يُنشر (وما لا يُنشر)
تنسخ وصفة `‎.cpanel.yml` إلى `public_html` ما تنشره Netlify نفسه فقط:
- `index.html`
- `data/graph.js` · `data/graph.evidence.js` · `data/schema.json`
- `‎.htaccess` (رؤوس الأمان والتخزين المؤقت — مترجَم من `andalus/_headers`)

ولا تنسخ عمدًا: الوثائق البحثية `andalus/*.md`، والنموذج الأولي `data/graph.prototype.js`،
و`data/README.md` — لأنها محتوى بحثي فيه بنود لم تُتحقق، ومكانها المستودع لا الموقع العام
(المنع نفسه المطبَّق في `andalus/_redirects` على Netlify).

## خطوات الإعداد (مرة واحدة)
1. **بدّل اسم المستخدم في الوصفة:** افتح `‎.cpanel.yml` في جذر المستودع، واستبدل `USERNAME`
   في `DEPLOYPATH=/home/USERNAME/public_html` باسم مستخدم حسابك في cPanel (تجده في أعلى
   شريط File Manager: `/home/‎<اسمك>`). ادفع التعديل إلى `main`.
   - لنشر الموقع في **مجلد فرعي** أو **مجال فرعي** بدّل المسار كله، مثل
     `/home/USERNAME/andalus` أو `/home/USERNAME/public_html/andalus`.
2. **cPanel → Git™ Version Control → Create.**
   - Clone URL: رابط المستودع. للمستودع العام:
     `https://github.com/othman20500-coder/montajati.git`
     (لو صار خاصًّا، استخدم رابط SSH وأضِف مفتاح النشر من cPanel إلى GitHub → Deploy keys).
   - Repository Path: مسار داخل الحساب لِنسخة المستودع، مثل `/home/USERNAME/repos/montajati`
     (ليس داخل `public_html`).
   - Branch: `main`.
3. بعد الاستنساخ، افتح المستودع في القائمة، ثم لسان **Pull or Deploy**:
   - **Update from Remote** لجلب آخر التغييرات.
   - **Deploy HEAD Commit** لتشغيل مهام `‎.cpanel.yml` (النسخ إلى `public_html`).
   - يظهر «Last deployment» أخضر عند النجاح. افتح نطاقك للتأكد.

## التحديث بعد كل تعديل
بعد أي دمج جديد في `main`:
- **يدويًا:** cPanel → Git Version Control → المستودع → Update from Remote ثم Deploy HEAD Commit.
- **تلقائيًا (اختياري):** GitHub → Settings → Webhooks → Add webhook، والصقْ رابط النشر
  الذي تعطيه cPanel (Push Deployment / زر Copy في صفحة المستودع)؛ فيصبح كل دفع إلى `main`
  ناشرًا تلقائيًّا. لا تضع أي سر أو رمز في المستودع.

## تحقّق سريع بعد النشر
- الصفحة الرئيسة تفتح، والخريطة والقصص تعمل.
- افتح أدوات المطوّر ← Network: `data/graph.js` و`data/graph.evidence.js` يُحمَّلان بحالة
  200 (أول مرة) ثم 304 عند إعادة الزيارة دون تغيير.
- `‎/00-README.md` و`‎/data/graph.prototype.js` يعطيان 404 (غير منشورَين) — وهذا مقصود.
- إن لم تظهر تغييرة بعد النشر، فحدِّث الصفحة تحديثًا قسريًّا (Ctrl+Shift+R).

## ملاحظات
- تحتاج الاستضافة تفعيل الوحدات `mod_headers` و`mod_deflate` (مفعّلة غالبًا في cPanel).
  ملف `‎.htaccess` يحرسها بـ `<IfModule>` فلا يتعطّل الموقع إن غابت إحداها.
- إن كان النطاق يعرض شهادة HTTPS من cPanel (AutoSSL) فالرؤوس تعمل كما هي.
