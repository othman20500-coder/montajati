// أدوات مشتركة للتصاميم الثلاثة: تقرأ الفهرس الحقيقي وتحسب الموقع والقصاصة.
window.M = (() => {
  const L = window.LIBRARY, books = L.books;
  const ar = n => String(n).replace(/\d/g, d => '٠١٢٣٤٥٦٧٨٩'[d]);
  const caseL = c => c === 'A' ? 'أ' : 'ب';
  const SEC = { q: 'القرآن وعلومه', f: 'العقيدة والفقه والسيرة', d: 'الدعوة والتربية والقيم', h: 'الفكر والتاريخ', m: 'القيادة والإدارة', s: 'تطوير الذات والإبداع', l: 'الأدب والرواية', n: 'غير مصنف' };
  const T2S = { 'القرآن وعلومه': 'q', 'العقيدة والإيمان': 'f', 'الفقه والشريعة': 'f', 'السيرة والحديث': 'f', 'الدعوة': 'd', 'التربية والأسرة': 'd', 'القيم والأخلاق': 'd', 'الوقف والعمل الخيري': 'd', 'الفكر والثقافة': 'h', 'التاريخ والحضارة': 'h', 'القيادة': 'm', 'الإدارة والعمل المؤسسي': 'm', 'المال والاقتصاد': 'm', 'تطوير الذات': 's', 'الإبداع والابتكار': 's', 'علم النفس والدماغ': 's', 'القراءة والتعلم': 's', 'أدب ورواية': 'l' };
  const sec = b => { if (b.status !== 'مؤكد') return 'n'; let t = (b.topics[0] || b.suggested[0] || {}).t; if (t === 'القرآن وعلومه' && b.topics[1]) t = b.topics[1].t; return T2S[t] || 'n'; };
  const slots = []; books.forEach(b => b.places.forEach((p, i) => slots.push({ b, p, i })));
  const shelf = (c, s) => slots.filter(x => x.p.case === c && +x.p.shelf === +s && x.p.pos).sort((a, b) => a.p.pos - b.p.pos);
  const find = t => books.find(b => b.title === t);
  function neighbours(p) {
    const on = shelf(p.case, p.shelf), at = k => on.find(x => x.p.pos === k);
    const nm = x => x && x.b.status === 'مؤكد' && !/^(عنوان|قراءة)/.test(x.b.title) ? x.b.title : null;
    return { left: nm(at(p.pos - 1)), right: nm(at(p.pos + 1)) };
  }
  function crop(p, ratio = 4 / 3, pad = .5) {
    const ph = L.photos[p.photo]; const [x0, y0, x1, y1] = p.box; const bw = x1 - x0, bh = y1 - y0;
    let ch = bh * 1.12, cw = Math.max(ch * ratio, bw * (1 + pad * 2)); ch = cw / ratio;
    cw = Math.min(cw, ph.w); ch = Math.min(ch, ph.h);
    const cx = Math.min(Math.max((x0 + x1) / 2 - cw / 2, 0), ph.w - cw), cy = Math.min(Math.max((y0 + y1) / 2 - ch / 2, 0), ph.h - ch);
    return { bg: `background-image:url(../../photos/${p.photo}.jpg);background-size:${ph.w / cw * 100}% ${ph.h / ch * 100}%;background-position:${cx / (ph.w - cw) * 100}% ${cy / (ph.h - ch) * 100}%`,
      mark: `left:${(x0 - cx) / cw * 100}%;top:${(y0 - cy) / ch * 100}%;width:${bw / cw * 100}%;height:${bh / ch * 100}%` };
  }
  const tc = hex => { const h = hex.replace('#', ''); const f = h.length === 3 ? h.split('').map(c => c + c).join('') : h;
    const L2 = [0, 2, 4].map(i => parseInt(f.substr(i, 2), 16) / 255).map(c => c <= .03928 ? c / 12.92 : ((c + .055) / 1.055) ** 2.4);
    const lum = .2126 * L2[0] + .7152 * L2[1] + .0722 * L2[2]; return 1.05 / (lum + .05) >= (lum + .05) / .0644 ? '#fff' : '#1c1c1c'; };
  const conf = books.filter(b => b.status === 'مؤكد').length;
  return { L, books, ar, caseL, SEC, sec, shelf, find, neighbours, crop, tc, total: books.length, conf };
})();
