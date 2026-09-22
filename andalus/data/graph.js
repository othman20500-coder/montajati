/* =========================================================
   طبقة بيانات منصة الأندلس (MVP)
   الشكل: ERAS[] · SOURCES{} · CLAIMS{} · الكيانات عبر add({...})
   يطابق data/schema.json من حيث المعنى. كل جملة تاريخية = ادعاء له حالة ومصادر.
   حالات الادعاء: fact 🟢 · disputed 🟠 · inference 🔵 · myth ⚪ · unverified ⬜
   مستوى تحقق الروابط: url_checked = "search" (ظهر في نتائج البحث) أو "fetched" (فُتح مباشرة)
   ========================================================= */
const E = {}; // الكيانات
function add(o){ E[o.id]=o; return o; }
const ERAS = [
  { id:"era:wulat",    name:"الفتح والولاة",        from:711,  to:756,  c:"var(--era-wulat)" },
  { id:"era:imara",    name:"الإمارة الأموية",        from:756,  to:929,  c:"var(--era-imara)" },
  { id:"era:khilafa",  name:"خلافة قرطبة",           from:929,  to:1031, c:"var(--era-khilafa)" },
  { id:"era:tawaif",   name:"ملوك الطوائف",          from:1031, to:1091, c:"var(--era-tawaif)" },
  { id:"era:murabit",  name:"المرابطون",             from:1091, to:1147, c:"var(--era-murabit)" },
  { id:"era:muwahhid", name:"الموحدون والطوائف الثالثة", from:1147, to:1238, c:"var(--era-muwahhid)" },
  { id:"era:nasrid",   name:"مملكة غرناطة",          from:1238, to:1492, c:"var(--era-nasrid)" },
  { id:"era:morisco",  name:"المدجنون والموريسكيون", from:1492, to:1614, c:"var(--era-morisco)" },
];
const SOURCES = {
  "src:kennedy-1996":{ title:"Muslim Spain and Portugal: A Political History of al-Andalus", author:"Hugh Kennedy", year:"1996", pub:"Longman", tier:"A", kind:"كتاب أكاديمي", lang:"EN" },
  "src:ei2":{ title:"Encyclopaedia of Islam, Second Edition", author:"Brill (مداخل متعددة)", year:"1960–2007", pub:"Brill", tier:"A", kind:"موسوعة أكاديمية", lang:"EN" },
  "src:harvey-1990":{ title:"Islamic Spain, 1250 to 1500", author:"L. P. Harvey", year:"1990", pub:"University of Chicago Press", tier:"A", kind:"كتاب أكاديمي", lang:"EN" },
  "src:harvey-2005":{ title:"Muslims in Spain, 1500 to 1614", author:"L. P. Harvey", year:"2005", pub:"University of Chicago Press", tier:"A", kind:"كتاب أكاديمي", lang:"EN" },
  "src:sanjuan-2013":{ title:"La conquista islámica de la península ibérica y la tergiversación del pasado", author:"Alejandro García Sanjuán", year:"2013", pub:"Marcial Pons", tier:"A", kind:"كتاب أكاديمي", lang:"ES" },
  "src:unesco":{ title:"قائمة التراث العالمي (UNESCO World Heritage List)", author:"UNESCO", year:"—", pub:"whc.unesco.org", tier:"B", kind:"مؤسسة دولية", lang:"EN/FR" },
  "src:ledger":{ title:"سجل الادعاءات: بانتظار التوثيق", author:"فريق التحرير", year:"2026", pub:"—", tier:"C", kind:"داخلي", lang:"AR" },
};
const CLAIMS = {
  "c:conquest-711":{ text:"بدأ الفتح الإسلامي لشبه الجزيرة الإيبيرية سنة 92هـ/711م.", status:"fact", sources:[{src:"src:kennedy-1996",loc:"الفصل الأول"},{src:"src:ei2",loc:"مدخل al-Andalus"}], counter:[] },
  "c:conquest-narratives":{ text:"تفاصيل الفتح (دور طارق وموسى، قصة يوليان، حجم الجيوش) تعتمد على روايات متأخرة مختلف على قيمتها.", status:"disputed", sources:[{src:"src:sanjuan-2013",loc:"الفصول 2–4"}], counter:[{position:"أطروحة «الإنكار» (Olagüe ثم González Ferrín): لم يقع فتح عسكري أصلًا. يرفضها أغلب المؤرخين.", sources:[{src:"src:sanjuan-2013",loc:"نقد الأطروحة"}]}] },
  "c:emirate-756":{ text:"أسس عبد الرحمن الداخل الإمارة الأموية المستقلة في قرطبة سنة 138هـ/756م.", status:"fact", sources:[{src:"src:kennedy-1996",loc:"الفصل الثاني"},{src:"src:ei2",loc:"مدخل ʿAbd al-Raḥmān I"}], counter:[] },
  "c:caliphate-929":{ text:"أعلن عبد الرحمن الثالث الخلافة وتلقّب بأمير المؤمنين سنة 316هـ/929م.", status:"fact", sources:[{src:"src:kennedy-1996",loc:"الفصل الرابع"},{src:"src:ei2",loc:"مدخل ʿAbd al-Raḥmān III"}], counter:[] },
  "c:zahra-936":{ text:"بدأ بناء مدينة الزهراء سنة 325هـ/936م.", status:"fact", sources:[{src:"src:ei2",loc:"مدخل Madīnat al-Zahrāʾ"}], counter:[] },
  "c:library-400k":{ text:"«مكتبة الحكم المستنصر ضمت 400 ألف مجلد».", status:"myth", sources:[{src:"src:ledger",loc:"الرقم يرد في مصادر وسيطة ويتناقله المتأخرون؛ لا يمكن التحقق منه ويُعرض كرواية شائعة مع نقده"}], counter:[{position:"المؤرخون المحدثون يعدّون الرقم مبالغة أدبية شائعة في المصادر الوسيطة.", sources:[{src:"src:ledger",loc:"يُستكمل بمرجع محدد قبل النشر"}]}] },
  "c:fitna-1009":{ text:"اندلعت الفتنة في قرطبة سنة 399هـ/1009م وانتهت بإلغاء الخلافة سنة 422هـ/1031م.", status:"fact", sources:[{src:"src:kennedy-1996",loc:"الفصل الخامس"}], counter:[] },
  "c:toledo-1085":{ text:"دخل ألفونسو السادس طليطلة سنة 478هـ/1085م.", status:"fact", sources:[{src:"src:kennedy-1996",loc:"الفصل السادس"}], counter:[] },
  "c:zallaqa-date":{ text:"وقعت معركة الزلاقة في 12 رجب 479هـ / 23 أكتوبر 1086م.", status:"fact", sources:[{src:"src:kennedy-1996",loc:"الفصل السادس"},{src:"src:ei2",loc:"مدخل al-Zallāḳa"}], counter:[] },
  "c:zallaqa-numbers":{ text:"أعداد الجيوش في الزلاقة كما ترد في المصادر الوسيطة مبالغ فيها ولا يمكن الجزم بها.", status:"disputed", sources:[{src:"src:kennedy-1996",loc:"الفصل السادس"}], counter:[{position:"بعض المصادر الوسيطة تذكر أرقامًا بمئات الآلاف.", sources:[{src:"src:ledger",loc:"تُحصر الروايات وتُعرض كمدى"}]}] },
  "c:navas-1212":{ text:"هُزم الموحدون في معركة العقاب (Las Navas de Tolosa) سنة 609هـ/1212م.", status:"fact", sources:[{src:"src:kennedy-1996",loc:"الفصل الثامن"},{src:"src:ei2",loc:"مدخل al-ʿIḳāb"}], counter:[] },
  "c:cordoba-1236":{ text:"دخل فرناندو الثالث قرطبة سنة 633هـ/1236م.", status:"fact", sources:[{src:"src:kennedy-1996",loc:"الفصل التاسع"}], counter:[] },
  "c:nasrid-1238":{ text:"دخل محمد بن الأحمر غرناطة سنة 635هـ/1238م مؤسسًا الدولة النصرية.", status:"fact", sources:[{src:"src:harvey-1990",loc:"الفصل الثاني"}], counter:[] },
  "c:seville-1248":{ text:"استسلمت إشبيلية لفرناندو الثالث سنة 646هـ/1248م.", status:"fact", sources:[{src:"src:kennedy-1996",loc:"الفصل التاسع"}], counter:[] },
  "c:granada-1492":{ text:"سُلِّمت غرناطة في 2 يناير 1492م (2 ربيع الأول 897هـ).", status:"fact", sources:[{src:"src:harvey-1990",loc:"الفصل الأخير"}], counter:[] },
  "c:expulsion-1609":{ text:"صدر مرسوم طرد الموريسكيين سنة 1609م ونُفّذ على مراحل حتى 1614م.", status:"fact", sources:[{src:"src:harvey-2005",loc:"الفصل العاشر"}], counter:[] },
  "c:expulsion-numbers":{ text:"عدد المطرودين تقديري ويتراوح بين مصادر حديثة مختلفة.", status:"disputed", sources:[{src:"src:harvey-2005",loc:"الفصل العاشر"}], counter:[{position:"التقديرات تختلف باختلاف منهج العدّ (السجلات الرسمية مقابل التقدير السكاني).", sources:[{src:"src:harvey-2005",loc:"الفصل العاشر"}]}] },
  "c:cordoba-unesco":{ text:"المركز التاريخي لقرطبة مسجل في قائمة التراث العالمي (1984، وُسّع 1994).", status:"fact", sources:[{src:"src:unesco",loc:"Historic Centre of Cordoba, ref 313"}], counter:[] },
  "c:ibnhazm-life":{ text:"وُلد ابن حزم في قرطبة سنة 384هـ/994م وتوفي سنة 456هـ/1064م.", status:"fact", sources:[{src:"src:ei2",loc:"مدخل Ibn Ḥazm"}], counter:[] },
  "c:ibnhazm-death-place":{ text:"توفي ابن حزم في ضيعة أهله بمنت ليشم قرب لبلة.", status:"inference", sources:[{src:"src:ei2",loc:"مدخل Ibn Ḥazm"}], counter:[] },
  "c:mutamid":{ text:"حكم المعتمد بن عبّاد إشبيلية 461–484هـ / 1069–1091م ونُفي إلى أغمات.", status:"fact", sources:[{src:"src:ei2",loc:"مدخل al-Muʿtamid"}], counter:[] },
  "c:averroes":{ text:"وُلد ابن رشد في قرطبة سنة 520هـ/1126م وتوفي في مراكش سنة 595هـ/1198م.", status:"fact", sources:[{src:"src:ei2",loc:"مدخل Ibn Rushd"}], counter:[] },
};
// أماكن (lat, lon)
add({id:"pl:cordoba",type:"Place",name:{ar:"قرطبة",lat:"Corduba",es:"Córdoba"},lat:37.88,lon:-4.78,kind:"مدينة",founded:711,summary:[["عاصمة الإمارة ثم الخلافة الأموية، وأكبر مدن الأندلس في القرن العاشر.","c:emirate-756"],["دخلها فرناندو الثالث سنة 1236م.","c:cordoba-1236"],["مركزها التاريخي تراث عالمي.","c:cordoba-unesco"]],control:[[711,1031,"muslim"],[1031,1236,"muslim"],[1236,1700,"christian"]],kids:"قرطبة كانت أكبر مدينة في الأندلس، فيها جامع مشهور بأقواسه الحمراء والبيضاء.",scholar:"تُعرض هنا الخلافات حول حجم المدينة وسكانها؛ الأرقام الوسيطة تُعرض كمدى لا كرقم."});
add({id:"pl:zahra",type:"Place",name:{ar:"مدينة الزهراء",es:"Medina Azahara"},lat:37.89,lon:-4.87,kind:"مدينة قصرية",founded:936,summary:[["مدينة قصرية بناها عبد الرحمن الثالث ابتداءً من 936م.","c:zahra-936"]],control:[[936,1010,"muslim"]]});
add({id:"pl:seville",type:"Place",name:{ar:"إشبيلية",lat:"Hispalis",es:"Sevilla"},lat:37.39,lon:-5.99,kind:"مدينة",founded:711,summary:[["عاصمة بني عبّاد في عصر الطوائف، ثم عاصمة الموحدين في الأندلس.","c:mutamid"],["استسلمت سنة 1248م.","c:seville-1248"]],control:[[711,1248,"muslim"],[1248,1700,"christian"]]});
add({id:"pl:granada",type:"Place",name:{ar:"غرناطة",es:"Granada"},lat:37.18,lon:-3.60,kind:"مدينة",founded:711,summary:[["عاصمة الدولة النصرية من 1238م.","c:nasrid-1238"],["سُلّمت سنة 1492م.","c:granada-1492"]],control:[[711,1492,"muslim"],[1492,1700,"christian"]]});
add({id:"pl:toledo",type:"Place",name:{ar:"طليطلة",lat:"Toletum",es:"Toledo"},lat:39.86,lon:-4.03,kind:"مدينة",founded:711,summary:[["عاصمة القوط، ثم مدينة حدودية كبرى، ثم عاصمة بني ذي النون.","c:toledo-1085"],["دخلها ألفونسو السادس سنة 1085م.","c:toledo-1085"]],control:[[711,1085,"muslim"],[1085,1700,"christian"]]});
add({id:"pl:zaragoza",type:"Place",name:{ar:"سرقسطة",lat:"Caesaraugusta",es:"Zaragoza"},lat:41.65,lon:-0.88,kind:"مدينة",founded:714,summary:[["عاصمة الثغر الأعلى، وبني هود في عصر الطوائف.","c:conquest-711"]],control:[[714,1118,"muslim"],[1118,1700,"christian"]]});
add({id:"pl:malaga",type:"Place",name:{ar:"مالقة",es:"Málaga"},lat:36.72,lon:-4.42,kind:"مدينة",founded:711,summary:[["ميناء غرناطة الكبير في العصر النصري.","c:nasrid-1238"]],control:[[711,1487,"muslim"],[1487,1700,"christian"]]});
add({id:"pl:almeria",type:"Place",name:{ar:"ألمرية",es:"Almería"},lat:36.83,lon:-2.46,kind:"مدينة",founded:955,summary:[["ميناء الخلافة، وبها كان ابن حزم فترة.","c:ibnhazm-life"]],control:[[955,1147,"muslim"],[1147,1157,"christian"],[1157,1489,"muslim"],[1489,1700,"christian"]]});
add({id:"pl:valencia",type:"Place",name:{ar:"بلنسية",es:"Valencia"},lat:39.47,lon:-0.38,kind:"مدينة",founded:711,summary:[["مركز الطوائف الشرقية؛ دخلها جايمي الأول سنة 1238م.","c:nasrid-1238"]],control:[[711,1238,"muslim"],[1238,1700,"christian"]]});
add({id:"pl:badajoz",type:"Place",name:{ar:"بطليوس",es:"Badajoz"},lat:38.88,lon:-6.97,kind:"مدينة",founded:875,summary:[["عاصمة بني الأفطس في عصر الطوائف، وقربها وقعت الزلاقة.","c:zallaqa-date"]],control:[[875,1230,"muslim"],[1230,1700,"christian"]]});
add({id:"pl:lisbon",type:"Place",name:{ar:"لشبونة",es:"Lisboa"},lat:38.72,lon:-9.14,kind:"مدينة",founded:711,summary:[["سقطت سنة 1147م.","c:conquest-711"]],control:[[711,1147,"muslim"],[1147,1700,"christian"]]});
add({id:"pl:murcia",type:"Place",name:{ar:"مرسية",es:"Murcia"},lat:37.99,lon:-1.13,kind:"مدينة",founded:825,summary:[["مركز الشرق الأندلسي في القرن الثالث عشر.","c:nasrid-1238"]],control:[[825,1243,"muslim"],[1243,1700,"christian"]]});
add({id:"pl:ceuta",type:"Place",name:{ar:"سبتة",es:"Ceuta"},lat:35.89,lon:-5.32,kind:"مدينة",founded:711,summary:[["بوابة العبور بين العدوتين.","c:conquest-711"]],control:[[711,1415,"muslim"],[1415,1700,"christian"]]});
add({id:"pl:fes",type:"Place",name:{ar:"فاس",es:"Fez"},lat:34.03,lon:-5.00,kind:"مدينة",founded:789,summary:[["مقصد المهاجرين الأندلسيين وعاصمة المرينيين.","c:conquest-711"]],control:[[789,1700,"muslim"]]});
add({id:"pl:leon",type:"Place",name:{ar:"ليون",es:"León"},lat:42.6,lon:-5.57,kind:"مدينة",founded:711,summary:[["عاصمة مملكة ليون المسيحية.","c:conquest-711"]],control:[[711,760,"muslim"],[760,1700,"christian"]]});
add({id:"pl:barcelona",type:"Place",name:{ar:"برشلونة",es:"Barcelona"},lat:41.39,lon:2.17,kind:"مدينة",founded:711,summary:[["فُتحت 717م تقريبًا واستعادها الفرنجة 801م.","c:conquest-711"]],control:[[717,801,"muslim"],[801,1700,"christian"]]});
// ميادين معارك
add({id:"pl:guadalete",type:"Place",name:{ar:"وادي لكة",es:"Guadalete"},lat:36.55,lon:-6.05,kind:"ميدان معركة",founded:711,summary:[["موقع المعركة الأولى؛ الموقع الدقيق مختلف عليه.","c:conquest-narratives"]],battle:true});
add({id:"pl:zallaqa",type:"Place",name:{ar:"الزلاقة",es:"Sagrajas"},lat:38.95,lon:-6.85,kind:"ميدان معركة",founded:1086,summary:[["ميدان معركة 1086م قرب بطليوس.","c:zallaqa-date"]],battle:true});
add({id:"pl:navas",type:"Place",name:{ar:"العقاب",es:"Las Navas de Tolosa"},lat:38.28,lon:-3.58,kind:"ميدان معركة",founded:1212,summary:[["ميدان معركة 1212م.","c:navas-1212"]],battle:true});
// أشخاص
add({id:"p:abdrahman1",type:"Person",name:{ar:"عبد الرحمن الداخل",en:"ʿAbd al-Raḥmān I"},born:731,died:788,roles:["أمير"],era:"era:imara",summary:[["أموي نجا من العباسيين وأسس الإمارة في قرطبة 756م.","c:emirate-756"]],edges:[["ruled","s:umayyad-cordoba","756–788"],["lived_in","pl:cordoba"],["participated_in","e:emirate-756","مؤسس"]],kids:"هرب من دمشق وهو شاب، وقطع الصحراء والبحر حتى وصل الأندلس وصار أميرها."});
add({id:"p:abdrahman3",type:"Person",name:{ar:"عبد الرحمن الناصر",en:"ʿAbd al-Raḥmān III"},born:891,died:961,roles:["أمير","خليفة"],era:"era:khilafa",summary:[["أعلن الخلافة سنة 929م.","c:caliphate-929"],["بدأ بناء مدينة الزهراء سنة 936م.","c:zahra-936"]],edges:[["ruled","s:umayyad-cordoba","912–961"],["born_in","pl:cordoba"],["participated_in","e:caliphate-929","المُعلِن"],["patron_of","pl:zahra"]]});
add({id:"p:hakam2",type:"Person",name:{ar:"الحكم المستنصر",en:"al-Ḥakam II"},born:915,died:976,roles:["خليفة"],era:"era:khilafa",summary:[["خليفة عُرف برعاية العلم والكتب.","c:library-400k"]],edges:[["ruled","s:umayyad-cordoba","961–976"],["born_in","pl:cordoba"]],scholar:"رقم «400 ألف مجلد» يُعرض في المنصة كرواية شائعة غير مثبتة مع نقدها."});
add({id:"p:ibnhazm",type:"Person",name:{ar:"ابن حزم",en:"Ibn Ḥazm"},born:994,died:1064,roles:["فقيه","أديب","مؤرخ"],era:"era:tawaif",summary:[["وُلد في قرطبة 994م وتوفي 1064م.","c:ibnhazm-life"],["توفي في منت ليشم.","c:ibnhazm-death-place"]],edges:[["born_in","pl:cordoba"],["lived_in","pl:almeria"],["lived_in","pl:seville"],["authored","w:tawq"],["participated_in","e:fitna-1009","شاهد"]],kids:"كتب كتابًا عن الحب والصداقة اسمه «طوق الحمامة» وهو ما زال يُقرأ حتى اليوم."});
add({id:"p:mutamid",type:"Person",name:{ar:"المعتمد بن عبّاد",en:"al-Muʿtamid"},born:1040,died:1095,roles:["ملك طائفة","شاعر"],era:"era:tawaif",summary:[["حكم إشبيلية 1069–1091م ونُفي إلى أغمات.","c:mutamid"]],edges:[["ruled","s:abbadid","1069–1091"],["lived_in","pl:seville"],["participated_in","e:zallaqa-1086","طرف"]]});
add({id:"p:yusuf",type:"Person",name:{ar:"يوسف بن تاشفين",en:"Yūsuf b. Tāshfīn"},born:1009,died:1106,roles:["أمير المسلمين"],era:"era:murabit",summary:[["قائد المرابطين في الزلاقة 1086م.","c:zallaqa-date"]],edges:[["ruled","s:almoravid","1061–1106"],["participated_in","e:zallaqa-1086","قائد"]]});
add({id:"p:alfonso6",type:"Person",name:{ar:"ألفونسو السادس",en:"Alfonso VI"},born:1040,died:1109,roles:["ملك قشتالة وليون"],era:"era:tawaif",summary:[["دخل طليطلة 1085م.","c:toledo-1085"],["هُزم في الزلاقة 1086م.","c:zallaqa-date"]],edges:[["participated_in","e:toledo-1085","قائد"],["participated_in","e:zallaqa-1086","قائد"]]});
add({id:"p:averroes",type:"Person",name:{ar:"ابن رشد",en:"Averroes"},born:1126,died:1198,roles:["فيلسوف","قاضٍ","طبيب"],era:"era:muwahhid",summary:[["وُلد في قرطبة 1126م وتوفي في مراكش 1198م.","c:averroes"]],edges:[["born_in","pl:cordoba"],["lived_in","pl:seville"]],kids:"فيلسوف شرح كتب أرسطو حتى سُمّي في أوروبا «الشارح»."});
add({id:"p:ibnahmar",type:"Person",name:{ar:"محمد بن الأحمر",en:"Muḥammad I of Granada"},born:1195,died:1273,roles:["سلطان"],era:"era:nasrid",summary:[["مؤسس الدولة النصرية 1238م.","c:nasrid-1238"]],edges:[["ruled","s:nasrid","1238–1273"],["lived_in","pl:granada"],["participated_in","e:nasrid-1238","مؤسس"]]});
add({id:"p:ibnkhatib",type:"Person",name:{ar:"لسان الدين بن الخطيب",en:"Ibn al-Khaṭīb"},born:1313,died:1374,roles:["وزير","مؤرخ","شاعر"],era:"era:nasrid",summary:[["وزير غرناطة ومؤرخها في «الإحاطة».","c:nasrid-1238"]],edges:[["lived_in","pl:granada"],["died_in","pl:fes"]]});
// دول
add({id:"s:umayyad-cordoba",type:"Polity",name:{ar:"الأمويون في قرطبة"},from:756,to:1031,capital:"pl:cordoba",summary:[["إمارة 756–929م ثم خلافة 929–1031م.","c:caliphate-929"]]});
add({id:"s:abbadid",type:"Polity",name:{ar:"بنو عبّاد (إشبيلية)"},from:1023,to:1091,capital:"pl:seville",summary:[["أقوى طوائف الجنوب.","c:mutamid"]]});
add({id:"s:almoravid",type:"Polity",name:{ar:"المرابطون"},from:1091,to:1147,capital:"pl:fes",summary:[["وحّدوا الأندلس مع المغرب بعد الزلاقة.","c:zallaqa-date"]]});
add({id:"s:nasrid",type:"Polity",name:{ar:"بنو نصر (غرناطة)"},from:1238,to:1492,capital:"pl:granada",summary:[["آخر دولة إسلامية في الأندلس.","c:nasrid-1238"]]});
// أحداث
add({id:"e:conquest-711",type:"Event",name:{ar:"بداية الفتح"},year:711,kind:"فتح",era:"era:wulat",place:"pl:guadalete",summary:[["بدأ الفتح سنة 711م.","c:conquest-711"],["تفاصيله مختلف عليها.","c:conquest-narratives"]],weight:3});
add({id:"e:emirate-756",type:"Event",name:{ar:"تأسيس الإمارة الأموية"},year:756,kind:"تأسيس",era:"era:imara",place:"pl:cordoba",summary:[["أسس عبد الرحمن الداخل الإمارة.","c:emirate-756"]],weight:3});
add({id:"e:caliphate-929",type:"Event",name:{ar:"إعلان الخلافة"},year:929,kind:"تحول سياسي",era:"era:khilafa",place:"pl:cordoba",summary:[["أعلن عبد الرحمن الثالث الخلافة.","c:caliphate-929"]],weight:3});
add({id:"e:zahra-936",type:"Event",name:{ar:"بدء بناء مدينة الزهراء"},year:936,kind:"بناء",era:"era:khilafa",place:"pl:zahra",summary:[["بدأ البناء سنة 936م.","c:zahra-936"]],weight:2});
add({id:"e:fitna-1009",type:"Event",name:{ar:"الفتنة وسقوط الخلافة"},year:1009,end:1031,kind:"تحول سياسي",era:"era:khilafa",place:"pl:cordoba",summary:[["فتنة 1009–1031م.","c:fitna-1009"]],weight:3});
add({id:"e:toledo-1085",type:"Event",name:{ar:"سقوط طليطلة"},year:1085,kind:"حصار",era:"era:tawaif",place:"pl:toledo",summary:[["دخلها ألفونسو السادس.","c:toledo-1085"]],weight:3});
add({id:"e:zallaqa-1086",type:"Event",name:{ar:"معركة الزلاقة"},year:1086,kind:"معركة",era:"era:tawaif",place:"pl:zallaqa",summary:[["23 أكتوبر 1086م.","c:zallaqa-date"],["أعداد الجيوش مختلف عليها.","c:zallaqa-numbers"]],weight:3,before:["e:toledo-1085"],after:["e:navas-1212"]});
add({id:"e:navas-1212",type:"Event",name:{ar:"معركة العقاب"},year:1212,kind:"معركة",era:"era:muwahhid",place:"pl:navas",summary:[["هزيمة الموحدين 1212م.","c:navas-1212"]],weight:3});
add({id:"e:cordoba-1236",type:"Event",name:{ar:"سقوط قرطبة"},year:1236,kind:"حصار",era:"era:muwahhid",place:"pl:cordoba",summary:[["دخلها فرناندو الثالث.","c:cordoba-1236"]],weight:2});
add({id:"e:nasrid-1238",type:"Event",name:{ar:"تأسيس مملكة غرناطة"},year:1238,kind:"تأسيس",era:"era:nasrid",place:"pl:granada",summary:[["دخل ابن الأحمر غرناطة.","c:nasrid-1238"]],weight:3});
add({id:"e:seville-1248",type:"Event",name:{ar:"سقوط إشبيلية"},year:1248,kind:"حصار",era:"era:nasrid",place:"pl:seville",summary:[["استسلمت المدينة.","c:seville-1248"]],weight:2});
add({id:"e:granada-1492",type:"Event",name:{ar:"تسليم غرناطة"},year:1492,kind:"معاهدة",era:"era:nasrid",place:"pl:granada",summary:[["2 يناير 1492م.","c:granada-1492"]],weight:3});
add({id:"e:expulsion-1609",type:"Event",name:{ar:"طرد الموريسكيين"},year:1609,end:1614,kind:"هجرة قسرية",era:"era:morisco",place:"pl:valencia",summary:[["مرسوم 1609م.","c:expulsion-1609"],["الأعداد تقديرية.","c:expulsion-numbers"]],weight:3});
// وثائق ومصنفات وآثار
add({id:"w:tawq",type:"Work",name:{ar:"طوق الحمامة"},author:"p:ibnhazm",year:1027,summary:[["رسالة في الحب ومعانيه كتبها ابن حزم في شاطبة.","c:ibnhazm-life"]]});
add({id:"d:muqtabis",type:"Document",name:{ar:"المقتبس لابن حيان"},author:"ابن حيان القرطبي (ت 1076م)",summary:[["المصدر الأساس لتاريخ الإمارة والخلافة؛ وصلنا ناقصًا.","c:caliphate-929"]],holding:{institution:"نسخ في مكتبات متعددة (تُوثَّق بالأرقام المكتبية في سجل المصادر)",iiif:""}});
add({id:"d:capitulations",type:"Document",name:{ar:"شروط تسليم غرناطة"},author:"1491م",summary:[["الاتفاق الذي سُلّمت بموجبه غرناطة.","c:granada-1492"]],holding:{institution:"الأرشيفات الإسبانية (تُوثَّق)",iiif:""}});
add({id:"a:mughira",type:"Artifact",name:{ar:"علبة المغيرة العاجية"},year:968,summary:[["علبة عاجية من مدينة الزهراء، 968م، محفوظة في متحف اللوفر.","c:zahra-936"]],holding:{institution:"متحف اللوفر، باريس",license:"صورة تُستخدم بترخيص المتحف"}});
add({id:"a:vase",type:"Artifact",name:{ar:"جرة الغزلان"},year:1400,summary:[["جرة نصرية كبيرة من قصر الحمراء.","c:nasrid-1238"]],holding:{institution:"متحف الحمراء، غرناطة",license:"غير معروف"}});
