// مكتبة آل عثمان — منطق الصفحة. البيانات في data/books.js، والتعديلات تُحفظ في localStorage.
(function () {
  'use strict';
  const ORIG = window.LIBRARY;
  const KEY = 'maktaba-hoqbi-v1';
  const PHOTOS = ORIG.photos, CASES = ORIG.cases, TOPICS = ORIG.topics;
  const PHOTO_SCALE = { P2: 1, P3: 1, P5: 1, P6: 1, P4: 1, P7: .5, P8: .55, P9: .55, P12: .55, P10: .6, P13: .8, P14: .8, P15: .8, P11: .3, P1: 1, P16: .6, P17: .6, P18: .6 };
  const $ = (s, r = document) => r.querySelector(s);
  const $$ = (s, r = document) => [...r.querySelectorAll(s)];
  const AR = ['٠','١','٢','٣','٤','٥','٦','٧','٨','٩'];
  const ar = n => String(n).replace(/\d/g, d => AR[d]);
  const esc = s => String(s ?? '').replace(/[&<>"']/g, c => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]));

  let books = load();
  function load() {
    try { const s = JSON.parse(window.localStorage.getItem(KEY)); if (s && Array.isArray(s.books)) return s.books; } catch (e) {}
    return structuredClone(ORIG.books);
  }
  function save() {
    try { localStorage.setItem(KEY, JSON.stringify({ savedAt: new Date().toISOString(), books })); }
    catch (e) { const m = $('#dataMsg'); if (m) m.textContent = 'تعذّر الحفظ في هذا المتصفح؛ صدّر الفهرس حتى لا تضيع التعديلات.'; }
    renderAll();
  }
  // نافذة تأكيد داخل الصفحة (confirm() لا يعمل في بعض العارضات)
  function askConfirm(msg) {
    return new Promise(res => {
      const d = $('#confirmDlg'); $('#confirmMsg').textContent = msg;
      d.onclose = () => res(d.returnValue === 'yes'); d.returnValue = ''; d.showModal();
    });
  }
  const store = { get: k => { try { return localStorage.getItem(k); } catch (e) { return null; } }, set: (k, v) => { try { localStorage.setItem(k, v); } catch (e) {} }, del: k => { try { localStorage.removeItem(k); } catch (e) {} } };

  // ---------- تطبيع العربية ----------
  function norm(s) {
    return String(s || '').replace(/[ً-ْٰـ]/g, '')
      .replace(/[أإآٱ]/g, 'ا').replace(/ى/g, 'ي').replace(/ة/g, 'ه').replace(/ؤ/g, 'و').replace(/ئ/g, 'ي')
      .replace(/[٠-٩]/g, d => '0123456789'['٠١٢٣٤٥٦٧٨٩'.indexOf(d)])
      .replace(/[«»"'()،,.:؛؟?!\-–—…]/g, ' ').replace(/\s+/g, ' ').trim().toLowerCase();
  }
  const caseName = c => CASES[c] ? CASES[c].name : c;
  const isUnread = b => /غير مقروء/.test(b.title) || b.kind === 'مجموعة غير مفهرسة' || b.kind === 'دفاتر';
  function placeText(p) {
    const where = `${caseName(p.case)}، الرف ${ar(p.shelf)}`;
    const pos = p.pos ? `الموضع ${ar(p.pos)} من اليسار (من ${ar(p.of || '?')})` : 'موضوع أفقيًا فوق الصف';
    return `${where} · ${pos}` + (p.vols ? ` · المجلد ${p.vols}` : '');
  }
  const caseLetter = c => caseName(c).replace('الخزانة ', '');
  const shortPlace = p => `خزانة ${caseLetter(p.case)} · الرف ${ar(p.shelf)} · ` + (p.pos ? `الكتاب ${ar(p.pos)} من اليسار` : 'فوق الصف');
  const booksWord = n => n === 1 ? 'كتاب واحد' : n === 2 ? 'كتابان' : (n >= 3 && n <= 10) ? `${ar(n)} كتب` : `${ar(n)} كتابًا`;
  function neighbours(b, p) { // الكتابان المجاوران في الرف، لتسهيل التعرّف عليه واقفًا أمامه
    if (!p.pos) return '';
    const on = slots().filter(x => x.p.case === p.case && +x.p.shelf === +p.shelf && x.p.pos);
    const at = k => on.find(x => x.p.pos === k);
    const nm = x => x && x.b.status === "مؤكد" && !/غير مقروء|^قراءة|^عنوان/.test(x.b.title) ? `«${x.b.title}${x.p.vols ? ' ' + x.p.vols : ''}»` : null;
    const l = nm(at(p.pos - 1)), r = nm(at(p.pos + 1));
    return l && r ? `بين ${l} على يساره و${r} على يمينه` : l ? `يساره ${l}` : r ? `يمينه ${r}` : '';
  }

  // ---------- الإحصاءات ----------
  function renderStats() {
    const conf = books.filter(b => b.status === 'مؤكد').length;
    const vols = books.reduce((n, b) => n + (b.places.length > 1 || b.places[0]?.vols ? b.places.length : 0), 0);
    $('#stats').textContent = `${ar(books.length)} سجلًا · ${ar(conf)} مؤكد · ${ar(books.length - conf)} يحتاج مراجعة · ${ar(vols)} مجلدًا في مجموعات`;
    $('#reviewCount').textContent = ar(books.length - conf);
  }

  // ---------- رسم الخزانات ----------
  function spineWidth(p) { const w = (p.box[2] - p.box[0]) * (PHOTO_SCALE[p.photo] || 1) / 3.4; return Math.max(11, Math.min(44, w)); }
  function textColor(hex) { // يختار الأسود أو الأبيض بأعلى تباين وفق WCAG
    const hh = hex.replace('#', ''); const ff = hh.length === 3 ? hh.split('').map(c => c + c).join('') : hh;
    const L = [0, 2, 4].map(i => parseInt(ff.substr(i, 2), 16) / 255).map(c => c <= .03928 ? c / 12.92 : ((c + .055) / 1.055) ** 2.4);
    const lum = .2126 * L[0] + .7152 * L[1] + .0722 * L[2];
    return (1.05 / (lum + .05)) >= ((lum + .05) / (.0144 + .05)) ? '#fff' : '#1c1c1c';
  }
  function slots() { // كل موضع (place) مع سجله
    const out = [];
    books.forEach(b => b.places.forEach((p, i) => out.push({ b, p, i })));
    return out;
  }
  function renderCabinets() {
    const all = slots();
    $('#cabinets').innerHTML = `<div class="legend" style="grid-column:1/-1"><span><i></i>مؤكد من الصورة</span><span><i class="r"></i>يحتاج مراجعة (مخطط)</span><span>الأشرطة الأفقية: كتب موضوعة فوق الصف</span></div>` +
      Object.entries(CASES).map(([c, cs]) => `
      <div class="cabinet" data-case="${c}"><h2>${esc(cs.name)}</h2><p class="cnote">${esc(cs.note)}</p>
      ${Object.keys(cs.shelves).map(s => {
        const items = all.filter(x => x.p.case === c && +x.p.shelf === +s);
        const up = items.filter(x => x.p.pos).sort((a, b) => a.p.pos - b.p.pos);
        const ly = items.filter(x => !x.p.pos);
        return `<div class="shelf" data-shelf="${c}${s}"><span class="shelf-label">الرف ${ar(s)} · ${booksWord(up.length)}</span>
          <div class="lying">${ly.map(x => `<button data-id="${x.b.id}" data-pi="${x.i}" style="background:${x.b.color};color:${textColor(x.b.color)};width:${Math.min(70, 25 + x.b.title.length)}%" title="${esc(x.b.title)}">${esc(x.b.title)}</button>`).join('')}</div>
          <div class="row-books" role="group" aria-label="${esc(cs.name)}، الرف ${ar(s)}">${up.map((x, j) => {
            const h = 110 + ((x.b.id.charCodeAt(3) * 7 + x.p.pos * 13) % 30);
            const label = (x.p.vols ? x.p.vols + ' · ' : '') + x.b.title;
            return `<button tabindex="${j ? -1 : 0}" class="spine${x.b.status === 'مؤكد' ? '' : ' review'}" data-id="${x.b.id}" data-pi="${x.i}" style="--w:${spineWidth(x.p)}px;--h:${h}px;background-color:${x.b.color};color:${textColor(x.b.color)}" title="${esc(label)} — ${esc(placeText(x.p))}" aria-label="${esc(label)}"><span>${esc(label)}</span></button>`;
          }).join('')}</div></div>`;
      }).join('')}</div>`).join('');
  }

  // ---------- البحث ----------
  const SYN = { // كلمات السؤال → موضوع
    'القيم': 'القيم والأخلاق', 'قيم': 'القيم والأخلاق', 'الاخلاق': 'القيم والأخلاق', 'اخلاق': 'القيم والأخلاق', 'الاخلاقيات': 'القيم والأخلاق',
    'التفسير': 'القرآن وعلومه', 'القران': 'القرآن وعلومه', 'السيره': 'السيرة والحديث', 'الحديث': 'السيرة والحديث',
    'العقيده': 'العقيدة والإيمان', 'الايمان': 'العقيدة والإيمان', 'الفقه': 'الفقه والشريعة', 'الشريعه': 'الفقه والشريعة',
    'الدعوه': 'الدعوة', 'التربيه': 'التربية والأسرة', 'الاسره': 'التربية والأسرة', 'القياده': 'القيادة', 'الاداره': 'الإدارة والعمل المؤسسي',
    'الوقف': 'الوقف والعمل الخيري', 'العمل الخيري': 'الوقف والعمل الخيري', 'الابداع': 'الإبداع والابتكار', 'الابتكار': 'الإبداع والابتكار',
    'تطوير الذات': 'تطوير الذات', 'الفكر': 'الفكر والثقافة', 'التاريخ': 'التاريخ والحضارة', 'علم النفس': 'علم النفس والدماغ',
    'المال': 'المال والاقتصاد', 'الاقتصاد': 'المال والاقتصاد', 'القراءه': 'القراءة والتعلم', 'الروايات': 'أدب ورواية', 'الادب': 'أدب ورواية', 'روايه': 'أدب ورواية'
  };
  const STOP = new Set(['ما', 'ماهي', 'هي', 'الكتب', 'كتب', 'كتاب', 'الموجوده', 'الموجود', 'عندي', 'لدي', 'في', 'مكتبتي', 'عن', 'حول', 'هل', 'يوجد', 'التي', 'تتحدث', 'تتناول', 'موضوع', 'اعرض', 'ابحث', 'اريد', 'وش', 'ايش']);
  function detectTopic(q) {
    const n = norm(q); const words = n.split(' ').filter(w => !STOP.has(w)); const rest = words.join(' ');
    if (!rest) return null;
    if (SYN[rest]) return SYN[rest];
    for (const t of TOPICS) if (norm(t) === rest || norm(t).split(' ').includes(rest)) return t;
    if (words.length < n.split(' ').length) for (const w of words) if (SYN[w]) return SYN[w]; // صيغة سؤال
    return null;
  }
  function textSearch(q) {
    const n = norm(q); if (!n) return [];
    const nums = (n.match(/\d+/g) || []); const terms = n.replace(/\d+/g, ' ').split(' ').filter(w => w && !STOP.has(w));
    const out = [];
    for (const b of books) {
      const hay = { title: norm(b.title), author: norm(b.author), pub: norm(b.publisher), topics: norm([...b.topics.map(t => t.t), ...b.suggested.map(t => t.t)].join(' ')), note: norm(b.note) };
      if (!terms.length && !nums.length) continue;
      let score = 0, why = [];
      if (terms.length) {
        const all = terms.every(t => Object.values(hay).some(h => h.includes(t)));
        if (!all) continue;
        if (terms.every(t => hay.title.includes(t))) { score += 10; why.push('العنوان'); }
        if (terms.some(t => hay.author.includes(t))) { score += 6; why.push('المؤلف'); }
        if (terms.some(t => hay.topics.includes(t))) { score += 3; why.push('الموضوع'); }
        if (terms.some(t => hay.pub.includes(t))) { score += 2; why.push('الناشر'); }
        if (!why.length) { score += 1; why.push('الملاحظات'); }
        if (hay.title.startsWith(terms.join(' '))) score += 5;
      }
      let placeIdx = 0;
      if (nums.length) {
        const vi = b.places.findIndex(p => p.vols && norm(p.vols) === nums[0]);
        if (vi >= 0) { placeIdx = vi; score += 8; why.push('رقم المجلد ' + ar(nums[0])); }
        else if (!terms.length) continue;
        else if (!hay.title.includes(nums[0])) score -= 2;
      }
      out.push({ b, score, why: 'تطابق في: ' + why.join('، '), placeIdx });
    }
    return out.sort((a, b) => b.score - a.score);
  }
  function resRow(r, why) {
    const p = r.b.places[r.placeIdx || 0];
    const extra = r.b.places.length > 1 ? ` <span class="muted small">(+${ar(r.b.places.length - 1)} موضع)</span>` : '';
    return `<div class="res" data-id="${r.b.id}" data-pi="${r.placeIdx || 0}" tabindex="0">
      <span class="sw" style="background:${r.b.color}"></span>
      <div><strong>${esc(r.b.title)}</strong>${statusBadge(r.b)}<div class="why">${esc(r.b.author || '')}${r.b.author ? ' · ' : ''}${esc(why)}</div></div>
      <span class="loc">${esc(shortPlace(p))}${extra}</span></div>`;
  }
  function statusBadge(b) {
    return (b.addedBy === 'يدوي' ? '<span class="badge man">أضيف يدويًا</span>' : '') +
      (b.status === 'مؤكد' ? '<span class="badge ok">العنوان مقروء</span>' : '<span class="badge rv">العنوان غير مؤكد</span>');
  }
  function runSearch() {
    const q = $('#q').value.trim(); const box = $('#results');
    if (!q) { box.hidden = true; box.innerHTML = ''; return; }
    const topic = detectTopic(q);
    let html = '';
    if (topic) {
      const conf = books.filter(b => b.topics.some(t => t.t === topic));
      const sug = books.filter(b => !conf.includes(b) && b.suggested.some(t => t.t === topic));
      html += `<h2>كتب عن «${esc(topic)}» في مكتبتك</h2>
        <p class="muted">ثابت الصلة من العنوان: ${ar(conf.length)}، ومقترح للمراجعة: ${ar(sug.length)}. لا يُعدّ كل كتاب في التربية أو الدين كتابًا عن هذا الموضوع تلقائيًا.</p>
        <div class="res-group"><h3>ثابت الصلة من العنوان (${ar(conf.length)})</h3>${conf.map(b => resRow({ b }, b.topics.find(t => t.t === topic).basis)).join('') || '<p class="empty">لا يوجد.</p>'}</div>
        <div class="res-group sug"><h3>مقترح يحتاج مراجعة (${ar(sug.length)})</h3>${sug.map(b => resRow({ b }, b.suggested.find(t => t.t === topic).reason)).join('') || '<p class="empty">لا يوجد.</p>'}</div>`;
    }
    const tr = textSearch(q).filter(r => !topic || !(r.b.topics.concat(r.b.suggested)).some(t => t.t === topic));
    if (!topic || tr.length) html += `<h2>${topic ? 'تطابقات نصية أخرى' : 'نتائج البحث'} (${ar(tr.length)})</h2>` +
      (tr.length ? tr.slice(0, 60).map(r => resRow(r, r.why)).join('') : `<p class="empty">لم أجد «${esc(q)}» في الفهرس الحالي. قد يكون الكتاب بين السجلات غير المقروءة؛ راجع تبويب «يحتاج مراجعة».</p>`);
    box.innerHTML = html; box.hidden = false;
  }

  // ---------- البطاقة ----------
  function cropStyle(p, pad = 0.35) {
    const ph = PHOTOS[p.photo]; let [x0, y0, x1, y1] = p.box;
    const bw = x1 - x0, bh = y1 - y0;
    let cw = Math.max(bw * (1 + pad * 2), bh * 0.75 * (1 + pad)), ch = cw * 0.75; // نسبة 4:3
    if (ch < bh * 1.1) { ch = bh * 1.1; cw = ch / 0.75; }
    cw = Math.min(cw, ph.w); ch = Math.min(ch, ph.h);
    let cx = Math.min(Math.max((x0 + x1) / 2 - cw / 2, 0), ph.w - cw), cy = Math.min(Math.max((y0 + y1) / 2 - ch / 2, 0), ph.h - ch);
    const size = `${ph.w / cw * 100}% ${ph.h / ch * 100}%`;
    const pos = `${cw >= ph.w ? 0 : cx / (ph.w - cw) * 100}% ${ch >= ph.h ? 0 : cy / (ph.h - ch) * 100}%`;
    const mark = `left:${(x0 - cx) / cw * 100}%;top:${(y0 - cy) / ch * 100}%;width:${bw / cw * 100}%;height:${bh / ch * 100}%`;
    return { bg: `background-image:url(photos/${p.photo}.jpg);background-size:${size};background-position:${pos}`, mark };
  }
  function overviewMark(p) { // موضع الرف والكتاب في الصورة العامة للخزانة
    const cs = CASES[p.case]; const ph = PHOTOS[cs.photo]; const sb = cs.shelves[p.shelf]; if (!sb) return '';
    const sm = `left:${sb[0] / ph.w * 100}%;top:${sb[1] / ph.h * 100}%;width:${(sb[2] - sb[0]) / ph.w * 100}%;height:${(sb[3] - sb[1]) / ph.h * 100}%`;
    let dot = '';
    if (p.pos && p.of) { const x = sb[0] + (sb[2] - sb[0]) * ((p.pos - .5) / p.of); dot = `<span class="dot" style="left:${x / ph.w * 100}%;top:${(sb[1] + sb[3]) / 2 / ph.h * 100}%"></span>`; }
    return `<div class="mini-over" data-photo="${cs.photo}" data-mark="${sb.join(',')}"><img src="photos/${cs.photo}.jpg" alt="${esc(cs.name)}"><span class="mark" style="${sm}"></span>${dot}</div>`;
  }
  let lastFocus = null;
  function openBook(id, pi = 0, scroll = true) {
    const b = books.find(x => x.id === id); if (!b) return;
    document.body.classList.add('sheet');
    const p = b.places[pi] || b.places[0];
    highlight(b, pi, scroll);
    const crop = p.photo ? cropStyle(p) : null;
    $('#drawerBody').innerHTML = `
      <h2 id="dTitle" tabindex="-1">${esc(b.title)}</h2>${statusBadge(b)}
      <div class="where"><span class="wcode"><b>${esc(caseLetter(p.case))}${ar(p.shelf)}</b>${p.pos ? `<em>${ar(p.pos)}</em><small>من اليسار</small>` : '<small>فوق الصف</small>'}</span>
        <div><strong>${esc(caseName(p.case))}، الرف ${ar(p.shelf)}</strong>
        <span>${p.pos ? `الكتاب ${ar(p.pos)} من اليسار، من ${ar(p.of || '?')}` : 'موضوع أفقيًا فوق الصف'}${p.vols ? ` · المجلد ${esc(p.vols)}` : ''}</span>
        ${neighbours(b, p) ? `<span class="nb">${esc(neighbours(b, p))}</span>` : ''}</div></div>
      <dl class="kv card-sec">
        <dt>المؤلف</dt><dd>${esc(b.author) || '<span class="muted">غير مقروء في الصورة</span>'}</dd>
        ${b.publisher ? `<dt>الناشر</dt><dd>${esc(b.publisher)}</dd>` : ''}
        <dt>النوع</dt><dd>${esc(b.kind)}${b.places.length > 1 ? ` · ${ar(b.places.length)} مجلدات ظاهرة` : ''}</dd>
        ${b.places.length > 1 ? `<dt>المجلدات</dt><dd>${b.places.map((q, i) => `<a href="#" data-pi="${i}" class="plink"${i === pi ? ' aria-current="true"' : ''}>${esc(placeText(q))}</a>`).join('<br>')}</dd>` : ''}
        <dt>الموضوعات</dt><dd>${b.topics.map(t => `<span class="tag" title="${esc(t.basis)}">${esc(t.t)}</span>`).join('') || '<span class="muted">لم يُثبت موضوع من العنوان</span>'}</dd>
        ${b.suggested.length ? `<dt>مقترح</dt><dd>${b.suggested.map(t => `<span class="tag s" title="${esc(t.reason)}">${esc(t.t)} (يحتاج مراجعة)</span>`).join('')}</dd>` : ''}
        <dt>الثقة</dt><dd>${b.status === 'مؤكد' ? 'مقروء من الصورة' : 'قراءة غير مؤكدة'}${b.addedBy === 'يدوي' ? ' · أضيف يدويًا' : ''}</dd>
        ${b.note ? `<dt>ملاحظة</dt><dd>${esc(b.note)}</dd>` : ''}
        ${b.copyNote ? `<dt>نسخ</dt><dd>${esc(b.copyNote)}</dd>` : ''}
      </dl>
      ${crop ? `<div class="card-sec"><h3 class="small">موضعه في الصورة: ${esc(PHOTOS[p.photo].label)}</h3>
        <div class="crop" style="${crop.bg}" data-photo="${p.photo}" data-mark="${p.box.join(',')}"><span class="mark" style="${crop.mark}"></span></div>
        <p class="muted small">الإطار تقريبي، رُسم يدويًا من الصورة.${p.photoNote ? ' ' + esc(p.photoNote) + '.' : ''}</p></div>` : ''}
      <div class="card-sec"><h3 class="small">الرف في صورة الخزانة كاملة</h3>${overviewMark(p)}</div>
      <div class="row">
        <button class="btn primary" id="dEdit">تحرير</button>
        ${b.status !== 'مؤكد' ? '<button class="btn" id="dVerify">تم التحقق</button>' : ''}
      </div>`;
    if ($('#drawer').hidden) lastFocus = document.activeElement;
    $('#drawer').hidden = false; document.body.classList.add('sheet'); $('#dTitle').focus({ preventScroll: true });
    $('#dEdit').onclick = () => openEdit(b.id, pi);
    const v = $('#dVerify'); if (v) v.onclick = () => { b.status = 'مؤكد'; save(); openBook(b.id, pi, false); };
    $$('.plink', $('#drawerBody')).forEach(a => a.onclick = e => { e.preventDefault(); openBook(b.id, +a.dataset.pi); });
  }
  function highlight(b, pi, scroll) {
    $$('.spine.hl,.lying button.hl,.shelf.hl').forEach(e => e.classList.remove('hl'));
    const p = b.places[pi] || b.places[0];
    const sh = $(`.shelf[data-shelf="${p.case}${p.shelf}"]`); if (sh) sh.classList.add('hl');
    const el = $(`[data-id="${b.id}"][data-pi="${pi}"]`, $('#cabinets'));
    if (!el) return; el.classList.add('hl');
    if (!scroll || $('#tab-shelves').hidden) return;
    if (matchMedia('(max-width: 720px)').matches) { // اللوحة تغطي أسفل الشاشة: اجعل الرف تحت الرأس مباشرة
      el.scrollIntoView({ block: 'nearest', inline: 'center' });
      requestAnimationFrame(() => { // بعد ظهور اللوحة: أسفل الكتاب فوق حافتها العليا مباشرة
        const d = $('#drawer'); const edge = d.hidden ? innerHeight : d.getBoundingClientRect().top;
        window.scrollBy({ top: el.getBoundingClientRect().bottom - (edge - 10), behavior: 'smooth' });
      });
    } else el.scrollIntoView({ behavior: 'smooth', block: 'center', inline: 'center' });
  }

  // ---------- عارض الصور ----------
  function openPhoto(id, mark) {
    const ph = PHOTOS[id];
    $('#photoImg').src = `photos/${id}.jpg`; $('#photoImg').alt = ph.label;
    $('#photoCap').textContent = `${ph.label} (${ph.file})`;
    $('#photoMarks').innerHTML = mark ? (() => { const [x0, y0, x1, y1] = mark.split(',').map(Number); return `<span class="mark" style="left:${x0 / ph.w * 100}%;top:${y0 / ph.h * 100}%;width:${(x1 - x0) / ph.w * 100}%;height:${(y1 - y0) / ph.h * 100}%"></span>`; })() : '';
    $('#photoDlg').showModal();
  }
  function renderPhotos() {
    $('#photoGrid').innerHTML = Object.entries(PHOTOS).sort((a, b) => a[1].file.localeCompare(b[1].file)).map(([id, p]) =>
      `<figure data-photo="${id}" tabindex="0" role="button" aria-label="تكبير ${esc(p.label)}"><img loading="lazy" src="photos/${id}.jpg" alt=""><figcaption><strong>${esc(p.label)}</strong><span class="muted small"> ${esc(p.file)}</span></figcaption></figure>`).join('');
  }

  // ---------- الفهرس ----------
  function shelfKeys() { return Object.entries(CASES).flatMap(([c, cs]) => Object.keys(cs.shelves).map(s => [c + s, `${cs.name}، الرف ${ar(s)}`])); }
  function renderFilters() {
    const keep = ['#fShelf', '#fTopic'].map(s => $(s).value);
    $('#fShelf').innerHTML = '<option value="">الكل</option>' + shelfKeys().map(([k, n]) => `<option value="${k}">${n}</option>`).join('');
    const tops = [...new Set([...TOPICS, ...books.flatMap(b => b.topics.map(t => t.t))])];
    $('#fTopic').innerHTML = '<option value="">الكل</option>' + tops.map(t => `<option>${esc(t)}</option>`).join('') + '<option value="__none">بلا موضوع مثبت</option>';
    $('#topicList').innerHTML = tops.map(t => `<option value="${esc(t)}">`).join('');
    $('#fShelf').value = keep[0]; $('#fTopic').value = keep[1];
  }
  function orderKey(b) { const p = b.places[0]; return (p.case === 'A' ? 0 : 1000) + p.shelf * 100 + (p.pos || 99); }
  function renderCatalog() {
    const fs = $('#fShelf').value, ft = $('#fTopic').value, fst = $('#fStatus').value;
    const list = books.filter(b => (!fs || b.places.some(p => p.case + p.shelf === fs)) &&
      (!ft || (ft === '__none' ? !b.topics.length : b.topics.some(t => t.t === ft) || b.suggested.some(t => t.t === ft))) &&
      (!fst || b.status === fst)).sort((a, b) => orderKey(a) - orderKey(b));
    $('#catCount').textContent = `${ar(list.length)} سجلًا`;
    $('#catalog').innerHTML = `<table><thead><tr><th>العنوان</th><th>المؤلف</th><th>المكان</th><th>الموضوعات</th><th>الحالة</th></tr></thead><tbody>${list.map(b => `
      <tr class="clk" data-id="${b.id}" tabindex="0"><td><span style="display:inline-block;width:8px;height:18px;background:${b.color};vertical-align:middle;margin-left:6px;border-radius:2px"></span>${esc(b.title)}</td>
      <td>${esc(b.author)}</td><td class="small">${b.places.map(p => esc(shortPlace(p)) + (p.vols ? ` (مج ${p.vols})` : '')).join('، ')}</td>
      <td>${b.topics.map(t => `<span class="tag">${esc(t.t)}</span>`).join('')}${b.suggested.map(t => `<span class="tag s">${esc(t.t)}؟</span>`).join('')}</td>
      <td>${statusBadge(b)}</td></tr>`).join('')}</tbody></table>`;
  }

  // ---------- المراجعة ----------
  function renderReview() {
    const list = books.filter(b => b.status !== 'مؤكد').sort((a, b) => orderKey(a) - orderKey(b));
    $('#reviewList').innerHTML = list.map(b => { const p = b.places[0]; const c = p.photo ? cropStyle(p, .6) : null; return `
      <div class="rcard">${c ? `<div class="crop" style="${c.bg}" data-photo="${p.photo}" data-mark="${p.box.join(',')}"><span class="mark" style="${c.mark}"></span></div>` : '<p class="muted small">لا صورة لهذا السجل.</p>'}
      <h3>${esc(b.title)}</h3><div class="loc">${esc(placeText(p))}</div>${b.note ? `<p class="muted small">${esc(b.note)}</p>` : ''}
      <div class="row"><button class="btn" data-edit="${b.id}">تحرير</button><button class="btn" data-verify="${b.id}">تم التحقق</button><button class="btn" data-open="${b.id}">في الرف</button></div></div>`; }).join('') || '<p>لا توجد سجلات تحتاج مراجعة.</p>';
  }

  // ---------- خطة إعادة الترتيب ----------
  // الخطة: لكل رف موضوعاته، وكل كتاب مؤكد مصنف يذهب إلى رف موضوعه. غير المصنف يبقى مكانه.
  const PLAN_DONE = 'maktaba-hoqbi-plan-done-v2';
  const PLAN_SHELVES = [
    { k: 'A1', label: 'التفسير والحديث: المجلدات الكبيرة', why: 'المجلدات الثقيلة في الأعلى: «في ظلال القرآن» و«قصص الأنبياء» و«معالم الدعوة» و«رياض الصالحين» و«الموسوعة الميسرة».' },
    { k: 'A2', label: '«التفسير البسيط» من المجلد ١ إلى ١٧', why: 'رتّب المجلدات متتالية بأرقامها.' },
    { k: 'A3', label: '«التفسير البسيط» ١٨–٢٥، ثم علوم القرآن، ثم الوقف', why: 'تكملة «التفسير البسيط» أولًا، ثم كتب علوم القرآن الصغيرة، ثم «مجموعة الأميرة العنود» وكتب الوقف.' },
    { k: 'A4', label: 'العقيدة والفقه والمقاصد، ثم السيرة', why: '' },
    { k: 'A5', label: 'الدعوة والتربية والقيم', why: 'فيه فراغ الآن، فيصلح أن يكون أول رف تنقل إليه.' },
    { k: 'A6', label: 'الفكر والتاريخ والحضارة', why: '' },
    { k: 'B1', label: 'الدفاتر والملفات وأوراق العمل', why: 'يبقى كما هو.' },
    { k: 'B2', label: 'القيادة والإدارة والعمل الخيري', why: '' },
    { k: 'B3', label: 'تطوير الذات والإبداع وعلم النفس', why: '' },
    { k: 'B4', label: 'الأدب والرواية والشعر، والكتيبات، والنسخ المكررة', why: 'الأدب في جهة، والكتيبات الرفيعة في الأخرى، والنسخ الثانية في الطرف حتى تقرر ما تفعل بها.' },
  ];
  const TOPIC_SHELF = {
    'القرآن وعلومه': 'A3', 'العقيدة والإيمان': 'A4', 'الفقه والشريعة': 'A4', 'السيرة والحديث': 'A4',
    'الدعوة': 'A5', 'التربية والأسرة': 'A5', 'القيم والأخلاق': 'A5', 'الفكر والثقافة': 'A6', 'التاريخ والحضارة': 'A6',
    'القيادة': 'B2', 'الإدارة والعمل المؤسسي': 'B2', 'المال والاقتصاد': 'B2',
    'تطوير الذات': 'B3', 'الإبداع والابتكار': 'B3', 'علم النفس والدماغ': 'B3', 'القراءة والتعلم': 'B3', 'أدب ورواية': 'B4'
  };
  const A1_TITLES = ['في ظلال القران', 'قصص الانبياء', 'معالم الدعوه في قصص', 'رياض الصالحين', 'الموسوعه الميسره'];
  const volNum = p => +String(p.vols || '').replace(/[٠-٩]/g, d => '٠١٢٣٤٥٦٧٨٩'.indexOf(d));
  function primaryTopic(b) { const t = b.topics[0] || b.suggested[0]; return t ? t.t : null; }
  function planTarget(b, p) { // يعيد [الرف، السبب] أو null إن بقي مكانه
    if (isUnread(b) || b.status !== 'مؤكد' || b.kind === 'وثيقة' || b.kind === 'دفاتر') return null;
    const nt = norm(b.title);
    if (/^التفسير البسيط/.test(b.title) && p.vols) return volNum(p) <= 17 ? ['A2', 'التفسير البسيط'] : ['A3', 'التفسير البسيط'];
    if (A1_TITLES.some(t => nt.startsWith(norm(t)))) return ['A1', 'مجلد كبير في التفسير والحديث'];
    if (/^نسخة ثانية/.test(b.note || '') || /^نسخة ثانية/.test(b.copyNote || '')) return ['B4', 'نسخة مكررة'];
    let t = primaryTopic(b); if (!t) return null;
    if (t === 'القرآن وعلومه' && b.topics[1]) t = b.topics[1].t; // «السيرة في ظلال القرآن» سيرة لا تفسير
    if (t === 'الوقف والعمل الخيري') return /وقف|اوقاف/.test(nt) ? ['A3', 'الوقف'] : ['B2', 'العمل الخيري'];
    return TOPIC_SHELF[t] ? [TOPIC_SHELF[t], t] : null;
  }
  function computePlan() {
    const moves = [], stay = {}, unk = {}, cur = {};
    for (const x of slots()) {
      if (!x.p.pos) continue; const k = x.p.case + x.p.shelf; cur[k] = (cur[k] || 0) + 1;
      const tg = planTarget(x.b, x.p);
      if (!tg) { unk[k] = (unk[k] || 0) + 1; continue; }
      if (tg[0] === k) { stay[k] = (stay[k] || 0) + 1; continue; }
      moves.push({ b: x.b, pi: x.i, p: x.p, from: k, to: tg[0], why: tg[1] });
    }
    return { moves, stay, unk, cur };
  }
  function renderPlan() {
    const { moves, stay, unk, cur } = computePlan(); const done = new Set(JSON.parse(store.get(PLAN_DONE) || '[]'));
    const sk = Object.fromEntries(shelfKeys()); const out = k => moves.filter(m => m.from === k).length; const inn = k => moves.filter(m => m.to === k);
    const key = m => m.b.id + ':' + m.pi;
    const scatter = {}; slots().forEach(x => { const t = primaryTopic(x.b); if (t && x.p.pos) (scatter[t] ||= new Set()).add(x.p.case + x.p.shelf); });
    const worst = Object.entries(scatter).sort((a, b) => b[1].size - a[1].size).slice(0, 4).map(([t, s]) => `${t} (${ar(s.size)} رفوف)`).join('، ');
    const totalUnk = Object.values(unk).reduce((a, b) => a + b, 0);
    $('#plan').innerHTML = `<div class="callout"><strong>اقتراح فقط.</strong> الخطة لا تغيّر خريطة الرفوف. بعد أن تنقل كتابًا بيدك اضغط «نقلته فعلًا» ليُحدَّث مكانه في الفهرس.
      الكتب غير المؤكدة وغير المصنفة (${ar(totalUnk)} موضعًا) تبقى مكانها حتى تُراجع، فالحدود بين الرفوف أولية.</div>
      <h2>الفكرة</h2>
      <p>الخزانة أ للعلوم الشرعية والدعوة والتربية، ثم الفكر والتاريخ في رفها الأخير. والخزانة ب للقيادة والإدارة وتطوير الذات، ثم الأدب.
      المجلدات الثقيلة في الأعلى، والكتيبات في الأسفل. داخل كل رف رتّب الكتب حسب المؤلف، وأبقِ كل مجموعة متعددة المجلدات متصلة بترتيب أرقامها.</p>
      <p class="muted">أكثر الموضوعات تشتتًا الآن: ${esc(worst)}. عدد المواضع التي تنتقل في الخطة: ${ar(moves.length)}، نُقل منها ${ar(moves.filter(m => done.has(key(m))).length)}.</p>
      <h2>ابدأ بهذه الرفوف</h2>
      <ol class="prio">
        <li><strong>الخزانة أ، الرفوف ١ و٢ و٣: «التفسير البسيط».</strong> مجلداته الـ٢٥ موزعة على ثلاثة رفوف وغير مرتبة. أسهل خطوة وأوضحها أثرًا.</li>
        <li><strong>الخزانة أ، الرف ٥.</strong> فيه فراغ؛ انقل إليه كتب الدعوة والتربية والقيم (يدخله ${ar(inn('A5').length)}).</li>
        <li><strong>الخزانة أ، الرفان ٦ و٤.</strong> أكبر رفين وأكثرهما خلطًا (يخرج منهما ${ar(out('A6') + out('A4'))} موضعًا).</li>
        <li><strong>الخزانة ب، الرف ٤.</strong> روايات وكتيبات ونسخ مكررة مختلطة؛ افرزه ليصير للأدب.</li>
      </ol>
      <h2>الرفوف بعد الترتيب</h2>
      ${PLAN_SHELVES.map(s => { const mv = inn(s.k).sort((a, b) => (a.b.author || '').localeCompare(b.b.author || '', 'ar') || volNum(a.p) - volNum(b.p));
        const after = (cur[s.k] || 0) - out(s.k) + mv.length; const full = after > (cur[s.k] || 0) * 1.15 + 3;
        return `<div class="plan-shelf"><h3>${esc(sk[s.k])} ← ${esc(s.label)}</h3>
        ${s.why ? `<p class="small">${esc(s.why)}</p>` : ''}
        <p class="muted small">فيه الآن ${ar(cur[s.k] || 0)}: يبقى ${ar(stay[s.k] || 0)}، ويخرج ${ar(out(s.k))}، ويبقى غير مصنف ${ar(unk[s.k] || 0)}. يدخله ${ar(mv.length)}، فيصير نحو ${ar(after)}.
        ${full ? '<strong class="warn">قد يضيق؛ انقل الكتيبات أو النسخ المكررة منه أولًا.</strong>' : ''}</p>
        ${mv.length ? `<details${s.k === 'A2' || s.k === 'A5' ? ' open' : ''}><summary>الكتب التي تنتقل إليه (${ar(mv.length)})، مرتبة حسب المؤلف</summary>
        ${mv.map(m => `<div class="move${done.has(key(m)) ? ' done' : ''}"><span><strong>${esc(m.b.title)}${m.p.vols ? ' — المجلد ' + esc(m.p.vols) : ''}</strong>
          <span class="muted small">${esc(m.b.author || '')}${m.b.author ? ' · ' : ''}من ${esc(sk[m.from])} · ${esc(m.why)}</span></span>
          ${done.has(key(m)) ? '<span class="badge ok">نُقل</span>' : `<button class="btn" data-moved="${m.b.id}" data-pi="${m.pi}" data-to="${m.to}">نقلته فعلًا</button>`}</div>`).join('')}</details>` : ''}</div>`; }).join('')}`;
  }
  function applyMove(id, pi, to) {
    const b = books.find(x => x.id === id); const c = to[0], s = +to.slice(1); const p = b.places[pi];
    const max = Math.max(0, ...slots().filter(x => x.p.case === c && +x.p.shelf === s).map(x => x.p.pos || 0));
    p.case = c; p.shelf = s; p.pos = max + 1; p.movedByPlan = true; p.photoNote = 'نُقل حسب خطة إعادة الترتيب؛ الصورة تُظهر المكان القديم';
    recount(); const d = new Set(JSON.parse(store.get(PLAN_DONE) || '[]')); d.add(id + ':' + pi); store.set(PLAN_DONE, JSON.stringify([...d])); save();
  }
  function recount() { // يعيد ترقيم المواضع متتابعة في كل رف، ويقدّم المعدَّل حديثًا عند التساوي
    const by = {}; slots().forEach(x => { if (x.p.pos) (by[x.p.case + x.p.shelf] ||= []).push(x.p); });
    Object.values(by).forEach(a => { a.sort((u, v) => u.pos - v.pos || (v._new ? 1 : 0) - (u._new ? 1 : 0)); a.forEach((p, i) => { p.pos = i + 1; p.of = a.length; delete p._new; }); });
  }

  // ---------- التحرير ----------
  let editing = null;
  function openEdit(id, pi = 0) {
    const f = $('#editForm'); const b = id ? books.find(x => x.id === id) : null;
    editing = { id, pi };
    const p = b ? b.places[pi] : { case: 'A', shelf: 1, pos: 0 };
    $('#editHead').textContent = b ? 'تحرير الكتاب' : 'إضافة كتاب يدويًا';
    f.title.value = b?.title || ''; f.author.value = b?.author || ''; f.publisher.value = b?.publisher || '';
    f.case.value = p.case; f.shelf.value = p.shelf; f.pos.value = p.pos || 0;
    f.status.value = b?.status || 'مؤكد';
    f.topics.value = (b?.topics || []).map(t => t.t).join('، '); f.suggested.value = (b?.suggested || []).map(t => t.t).join('، ');
    f.note.value = b?.note || '';
    $('#editPlaceNote').textContent = b && b.places.length > 1 ? `هذه مجموعة لها ${ar(b.places.length)} مواضع؛ تعديل المكان يخص المجلد ${b.places[pi].vols || ''} فقط.` : 'الموضع ٠ يعني «فوق الصف أفقيًا».';
    $('#delBtn').hidden = !b;
    const setMax = () => { f.shelf.max = Object.keys(CASES[f.case.value].shelves).length; };
    setMax(); f.case.onchange = setMax;
    $('#editDlg').showModal();
  }
  $('#editForm').addEventListener('submit', async e => {
    const act = e.submitter?.value; const f = e.target;
    if (act === 'cancel') return;
    if (act === 'delete') { if (await askConfirm('حذف هذا السجل من الفهرس؟')) { books = books.filter(x => x.id !== editing.id); recount(); save(); $('#drawer').hidden = true; } return; }
    const split = s => s.split(/[،,]/).map(x => x.trim()).filter(Boolean);
    let b = editing.id ? books.find(x => x.id === editing.id) : null;
    if (!b) {
      b = { id: 'm' + Date.now().toString(36), color: '#8a7f72', kind: 'كتاب', places: [{ case: 'A', shelf: 1, pos: 0, photo: null, box: null }], topics: [], suggested: [], addedBy: 'يدوي', publisher: '', note: '' };
      books.push(b); editing.pi = 0;
    }
    b.title = f.title.value.trim(); b.author = f.author.value.trim(); b.publisher = f.publisher.value.trim(); b.status = f.status.value; b.note = f.note.value.trim();
    const oldT = Object.fromEntries(b.topics.map(t => [t.t, t.basis]));
    b.topics = split(f.topics.value).map(t => ({ t, basis: oldT[t] || 'أُثبت يدويًا' }));
    const oldS = Object.fromEntries(b.suggested.map(t => [t.t, t.reason]));
    b.suggested = split(f.suggested.value).filter(t => !b.topics.some(x => x.t === t)).map(t => ({ t, reason: oldS[t] || 'اقتراح يدوي يحتاج مراجعة' }));
    const p = b.places[editing.pi];
    const moved = p.case !== f.case.value || +p.shelf !== +f.shelf.value || +p.pos !== +f.pos.value;
    p.case = f.case.value; p.shelf = +f.shelf.value; p.pos = +f.pos.value; if (moved) p._new = true;
    if (moved && p.photo) p.photoNote = 'المكان عُدّل يدويًا؛ الصورة تُظهر المكان القديم';
    recount(); save(); openBook(b.id, editing.pi, true);
  });

  // ---------- الاستيراد والتصدير ----------
  function download(name, text, type) {
    try { const a = document.createElement('a'); a.href = URL.createObjectURL(new Blob([text], { type })); a.download = name; a.click(); setTimeout(() => URL.revokeObjectURL(a.href), 1000); } catch (e) {}
    // بديل حين يمنع العارض التنزيل: النص في مربع مع زر نسخ
    $('#exportBox').hidden = false; $('#exportText').value = text; $('#exportName').textContent = name;
    $('#dataMsg').textContent = `جُهّز ${name}. إن لم يبدأ التنزيل فانسخ النص من المربع واحفظه ملفًا بهذا الاسم.`;
  }
  $('#copyExport').onclick = async () => {
    const t = $('#exportText');
    try { await navigator.clipboard.writeText(t.value); $('#dataMsg').textContent = 'نُسخ النص.'; }
    catch (e) { t.select(); $('#dataMsg').textContent = 'حدّدت النص؛ انسخه يدويًا.'; }
  };
  const CSV_COLS = ['id', 'title', 'author', 'publisher', 'status', 'kind', 'case', 'shelf', 'pos', 'vols', 'topics', 'suggested', 'note', 'photo', 'box', 'color', 'addedBy'];
  function toCsv() {
    const q = v => `"${String(v ?? '').replace(/"/g, '""')}"`;
    const rows = books.flatMap(b => b.places.map(p => [b.id, b.title, b.author, b.publisher, b.status, b.kind, p.case, p.shelf, p.pos, p.vols || '', b.topics.map(t => t.t).join('|'), b.suggested.map(t => t.t).join('|'), b.note, p.photo || '', (p.box || []).join(' '), b.color, b.addedBy]));
    return '﻿' + [CSV_COLS, ...rows].map(r => r.map(q).join(',')).join('\r\n');
  }
  function parseCsv(text) {
    const rows = []; let row = [], cur = '', inq = false;
    text = text.replace(/^﻿/, '');
    for (let i = 0; i < text.length; i++) {
      const c = text[i];
      if (inq) { if (c === '"') { if (text[i + 1] === '"') { cur += '"'; i++; } else inq = false; } else cur += c; }
      else if (c === '"') inq = true; else if (c === ',') { row.push(cur); cur = ''; } else if (c === '\n' || c === '\r') { if (c === '\r' && text[i + 1] === '\n') i++; row.push(cur); rows.push(row); row = []; cur = ''; } else cur += c;
    }
    if (cur || row.length) { row.push(cur); rows.push(row); }
    const head = rows.shift(); const map = {};
    for (const r of rows) {
      if (r.length < 2) continue; const o = Object.fromEntries(head.map((h, i) => [h, r[i] ?? '']));
      const prev = books.find(b => b.id === o.id);
      const b = map[o.id] ||= { id: o.id || 'm' + Math.random().toString(36).slice(2, 8), title: o.title, author: o.author, publisher: o.publisher, status: o.status || 'يحتاج مراجعة', kind: o.kind || 'كتاب', color: o.color || '#8a7f72', addedBy: o.addedBy || 'يدوي', note: o.note,
        topics: o.topics.split('|').filter(Boolean).map(t => ({ t, basis: prev?.topics.find(x => x.t === t)?.basis || 'من ملف مستورد' })),
        suggested: o.suggested.split('|').filter(Boolean).map(t => ({ t, reason: prev?.suggested.find(x => x.t === t)?.reason || 'من ملف مستورد' })), places: [] };
      b.places.push({ case: o.case || 'A', shelf: +o.shelf || 1, pos: +o.pos || 0, vols: o.vols || undefined, photo: o.photo || null, box: o.box ? o.box.split(' ').map(Number) : null });
    }
    return Object.values(map);
  }
  $('#exportJson').onclick = () => download('maktaba-al-othman.json', JSON.stringify({ version: 1, exportedAt: new Date().toISOString(), books }, null, 1), 'application/json');
  $('#exportCsv').onclick = () => download('maktaba-al-othman.csv', toCsv(), 'text/csv');
  $('#importFile').onchange = async e => {
    const file = e.target.files[0]; if (!file) return; const text = await file.text();
    try {
      const nb = file.name.endsWith('.csv') ? parseCsv(text) : (JSON.parse(text).books || JSON.parse(text));
      if (!Array.isArray(nb) || !nb.every(b => b.title && Array.isArray(b.places))) throw new Error('بنية غير متوقعة');
      if (!await askConfirm(`سيُستبدل الفهرس الحالي بـ ${nb.length} سجلًا من الملف. متابعة؟`)) return;
      books = nb; recount(); save(); $('#dataMsg').textContent = `استُورد ${ar(nb.length)} سجلًا.`;
    } catch (err) { $('#dataMsg').textContent = 'تعذّر الاستيراد: ' + err.message; }
    e.target.value = '';
  };
  $('#resetData').onclick = async () => { if (await askConfirm('سيُحذف كل تعديل محفوظ في هذا المتصفح ويعود الفهرس كما استُخرج من الصور. متابعة؟')) { store.del(KEY); store.del(PLAN_DONE); books = structuredClone(ORIG.books); renderAll(); $('#dataMsg').textContent = 'عاد الفهرس إلى أصله.'; } };
  $('#addBook').onclick = () => openEdit(null);

  // ---------- التبويبات والأحداث ----------
  function showTab(t) {
    $$('.tabs button').forEach(b => b.setAttribute('aria-selected', b.dataset.tab === t));
    $$('.tab').forEach(s => s.hidden = s.id !== 'tab-' + t);
  }
  $$('.tabs button').forEach(b => b.onclick = () => showTab(b.dataset.tab));
  let tmr; $('#q').addEventListener('input', () => { clearTimeout(tmr); tmr = setTimeout(() => { runSearch(); if (window.scrollY > 0) window.scrollTo({ top: 0, behavior: 'smooth' }); }, 120); });
  document.addEventListener('keydown', e => { // «/» يضع المؤشر في البحث
    if (e.key === '/' && !/INPUT|TEXTAREA|SELECT/.test(document.activeElement.tagName) && !$('dialog[open]')) { e.preventDefault(); $('#q').focus(); }
  });
  $('#cabinets').addEventListener('keydown', e => { // الأسهم تتنقل بين كتب الرف الواحد
    const t = e.target; if (!t.classList.contains('spine') || !/Arrow(Left|Right)|Home|End/.test(e.key)) return;
    const row = [...t.parentNode.children];
    const n = e.key === 'Home' ? row[0] : e.key === 'End' ? row[row.length - 1] : e.key === 'ArrowRight' ? t.nextElementSibling : t.previousElementSibling;
    if (n) { e.preventDefault(); t.tabIndex = -1; n.tabIndex = 0; n.focus(); }
  });
  ['#fShelf', '#fTopic', '#fStatus'].forEach(s => $(s).onchange = renderCatalog);
  $('#drawerClose').onclick = () => { $('#drawer').hidden = true; $$('.hl').forEach(e => e.classList.remove('hl')); document.body.classList.remove('sheet'); const back = lastFocus && document.contains(lastFocus) ? lastFocus : ($('.spine[tabindex="0"]', $('.shelf.hl') || document) || $('#q')); if (back) back.focus({ preventScroll: true }); };
  document.addEventListener('keydown', e => { if (e.key === 'Escape' && !$('#drawer').hidden && !$('dialog[open]')) $('#drawerClose').click(); });
  document.addEventListener('click', e => {
    const t = e.target.closest('[data-moved],[data-id],[data-photo],[data-edit],[data-verify],[data-open]');
    if (!t) return;
    if (t.dataset.moved) return applyMove(t.dataset.moved, +t.dataset.pi, t.dataset.to);
    if (t.dataset.edit) return openEdit(t.dataset.edit);
    if (t.dataset.verify) { const b = books.find(x => x.id === t.dataset.verify); b.status = 'مؤكد'; return save(); }
    if (t.dataset.open) { showTab('shelves'); return openBook(t.dataset.open, 0); }
    if (t.dataset.photo && !t.closest('.res,.spine')) return openPhoto(t.dataset.photo, t.dataset.mark);
    if (t.dataset.id) {
      if (t.closest('#results')) showTab('shelves');
      openBook(t.dataset.id, +(t.dataset.pi || 0));
    }
  });
  document.addEventListener('keydown', e => { if ((e.key === 'Enter' || e.key === ' ') && e.target.matches('.res, tr.clk, figure[data-photo]')) { e.preventDefault(); e.target.click(); } });

  function renderAll() { renderStats(); renderCabinets(); renderFilters(); renderCatalog(); renderReview(); renderPlan(); runSearch(); }
  renderPhotos(); renderAll();
  // رابط مباشر: #q=نص البحث
  const h = decodeURIComponent(location.hash.slice(1)); if (h.startsWith('q=')) { $('#q').value = h.slice(2); runSearch(); }
})();
