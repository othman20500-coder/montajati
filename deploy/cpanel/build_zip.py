#!/usr/bin/env python3
"""يبني حزمة نشر مضغوطة (andalus-site.zip) جاهزة للرفع اليدوي عبر cPanel File Manager.

الحزمة تحوي ما تنشره Netlify (و.cpanel.yml) نفسه فقط: الصفحة وبيانات الإصدار و.htaccess،
دون الوثائق البحثية (*.md) ولا النموذج الأولي graph.prototype.js (محتوى غير موثّق للنشر العام).

التشغيل من أي مكان:  python3 deploy/cpanel/build_zip.py
الناتج:              deploy/cpanel/dist/andalus-site.zip

الرفع: File Manager ← public_html/andalus ← Upload، ثم استخرج الحزمة هناك (Extract).
عند فك الضغط تظهر الملفات مباشرةً في public_html/andalus؛ لا تستبدل صفحة الجذر.
يعمل ببايثون قياسي فقط؛ بلا اعتماديات خارجية (يوافق قاعدة platform/CLAUDE.md).
"""
import os
import sys
import zipfile

# نفس مجموعة الملفات العامة في .cpanel.yml بالضبط: (المصدر النسبي من جذر المستودع، المسار داخل الحزمة)
FILES = [
    ("andalus/index.html", "index.html"),
    ("andalus/atlas-light.css", "atlas-light.css"),
    ("andalus/identity.css", "identity.css"),
    ("andalus/identity.js", "identity.js"),
    ("andalus/assets/andalus-mark.png", "assets/andalus-mark.png"),
    ("andalus/data/cartography.js", "data/cartography.js"),
    ("andalus/data/graph.js", "data/graph.js"),
    ("andalus/data/graph.evidence.js", "data/graph.evidence.js"),
    ("andalus/data/schema.json", "data/schema.json"),
    ("andalus/data/media.js", "data/media.js"),
    ("andalus/data/geo/land.geojson", "data/geo/land.geojson"),
    ("andalus/data/geo/rivers.geojson", "data/geo/rivers.geojson"),
    ("deploy/cpanel/.htaccess", ".htaccess"),
]

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, "..", ".."))
OUT_DIR = os.path.join(HERE, "dist")
ZIP_PATH = os.path.join(OUT_DIR, "andalus-site.zip")


def main():
    os.makedirs(OUT_DIR, exist_ok=True)
    missing = [src for src, _ in FILES if not os.path.isfile(os.path.join(ROOT, src))]
    if missing:
        sys.exit("ملفات مفقودة (شغّل platform/tools/export_static.py أولًا؟):\n  " + "\n  ".join(missing))

    if os.path.exists(ZIP_PATH):
        os.remove(ZIP_PATH)

    total = 0
    with zipfile.ZipFile(ZIP_PATH, "w", zipfile.ZIP_DEFLATED) as z:
        for src, arc in FILES:
            path = os.path.join(ROOT, src)
            z.write(path, arc)
            total += os.path.getsize(path)

    print("تم بناء الحزمة:")
    print("  " + ZIP_PATH)
    with zipfile.ZipFile(ZIP_PATH) as z:
        for n in z.namelist():
            print(f"    - {n}")
    print(f"  حجم المحتوى قبل الضغط: {total/1024/1024:.2f}MB · حجم الحزمة: {os.path.getsize(ZIP_PATH)/1024/1024:.2f}MB")


if __name__ == "__main__":
    main()
