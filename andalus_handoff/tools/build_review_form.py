#!/usr/bin/env python3
"""يبني استمارة المراجعة بالعين (andalus_review_form.xlsx) مُعبّأة بالشواهد التي تنتظر مراجعة.

الربط بخاصية المراجعة: الطابور مشتقٌّ من العرض v_attestation_review_status (الشاهد بحالة
«لم يُراجع»). هذه الأداة تصدّر الشواهد المطلوب فحصها بالعين (القاعدة 10) إلى استمارة
بورقتين بالبنية نفسها التي يقرؤها tools/import_reviews.py بالضبط:
  - ورقة «المراجع»: بيانات المراجع وتوقيعه وإقراره (الصفوف 4–11، العمود الأول تسمية والثاني يُملأ).
  - ورقة «الشواهد»: الأعمدة «المعرف» و«الحكم» و«الملاحظة أو النص الصحيح» (يقرؤها السكربت)،
    مع أعمدة سياق للقراءة (المصدر، يُثبت، النص الحرفي، الموضع، الرابط).

لا تكتب هذه الأداة في قاعدة البيانات؛ تُنتج ملف إدخال فقط. الدورة الكاملة:
  1) python tools/build_review_form.py --db andalus.sqlite --out andalus_review_form.xlsx
  2) يملأ المراجع المتخصص ورقته وعمود «الحكم» لكل شاهد، ويوقّع.
  3) python tools/import_reviews.py --db andalus.sqlite \
        --schema spec/review/schema_review.sql --excel andalus_review_form.xlsx --owner "<الاسم>"
  4) يعتمد صاحب المشروع المراجع في المنصة، فتدخل أحكامه في v_attestation_review_status.

التصفية الافتراضية: الشواهد المفحوصة بنموذج مساعد (WebFetch) التي لم تُراجَع بعد.
بخيار --methods يمكن تضمين OCR والقراءة البصرية أيضًا.
"""
import argparse, sqlite3, datetime

METHOD_LIKE = {
    'webfetch': '%WebFetch%',
    'ocr': '%OCR%',
    'visual': '%قراءة بصرية%',
}
VERDICTS = ['مطابق', 'مطابق بفرق يسير', 'غير مطابق']
REVIEWER_LABELS = [
    'الاسم الكامل', 'الدرجة العلمية', 'التخصص الدقيق', 'الجهة',
    'اللغات التي يقرأ بها المصادر', 'تاريخ المراجعة', 'التوقيع', 'الإقرار',
]


def fetch(db, methods):
    con = sqlite3.connect(db); con.row_factory = sqlite3.Row
    likes = [METHOD_LIKE[m] for m in methods]
    where = ' OR '.join(['a.verbatim_check LIKE ?'] * len(likes))
    rows = con.execute(f"""
      SELECT a.attestation_id, a.locator, a.quote, a.stance, a.verbatim_check, a.note_ar,
             COALESCE(a.url, s.url) AS link, s.label AS src_label,
             asr.target_id, asr.field, asr.value_ar,
             COALESCE(st.review_status,'لم يُراجع') AS review_status
      FROM attestations a
      LEFT JOIN sources s ON s.source_id=a.source_id
      LEFT JOIN assertions asr ON asr.assertion_id=a.assertion_id
      LEFT JOIN v_attestation_review_status st ON st.attestation_id=a.attestation_id
      WHERE ({where})
      ORDER BY s.label, a.attestation_id
    """, likes).fetchall()
    con.close()
    # الطابور: ما لم يُعتمد بالعين بعد
    return [r for r in rows if r['review_status'] != 'معتمد بالعين']


def build(rows, out):
    from openpyxl import Workbook
    from openpyxl.worksheet.datavalidation import DataValidation
    from openpyxl.styles import Font, Alignment, PatternFill
    wb = Workbook()
    head = Font(name='Arial', bold=True)
    fill = PatternFill('solid', fgColor='EAF0F7')
    wrap = Alignment(wrap_text=True, vertical='top', horizontal='right')
    rtl = Alignment(horizontal='right')

    # ورقة المراجع
    rv = wb.active; rv.title = 'المراجع'; rv.sheet_view.rightToLeft = True
    rv['A1'] = 'استمارة المراجعة بالعين — بيانات المراجع'; rv['A1'].font = Font(bold=True, size=13)
    rv['A2'] = 'املأ العمود الثاني. المراجعة لا تُقبل إلا من متخصص يعتمده صاحب المشروع (القاعدة 10).'
    rv['A2'].font = Font(italic=True, color='5C6675')
    for i, lab in enumerate(REVIEWER_LABELS):
        c = rv.cell(4 + i, 1, lab); c.font = head; c.alignment = rtl
        rv.cell(4 + i, 2, '').alignment = wrap
    rv.cell(13, 1, 'الحكم المقبول في ورقة «الشواهد»: ' + ' / '.join(VERDICTS)).font = Font(italic=True)
    rv.column_dimensions['A'].width = 26; rv.column_dimensions['B'].width = 52

    # ورقة الشواهد
    sh = wb.create_sheet('الشواهد'); sh.sheet_view.rightToLeft = True
    headers = ['المعرف', 'المصدر', 'يُثبت', 'النص الحرفي', 'الموضع', 'الرابط للفحص',
               'الحكم', 'الملاحظة أو النص الصحيح']
    for j, h in enumerate(headers, 1):
        c = sh.cell(1, j, h); c.font = head; c.fill = fill; c.alignment = rtl
    widths = [12, 22, 26, 60, 20, 40, 18, 34]
    for j, w in enumerate(widths, 1):
        sh.column_dimensions[chr(64 + j)].width = w
    for i, r in enumerate(rows, 2):
        asrt = f"{r['target_id'] or ''} · {r['field'] or ''} = «{r['value_ar'] or ''}»"
        vals = [r['attestation_id'], r['src_label'] or '', asrt, r['quote'] or '',
                r['locator'] or '', r['link'] or '', '', '']
        for j, v in enumerate(vals, 1):
            c = sh.cell(i, j, v); c.alignment = wrap
    sh.freeze_panes = 'A2'
    dv = DataValidation(type='list', formula1='"' + ','.join(VERDICTS) + '"', allow_blank=True)
    dv.prompt = 'اختر حكم المطابقة'; dv.promptTitle = 'الحكم'
    sh.add_data_validation(dv); dv.add(f'G2:G{len(rows) + 1}')

    # ورقة تعليمات
    tp = wb.create_sheet('تعليمات'); tp.sheet_view.rightToLeft = True
    lines = [
        'استمارة المراجعة بالعين — منصة الأندلس',
        f'عدد الشواهد: {len(rows)} — مُولّدة {datetime.date.today().isoformat()}.',
        '',
        '١) املأ ورقة «المراجع»: الاسم، التخصص، التوقيع، والإقرار (إلزامية).',
        '٢) في ورقة «الشواهد»: افتح رابط كل شاهد، اقرأ الموضع، طابِق «النص الحرفي» حرفًا بحرف.',
        '٣) ضع «الحكم»: مطابق / مطابق بفرق يسير / غير مطابق. وعند الفرق اكتب النص الصحيح وموضعه.',
        '٤) أعِد الملف لصاحب المشروع لاستيراده عبر tools/import_reviews.py.',
        '',
        'يُعتمد الشاهد «معتمد بالعين» بحكم مراجعَين معتمدَين «مطابق» دون حكم مخالف (القاعدة 10).',
    ]
    for i, ln in enumerate(lines, 1):
        c = tp.cell(i, 1, ln); c.alignment = rtl
        if i == 1: c.font = Font(bold=True, size=13)
    tp.column_dimensions['A'].width = 90
    wb.save(out)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--db', required=True)
    ap.add_argument('--out', default='andalus_review_form.xlsx')
    ap.add_argument('--methods', nargs='*', default=['webfetch'], choices=list(METHOD_LIKE))
    a = ap.parse_args()
    rows = fetch(a.db, a.methods)
    build(rows, a.out)
    print(f'استمارة: {a.out} — {len(rows)} شاهدًا ({", ".join(a.methods)}).')


if __name__ == '__main__':
    main()
