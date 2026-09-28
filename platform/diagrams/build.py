# يولّد صفحة مخططات منصة الأندلس بنظام Diagram Design بعد تكييفه للعربية
# الاستخدام: python platform/diagrams/build.py /tmp/fragment.html platform/diagrams/index.html
import sqlite3, sys, pathlib

DB = str(pathlib.Path(__file__).resolve().parents[2] / "platform/db/andalus.sqlite")
OUT_FRAGMENT = sys.argv[1]
OUT_STANDALONE = sys.argv[2]

MARKERS = """
<marker id="{p}-arrow" markerWidth="8" markerHeight="6" refX="7" refY="3" orient="auto"><polygon class="mk" points="0 0, 8 3, 0 6"/></marker>
<marker id="{p}-arrow-accent" markerWidth="8" markerHeight="6" refX="7" refY="3" orient="auto"><polygon class="mk-accent" points="0 0, 8 3, 0 6"/></marker>
<marker id="{p}-arrow-link" markerWidth="8" markerHeight="6" refX="7" refY="3" orient="auto"><polygon class="mk-link" points="0 0, 8 3, 0 6"/></marker>
"""

def node(x, y, w, h, kind, tag, name, sub, sub_mono=False):
    right = x + w
    cx = x + w / 2
    tw = 44
    s = []
    s.append(f'<rect class="mask" x="{x}" y="{y}" width="{w}" height="{h}" rx="6"/>')
    s.append(f'<rect class="n-{kind}" x="{x}" y="{y}" width="{w}" height="{h}" rx="6"/>')
    if tag:
        s.append(f'<rect class="tag" x="{right-8-tw}" y="{y+8}" width="{tw}" height="15" rx="2"/>')
        s.append(f'<text class="t-tag" x="{right-8-tw/2}" y="{y+19}" text-anchor="middle">{tag}</text>')
    s.append(f'<text class="t-name" x="{cx}" y="{y+46}" text-anchor="middle">{name}</text>')
    cls = "t-mono" if sub_mono else "t-sub"
    d = ' direction="ltr"' if sub_mono else ""
    s.append(f'<text class="{cls}" x="{cx}" y="{y+62}" text-anchor="middle"{d}>{sub}</text>')
    return "\n".join(s)

def label(cx, y_top, w, text, mono=False):
    cls = "t-mono-lab" if mono else "t-lab"
    d = ' direction="ltr"' if mono else ""
    return (f'<rect class="mask" x="{cx-w/2}" y="{y_top}" width="{w}" height="13" rx="2"/>'
            f'<text class="{cls}" x="{cx}" y="{y_top+10}" text-anchor="middle"{d}>{text}</text>')

def legend(y, width, items, title="مفتاح"):
    s = [f'<line class="rule" x1="24" y1="{y-10}" x2="{width-24}" y2="{y-10}"/>',
         f'<text class="t-eyebrow" x="{width-24}" y="{y+14}" text-anchor="start">{title}</text>']
    x = width - 84
    for kind, text in items:
        if kind.startswith("line-"):
            dash = ' stroke-dasharray="5,4"' if kind == "line-dash" else ""
            s.append(f'<line class="edge" x1="{x-22}" y1="{y+10}" x2="{x}" y2="{y+10}"{dash}/>')
        elif kind == "hatch":
            s.append(f'<rect x="{x-22}" y="{y+4}" width="22" height="12" rx="1" fill="url(#tl-hatch)" class="fuzzy-outline"/>')
        elif kind == "hatch-accent":
            s.append(f'<rect x="{x-22}" y="{y+4}" width="22" height="12" rx="1" fill="url(#tl-hatch-accent)" class="fuzzy-outline-accent"/>')
        elif kind == "bar":
            s.append(f'<rect class="bar" x="{x-22}" y="{y+4}" width="22" height="12" rx="1"/>')
        elif kind == "subbar":
            s.append(f'<rect class="bar sub" x="{x-22}" y="{y+7}" width="22" height="6" rx="1"/>')
        else:
            s.append(f'<rect class="n-{kind}" x="{x-22}" y="{y+4}" width="22" height="12" rx="2"/>')
        s.append(f'<text class="t-leg" x="{x-30}" y="{y+14}" text-anchor="start">{text}</text>')
        x -= 30 + 8 * len(text) + 36
    return "\n".join(s)

# ─────────────────────────── المخطط أ: من المصدر إلى الأطلس
def diagram_pipeline():
    W, H = 1072, 372
    col = {"A": 24, "B": 240, "C": 456, "D": 672, "E": 888}
    r1, r2, w, h = 64, 208, 160, 72
    e = []
    # الأسهم قبل الصناديق
    e.append('<path class="edge" d="M888 100 H832" marker-end="url(#pl-arrow)"/>')
    e.append('<path class="edge" d="M672 100 H616" marker-end="url(#pl-arrow)"/>')
    e.append('<path class="edge" d="M456 100 H400" marker-end="url(#pl-arrow)"/>')
    e.append(label(428, 79, 40, "ترحيل"))
    e.append('<path class="edge-link" d="M184 100 H240" marker-end="url(#pl-arrow-link)"/>')
    e.append(label(212, 79, 40, "أحكام"))
    e.append('<path class="edge" d="M320 136 V208" marker-end="url(#pl-arrow)"/>')
    e.append('<rect class="mask" x="328" y="160" width="50" height="13" rx="2"/>'
             '<text class="t-lab" x="376" y="170" text-anchor="start">كل دمج</text>')
    e.append('<path class="edge-accent" d="M400 244 H456" marker-end="url(#pl-arrow-accent)"/>')
    e.append(label(428, 223, 44, "إن نجحت"))
    e.append('<path class="edge" d="M616 244 H672" marker-end="url(#pl-arrow)"/>')
    e.append(label(644, 223, 48, "graph.js", mono=True))
    # الصناديق
    e.append(node(col["E"], r1, w, h, "ext", "خارجي", "المصادر الأولية", "الشاملة · صور الطبعة · OCR"))
    e.append(node(col["D"], r1, w, h, "step", "منهج", "مهارة الإسناد", "andalus-evidence", True))
    e.append(node(col["C"], r1, w, h, "store", "بذور", "ملفات البذور", "seed/json + additions/", True))
    e.append(node(col["B"], r1, w, h, "store", "مخزن", "قاعدة المنصة", "andalus.sqlite", True))
    e.append(node(col["A"], r1, w, h, "ext", "خدمة", "خدمة المراجعة", "Render · /review", True))
    e.append(node(col["B"], r2, w, h, "focal", "بوابة", "بوابة الجودة", "26 فحصًا · تمنع الدمج"))
    e.append(node(col["C"], r2, w, h, "step", "بناء", "التصدير الثابت", "export_static.py", True))
    e.append(node(col["D"], r2, w, h, "user", "واجهة", "الأطلس والموسوعة", "andalus/index.html", True))
    e.append(legend(318, W, [("ext", "مصدر أو خدمة خارجية"), ("step", "خطوة"), ("store", "مخزن بيانات"),
                             ("user", "واجهة القارئ"), ("focal", "نقطة التركيز")]))
    body = "\n".join(e)
    return f'''<svg viewBox="0 0 {W} {H}" role="img" aria-labelledby="andalus-pipeline-title andalus-pipeline-desc" class="dd">
<title id="andalus-pipeline-title">من المصدر إلى الأطلس</title>
<desc id="andalus-pipeline-desc">مسار البيانات في منصة الأندلس: المصادر الأولية تمر بمهارة الإسناد إلى ملفات البذور، ثم تُرحَّل إلى قاعدة المنصة التي تكتب فيها خدمة المراجعة أحكامها، ولا يصل شيء إلى التصدير الثابت والأطلس إلا بعد نجاح بوابة الجودة.</desc>
<defs>{MARKERS.format(p="pl")}</defs>
{body}
</svg>'''

# ─────────────────────────── المخطط ب: حالة الشاهد في المراجعة بالعين
def diagram_review():
    W, H = 960, 408
    e = []
    e.append('<rect class="zone" x="496" y="40" width="440" height="136" rx="8"/>')
    e.append('<text class="t-eyebrow" x="920" y="60" text-anchor="start">قبل الاعتماد</text>')
    # الأسهم
    e.append('<path class="edge" d="M752 112 H696" marker-end="url(#rv-arrow)"/>')
    e.append(label(724, 91, 40, "مطابق"))
    e.append('<path class="edge-accent" d="M520 104 H440" marker-end="url(#rv-arrow-accent)"/>')
    e.append(label(478, 83, 56, "مطابق ثانٍ"))
    e.append('<path class="edge" d="M440 128 H520" stroke-dasharray="5,4" marker-end="url(#rv-arrow)"/>')
    e.append(label(478, 136, 58, "سحب اعتماد"))
    e.append('<circle class="dot" cx="608" cy="176" r="3"/>')
    e.append('<path class="edge" d="M608 176 V240" marker-end="url(#rv-arrow)"/>')
    e.append('<rect class="mask" x="616" y="201" width="50" height="13" rx="2"/>'
             '<text class="t-lab" x="664" y="211" text-anchor="start">حكم بفرق</text>')
    e.append('<circle class="dot" cx="832" cy="176" r="3"/>')
    e.append('<path class="edge" d="M832 176 V240" marker-end="url(#rv-arrow)"/>')
    e.append('<rect class="mask" x="840" y="201" width="76" height="13" rx="2"/>'
             '<text class="t-lab" x="914" y="211" text-anchor="start">حكم غير مطابق</text>')
    e.append('<path class="edge" d="M520 276 H440" stroke-dasharray="5,4" marker-end="url(#rv-arrow)"/>')
    e.append(label(480, 255, 32, "يعود"))
    e.append('<path class="edge" d="M832 312 V336 Q832 344 824 344 H348 Q340 344 340 336 V312" stroke-dasharray="5,4" marker-end="url(#rv-arrow)"/>')
    # الحواشي التحريرية
    e.append('<path class="leader" d="M226 112 H238"/>')
    e.append('<text class="t-aside" x="220" y="98" text-anchor="start">عند الاعتماد يُكتب في الشاهد:</text>')
    e.append('<text class="t-aside" x="220" y="118" text-anchor="start">«مطابق بالعين: المراجعان</text>')
    e.append('<text class="t-aside" x="220" y="137" text-anchor="start">وتخصصاهما، التاريخ»</text>')
    e.append('<text class="t-mono" x="220" y="156" text-anchor="end" direction="ltr">attestations.verbatim_check</text>')
    # الحالات
    e.append(node(752, 76, 160, 72, "step", "بداية", "لم يُراجع", "لا أحكام معتمدة"))
    e.append(node(520, 76, 176, 72, "step", "", "يحتاج مراجعًا ثانيًا", "حكم «مطابق» واحد"))
    e.append(node(240, 76, 200, 72, "focal", "معتمد", "معتمد بالعين", "حكمان «مطابق» ولا غيرهما"))
    e.append(node(752, 240, 160, 72, "step", "", "غير مطابق", "حكم «غير مطابق» واحد"))
    e.append(node(520, 240, 176, 72, "step", "", "خلاف أو فرق", "«بفرق يسير» ولا «غير مطابق»"))
    e.append(node(240, 240, 200, 72, "opt", "إجراء", "إعادة الفحص", "andalus-evidence", True))
    e.append(legend(376, W, [("step", "حالة"), ("focal", "الحالة المقصودة"), ("opt", "إجراء خارج المراجعة"),
                             ("line-dash", "رجوع أو إسقاط")]))
    body = "\n".join(e)
    return f'''<svg viewBox="0 0 {W} {H}" role="img" aria-labelledby="andalus-review-title andalus-review-desc" class="dd">
<title id="andalus-review-title">حالة الشاهد في المراجعة بالعين</title>
<desc id="andalus-review-desc">يبدأ الشاهد غير مراجع، ويحتاج مراجعًا ثانيًا بعد أول حكم «مطابق»، ولا يصير «معتمدًا بالعين» إلا بحكمين «مطابق» بلا حكم مخالف؛ وأي حكم بفرق أو عدم مطابقة يعيده إلى الفحص بمهارة الإسناد.</desc>
<defs>{MARKERS.format(p="rv")}</defs>
{body}
</svg>'''

# ─────────────────────────── المخطط ج: العصور بحدودها غير القاطعة
def diagram_timeline():
    con = sqlite3.connect(DB)
    rows = con.execute("select period_id,label_ar,start_earliest,start_latest,end_earliest,end_latest,hijri,parent_id "
                       "from periods order by start_earliest, period_id").fetchall()
    W, H = 960, 344
    X0, X1, Y0, Y1 = 912, 48, 711, 1614
    x = lambda yr: round(X0 - (yr - Y0) * (X0 - X1) / (Y1 - Y0), 1)
    main = [r for r in rows if "a" not in r[0]]
    subs = [r for r in rows if "a" in r[0]]
    short = {"PRD-01": "الفتح والولاة", "PRD-04": "الطوائف الأولى", "PRD-05": "المرابطون",
             "PRD-06": "الموحدون", "PRD-08": "المدجنون والموريسكيون", "PRD-05a": "الطوائف الثانية",
             "PRD-06a": "الطوائف الثالثة", "PRD-03a": "الفتنة"}
    e = []
    e.append('<defs>'
             '<pattern id="tl-hatch" width="5" height="5" patternUnits="userSpaceOnUse" patternTransform="rotate(45)"><rect width="5" height="5" class="hatch-bg"/><line x1="0" y1="0" x2="0" y2="5" class="hatch-line"/></pattern>'
             '<pattern id="tl-hatch-accent" width="5" height="5" patternUnits="userSpaceOnUse" patternTransform="rotate(45)"><rect width="5" height="5" class="hatch-bg-accent"/><line x1="0" y1="0" x2="0" y2="5" class="hatch-line-accent"/></pattern>'
             '</defs>')
    # المحور
    ay = 268
    e.append(f'<line class="axis" x1="{X1}" y1="{ay}" x2="{X0}" y2="{ay}"/>')
    ticks = [711, 800, 900, 1000, 1100, 1200, 1300, 1400, 1492, 1614]
    for t in ticks:
        e.append(f'<line class="axis" x1="{x(t)}" y1="{ay}" x2="{x(t)}" y2="{ay+5}"/>')
        e.append(f'<text class="t-tick" x="{x(t)}" y="{ay+19}" text-anchor="middle">{t}</text>')
    e.append(f'<text class="t-eyebrow" x="{X0}" y="{ay+36}" text-anchor="start">السنة الميلادية</text>')

    def bar(r, y, hgt, sub=False):
        pid, name, se, sl, ee, el = r[:6]
        focal_end = pid == "PRD-03"
        focal_start = pid == "PRD-04"
        out = []
        cls = "bar sub" if sub else "bar"
        out.append(f'<rect class="{cls}" x="{x(ee)}" y="{y}" width="{round(x(sl)-x(ee),1)}" height="{hgt}" rx="1"/>')
        if sl > se:
            fill, oc = ("tl-hatch-accent", "fuzzy-outline-accent") if focal_start else ("tl-hatch", "fuzzy-outline")
            out.append(f'<rect x="{x(sl)}" y="{y}" width="{round(x(se)-x(sl),1)}" height="{hgt}" fill="url(#{fill})" class="{oc}"/>')
        if el > ee:
            fill, oc = ("tl-hatch-accent", "fuzzy-outline-accent") if focal_end else ("tl-hatch", "fuzzy-outline")
            out.append(f'<rect x="{x(el)}" y="{y}" width="{round(x(ee)-x(el),1)}" height="{hgt}" fill="url(#{fill})" class="{oc}"/>')
        return out

    laneA, laneB = 96, 128
    for i, r in enumerate(main):
        pid, name, se, sl, ee, el, hijri = r[:7]
        cx = round((x(se) + x(el)) / 2, 1)
        nm = short.get(pid, name)
        if hijri == '5هـ': hijri = 'القرن الخامس الهجري'
        if i % 2 == 0:
            e += bar(r, laneA, 16)
            e.append(f'<text class="t-period" x="{cx}" y="{laneA-8}" text-anchor="middle">{nm}</text>')
            e.append(f'<text class="t-hijri" x="{cx}" y="{laneA-24}" text-anchor="middle">{hijri}</text>')
        else:
            e += bar(r, laneB, 16)
            e.append(f'<text class="t-period" x="{cx}" y="{laneB+32}" text-anchor="middle">{nm}</text>')
            e.append(f'<text class="t-hijri" x="{cx}" y="{laneB+48}" text-anchor="middle">{hijri}</text>')
    laneC = 200
    for j, r in enumerate(subs):
        pid = r[0]
        e += bar(r, laneC, 7, sub=True)
        cx = round((x(r[2]) + x(r[5])) / 2, 1)
        ly = laneC + 24 + (16 if pid == "PRD-05a" else 0)
        e.append(f'<text class="t-subperiod" x="{cx}" y="{ly}" text-anchor="middle">{short.get(pid, r[1])}</text>')
    e.append(f'<text class="t-eyebrow" x="{X0}" y="{laneC-8}" text-anchor="start">مراحل فرعية وانتقالية</text>')
    # الحاشية التحريرية على الحد المختلف فيه
    lx = round((x(1009) + x(1031)) / 2)
    e.append(f'<path class="leader" d="M{lx} 36 V{laneA-2}"/>')
    e.append(f'<text class="t-aside" x="{lx-8}" y="30" text-anchor="start">نهاية الخلافة بتعريفين: 1009 بداية الفتنة، أو 1031 إلغاؤها رسميًا</text>')
    e.append(legend(318, W, [("bar", "مدة مستقرة"), ("hatch", "هامش الحدّ غير القاطع"),
                             ("hatch-accent", "الحدّ المقصود بالحاشية"), ("subbar", "مرحلة فرعية")]))
    body = "\n".join(e)
    return f'''<svg viewBox="0 0 {W} {H}" role="img" aria-labelledby="andalus-eras-title andalus-eras-desc" class="dd">
<title id="andalus-eras-title">عصور الأندلس بحدودها غير القاطعة</title>
<desc id="andalus-eras-desc">العصور الثمانية من 711 إلى 1614 كما في جدول periods، مع هامش لكل حدّ له أكثر من تعريف، كنهاية الخلافة بين 1009 و1031، والمراحل الانتقالية الثلاث في صف مستقل.</desc>
{body}
</svg>'''

CSS = open(pathlib.Path(__file__).with_name("page.css"), encoding="utf-8").read()
TPL = open(pathlib.Path(__file__).with_name("page.template.html"), encoding="utf-8").read()
page = (TPL.replace("{{CSS}}", CSS)
           .replace("{{SVG_PIPELINE}}", diagram_pipeline())
           .replace("{{SVG_REVIEW}}", diagram_review())
           .replace("{{SVG_ERAS}}", diagram_timeline()))
pathlib.Path(OUT_FRAGMENT).write_text(page, encoding="utf-8")
head = page.split("</style>", 1)
standalone = ('<!doctype html>\n<html lang="ar" dir="rtl">\n<head>\n<meta charset="utf-8">\n'
              '<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">\n'
              + head[0] + "</style>\n</head>\n<body>\n" + head[1] + "\n</body>\n</html>\n")
pathlib.Path(OUT_STANDALONE).write_text(standalone, encoding="utf-8")
print("ok")
