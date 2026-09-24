BEGIN TRANSACTION;
CREATE TABLE assertion_claim_links(assertion_id TEXT NOT NULL, claim_id TEXT NOT NULL, relation TEXT, PRIMARY KEY(assertion_id, claim_id),
  FOREIGN KEY(assertion_id) REFERENCES assertions(assertion_id), FOREIGN KEY(claim_id) REFERENCES claims(claim_id));
INSERT INTO "assertion_claim_links" VALUES('AST-012','CLM-001','يدعم التاريخ');
INSERT INTO "assertion_claim_links" VALUES('AST-027','CLM-001','نفس الادعاء بصياغة الفرع');
INSERT INTO "assertion_claim_links" VALUES('AST-003','CLM-001','حد العصر');
INSERT INTO "assertion_claim_links" VALUES('AST-013','ATLAS-CLM01','تاريخ بدء البناء');
INSERT INTO "assertion_claim_links" VALUES('AST-015','ATLAS-CLM01','يدقق صيغة UNESCO للخراب: دخول البربر 401هـ ثم الخراب التام 414–416هـ');
INSERT INTO "assertion_claim_links" VALUES('AST-025','ATLAS-CLM01','الهوية والموقع');
INSERT INTO "assertion_claim_links" VALUES('AST-024','ATLAS-CLM02','هوية قرطبة');
INSERT INTO "assertion_claim_links" VALUES('AST-G29','ATLAS-CLM03','الحمراء');
INSERT INTO "assertion_claim_links" VALUES('AST-G30','ATLAS-CLM03','جنة العريف');
CREATE TABLE assertions(assertion_id TEXT PRIMARY KEY, target_id TEXT NOT NULL, field TEXT NOT NULL, kind TEXT, value_ar TEXT NOT NULL, value_before TEXT,
  status TEXT NOT NULL, resolution_ar TEXT, todo_ar TEXT, model TEXT NOT NULL, last_verified TEXT NOT NULL);
INSERT INTO "assertions" VALUES('AST-001','PRD-02','start','حد عصر','756',NULL,'موثّق',NULL,NULL,'cordoba','2026-09-23');
INSERT INTO "assertions" VALUES('AST-002','PRD-02','end','حد عصر','929',NULL,'موثّق',NULL,NULL,'cordoba','2026-09-23');
INSERT INTO "assertions" VALUES('AST-003','PRD-03','start','حد عصر','929',NULL,'موثّق',NULL,NULL,'cordoba','2026-09-23');
INSERT INTO "assertions" VALUES('AST-004','PRD-03','end','حد عصر','1009–1031',NULL,'موثّق جزئيًا',NULL,'حد نهاية الخلافة يحتمل تعريفين؛ الشواهد تدعم الطرفين جزئيًا — القرار التحريري: إبقاء النطاق 1009–1031.','cordoba','2026-09-23');
INSERT INTO "assertions" VALUES('AST-005','PRD-03a','start','حد عصر','1009',NULL,'موثّق',NULL,NULL,'cordoba','2026-09-23');
INSERT INTO "assertions" VALUES('AST-006','PRD-03a','end','حد عصر','1031',NULL,'موثّق',NULL,NULL,'cordoba','2026-09-23');
INSERT INTO "assertions" VALUES('AST-007','TEN-001','span','مدة ولاية','756–788 (أمير)',NULL,'حُسم الخلاف','حُسم: 24 ربيع الآخر 172هـ = 1 أكتوبر 788م بالتحويل الجدولي؛ تحويل عنان إلى 787 سهو. القيمة 788 باقية.',NULL,'cordoba','2026-09-23');
INSERT INTO "assertions" VALUES('AST-008','TEN-002a','span','مدة ولاية','912–929 (أمير)',NULL,'موثّق',NULL,NULL,'cordoba','2026-09-23');
INSERT INTO "assertions" VALUES('AST-009','TEN-002b','span','مدة ولاية','929–961 (خليفة)',NULL,'موثّق',NULL,NULL,'cordoba','2026-09-23');
INSERT INTO "assertions" VALUES('AST-010','TEN-003','span','مدة ولاية','961–976 (خليفة)',NULL,'موثّق',NULL,NULL,'cordoba','2026-09-23');
INSERT INTO "assertions" VALUES('AST-011','EVT-002','date','تاريخ حدث','756–756 / 138هـ',NULL,'موثّق',NULL,NULL,'cordoba','2026-09-23');
INSERT INTO "assertions" VALUES('AST-012','EVT-003','date','تاريخ حدث','929–929 / 316هـ',NULL,'حُسم الخلاف','حُسم بالمصدر الأولي: البيان المغرب ج2 ص196–198 يضع التسمي بأمير المؤمنين في حوادث سنة 316هـ والخطبة به مستهل ذي الحجة 316 (≈ 15 يناير 929م). رواية «منذ 317» في حاشية عنان مرجوحة. القيمة 316هـ/929م ثابتة.',NULL,'cordoba','2026-09-23');
INSERT INTO "assertions" VALUES('AST-013','EVT-004','date','تاريخ حدث','936 / محرم 325هـ (بدء البناء)','ق4هـ','موثّق',NULL,NULL,'cordoba','2026-09-23');
INSERT INTO "assertions" VALUES('AST-014','EVT-005','date','تاريخ حدث','1009–1031 / 399–422هـ',NULL,'موثّق جزئيًا',NULL,NULL,'cordoba','2026-09-23');
INSERT INTO "assertions" VALUES('AST-015','EVT-012','event','حدث مقترح','خراب مدينة الزهراء في الفتنة: دخلها البربر أواخر ربيع الأول 401هـ (نوفمبر 1010م)، واستُؤصل خرابها في أيام المستكفي 414–416هـ (1024–1025م)','خراب مدينة الزهراء في الفتنة 1009–1010','صُحح وموثّق','القيمة السابقة «1009–1010» تجعل الخراب حدثًا واحدًا، والمصادر الأولية تجعله على مرحلتين. الأولى دخول البربر المدينة والغارات في ربيع الأول 401هـ («أعمال الأعلام» ص117، وعنان). والثانية الخراب التام وطمس القصر في أيام المستكفي («الذخيرة» ج1 ص436)، وولايته 414–416هـ («جذوة المقتبس» ص26–27). صيغة اليونسكو «1009–1010» صارت «يدعم جزئيًا».',NULL,'cordoba','2026-09-24');
INSERT INTO "assertions" VALUES('AST-016','PER-002','life','تاريخا الميلاد والوفاة','891–961','889–961','صُحح وموثّق','صُحح: 22 رمضان 277هـ = 7 يناير 891م؛ يوافقه Britannica (يناير 891)؛ «ديسمبر 890» عند عنان تقريب. القيمة الجديدة 891.',NULL,'cordoba','2026-09-23');
INSERT INTO "assertions" VALUES('AST-017','PER-002','name_parts','أجزاء الاسم','عبد الرحمن | أبو المطرف | بن محمد بن عبد الله | الأموي | الناصر لدين الله',NULL,'موثّق',NULL,NULL,'cordoba','2026-09-23');
INSERT INTO "assertions" VALUES('AST-018','PER-ALHAKAM-II','life','تاريخا الميلاد والوفاة','915–976',NULL,'موثّق',NULL,NULL,'cordoba','2026-09-23');
INSERT INTO "assertions" VALUES('AST-019','PER-ALHAKAM-II','name_parts','أجزاء الاسم','الحكم | أبو العاص | بن عبد الرحمن الناصر | الأموي | المستنصر بالله',NULL,'موثّق',NULL,NULL,'cordoba','2026-09-23');
INSERT INTO "assertions" VALUES('AST-020','PER-004','life','تاريخا الميلاد والوفاة','نحو 938–940 – 1002 (27 رمضان 392هـ)','939–1002 (مولده 328هـ = 939/940م)','موثّق جزئيًا','الوفاة: 27 رمضان 392هـ عند ابن عذاري (ج2 ص301) وعنان؛ و393هـ عند الحميدي رواية مرجوحة. المولد: 328هـ عند عنان، وسنّه عند ابن عذاري تجعله نحو 326هـ (938م).','المولد بين 326 و328هـ: لم أعثر عليه ضمن البحث المنفذ في «جذوة المقتبس» و«البيان المغرب» و«نفح الطيب» و«الذخيرة» و«بغية الملتمس» و«العبر» (2026-09-24). يبقى «موثّق جزئيًا».','cordoba','2026-09-24');
INSERT INTO "assertions" VALUES('AST-021','PER-004','name_parts','أجزاء الاسم','محمد | أبو عامر | بن عبد الله بن أبي عامر | المعافري | المنصور',NULL,'موثّق',NULL,NULL,'cordoba','2026-09-23');
INSERT INTO "assertions" VALUES('AST-022','PER-012','life','تاريخا الميلاد والوفاة','توفي بعد 400هـ (1009م)؛ السنة المحددة غير معروفة (نحو 1013م عند Britannica، و427هـ/1036م عند الزركلي)','نحو 936–1013م','موثّق جزئيًا','المصادر الأولية لا تذكر سنة الوفاة. «الصلة» (ص162): «مات بالأندلس بعد الأربع مئة». وابن حزم (ت 456هـ) يقول: «أدركناه وشاهدناه». وترجمة ابن أبي أصيبعة في «عيون الأنباء» (ص501) بلا تاريخ. والتقديران الحديثان متعارضان: 1013 و1036. والميلاد نحو 936 عند Britannica وحدها.','يُبحث عن سنة الوفاة في «التكملة» لابن الأبار و«طبقات الأمم» لصاعد. «طبقات الأمم» لم أعثر عليه في فهرس الشاملة.','cordoba','2026-09-24');
INSERT INTO "assertions" VALUES('AST-023','PER-012','name_parts','أجزاء الاسم','خلف | أبو القاسم | بن عباس | الزهراوي | ',NULL,'موثّق',NULL,NULL,'cordoba','2026-09-23');
INSERT INTO "assertions" VALUES('AST-024','PLC-CORDOBA','identity','هوية مكان','قرطبة = Córdoba؛ عاصمة الإمارة والخلافة',NULL,'موثّق',NULL,NULL,'cordoba','2026-09-23');
INSERT INTO "assertions" VALUES('AST-025','PLC-MADINAT-ZAHRA','identity+location','هوية وموقع','مدينة الزهراء = Medina Azahara؛ موقع أثري غرب قرطبة (37.8859, -4.8677 بحسب UNESCO)',NULL,'موثّق',NULL,NULL,'cordoba','2026-09-23');
INSERT INTO "assertions" VALUES('AST-026','COIN-003','object','قطعة مادية','درهم عبد الرحمن الثالث 316هـ فضة (MAN)',NULL,'موثّق جزئيًا',NULL,'القطعة نفسها لم تُفتح صفحتها في MAN (القائمة فقط): يُطلب سجل المتحف برقم الجرد.','cordoba','2026-09-23');
INSERT INTO "assertions" VALUES('AST-027','CLM-001','claim','ادعاء','إعلان عبد الرحمن الثالث الخلافة سنة 316هـ/929م',NULL,'حُسم الخلاف','كما في AST-012 (البيان المغرب ج2 ص198).',NULL,'cordoba','2026-09-23');
INSERT INTO "assertions" VALUES('AST-G01','PRD-07','start','حد عصر','1232–1238 (إعلان ابن الأحمر 1232 / دخول غرناطة 1238)',NULL,'موثّق',NULL,NULL,'granada','2026-09-23');
INSERT INTO "assertions" VALUES('AST-G02','PRD-07','end','حد عصر','1492 (تسليم غرناطة 2 يناير 1492)',NULL,'موثّق',NULL,NULL,'granada','2026-09-23');
INSERT INTO "assertions" VALUES('AST-G03','TEN-007','span','مدة ولاية','1232–1273',NULL,'موثّق جزئيًا','الوفاة 29 جمادى الآخرة 671هـ = 21 يناير 1273م بنص الإحاطة ج2 ص56؛ «ديسمبر 1272» عند عنان سهو في التحويل.',NULL,'granada','2026-09-23');
INSERT INTO "assertions" VALUES('AST-G04','TEN-009','span','مدة ولاية','1273–1302',NULL,'موثّق',NULL,NULL,'granada','2026-09-23');
INSERT INTO "assertions" VALUES('AST-G05','TEN-010','span','مدة ولاية','1333–1354',NULL,'موثّق',NULL,NULL,'granada','2026-09-23');
INSERT INTO "assertions" VALUES('AST-G06','TEN-011a','span','مدة ولاية','1354–1359',NULL,'موثّق',NULL,NULL,'granada','2026-09-24');
INSERT INTO "assertions" VALUES('AST-G07','TEN-011b','span','مدة ولاية','1362–1391',NULL,'حُسم الخلاف','حُسم: جمادى الآخرة 763هـ = مارس–أبريل 1362م؛ «1361» عند عنان سهو تحويل. القيمة 1362 باقية.',NULL,'granada','2026-09-23');
INSERT INTO "assertions" VALUES('AST-G08','TEN-012a','span','مدة ولاية','868هـ (1463/1464) – 1482','1464–1482','حُسم الخلاف','حُسم مؤقتًا: البداية 868هـ (1463/1464م) عند عنان تُرجَّح على «1466» في Britannica؛ يُفحص في Fábregas (LIB-BK-026).',NULL,'granada','2026-09-23');
INSERT INTO "assertions" VALUES('AST-G09','TEN-012b','span','مدة ولاية','1483–1485',NULL,'موثّق',NULL,NULL,'granada','2026-09-23');
INSERT INTO "assertions" VALUES('AST-G10','TEN-013','span','مدة ولاية','1485–1487',NULL,'موثّق',NULL,NULL,'granada','2026-09-23');
INSERT INTO "assertions" VALUES('AST-G11','TEN-008a','span','مدة ولاية','1482–1483',NULL,'موثّق',NULL,NULL,'granada','2026-09-23');
INSERT INTO "assertions" VALUES('AST-G12','TEN-008b','span','مدة ولاية','1487–1492',NULL,'موثّق',NULL,NULL,'granada','2026-09-23');
INSERT INTO "assertions" VALUES('AST-G13','PER-030','name_parts','أجزاء الاسم','محمد بن يوسف بن نصر؛ أبو عبد الله؛ الغالب بالله؛ ابن الأحمر',NULL,'موثّق',NULL,NULL,'granada','2026-09-23');
INSERT INTO "assertions" VALUES('AST-G14','PER-033','life','تاريخا الميلاد والوفاة','1318 (28 ربيع الآخر 718هـ) – 1354 (1 شوال 755هـ)','نحو 1317–1319 (السادسة عشرة سنة 733هـ) – 1354','صُحح وموثّق','المولد من نقش القبر في الإحاطة ج4 ص292 بدل التقدير بالسن.',NULL,'granada','2026-09-23');
INSERT INTO "assertions" VALUES('AST-G15','PER-034','life','تاريخا الميلاد والوفاة','1339 (22 جمادى الآخرة 739هـ) – 1391 (793هـ)','1338 (لم يوثق) – 1391 (793هـ)','صُحح وموثّق','صُحح الميلاد من 1338 إلى 1339 بنص الإحاطة ج2 ص50.',NULL,'granada','2026-09-23');
INSERT INTO "assertions" VALUES('AST-G16','PER-018','life','تاريخا الميلاد والوفاة','1313 (25 رجب 713هـ) – 1374/1375 (776هـ)','1313 (25 رجب 713هـ) – 1374 (أوائل 776هـ)','موثّق','الوفاة مواءمة مع AST-G28: 776هـ بين مستهلّها وشوالها (ابن خلدون).',NULL,'granada','2026-09-24');
INSERT INTO "assertions" VALUES('AST-G17','PER-035','life','تاريخا الميلاد والوفاة','1333 (14 شوال 733هـ) – بعد 795هـ (أواخر 1393م أو بعدها)','1333 – 1393 أو 1395 (خلاف)','موثّق جزئيًا','الميلاد موثّق (الإحاطة عبر نفح الطيب ج7 ص160). الوفاة: المقري (ج7 ص170) لا يعرف سنتها ويحدها ببعد 795هـ؛ فسنة 1393 حدّ أدنى لا تاريخ. والمراجع الحديثة متضاربة: 1393 و1394 (موقع الباترونato في صفحتين) و1395 (عنان محيلًا إلى النفح الذي لا يذكرها). ويجعلها الزركلي «نحو 793هـ» (ATT-277)، وهذا يخالف نص المقري.','«نثير فرائد الجمان» لم أعثر عليه في فهرس الشاملة. وكتاب ابن الأحمر المنزّل بعنوان «أعلام المغرب والأندلس في القرن الثامن» لا يذكر ابن زمرك إلا في المقدمة. والمطلوب «البقية والمدرك» (ديوان ابن زمرك بجمع ابن الأحمر) من طبعة ورقية. إلى حينه تُعرض الوفاة «بعد 795هـ».','granada','2026-09-24');
INSERT INTO "assertions" VALUES('AST-G18','PER-031','name_parts','أجزاء الاسم','أبو عبد الله محمد بن علي (Boabdil)',NULL,'موثّق',NULL,NULL,'granada','2026-09-23');
INSERT INTO "assertions" VALUES('AST-G19','EVT-013','date','تاريخ حدث','1238 / 635هـ',NULL,'موثّق',NULL,NULL,'granada','2026-09-23');
INSERT INTO "assertions" VALUES('AST-G20','EVT-014','date','تاريخ حدث','643هـ = 1245/1246م','1246 / 643هـ','حُسم الخلاف','حُسم بتوسيع النطاق: 643هـ تمتد من مايو 1245 إلى مايو 1246؛ عنان يذكر 1245. القيمة: 643هـ = 1245/1246م.',NULL,'granada','2026-09-23');
INSERT INTO "assertions" VALUES('AST-G21','EVT-015','date','تاريخ حدث','1340 / 741هـ',NULL,'موثّق',NULL,NULL,'granada','2026-09-23');
INSERT INTO "assertions" VALUES('AST-G22','EVT-016','date','تاريخ ونسبة بناء','1362–1391 (محمد الخامس)',NULL,'موثّق',NULL,NULL,'granada','2026-09-23');
INSERT INTO "assertions" VALUES('AST-G23','EVT-017','date','تاريخ حدث','1487 / 892هـ',NULL,'موثّق',NULL,NULL,'granada','2026-09-23');
INSERT INTO "assertions" VALUES('AST-G24','EVT-018','date','تاريخ حدث','25 نوفمبر 1491',NULL,'موثّق',NULL,'إعادة نقل نص الشاهد ATT-GB08 حرفيًا من ص250.','granada','2026-09-23');
INSERT INTO "assertions" VALUES('AST-G25','EVT-009','date','تاريخ حدث','2 يناير 1492 / 897هـ',NULL,'موثّق',NULL,NULL,'granada','2026-09-23');
INSERT INTO "assertions" VALUES('AST-G26','EVT-019','date','تاريخ حدث','1499–1501',NULL,'موثّق جزئيًا',NULL,'تاريخا بداية الثورة ونهايتها غير صريحين عند عنان: يُفحص في Harvey (Islamic Spain 1250–1500) وLadero.','granada','2026-09-23');
INSERT INTO "assertions" VALUES('AST-G27','EVT-020','date','تاريخ حدث','12 فبراير 1502 (نحو 4 شعبان 907هـ)','1502','موثّق','تاريخ الأمر 12 فبراير 1502 بمرجعين متخصصين مستقلين: Ladero Quesada 1999 (ص179) وOrtego Rico 2011 (ص279 وص283)، ويوافقهما Britannica في السنة. أمر 20 يوليو 1501 عند عنان خاص بمملكة غرناطة، وهو أمر آخر.','نص الأمر الملكي نفسه لم يُقرأ بعد. مظانّه: Ladero Quesada، Los mudéjares de Castilla en tiempo de Isabel I (1969)، ص127–130 (بإحالة Ortego Rico)، وسجلات Archivo General de Simancas عبر PARES.','granada','2026-09-24');
INSERT INTO "assertions" VALUES('AST-G28','EVT-021','date','تاريخ حدث','776هـ (بين مستهلّها وشوالها؛ منتصف 1374م إلى أوائل 1375م)','1374 / أوائل 776هـ','موثّق','ابن خلدون في «العبر» (ج7 ص452–453) يضع النكبة والقتل بعد استيلاء أبي العباس على فاس الجديد مستهل 776هـ، وفي «الرحلة» (ص187) يسبق خبر القتل لحاق أهله به في عيد الفطر 776هـ. لا يذكر أحد المصدرين يوم القتل ولا شهره، فتبقى السنة 776هـ.',NULL,'granada','2026-09-24');
INSERT INTO "assertions" VALUES('AST-G29','PLC-G01','identity+location','هوية وموقع','الحمراء: مدينة قصور نصرية على تل السبيكة؛ ضمن موقع UNESCO 314',NULL,'موثّق',NULL,NULL,'granada','2026-09-23');
INSERT INTO "assertions" VALUES('AST-G30','PLC-G02','identity','هوية مكان','جنة العريف: قصر ريفي/بساتين نصرية بجوار الحمراء',NULL,'موثّق',NULL,NULL,'granada','2026-09-23');
INSERT INTO "assertions" VALUES('AST-G31','CLM-G01','claim','ادعاء','أشعار ابن زمرك منقوشة على جدران الحمراء',NULL,'موثّق',NULL,NULL,'granada','2026-09-23');
INSERT INTO "assertions" VALUES('AST-G32','CLM-G02','claim','ادعاء','قصر قمارش ينسب إلى يوسف الأول (مع إتمام محمد الخامس)',NULL,'موثّق',NULL,NULL,'granada','2026-09-23');
INSERT INTO "assertions" VALUES('AST-G33','PER-030','life','تاريخا الميلاد والوفاة','1194/1195 (591هـ، عام الأرك) – 1273 (29 جمادى الآخرة 671هـ)',NULL,'حُسم الخلاف','الإحاطة (نقش القبر ج2 ص56، وج2 ص55 «عام الأرك») تجعل المولد 591هـ؛ عنان (ج5 ص38) 595هـ بلا إحالة هنا. الترجيح لنص ابن الخطيب المعاصر لبني نصر.',NULL,'granada','2026-09-23');
CREATE TABLE atlas_layer_members (
  layer_id TEXT NOT NULL,
  entity_id TEXT NOT NULL,
  role TEXT,
  PRIMARY KEY(layer_id,entity_id),
  FOREIGN KEY(layer_id) REFERENCES atlas_layers(layer_id),
  FOREIGN KEY(entity_id) REFERENCES entities(entity_id)
);
INSERT INTO "atlas_layer_members" VALUES('LYR-EARLY','PLC-SAQUNDA','urban archaeology');
INSERT INTO "atlas_layer_members" VALUES('LYR-EARLY','PLC-PECHINA','craft/urban');
INSERT INTO "atlas_layer_members" VALUES('LYR-EARLY','PLC-EL-MOLON','early mosque');
INSERT INTO "atlas_layer_members" VALUES('LYR-EARLY','PLC-TOSSAL-VILA','early mosque');
INSERT INTO "atlas_layer_members" VALUES('LYR-CALIPHATE','PLC-CORDOBA','capital');
INSERT INTO "atlas_layer_members" VALUES('LYR-CALIPHATE','PLC-CORDOBA-WH','urban heritage');
INSERT INTO "atlas_layer_members" VALUES('LYR-CALIPHATE','PLC-MADINAT-ZAHRA','caliphal city');
INSERT INTO "atlas_layer_members" VALUES('LYR-URBAN','PLC-ALMARIYYA','port/economy');
INSERT INTO "atlas_layer_members" VALUES('LYR-URBAN','PLC-PECHINA','craft/urban');
INSERT INTO "atlas_layer_members" VALUES('LYR-URBAN','PLC-GRANADA','urban centre');
INSERT INTO "atlas_layer_members" VALUES('LYR-KNOWLEDGE','PLC-GRANADA','origin');
INSERT INTO "atlas_layer_members" VALUES('LYR-KNOWLEDGE','PLC-TOLEDO','translation');
INSERT INTO "atlas_layer_members" VALUES('LYR-KNOWLEDGE','PLC-DAMASCUS','destination');
INSERT INTO "atlas_layer_members" VALUES('LYR-LEGACY','PLC-LEON','court culture');
INSERT INTO "atlas_layer_members" VALUES('LYR-LEGACY','PLC-MANISES','craft continuity');
CREATE TABLE atlas_layers (
  layer_id TEXT PRIMARY KEY,
  label_ar TEXT NOT NULL,
  layer_type TEXT NOT NULL,
  description_ar TEXT,
  min_year INTEGER,
  max_year INTEGER,
  cartographic_status TEXT
);
INSERT INTO "atlas_layers" VALUES('LYR-EARLY','البدايات 711–929','period','المواقع والشواهد الأثرية المرتبطة بالبدايات والإمارة الأولى.',711,929,'thematic layer; not a political boundary');
INSERT INTO "atlas_layers" VALUES('LYR-CALIPHATE','الخلافة 929–1031','period','قرطبة ومدينة الزهراء وشواهد السلطة والعمران.',929,1031,'thematic layer; not a political boundary');
INSERT INTO "atlas_layers" VALUES('LYR-URBAN','المدينة والحرفة','theme','المراكز الحضرية والحرف والاقتصاد المادي.',750,1492,'evidence/theme layer');
INSERT INTO "atlas_layers" VALUES('LYR-KNOWLEDGE','انتقال المعرفة','theme','الأشخاص والأعمال ومسارات الترجمة والهجرة العلمية.',900,1500,'network layer');
INSERT INTO "atlas_layers" VALUES('LYR-LEGACY','الامتداد والأثر','theme','مواقع ما بعد تغير السلطة التي تحفظ استمرار تقنيات أو رموز أندلسية.',1200,1600,'legacy layer');
CREATE TABLE atlas_place_metadata (
  entity_id TEXT PRIMARY KEY,
  period_group TEXT NOT NULL,
  theme TEXT NOT NULL,
  historical_status TEXT NOT NULL,
  display_priority INTEGER NOT NULL DEFAULT 50,
  note_ar TEXT,
  FOREIGN KEY(entity_id) REFERENCES entities(entity_id)
);
INSERT INTO "atlas_place_metadata" VALUES('PLC-CORDOBA','cross_period','politics,urban,knowledge','verified_claim_linked',100,'عاصمة أموية ومحور متعدد الطبقات.');
INSERT INTO "atlas_place_metadata" VALUES('PLC-CORDOBA-WH','early_caliphate','urban,heritage','verified_site',100,'عقار UNESCO؛ مرساة تمثيلية.');
INSERT INTO "atlas_place_metadata" VALUES('PLC-MADINAT-ZAHRA','caliphate','politics,urban,heritage','verified_site',100,'مدينة خلافية مؤرخة مؤسسيًا.');
INSERT INTO "atlas_place_metadata" VALUES('PLC-SAQUNDA','early','urban,archaeology','verified_claim_linked',95,'الإحداثية الحالية مرساة قرطبة وليست نقطة الحفر.');
INSERT INTO "atlas_place_metadata" VALUES('PLC-GRANADA','cross_period','politics,knowledge','verified_claim_linked',100,'مدينة متعددة الطبقات ومسار معرفة.');
INSERT INTO "atlas_place_metadata" VALUES('PLC-ALHAMBRA-WH','nasrid_late','urban,heritage','verified_site',100,'عقار UNESCO مركب.');
INSERT INTO "atlas_place_metadata" VALUES('PLC-PECHINA','early','urban,economy,archaeology','verified_claim_linked',95,'خزف وحي حضري.');
INSERT INTO "atlas_place_metadata" VALUES('PLC-ALMARIYYA','taifa_empires','urban,economy,archaeology','verified_claim_linked',95,'ميناء وصناعة واتصال تجاري.');
INSERT INTO "atlas_place_metadata" VALUES('PLC-XERESA','caliphate_to_empires','society,archaeology','verified_claim_linked',90,'مجتمع فلاحي ودراسة عظمية.');
INSERT INTO "atlas_place_metadata" VALUES('PLC-BAIREN','caliphate_to_taifa','archaeology,economy','verified_claim_linked',85,'حصن ودليل نباتي؛ المرساة تقريبية.');
INSERT INTO "atlas_place_metadata" VALUES('PLC-EL-MOLON','early','religion,archaeology','verified_claim_linked',85,'فضاء ديني مبكر؛ المرساة تقريبية.');
INSERT INTO "atlas_place_metadata" VALUES('PLC-TOSSAL-VILA','early','religion,archaeology','verified_claim_linked',85,'فضاء ديني مبكر؛ المرساة تقريبية.');
INSERT INTO "atlas_place_metadata" VALUES('PLC-TOLEDO','legacy_transfer','knowledge,translation','verified_claim_linked',90,'محور ترجمة ونقل معرفة.');
INSERT INTO "atlas_place_metadata" VALUES('PLC-DAMASCUS','legacy_transfer','knowledge,migration','verified_claim_linked',80,'محطة شرقية في شبكة انتقال المعرفة.');
INSERT INTO "atlas_place_metadata" VALUES('PLC-LEON','legacy_transfer','court,art','verified_claim_linked',70,'ثقافة بلاط متداخلة.');
INSERT INTO "atlas_place_metadata" VALUES('PLC-MANISES','legacy_transfer','craft,legacy','verified_claim_linked',70,'استمرار حرف وتقنيات بعد تغير السلطة.');
INSERT INTO "atlas_place_metadata" VALUES('PLC-SEVILLE','taifa_empires','politics,urban,heritage,legacy','verified_claim_linked',95,'مرساة مدينة حديثة مرتبطة بـClaim معماري موثق؛ لا تمثل موضع القصر أو الجيرالدا بدقة أثرية.');
INSERT INTO "atlas_place_metadata" VALUES('PLC-ZARAGOZA','cross_period','reference','gazetteer_candidate',30,'مرساة مكانية مرشحة؛ الدور التاريخي ينتظر Claim موثقًا.');
INSERT INTO "atlas_place_metadata" VALUES('PLC-VALENCIA','cross_period','reference','gazetteer_candidate',30,'مرساة مكانية مرشحة؛ الدور التاريخي ينتظر Claim موثقًا.');
INSERT INTO "atlas_place_metadata" VALUES('PLC-MALAGA','cross_period','reference','gazetteer_candidate',30,'مرساة مكانية مرشحة؛ الدور التاريخي ينتظر Claim موثقًا.');
INSERT INTO "atlas_place_metadata" VALUES('PLC-MURCIA','cross_period','reference','gazetteer_candidate',30,'مرساة مكانية مرشحة؛ الدور التاريخي ينتظر Claim موثقًا.');
INSERT INTO "atlas_place_metadata" VALUES('PLC-PALMA','cross_period','reference','gazetteer_candidate',30,'مرساة مكانية مرشحة؛ الدور التاريخي ينتظر Claim موثقًا.');
INSERT INTO "atlas_place_metadata" VALUES('PLC-ALICANTE','cross_period','reference','gazetteer_candidate',30,'مرساة مكانية مرشحة؛ الدور التاريخي ينتظر Claim موثقًا.');
INSERT INTO "atlas_place_metadata" VALUES('PLC-BADAJOZ','cross_period','reference','gazetteer_candidate',30,'مرساة مكانية مرشحة؛ الدور التاريخي ينتظر Claim موثقًا.');
INSERT INTO "atlas_place_metadata" VALUES('PLC-RONDA','cross_period','reference','gazetteer_candidate',30,'مرساة مكانية مرشحة؛ الدور التاريخي ينتظر Claim موثقًا.');
INSERT INTO "atlas_place_metadata" VALUES('PLC-JAEN','cross_period','reference','gazetteer_candidate',30,'مرساة مكانية مرشحة؛ الدور التاريخي ينتظر Claim موثقًا.');
INSERT INTO "atlas_place_metadata" VALUES('PLC-HUELVA','cross_period','reference','gazetteer_candidate',30,'مرساة مكانية مرشحة؛ الدور التاريخي ينتظر Claim موثقًا.');
INSERT INTO "atlas_place_metadata" VALUES('PLC-ECIJA','cross_period','reference','gazetteer_candidate',30,'مرساة مكانية مرشحة؛ الدور التاريخي ينتظر Claim موثقًا.');
INSERT INTO "atlas_place_metadata" VALUES('PLC-MEDINA-SIDONIA','cross_period','reference','gazetteer_candidate',30,'مرساة مكانية مرشحة؛ الدور التاريخي ينتظر Claim موثقًا.');
INSERT INTO "atlas_place_metadata" VALUES('PLC-TORTOSA','cross_period','reference','gazetteer_candidate',30,'مرساة مكانية مرشحة؛ الدور التاريخي ينتظر Claim موثقًا.');
INSERT INTO "atlas_place_metadata" VALUES('PLC-ALGECIRAS','cross_period','reference','gazetteer_candidate',30,'مرساة مكانية مرشحة؛ الدور التاريخي ينتظر Claim موثقًا.');
INSERT INTO "atlas_place_metadata" VALUES('PLC-MERIDA','cross_period','reference','gazetteer_candidate',30,'مرساة مكانية مرشحة؛ الدور التاريخي ينتظر Claim موثقًا.');
INSERT INTO "atlas_place_metadata" VALUES('PLC-008','cross_period','politics,urban','candidate_anchor',60,'أضيف من فرع الأدلة v6.1');
INSERT INTO "atlas_place_metadata" VALUES('PLC-013','cross_period','politics,urban','verified_site',90,'أضيف من فرع الأدلة v6.1');
INSERT INTO "atlas_place_metadata" VALUES('PLC-014','cross_period','politics,urban','candidate_anchor',60,'أضيف من فرع الأدلة v6.1');
INSERT INTO "atlas_place_metadata" VALUES('PLC-015','cross_period','politics,urban','candidate_anchor',60,'أضيف من فرع الأدلة v6.1');
INSERT INTO "atlas_place_metadata" VALUES('PLC-016','cross_period','politics,urban','candidate_anchor',60,'أضيف من فرع الأدلة v6.1');
INSERT INTO "atlas_place_metadata" VALUES('PLC-017','cross_period','politics,urban','candidate_anchor',60,'أضيف من فرع الأدلة v6.1');
INSERT INTO "atlas_place_metadata" VALUES('PLC-019','cross_period','politics,urban','candidate_anchor',60,'أضيف من فرع الأدلة v6.1');
INSERT INTO "atlas_place_metadata" VALUES('PLC-C01','nasrid','politics,urban','candidate_anchor',60,'أضيف من فرع الأدلة v6.1');
INSERT INTO "atlas_place_metadata" VALUES('PLC-C06','cross_period','politics,urban','candidate_anchor',60,'أضيف من فرع الأدلة v6.1');
INSERT INTO "atlas_place_metadata" VALUES('PLC-G01','nasrid','politics,urban','verified_site',90,'أضيف من فرع الأدلة v6.1');
INSERT INTO "atlas_place_metadata" VALUES('PLC-G02','nasrid','politics,urban','verified_site',90,'أضيف من فرع الأدلة v6.1');
INSERT INTO "atlas_place_metadata" VALUES('PLC-G03','nasrid','politics,urban','candidate_anchor',60,'أضيف من فرع الأدلة v6.1');
INSERT INTO "atlas_place_metadata" VALUES('PLC-G04','nasrid','politics,urban','candidate_anchor',60,'أضيف من فرع الأدلة v6.1');
INSERT INTO "atlas_place_metadata" VALUES('PLC-G05','nasrid','politics,urban','candidate_anchor',60,'أضيف من فرع الأدلة v6.1');
CREATE TABLE atlas_stories (
  story_id TEXT PRIMARY KEY,
  title_ar TEXT NOT NULL,
  summary_ar TEXT,
  period_label TEXT,
  warning_ar TEXT
);
INSERT INTO "atlas_stories" VALUES('STORY-CORDOBA','من الإمارة إلى الخلافة','ثلاث محطات لقراءة تحوّل قرطبة: الربض، المدينة، ثم المدينة الخلافية الجديدة.','750–1031','الخطوط بين المحطات تنظيم سردي لا طريق سفر.');
INSERT INTO "atlas_stories" VALUES('STORY-EAST','الشرق الأندلسي المبكر','شواهد مادية من الفضاءات الدينية إلى الحصون والمجتمع الريفي.','8–13م','المواقع مستقلة ولا تمثل إقليمًا سياسيًا واحدًا.');
INSERT INTO "atlas_stories" VALUES('STORY-SE-CITIES','المدينة والحرفة في الجنوب الشرقي','من بَجّانة إلى ألمرية ثم غرناطة: إنتاج، ميناء، وعمران.','9–15م','الترتيب تعليمي موضوعي وليس مسارًا زمنيًا متصلًا دائمًا.');
INSERT INTO "atlas_stories" VALUES('STORY-KNOWLEDGE','شبكات المعرفة خارج الحدود','غرناطة وطليطلة ودمشق بوصفها عقدًا مختلفة لانتقال الأشخاص والأعمال والترجمة.','11–13م','ليس طريقًا واحدًا لشخص واحد إلا حيث يثبت Claim ذلك.');
CREATE TABLE atlas_story_steps (
  story_id TEXT NOT NULL,
  ordinal INTEGER NOT NULL,
  place_entity_id TEXT,
  claim_id TEXT,
  title_ar TEXT,
  narrative_ar TEXT,
  PRIMARY KEY(story_id,ordinal),
  FOREIGN KEY(story_id) REFERENCES atlas_stories(story_id),
  FOREIGN KEY(place_entity_id) REFERENCES entities(entity_id),
  FOREIGN KEY(claim_id) REFERENCES claims(claim_id)
);
INSERT INTO "atlas_story_steps" VALUES('STORY-CORDOBA',1,'PLC-SAQUNDA','RUR-CLM04','شقندة قبل 818م','الحفر الواسع يقدم سجلًا مباشرًا للحياة اليومية والتخطيط الحضري في قرطبة الأموية المبكرة.');
INSERT INTO "atlas_story_steps" VALUES('STORY-CORDOBA',2,'PLC-CORDOBA-WH','ATLAS-CLM02','قرطبة: المدينة والجامع','العقار التاريخي يربط النسيج الحضري بالجامع الكبير وتراكمات المدينة الإسلامية.');
INSERT INTO "atlas_story_steps" VALUES('STORY-CORDOBA',3,'PLC-MADINAT-ZAHRA','ATLAS-CLM01','مدينة الزهراء','مدينة جديدة للخلافة في القرن العاشر، مع بنية حضرية ومادية واسعة.');
INSERT INTO "atlas_story_steps" VALUES('STORY-EAST',1,'PLC-TOSSAL-VILA','ARC-CLM01','توسال دي لا فيلا','من أقدم الشواهد الأثرية للعمارة الدينية الإسلامية في شبه الجزيرة.');
INSERT INTO "atlas_story_steps" VALUES('STORY-EAST',2,'PLC-EL-MOLON','ARC-CLM01','المولون','موقع ثانٍ يتيح مقارنة التكوين المبكر للفضاءات الدينية.');
INSERT INTO "atlas_story_steps" VALUES('STORY-EAST',3,'PLC-BAIREN','ARC-CLM03','بايرين','حصن ودليل نباتي مؤرخ؛ أولوية الدخن ما تزال حساسة للتحديث.');
INSERT INTO "atlas_story_steps" VALUES('STORY-EAST',4,'PLC-XERESA','RUR-CLM02','خيريسة/شيريسا','التحليل العظمي يفتح نافذة على العمل والرعاية في مجتمع فلاحي.');
INSERT INTO "atlas_story_steps" VALUES('STORY-SE-CITIES',1,'PLC-PECHINA','ARC-CLM04','بَجّانة','فرن خزف مزجج ثم حي بمساكن وشوارع ومحلات وورش.');
INSERT INTO "atlas_story_steps" VALUES('STORY-SE-CITIES',2,'PLC-ALMARIYYA','RUR-CLM03','ألمرية','مرفأ ونسيج وحركة سلع ضمن اقتصاد متصل.');
INSERT INTO "atlas_story_steps" VALUES('STORY-SE-CITIES',3,'PLC-ALHAMBRA-WH','ATLAS-CLM03','غرناطة النصرية','الحمراء والبيازين وجنة العريف كوحدة تراثية مركبة مع وظائف مختلفة.');
INSERT INTO "atlas_story_steps" VALUES('STORY-KNOWLEDGE',1,'PLC-GRANADA','ARC-CLM09','غرناطة','عقدة أندلسية في مسار انتقال أفراد وأعمال إلى المشرق.');
INSERT INTO "atlas_story_steps" VALUES('STORY-KNOWLEDGE',2,'PLC-TOLEDO','SOC-CLM08','طليطلة','بيئة ترجمة عبر خلفيات دينية ولغوية متعددة.');
INSERT INTO "atlas_story_steps" VALUES('STORY-KNOWLEDGE',3,'PLC-DAMASCUS','ARC-CLM09','دمشق','محطة شرقية في شبكة انتقال المعرفة؛ لا تُستكمل المحطات الوسيطة دون مصدر مباشر.');
CREATE TABLE atlas_zones (
  zone_id TEXT PRIMARY KEY,
  label_ar TEXT NOT NULL,
  min_year INTEGER,
  max_year INTEGER,
  theme TEXT,
  cartographic_status TEXT NOT NULL,
  geometry_geojson TEXT NOT NULL,
  note_ar TEXT
);
INSERT INTO "atlas_zones" VALUES('ZONE-CORDOBA-CORE','عنقود قرطبة الأموي',750,1031,'politics,urban','analytical envelope — NOT a historical boundary','{"type": "Polygon", "coordinates": [[[-4.95, 37.8], [-4.65, 37.8], [-4.65, 38.0], [-4.95, 38.0], [-4.95, 37.8]]]}','مظروف تحليلي يربط قرطبة وشقندة ومدينة الزهراء؛ لا يمثل حدود الكورة أو الخلافة.');
INSERT INTO "atlas_zones" VALUES('ZONE-EAST-EARLY','عنقود الشرق الأندلسي المبكر',711,1031,'archaeology,religion','analytical envelope — NOT a historical boundary','{"type": "Polygon", "coordinates": [[[-1.55, 38.65], [0.15, 38.65], [0.15, 40.45], [-1.55, 40.45], [-1.55, 38.65]]]}','مظروف بصري لمواقع المساجد المبكرة وبايرين وشيريسا؛ ليس إقليمًا إداريًا.');
INSERT INTO "atlas_zones" VALUES('ZONE-SE-URBAN','عنقود الجنوب الشرقي الحضري',800,1300,'urban,economy','analytical envelope — NOT a historical boundary','{"type": "Polygon", "coordinates": [[[-4.7, 36.45], [-1.0, 36.45], [-1.0, 38.2], [-4.7, 38.2], [-4.7, 36.45]]]}','تجميع تحليلي لبجّانة وألمرية وغرناطة ومرسية ومالقة؛ لا يمثل دولة أو حدودًا تاريخية.');
INSERT INTO "atlas_zones" VALUES('ZONE-GRANADA-NASRID','عنقود غرناطة النصرية',1238,1492,'palace,urban,heritage','analytical envelope — NOT a historical boundary','{"type": "Polygon", "coordinates": [[[-3.75, 37.05], [-3.45, 37.05], [-3.45, 37.3], [-3.75, 37.3], [-3.75, 37.05]]]}','مظروف عرض حول غرناطة والحمراء؛ ليس حدود مملكة بني نصر.');
CREATE TABLE attestations(attestation_id TEXT PRIMARY KEY, assertion_id TEXT NOT NULL, source_id TEXT NOT NULL, source_kind TEXT, locator TEXT NOT NULL,
  quote TEXT NOT NULL, stance TEXT NOT NULL, verbatim_check TEXT, note_ar TEXT, url TEXT, checked_on TEXT NOT NULL,
  FOREIGN KEY(assertion_id) REFERENCES assertions(assertion_id), FOREIGN KEY(source_id) REFERENCES sources(source_id));
INSERT INTO "attestations" VALUES('ATT-001','AST-001','LIB-BK-005','دراسة حديثة','ج1 ص154 (بحسب ترقيم الشاملة للمطبوع)، الفصل الثاني: بعث الدولة الأموية في الأندلس','وبويع في الحال بالإمارة، وذلك في العاشر من ذى الحجة سنة ١٣٨هـ (١٣ مايو سنة ٧٥٦ م)','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)',NULL,'https://shamela.ws/book/1009/152','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-002','AST-001','EXT-MET-TOAH','مرجع مؤسسي','فقرة عبد الرحمن الأول','''Abd al-Rahman I (r. 756–88) made Córdoba his capital','يدعم','مطابق حرفيًا (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)','معرّف LIB-ENC للـMet غير محدد في المهمة؛ تُرك فارغًا','https://www.metmuseum.org/essays/the-art-of-the-umayyad-period-in-spain-711-1031','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-003','AST-002','LIB-BK-005','دراسة حديثة','ج1 ص429 (بحسب ترقيم الشاملة للمطبوع)، الفصل الأول: ولاية عبد الرحمن الناصر','ونفذ الأمر بذلك في يوم الجمعة مستهل ذي الحجة سنة ٣١٦ هـ','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','١ ذو الحجة ٣١٦هـ ≈ ١٦ يناير ٩٢٩م (تحويل تقريبي، لا يرد في النص)','https://shamela.ws/book/1009/421','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-004','AST-002','EXT-MET-TOAH','مرجع مؤسسي','فقرة عبد الرحمن الثالث','who became the first Spanish Umayyad amir to declare himself caliph (929)','يدعم','مطابق حرفيًا (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)',NULL,'https://www.metmuseum.org/essays/the-art-of-the-umayyad-period-in-spain-711-1031','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-005','AST-003','SRC-B819B01BE2','مرجع مؤسسي','Brief Synthesis','In 929, Abderraman III established it as the headquarters of the independent Caliphate.','يدعم','مطابق حرفيًا (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)',NULL,'https://whc.unesco.org/en/list/313','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-006','AST-003','LIB-ART-029','دراسة حديثة','p. 74','In the year 316/929 the eighth emir of al-Andalus, ''Abd al-Raḥmān III, was proclaimed caliph in Cordoba.','يدعم','مطابق حرفيًا (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)',NULL,'https://shedet.journals.ekb.eg/article_87829_4b1aefcbf0be7e09c877183df0d16b06.pdf','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-007','AST-004','SRC-B819B01BE2','مرجع مؤسسي','Statement of Outstanding Universal Value','The Historic Centre of Córdoba is the highly relevant testimony to the Caliphate of Cordoba (929-1031)','يدعم جزئيًا','مطابق حرفيًا (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)','يعطي 1031 نهايةً دون ذكر 1009','https://whc.unesco.org/en/list/313','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-008','AST-004','LIB-BK-005','دراسة حديثة','ج1 ص642 (بحسب ترقيم الشاملة للمطبوع)، الكتاب الرابع، الفصل الأول: الخلافة فى معترك الفتنة والفوضى','تربع محمد بن هشام الملقب بالمهدي على كرسي الخلافة، مكان الخليفة هشام المؤيد، في ١٧ جمادى الآخرة سنة ٣٩٩ هـ (١٦ فبراير سنة ١٠٠٩ م)','يدعم جزئيًا','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','يدعم الحد الأول 1009','https://shamela.ws/book/1009/631','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-009','AST-005','LIB-BK-005','دراسة حديثة','ج1 ص642 (بحسب ترقيم الشاملة للمطبوع)، الكتاب الرابع، الفصل الأول','تربع محمد بن هشام الملقب بالمهدي على كرسي الخلافة، مكان الخليفة هشام المؤيد، في ١٧ جمادى الآخرة سنة ٣٩٩ هـ (١٦ فبراير سنة ١٠٠٩ م)','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)',NULL,'https://shamela.ws/book/1009/631','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-010','AST-005','SRC-FF27E1A80B','مرجع مؤسسي','Description','laid to waste during the civil war that put an end to the Caliphate in 1009-1010','يدعم جزئيًا','مطابق حرفيًا (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)','يؤرخ الحرب الأهلية بـ1009–1010','https://whc.unesco.org/en/list/1560','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-011','AST-006','LIB-BK-005','دراسة حديثة','ج1 ص669 (بحسب ترقيم الشاملة للمطبوع)، الكتاب الرابع، الفصل الثاني: دولة بنى حمود','(ذو القعدة سنة ٤٢٢ هـ - نوفمبر سنة ١٠٣١ م)','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','في السياق نفسه: «والتخلص جملة من بني أمية، وإبطال رسم الخلافة»','https://shamela.ws/book/1009/658','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-012','AST-006','SRC-B819B01BE2','مرجع مؤسسي','Statement of Outstanding Universal Value','the Caliphate of Cordoba (929-1031)','يدعم','مطابق حرفيًا (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)',NULL,'https://whc.unesco.org/en/list/313','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-013','AST-006','EXT-MET-TOAH','مرجع مؤسسي','عنوان المقال','The Art of the Umayyad Period in Spain (711–1031)','يدعم جزئيًا','مطابق حرفيًا (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)','العنوان يحدّ الحقبة الأموية بـ1031','https://www.metmuseum.org/essays/the-art-of-the-umayyad-period-in-spain-711-1031','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-014','AST-007','EXT-MET-TOAH','مرجع مؤسسي','فقرة عبد الرحمن الأول','''Abd al-Rahman I (r. 756–88)','يدعم','مطابق حرفيًا (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)',NULL,'https://www.metmuseum.org/essays/the-art-of-the-umayyad-period-in-spain-711-1031','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-015','AST-007','LIB-BK-005','دراسة حديثة','ج1 ص192 (بحسب ترقيم الشاملة للمطبوع)، الفصل السادس: خلال عبد الرحمن ومآثره','توفي عبد الرحمن الأموي في الرابع والعشرين من ربيع الآخر سنة ١٧٢ هـ (٢ أكتوبر سنة ٧٨٧ م)','يخالف','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','عنان يحوّل ١٧٢هـ إلى ٧٨٧م؛ ٢٤ ربيع الآخر ١٧٢هـ يقع فعليًا نحو ٣٠ سبتمبر/١ أكتوبر ٧٨٨م، فالأرجح خطأ تحويل/طباعة، لكنه تعارض مدوَّن','https://shamela.ws/book/1009/190','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-016','AST-008','LIB-BK-005','دراسة حديثة','ج1 ص373 (بحسب ترقيم الشاملة للمطبوع)، الفصل الأول: ولاية عبد الرحمن الناصر','في مستهل ربيع الأول سنة ٣٠٠ هـ (١٥ أكتوبر سنة ٩١٢ م)','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','تاريخ وفاة الأمير عبد الله وتولي حفيده عبد الرحمن في اليوم نفسه','https://shamela.ws/book/1009/365','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-017','AST-008','EXT-MWNF','مرجع مؤسسي','Description','Abd al-Rahman III (r. AH 299–350 / AD 912–61)','يدعم جزئيًا','مطابق حرفيًا (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)','يدعم 912 بدايةً؛ لاحظ أن الموقع يكتب 299هـ بدل 300هـ','https://islamicart.museumwnf.org/database_item.php?id=monument%3Bisl%3Bes%3Bmon01%3B2%3Ben','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-018','AST-009','EXT-MWNF','مرجع مؤسسي','Description','Abd al-Rahman III (r. AH 299–350 / AD 912–61)','يدعم جزئيًا','مطابق حرفيًا (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)','يدعم نهاية 961','https://islamicart.museumwnf.org/database_item.php?id=monument%3Bisl%3Bes%3Bmon01%3B2%3Ben','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-019','AST-009','LIB-BK-005','دراسة حديثة','ج1 ص483 (بحسب ترقيم الشاملة للمطبوع)، الكتاب الثاني ق4، الفصل الأول: الحكم المستنصر بالله','وبويع الحكم في اليوم التالي لوفاة أبيه، في الثالث من رمضان سنة ٣٥٠ هـ (١٦ أكتوبر ٩٦١ م)','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','يستلزم وفاة الناصر ٢ رمضان ٣٥٠هـ/١٥ أكتوبر ٩٦١م','https://shamela.ws/book/1009/474','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-020','AST-009','SRC-B819B01BE2','مرجع مؤسسي','Brief Synthesis','In 929, Abderraman III established it as the headquarters of the independent Caliphate.','يدعم جزئيًا','مطابق حرفيًا (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)','يدعم البداية 929 فقط','https://whc.unesco.org/en/list/313','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-021','AST-010','EXT-MWNF','مرجع مؤسسي','Description','al-Hakam II (r. AH 350–66 / AD 961–76)','يدعم','مطابق حرفيًا (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)',NULL,'https://islamicart.museumwnf.org/database_item.php?id=monument%3Bisl%3Bes%3Bmon01%3B2%3Ben','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-022','AST-010','LIB-BK-005','دراسة حديثة','ج1 ص517 (بحسب ترقيم الشاملة للمطبوع)، الفصل الثاني: هشام المؤيد بالله','لما توفي الحكم المستنصر بالله، في اليوم الثاني من صفر سنة ٣٦٦ هـ','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','٢ صفر ٣٦٦هـ ≈ ١ أكتوبر ٩٧٦م (تحويل تقريبي)','https://shamela.ws/book/1009/508','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-023','AST-010','EXT-MET-TOAH','مرجع مؤسسي','فقرة الحكم الثاني','al-Hakam II (r. 961–76)','يدعم','مطابق حرفيًا (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)',NULL,'https://www.metmuseum.org/essays/the-art-of-the-umayyad-period-in-spain-711-1031','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-024','AST-011','LIB-BK-005','دراسة حديثة','ج1 ص154 (بحسب ترقيم الشاملة للمطبوع)','وبويع في الحال بالإمارة، وذلك في العاشر من ذى الحجة سنة ١٣٨هـ (١٣ مايو سنة ٧٥٦ م)','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)',NULL,'https://shamela.ws/book/1009/152','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-025','AST-012','LIB-BK-005','دراسة حديثة','ج1 ص429 (بحسب ترقيم الشاملة للمطبوع)، الفصل الأول: ولاية عبد الرحمن الناصر','ونفذ الأمر بذلك في يوم الجمعة مستهل ذي الحجة سنة ٣١٦ هـ','يدعم','مطابق حرفيًا (فحص مباشر)',NULL,'https://shamela.ws/book/1009/421','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-026','AST-012','LIB-ART-029','دراسة حديثة','p. 74','In the year 316/929 the eighth emir of al-Andalus, ''Abd al-Raḥmān III, was proclaimed caliph in Cordoba.','يدعم','مطابق حرفيًا (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)',NULL,'https://shedet.journals.ekb.eg/article_87829_4b1aefcbf0be7e09c877183df0d16b06.pdf','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-027','AST-012','LIB-BK-005','دراسة حديثة','ج1 ص401 (بحسب ترقيم الشاملة للمطبوع)، حاشية (١)','كان عبد الرحمن قد اتخذ سمة الخلافة وتلقب بالناصر لدين الله منذ سنة ٣١٧ هـ','يخالف','مطابق حرفيًا (فحص مباشر)','تعارض داخلي عند عنان: المتن ٣١٦هـ (ص429) والحاشية ٣١٧هـ','https://shamela.ws/book/1009/393','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-028','AST-015','SRC-FF27E1A80B','مرجع مؤسسي','Description','laid to waste during the civil war that put an end to the Caliphate in 1009-1010','يدعم جزئيًا','مطابق حرفيًا (فحص مباشر)','يحصر الخراب في 1009–1010، والمصادر الأولية تجعل الخراب التام في أيام المستكفي (414–416هـ/1024–1025م).','https://whc.unesco.org/en/list/1560','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-029','AST-015','LIB-BK-005','دراسة حديثة','ج1 ص440 (بحسب ترقيم الشاملة للمطبوع)، الفصل الثاني: خلال الناصر ومآثره','ففي ربيع الأول سنة ٤٠١ هـ (نوفمبر سنة ١٠١٠ م) زحفت قوات البربر','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','يتبعها: «واقتحموا في طريقهم مدينة الزهراء» — يحدد 1010 لا 1009','https://shamela.ws/book/1009/432','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-030','AST-015','EXT-MWNF','مرجع مؤسسي','Description','The city lasted 74 years, after which it was systematically destroyed','يدعم جزئيًا','مطابق حرفيًا (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)','936+74≈1010؛ لا سنة صريحة','https://islamicart.museumwnf.org/database_item.php?id=monument%3Bisl%3Bes%3Bmon01%3B2%3Ben','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-031','AST-016','LIB-BK-005','دراسة حديثة','ج1 ص373 (بحسب ترقيم الشاملة للمطبوع)','ولد عبد الرحمن قبيل مقتل أبيه بأسابيع قلائل في ٢٢ رمضان سنة ٢٧٧ هـ (ديسمبر سنة ٨٩٠ م)','يدعم (بعد التصحيح)','مطابق حرفيًا (فحص مباشر)','الميلاد 890/891 لا 889 (٢٢ رمضان ٢٧٧هـ ≈ ٧ يناير ٨٩١م) | خالف القيمة السابقة؛ يدعم القيمة المصححة في v5.2.','https://shamela.ws/book/1009/365','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-032','AST-016','EXT-BRITANNICA','مرجعي عام','رأس المقالة','born January 891 ... died October 15, 961','يدعم (بعد التصحيح)','مطابق حرفيًا (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)','يخالف الميلاد 889، ويدعم الوفاة 961. الاقتباس ملخّص من أداة الجلب وليس نصًا حرفيًا كاملًا | خالف القيمة السابقة؛ يدعم القيمة المصححة في v5.2.','https://www.britannica.com/biography/Abd-al-Rahman-III','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-033','AST-017','EXT-BRITANNICA','مرجعي عام','رأس المقالة','ʿAbd al-Raḥmān ibn Muḥammad ibn ʿAbd Allāh ibn Muḥammad ibn ʿAbd al-Raḥmān ibn al-Ḥakam al-Rabḍī ibn Hishām ibn ʿAbd al-Raḥmān al-Dākhil','يدعم جزئيًا','مطابق حرفيًا (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)','يدعم النسب؛ لا يذكر الكنية أبو المطرف','https://www.britannica.com/biography/Abd-al-Rahman-III','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-034','AST-017','LIB-BK-005','دراسة حديثة','ج1 ص401 (بحسب ترقيم الشاملة للمطبوع)، حاشية (١)','كان عبد الرحمن قد اتخذ سمة الخلافة وتلقب بالناصر لدين الله','يدعم جزئيًا','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23) — الموضع في حاشية عنان نفسه','يدعم اللقب؛ الكنية غير موجودة في الصفحات المفحوصة','https://shamela.ws/book/1009/393','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-035','AST-018','LIB-BK-005','دراسة حديثة','ج1 ص483 (بحسب ترقيم الشاملة للمطبوع)','مولده حسبما تقدم بقرطبة في ٢٤ من جمادى الأولى وقيل في غرة رجب سنة ٣٠٢ هـ (٩١٥ م)','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)',NULL,'https://shamela.ws/book/1009/474','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-036','AST-018','LIB-BK-005','دراسة حديثة','ج1 ص517 (بحسب ترقيم الشاملة للمطبوع)','لما توفي الحكم المستنصر بالله، في اليوم الثاني من صفر سنة ٣٦٦ هـ','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','٣٦٦هـ = ٩٧٦م','https://shamela.ws/book/1009/508','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-037','AST-019','LIB-BK-005','دراسة حديثة','ج1 ص482 (بحسب ترقيم الشاملة للمطبوع)، عنوان الفصل','الفصل الأول الحكم المستنصر بالله','يدعم جزئيًا','مطابق حرفيًا في الصفحة السابقة (ج1 ص482) لا في ص483 — صُحح الموضع (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','يدعم الاسم واللقب؛ الكنية أبو العاص غير واردة في الصفحة','https://shamela.ws/book/1009/473','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-038','AST-020','LIB-BK-005','دراسة حديثة','ج1 ص566 (بحسب ترقيم الشاملة للمطبوع)، الفصل الأول: الحاجب المنصور','وفي ليلة الإثنين ٢٧ رمضان سنة ٣٩٢، الموافق ١١ أغسطس سنة ١٠٠٢','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','يدعم الوفاة 1002','https://shamela.ws/book/1009/556','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-039','AST-020','LIB-BK-005','دراسة حديثة','ج1 ص566 (بحسب ترقيم الشاملة للمطبوع)','إذ كان مولده في سنة ٣٢٨ هـ','يدعم (بعد التصحيح)','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','٣٢٨هـ = 939/940م لا 938 (٣٢٧هـ) | خالف القيمة السابقة؛ يدعم القيمة المصححة في v5.2.','https://shamela.ws/book/1009/556','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-040','AST-021','LIB-BK-005','دراسة حديثة','ج1 ص521 (بحسب ترقيم الشاملة للمطبوع)، الفصل الثاني: هشام المؤيد بالله','محمد بن عبد الله بن محمد بن عبد الله بن أبي عامر المعافري','يدعم جزئيًا','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','يدعم الاسم والنسب والنسبة؛ الكنية (أبو عامر) غير واردة هنا','https://shamela.ws/book/1009/512','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-041','AST-022','EXT-BRITANNICA','مرجعي عام','رأس المقالة','Abū al-Qāsim al-Zahrāwī (born c. 936, near Córdoba [Spain]—died c. 1013)','يدعم','مطابق حرفيًا (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)',NULL,'https://www.britannica.com/biography/Abu-al-Qasim','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-042','AST-023','EXT-BRITANNICA','مرجعي عام','متن المقالة','Abū al-Qāsim Khalaf ibn ʿAbbās al-Zahrāwī','يدعم','مطابق حرفيًا (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)','لم يُعثر على نص أولي (الصلة/الجذوة) قابل للفتح','https://www.britannica.com/biography/Abu-al-Qasim','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-043','AST-024','SRC-B819B01BE2','مرجع مؤسسي','Brief Synthesis','It became the capital of the emirate depending on Damascus in the 8th century.','يدعم','مطابق حرفيًا (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)',NULL,'https://whc.unesco.org/en/list/313','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-044','AST-024','EXT-MET-TOAH','مرجع مؤسسي','فقرة عبد الرحمن الأول','''Abd al-Rahman I made Córdoba his capital and unified al-Andalus','يدعم','مطابق حرفيًا مع حذف «(r. 756–88)» وتتمة «under his rule» (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)',NULL,'https://www.metmuseum.org/essays/the-art-of-the-umayyad-period-in-spain-711-1031','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-045','AST-025','SRC-FF27E1A80B','مرجع مؤسسي','بيانات الموقع (Coordinates)','N37 53 9.2 W4 52 3.7','يدعم','مطابق حرفيًا (فحص مباشر)','= 37.8859, -4.8677 تطابق الإحداثيات المقترحة','https://whc.unesco.org/en/list/1560','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-046','AST-025','LIB-BK-005','دراسة حديثة','ج1 ص437 (بحسب ترقيم الشاملة للمطبوع)','في ساحة تقع شمال غربي قرطبة، على قيد خمسة أميال أو ستة منها','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)',NULL,'https://shamela.ws/book/1009/429','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-047','AST-025','LIB-BK-005','دراسة حديثة','ج1 ص442 (بحسب ترقيم الشاملة للمطبوع)','تقع هذه الأطلال الضخمة غربي قرطبة على بعد نحو سبعة أميال منها','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','تفاوت داخلي في المسافة (5–6 أو 7 أميال)','https://shamela.ws/book/1009/434','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-048','AST-025','EXT-MWNF','مرجع مؤسسي','Address','Ctra. de Palma del Río, km 8, Córdoba, Spain','يدعم جزئيًا','مطابق حرفيًا (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)',NULL,'https://islamicart.museumwnf.org/database_item.php?id=monument%3Bisl%3Bes%3Bmon01%3B2%3Ben','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-049','AST-026','LIB-ART-029','دراسة حديثة','p. 74','In the same year, the new caliph reopened the Cordoba mint, which coined gold coins (dinars)','يدعم جزئيًا','مطابق حرفيًا (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)','يسند سياق ضرب الدراهم 316هـ لا القطعة ذاتها؛ صفحات MAN لم تُستخرج نصوصها','https://shedet.journals.ekb.eg/article_87829_4b1aefcbf0be7e09c877183df0d16b06.pdf','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-050','AST-026','LIB-BK-005','دراسة حديثة','ج1 ص447 (بحسب ترقيم الشاملة للمطبوع)','أمر في سنة ٣١٦ هـ، باتخاذ دار السِّكة داخل مدينة قرطبة لضرب العين من الدنانير والدراهم','يدعم جزئيًا','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','سياق فقط، لا القطعة','https://shamela.ws/book/1009/439','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-051','AST-027','LIB-BK-005','دراسة حديثة','ج1 ص429 (بحسب ترقيم الشاملة للمطبوع)','ونفذ الأمر بذلك في يوم الجمعة مستهل ذي الحجة سنة ٣١٦ هـ','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)',NULL,'https://shamela.ws/book/1009/421','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-052','AST-027','LIB-ART-029','دراسة حديثة','p. 74','In the year 316/929 the eighth emir of al-Andalus, ''Abd al-Raḥmān III, was proclaimed caliph in Cordoba.','يدعم','مطابق حرفيًا (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)',NULL,'https://shedet.journals.ekb.eg/article_87829_4b1aefcbf0be7e09c877183df0d16b06.pdf','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-053','AST-027','LIB-BK-005','دراسة حديثة','ج1 ص401 (بحسب ترقيم الشاملة للمطبوع)، حاشية (١)','كان عبد الرحمن قد اتخذ سمة الخلافة وتلقب بالناصر لدين الله منذ سنة ٣١٧ هـ','يخالف','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23) — الموضع في حاشية عنان نفسه','تعارض داخلي عند عنان','https://shamela.ws/book/1009/393','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-054','AST-027','EXT-MET-TOAH','مرجع مؤسسي','فقرة عبد الرحمن الثالث','who became the first Spanish Umayyad amir to declare himself caliph (929)','يدعم','مطابق حرفيًا (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)',NULL,'https://www.metmuseum.org/essays/the-art-of-the-umayyad-period-in-spain-711-1031','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-055','AST-013','LIB-BK-005','دراسة حديثة','ج1 ص437 (بحسب ترقيم الشاملة للمطبوع)','وكان البدء في بنائها في فاتحة المحرم سنة خمس وعشرين وثلثمائة (نوفمبر سنة ٩٣٦ م)','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','فتحه المحقق الرئيس مباشرة.','https://shamela.ws/book/1009/429','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-056','AST-013','SRC-FF27E1A80B','مرجع مؤسسي','Description','built in the mid-10th century CE by the Umayyad dynasty as the seat of the Caliphate of Cordoba','يدعم جزئيًا','مطابق حرفيًا (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)','يدعم منتصف القرن العاشر لا السنة بعينها.','https://whc.unesco.org/en/list/1560','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-057','AST-014','LIB-BK-005','دراسة حديثة','ج1 ص642 (بحسب ترقيم الشاملة للمطبوع)، الكتاب الرابع، الفصل الأول','تربع محمد بن هشام الملقب بالمهدي على كرسي الخلافة، مكان الخليفة هشام المؤيد، في ١٧ جمادى الآخرة سنة ٣٩٩ هـ (١٦ فبراير سنة ١٠٠٩ م)','يدعم جزئيًا','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','الشاهد نفسه في ATT-009 يثبت أحد طرفي النطاق.','https://shamela.ws/book/1009/631','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-058','AST-014','LIB-BK-005','دراسة حديثة','ج1 ص669 (بحسب ترقيم الشاملة للمطبوع)، الكتاب الرابع، الفصل الثاني: دولة بنى حمود','(ذو القعدة سنة ٤٢٢ هـ - نوفمبر سنة ١٠٣١ م)','يدعم جزئيًا','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','الشاهد نفسه في ATT-011 يثبت أحد طرفي النطاق.','https://shamela.ws/book/1009/658','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GA01','AST-G01','LIB-BK-005','دراسة حديثة','ج 5 ص 38 (بحسب ترقيم الشاملة للمطبوع)','وولد محمد بن يوسف في أرجونة سنة ٥٩٥ هـ (١١٩٨ م)','يدعم جزئيًا','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','يُثبت أصله من أرجونة فقط؛ انظر السجلات التالية لتواريخ القيام والدخول.','https://shamela.ws/book/1009/2512','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GA02','AST-G01','LIB-BK-005','دراسة حديثة','ج 5 ص 39 (بحسب ترقيم الشاملة للمطبوع)','ونادت قرمونة وقرطبة وإشبيلية بطاعته لمدى قصير وذلك في أواسط سنة ٦٢٩ هـ','يدعم جزئيًا','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','629هـ ≈ 1231–1232م؛ يدعم بداية الحركة 1232 دون نصّ صريح على «إعلان أرجونة». نص الاقتباس بحسب مستخلص الصفحة.','https://shamela.ws/book/1009/2513','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GA03','AST-G01','LIB-BK-005','دراسة حديثة','ج 5 ص 40 (بحسب ترقيم الشاملة للمطبوع)','سنة ٦٣٥ هـ (أبريل سنة ١٢٣٨ م)، وهو يرتدى ثياباً خشنة وحلة مرقعة، ونزل بجامع القصبة','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','دخول غرناطة 1238؛ وفي الحاشية: «ولكن معظم الروايات على أن دخوله كان في ٦٣٥ هـ» (رواية بـ636).','https://shamela.ws/book/1009/2514','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GA04','AST-G01','EXT-PATRONATO','مرجع مؤسسي','صفحة «Historia»','Al-Ahmar, fundador de la Dinastía nazarí, se instala en 1238 en la Antigua Alcazaba del Albaicín','يدعم جزئيًا','مطابق حرفيًا (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)','يدعم 1238 فقط.','https://www.alhambra-patronato.es/descubrir/historia','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GA05','AST-G01','LIB-BK-005','دراسة حديثة','ج 5، عنوان القسم (فهرس الشاملة)','تاريخ مملكة غرناطة ٦٣٥ - ٨٩٧ هـ: ١٢٣٨ - ١٤٩٢ م','يدعم جزئيًا','مطابق حرفيًا عدا التشكيل (غَرناطة) (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','عنان يؤرخ المملكة من 1238 (دخول غرناطة) لا من 1232.','https://shamela.ws/book/1009/2488','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GA06','AST-G02','LIB-BK-005','دراسة حديثة','ج 5 ص 264 (بحسب ترقيم الشاملة للمطبوع)','وفى صباح اليوم الثانى من يناير سنة ١٤٩٢ م، فى الوقت','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','الجملة تتمة في الصفحة التالية؛ سياقها تسليم الحمراء. وفي ص 262: استلام الحمراء «يوم ٢ يناير» ثم دخول الملكين في 8 يناير.','https://shamela.ws/book/1009/2737','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GA07','AST-G02','EXT-BRITANNICA','مرجعي عام','المقالة','After a siege that began in 1491, he too surrendered, on January 2, 1492','يدعم','مطابق حرفيًا (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)',NULL,'https://www.britannica.com/biography/Muhammad-XI','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GA08','AST-G03','LIB-BK-005','دراسة حديثة','ج 5 ص 53 (بحسب ترقيم الشاملة للمطبوع)','وتوفى محمد بن الأحمر فى التاسع والعشرين من جمادى الثانية سنة ٦٧١ هـ (ديسمبر ١٢٧٢ م) على أثر سقطة من جواده','يدعم جزئيًا','مطابق حرفيًا؛ النسخة الرقمية فيها «سة» تصحيف «سنة» (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','النص المطبوع في الشاملة فيه «سة» (خطأ طباعي لسنة). عنان يقابله بديسمبر 1272، بينما 29 جمادى الآخرة 671 ≈ يناير 1273؛ على القائد التحويل.','https://shamela.ws/book/1009/2527','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GA09','AST-G03','EXT-BRITANNICA','مرجعي عام','المقالة','The first Naṣrid ruler, Muḥammad I al-Ghālib (d. 1273)','يدعم جزئيًا','مطابق حرفيًا (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)','يدعم نهاية الولاية 1273 فقط.','https://www.britannica.com/topic/Nasrid-dynasty','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GA10','AST-G04','LIB-BK-005','دراسة حديثة','ج 5 ص 112 (بحسب ترقيم الشاملة للمطبوع)','ولم يمض على عقدها بضعة أشهر حتى توفى السلطان فى شعبان سنة ٧٠١ هـ (مايو سنة ١٣٠٢ م) بعد أن حكم أكثر من ثلاثين عاماً','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','بداية الولاية 1273 تلزم من وفاة أبيه (ص 94: «خلفه فى الملك ولده وولى عهده أبو عبد الله محمد»).','https://shamela.ws/book/1009/2586','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GA11','AST-G05','LIB-BK-005','دراسة حديثة','ج 5 ص 124 (بحسب ترقيم الشاملة للمطبوع)','اغتاله فى الطريق جماعة من المتآمرين بتحريض بنى أبى العلاء، (ذى الحجة سنة ٧٣٣ هـ)','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','مقتل محمد الرابع؛ وفي ص 125: «وولى العرش من بعده أخوه أبو الحجاج يوسف بن أبى الوليد إسماعيل، وهو فتى فى السادسة عشرة.» ذو الحجة 733 ≈ أغسطس 1333.','https://shamela.ws/book/1009/2598','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GA12','AST-G05','LIB-BK-005','دراسة حديثة','ج 5 ص 134 (بحسب ترقيم الشاملة للمطبوع)','ولكنه ما لبث أن قتل غيلة أثناء صلاته بالمسجد الأعظم فى يوم عيد الفطر سنة ٧٥٥ هـ (أكتوبر سنة ١٣٥٤ م)','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)',NULL,'https://shamela.ws/book/1009/2608','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GA13','AST-G05','EXT-PATRONATO','مرجع مؤسسي','صفحة «Historia»','coincidiendo con los sultanatos de Yusuf I (1333-1354) y el segundo reinado de Muhammad V (1362-1391).','يدعم','مطابق حرفيًا (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)',NULL,'https://www.alhambra-patronato.es/descubrir/historia','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GA14','AST-G06','LIB-BK-005','دراسة حديثة','ج 5 ص 139 (بحسب ترقيم الشاملة للمطبوع)','لم تمض ساعات قلائل على مصرع السلطان يوسف أبى الحجاج فى صبيحة يوم عيد الفطر سنة ٧٥٥ هـ، حتى خلفه فى الملك ولده محمد الملقب بالغنى بالله','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','بداية الولاية الأولى 1354.','https://shamela.ws/book/1009/2613','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GA15','AST-G06','LIB-BK-005','دراسة حديثة','ج 5 ص 140 (بحسب ترقيم الشاملة للمطبوع)','في رمضان سنة ٧٦٠ هـ (١٣٥٩ م) نشبت فى غرناطة ثورة فقد فيها الغنى بالله ملكه','يدعم','مطابق حرفيًا عدا رسم الهمزة/الياء («ففى» في الأصل) (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','نهاية الولاية الأولى 1359.','https://shamela.ws/book/1009/2614','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GA16','AST-G07','LIB-BK-005','دراسة حديثة','ج 5 ص 141–142 (بحسب ترقيم الشاملة للمطبوع)','واسترد محمد ملكه (جمادى الآخرة سنة ٧٦٣ هـ - ١٣٦١ م)','يخالف','مطابق حرفيًا (فحص مباشر؛ النص يمتد ص141–142)','عنان يقابل العودة بـ1361م بدل 1362؛ لكن جمادى الآخرة 763 ≈ أبريل 1362، فالخلاف ظاهري في التحويل على الأرجح. الاقتباس مركّب من نهاية ص141 وبداية ص142 كما عرضها المستخلص.','https://shamela.ws/book/1009/2616','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GA17','AST-G07','LIB-BK-005','دراسة حديثة','ج 5 ص 148 (بحسب ترقيم الشاملة للمطبوع)','واستطال حكم الغنى بالله حتى سنة ٧٩٣ هـ (١٣٩١ م) وساد الأمن والسلام فى عصره','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','نهاية الولاية الثانية 1391.','https://shamela.ws/book/1009/2622','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GA18','AST-G07','EXT-PATRONATO','مرجع مؤسسي','صفحة «Historia»','coincidiendo con los sultanatos de Yusuf I (1333-1354) y el segundo reinado de Muhammad V (1362-1391).','يدعم','مطابق حرفيًا (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)',NULL,'https://www.alhambra-patronato.es/descubrir/historia','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GA19','AST-G08','LIB-BK-005','دراسة حديثة','ج 5 ص 167 (بحسب ترقيم الشاملة للمطبوع)','وفى العام التالى أعنى سنة ٨٦٨ هـ، لما اشتد ضغط النصارى على الأندلس، عاد أبو الحسن فعقد الصلح مع أبيه... وعندئذ خلص العرش لأبى الحسن.','يدعم جزئيًا','مطابق حرفيًا لجزأيه، والنص مركّب بحذف (...) (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','868هـ = 1463–1464م؛ عنوان الكتاب الثاني «٨٦٨ - ٨٩٧: ١٤٦٣ - ١٤٩٢ م».','https://shamela.ws/book/1009/2641','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GA20','AST-G08','LIB-BK-005','دراسة حديثة','ج 5 ص 202 (بحسب ترقيم الشاملة للمطبوع)','وجلس أبو عبد الله محمد مكان أبيه على عرش غرناطة','يدعم','مطابق حرفيًا بعد حذف رقم الحاشية (٥) (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','خلع أبي الحسن 887هـ/1482 («ففر الملك الشيخ إلى مالقة»؛ الصفحة تذكر جمادى الأولى ٨٨٧ - يوليه ١٤٨٢).','https://shamela.ws/book/1009/2675','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GA21','AST-G08','EXT-BRITANNICA','مرجعي عام','المقالة','Abū al-Ḥasan ʿAlī (1466–85)','يخالف','مطابق حرفيًا (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)','بريتانيكا تبدأ ولايته 1466 وتنهيها 1485 (تجمع الولايتين).','https://www.britannica.com/topic/Nasrid-dynasty','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GA22','AST-G09','LIB-BK-005','دراسة حديثة','ج 5 ص 204 (بحسب ترقيم الشاملة للمطبوع)','واجتمع الكبراء والقادة وقرروا استدعاء أبى الحسن السلطان المخلوع ليجلس على العرش مكان ولده الأسير.','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','بعد أسر أبي عبد الله عند اللسانة (ربيع الأول 888/أبريل 1483، ص 203).','https://shamela.ws/book/1009/2677','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GA23','AST-G09','LIB-BK-005','دراسة حديثة','ج 5 ص 204 (بحسب ترقيم الشاملة للمطبوع)','فنزل عن العرش لأخيه محمد أبى عبد الله "الزغل" حاكم مالقة، وارتد إلى المنكَّب فأقام بها حيناً حتى توفى (٨٩٠ هـ - ١٤٨٥ م).','يدعم جزئيًا','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','التاريخ بين القوسين متعلق بالوفاة؛ النزول قبلها في 1485 ضمنًا.','https://shamela.ws/book/1009/2677','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GA24','AST-G10','LIB-BK-005','دراسة حديثة','ج 5 ص 204 (بحسب ترقيم الشاملة للمطبوع)','فنزل عن العرش لأخيه محمد أبى عبد الله "الزغل" حاكم مالقة، وارتد إلى المنكَّب فأقام بها حيناً حتى توفى (٨٩٠ هـ - ١٤٨٥ م).','يدعم جزئيًا','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','بداية الزغل 1485.','https://shamela.ws/book/1009/2677','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GA25','AST-G10','LIB-BK-005','دراسة حديثة','ج 5 ص 214 (بحسب ترقيم الشاملة للمطبوع)','وأنه دخلها وتبوأ العرش مكانه (٥ جمادى الأولى - ٢٨ أبريل)','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','سياق: سقوط بلش مالقة «فى جمادى الأولى سنة ٨٩٢ هـ (ابريل سنة ١٤٨٧)»، ودخول أبي عبد الله غرناطة وانسحاب الزغل إلى وادي آش؛ نهاية ولايته في غرناطة 1487.','https://shamela.ws/book/1009/2687','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GA26','AST-G11','LIB-BK-005','دراسة حديثة','ج 5 ص 202 (بحسب ترقيم الشاملة للمطبوع)','وجلس أبو عبد الله محمد مكان أبيه على عرش غرناطة','يدعم','مطابق حرفيًا بعد حذف رقم الحاشية (٥) (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','الصفحة تؤرخ الأحداث بـ«جمادى الأولى ٨٨٧ - يوليه ١٤٨٢».','https://shamela.ws/book/1009/2675','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GA27','AST-G11','LIB-BK-005','دراسة حديثة','ج 5 ص 203 (بحسب ترقيم الشاملة للمطبوع)','كان بين الأسرى السلطان أبو عبد الله محمد نفسه','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','أسره عند اللسانة (Lucena) ربيع الأول 888 / أبريل 1483 = نهاية الولاية الأولى.','https://shamela.ws/book/1009/2676','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GA28','AST-G12','LIB-BK-005','دراسة حديثة','ج 5 ص 214 (بحسب ترقيم الشاملة للمطبوع)','وأنه دخلها وتبوأ العرش مكانه (٥ جمادى الأولى - ٢٨ أبريل)','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','892هـ/1487.','https://shamela.ws/book/1009/2687','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GA29','AST-G12','LIB-BK-005','دراسة حديثة','ج 5 ص 264 (بحسب ترقيم الشاملة للمطبوع)','وفى صباح اليوم الثانى من يناير سنة ١٤٩٢ م، فى الوقت','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','نهاية الولاية بالتسليم.','https://shamela.ws/book/1009/2737','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GA30','AST-G12','EXT-BRITANNICA','مرجعي عام','المقالة','His reign (1482–92) was marked by incessant civil strife and the fall of Granada to Ferdinand and Isabella.','يدعم جزئيًا','مطابق حرفيًا (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)','مدى إجمالي لا يفصّل الانقطاع.','https://www.britannica.com/biography/Muhammad-XI','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GA31','AST-G13','LIB-BK-005','دراسة حديثة','ج 5 ص 38 (بحسب ترقيم الشاملة للمطبوع)','محمد بن يوسف بن محمد بن أحمد بن خميس بن نصر ابن قيس الخزرجى','يدعم جزئيًا','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','يؤكد «محمد بن يوسف ... بن نصر»؛ ولم يُعثر في الصفحات المفحوصة على «أبو عبد الله» أو «الغالب بالله» لمحمد الأول. «ابن الأحمر» مستعمل عند عنان مرارًا (ص 41، 53).','https://shamela.ws/book/1009/2512','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GA32','AST-G13','EXT-BRITANNICA','مرجعي عام','المقالة','The first Naṣrid ruler, Muḥammad I al-Ghālib (d. 1273)','يدعم جزئيًا','مطابق حرفيًا (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)','يدعم لقب الغالب.','https://www.britannica.com/topic/Nasrid-dynasty','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GA33','AST-G14','LIB-BK-005','دراسة حديثة','ج 5 ص 125 (بحسب ترقيم الشاملة للمطبوع)','وولى العرش من بعده أخوه أبو الحجاج يوسف بن أبى الوليد إسماعيل، وهو فتى فى السادسة عشرة.','يدعم جزئيًا','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','ابن 16 عند ولايته (ذو الحجة 733/1333) ⇒ مولده نحو 717–718هـ/1317–1318م؛ لا نص صريح بسنة المولد.','https://shamela.ws/book/1009/2599','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GA34','AST-G14','LIB-BK-005','دراسة حديثة','ج 5 ص 134 (بحسب ترقيم الشاملة للمطبوع)','ولكنه ما لبث أن قتل غيلة أثناء صلاته بالمسجد الأعظم فى يوم عيد الفطر سنة ٧٥٥ هـ (أكتوبر سنة ١٣٥٤ م)','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','اغتيال 1354.','https://shamela.ws/book/1009/2608','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GA35','AST-G15','LIB-BK-005','دراسة حديثة','ج 5 ص 149 (بحسب ترقيم الشاملة للمطبوع)','توفى الغنى بالله سنة ٧٩٣ هـ (١٣٩١ م)','يدعم جزئيًا','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','يدعم الوفاة 1391 فقط؛ سنة المولد 1338 لم تُتحقق.','https://shamela.ws/book/1009/2623','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GA36','AST-G16','LIB-BK-005','دراسة حديثة','ج 5 ص 146 (بحسب ترقيم الشاملة للمطبوع)','فقتلوه فى سجنه، وذلك فى أوائل سنة ٧٧٦ هـ (أواخر ١٣٧٤ م)','يدعم جزئيًا','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','يدعم الوفاة (1374/75) والقتل في السجن؛ سنة المولد 1313 لم تُتحقق.','https://shamela.ws/book/1009/2620','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GA37','AST-G17','LIB-BK-005','دراسة حديثة','ج 5 ص 150 (بحسب ترقيم الشاملة للمطبوع)','وفى أواخر سنة ٧٩٧ هـ (١٣٩٥ م) دهمه جماعة من المتآمرين بمنزله وقتلوه وآله','يدعم جزئيًا','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','يتسق مع «بعد 1393» ويحدده بأواخر 797هـ/1395؛ سنة المولد 1333 لم تُتحقق. يُقترح تحديث القيمة. — حاشية عنان (٣) تحيل إلى «نفح الطيب ج4 ص286 و290» (الطبعة القديمة)؛ ونص النفح بتحقيق إحسان عباس لا يذكر 797 بل ينص المقري على أن القتل «بعد عام خمسة وتسعين وسبعمائة، ولم أقف من أمره على غير ما تقدم» (ج7 ص170). فسنة 797 لا يسندها المصدر المحال إليه.','https://shamela.ws/book/1009/2624','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GA38','AST-G18','LIB-BK-005','دراسة حديثة','ج 5 ص 215 (بحسب ترقيم الشاملة للمطبوع)','تبوأ أبو عبد الله محمد بن السلطان علىّ أبى الحسن عرش غرناطة للمرة الثانية، عقب عوده من الأسر بنحو عام','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)',NULL,'https://shamela.ws/book/1009/2688','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GA39','AST-G18','EXT-BRITANNICA','مرجعي عام','المقالة','Muḥammad XII (died 1527) was the last Naṣrid sultan of Granada, Spain.','يدعم جزئيًا','مطابق حرفيًا (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)','تذكر المقالة أيضًا الصيغ Abū ʿAbd Allāh Muḥammad XII وBoabdil (بحسب مستخلص الصفحة).','https://www.britannica.com/biography/Muhammad-XI','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GB01','AST-G19','LIB-BK-005','دراسة حديثة','ج5 ص39–40 (بحسب ترقيم الشاملة للمطبوع)، الفصل الثاني: نشأة مملكة غرناطة','فسار ابن الأحمر إلى غرناطة ودخلها عند مغيب الشمس في يوم من أواخر رمضان [ص40:] سنة ٦٣٥ هـ (أبريل سنة ١٢٣٨ م)','يدعم','مطابق حرفيًا، والنص يمتد بين ج5 ص39 وص40 (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','الجملة تمتد بين صفحتي 2513 و2514 في الشاملة.','https://shamela.ws/book/1009/2513','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GB02','AST-G19','EXT-PATRONATO','مرجع مؤسسي','صفحة Historia','Al-Ahmar, fundador de la Dinastía nazarí, se instala en 1238 en la Antigua Alcazaba del Albaicín','يدعم','مطابق حرفيًا (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)',NULL,'https://www.alhambra-patronato.es/descubrir/alhambra-y-generalife/historia','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GB03','AST-G20','LIB-BK-005','دراسة حديثة','ج5 ص43 (بحسب ترقيم الشاملة للمطبوع)، الفصل الثاني','وسلم ابن الأحمر إلى فرناندو جيّان وأرجونة ... وعقد ملك قشتالة السلم مع ابن الأحمر لمدة عشرين سنة، وأقره على ما بقى بيده من القواعد والحصون (٦٤٣ هـ - ١٢٤٥ م)','يخالف','مطابق حرفيًا (فحص مباشر)','يتفق في السنة الهجرية 643 ويخالف في الميلادية (1245 لا 1246)؛ 643هـ تمتد من مايو 1245 إلى مايو 1246، فالفرق فرق تحويل. القرار للمحرر.','https://shamela.ws/book/1009/2517','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GB04','AST-G21','LIB-BK-005','دراسة حديثة','ج5 ص127 (بحسب ترقيم الشاملة للمطبوع)، الفصل السابع','وفى يوم ٣٠ أكتوبر سنة ١٣٤٠ (جمادى الأولى سنة ٧٤١ هـ) نشبت بين الفريقين معركة عامة على ضفاف نهر سالادو','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)',NULL,'https://shamela.ws/book/1009/2601','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GB05','AST-G22','EXT-PATRONATO','مرجع مؤسسي','صفحة Patio de los Leones','Muhammad V fue el inspirador de este bello palacio construido en su segundo mandato, entre 1362 y 1391','يدعم','مطابق حرفيًا (فحص مباشر)',NULL,'https://www.alhambra-patronato.es/edificios-lugares/patio-de-los-leones','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GB06','AST-G22','EXT-PATRONATO','مرجع مؤسسي','صفحة Historia','alcanza su esplendor en la segunda mitad del siglo XIV, coincidiendo con los sultanatos de Yusuf I (1333-1354) y el segundo reinado de Muhammad V (1362-1391)','يدعم','مطابق حرفيًا (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)','سياقي لتواريخ الحكم.','https://www.alhambra-patronato.es/descubrir/alhambra-y-generalife/historia','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GB07','AST-G23','LIB-BK-005','دراسة حديثة','ج5 ص217 (بحسب ترقيم الشاملة للمطبوع)، الفصل الثاني: بداية النهاية','وهكذا سقطت مالقة بعد دفاع مجيد استطال ثلاثة أشهر فى أيدى النصارى، وذلك فى أواخر شعبان سنة ٨٩٢ هـ (أغسطس ١٤٨٧ م)','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','بدء الحصار في ص216: جمادى الثانية 892هـ (يونيه 1487م).','https://shamela.ws/book/1009/2690','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GB08','AST-G24','LIB-BK-005','دراسة حديثة','ج5 ص250 (بحسب ترقيم الشاملة للمطبوع)، الفصل الثالث: الصراع الأخير','وعليها تاريخ تحريرها وهو يوم ٢٥ نوفمبر سنة ١٤٩١','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)',NULL,'https://shamela.ws/book/1009/2723','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GB09','AST-G24','LIB-BK-005','دراسة حديثة','ج5 ص257 (بحسب ترقيم الشاملة للمطبوع)، حاشية','عهد التسليم وقع كما رأينا فى ٢٥ نوفمبر سنة ١٤٩١ م (٢١ محرم سنة ٨٩٧ هـ)','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23) — الموضع في حاشية عنان نفسه','مقتطف من الحاشية.','https://shamela.ws/book/1009/2730','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GB10','AST-G25','LIB-BK-005','دراسة حديثة','ج5 ص257 (بحسب ترقيم الشاملة للمطبوع)، الفصل الثالث','واتفق مع ملك قشتالة على تسليم المدينة فى الثانى من يناير سنة ١٤٩٢ م','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','الحاشية نفسها تضع الاستيلاء الفعلي في 2 ربيع الأول 897هـ (نقل بالمعنى من ملخص الأداة، لا اقتباس حرفي).','https://shamela.ws/book/1009/2730','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GB11','AST-G26','LIB-BK-005','دراسة حديثة','ج5 ص316 (بحسب ترقيم الشاملة للمطبوع)، الكتاب الثالث ف1','وثار أهل البيازين وتحصنوا بحيهم، ونددوا بخرق العهود','يدعم جزئيًا','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','لا تاريخ صريح في الصفحة لبدء الثورة (1499).','https://shamela.ws/book/1009/2788','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GB12','AST-G26','LIB-BK-005','دراسة حديثة','ج5 ص325 (بحسب ترقيم الشاملة للمطبوع)، الكتاب الثالث ف1','(مارس سنة ١٥٠١)','يدعم جزئيًا','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','تاريخ معركة جبلية في مارس 1501 ضمن سياق الثورات؛ يدعم امتدادها إلى 1501 دون نص صريح على 1499–1501 كحدّين.','https://shamela.ws/book/1009/2797','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GB13','AST-G27','EXT-BRITANNICA','مرجعي عام','مادة Morisco','In 1502, offered the choice of baptism or exile, many of them were baptized','يدعم','مطابق حرفيًا (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)',NULL,'https://www.britannica.com/topic/Morisco','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GB14','AST-G27','LIB-BK-005','دراسة حديثة','ج5 ص324 (بحسب ترقيم الشاملة للمطبوع)، الكتاب الثالث ف1','ففى ٢٠ يوليه سنة ١٥٠١ أصدر فرناندو وإيسابيلا أمراً ملكياً خلاصته','يدعم جزئيًا','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','أمر 1501 خاص بمملكة غرناطة؛ لم يُعثر في الصفحات المفحوصة (2794–2801) على نص قرار 1502 لمسلمي قشتالة.','https://shamela.ws/book/1009/2796','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GB15','AST-G28','LIB-BK-005','دراسة حديثة','ج5 ص478 (بحسب ترقيم الشاملة للمطبوع)، الكتاب الخامس ف3: عهد النضج والازدهار','ودس عليه الوزير سليمان بعض الأوغاد فقتلوه خنقاً فى سجنه','يدعم جزئيًا','مطابق حرفيًا بعد التصحيح (فحص آلي بأداة verify_quote، 2026-09-23): حُذفت من النص المنقول سابقًا عبارة «وذلك فى أوائل سنة ٧٧٦ هـ (١٣٧٤ م)» لأنها في الأصل تخص جلوس السلطان أحمد','ترتيب الجملتين في الصفحة كما أعادتهما الأداة؛ الميلادي 1374 فقط (أوائل 776هـ). — القتل خنقًا في السجن ثابت في النص، أما التاريخ فيؤخذ من ج5 ص146 (ATT-GA36) لا من هذا الموضع.','https://shamela.ws/book/1009/2950','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GB16','AST-G29','SRC-F650A5BEAE','مرجع مؤسسي','Brief synthesis','Rising above the modern lower town, the Alhambra and the Albaycín, situated on two adjacent hills, form the medieval part of Granada.','يدعم جزئيًا','مطابق حرفيًا (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)','UNESCO لا تسمي تل السبيكة؛ انظر مصدر Patronato.','https://whc.unesco.org/en/list/314','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GB17','AST-G29','SRC-F650A5BEAE','مرجع مؤسسي','Brief synthesis','The Alhambra, with its continuous occupation over time, is currently the only preserved palatine city of the Islamic period.','يدعم','مطابق حرفيًا (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)',NULL,'https://whc.unesco.org/en/list/314','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GB18','AST-G29','EXT-PATRONATO','مرجع مؤسسي','صفحة Historia','En el siglo IX existen noticias de construcciones en la colina de la Sabika, donde posteriormente se levantará la Alhambra','يدعم','مطابق حرفيًا (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)',NULL,'https://www.alhambra-patronato.es/descubrir/alhambra-y-generalife/historia','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GB19','AST-G30','SRC-F650A5BEAE','مرجع مؤسسي','Brief synthesis','To the east of the Alhambra fortress and residence are the gardens of the Generalife, an example of a rural residence of the emirs, built during the 13th and 14th centuries.','يدعم','مطابق حرفيًا (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)',NULL,'https://whc.unesco.org/en/list/314','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GB20','AST-G30','EXT-PATRONATO','مرجع مؤسسي','صفحة Palacio del Generalife','La Almunia del Generalife era una hacienda ideal para la explotación agrícola y el descanso, con un núcleo de edificación residencial y una vasta extensión de terreno de cultivo y pasto.','يدعم','مطابق حرفيًا لصدر الجملة؛ حُذفت تتمتها «compartimentada en paratas o bancales…» (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)','الصفحة نفسها تقول «construido entre los siglos XII y XIV» خلافًا لـUNESCO (XIII–XIV)؛ لا يمس صيغة الادعاء.','https://www.alhambra-patronato.es/edificios-lugares/palacio-del-generalife','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GB21','AST-G31','EXT-PATRONATO','مرجع مؤسسي','مقال Ibn Zamrak, un poeta en la Alhambra','Su labor poética se plasmó en los lugares más emblemáticos de la ciudad palatina como puede apreciarse, entre otros, en la torre de la Cautiva, puerta de Comares, fuente del jardín de Daraxa, la sala de Dos Hermanas, o la taza de la fuente del patio de los Leones','يدعم','مطابق حرفيًا (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)',NULL,'https://www.alhambra-patronato.es/ibn-zamrak-un-poeta-en-la-alhambra','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GB22','AST-G31','EXT-PATRONATO','مرجع مؤسسي','مقال La yesería de Arrayanes con versos de Ibn Zamrak','En estas cartelas se encuentran un poema de Ibn Zamrak (1333-1393).','يدعم','مطابق حرفيًا (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)','تواريخ ابن زمرك تختلف بين مقالي الموقع (1393 هنا و1394 في المقال الآخر).','https://www.alhambra-patronato.es/yeseria-arrayanes','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GB23','AST-G32','EXT-PATRONATO','مرجع مؤسسي','Pieza del mes: Canecillo del alero del patio de Comares','El palacio de Comares, obra clave de la construcción del sultán Yusuf I, alberga el emblemático salón que le da nombre','يدعم','مطابق حرفيًا (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)',NULL,'https://www.alhambra-patronato.es/elemento-del-mes/canecillo-del-alero-del-patio-de-comares','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GB24','AST-G32','EXT-PATRONATO','مرجع مؤسسي','Pieza del mes: Torre de Comares','Construida por Yūsuf I sobre otra menor, de Ismāʿīl I, su etimología procede del árabe arsh: «trono», como también es conocido su salón interior.','يدعم','مطابق حرفيًا (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)',NULL,'https://www.alhambra-patronato.es/elemento-del-mes/torre-de-comares','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-GB25','AST-G32','EXT-PATRONATO','مرجع مؤسسي','صفحة Fachada de Comares','Fue mandada construir por Muhammad V en 1370 con motivo de la conquista de Algeciras.','يدعم جزئيًا','مطابق حرفيًا (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)','يدعم مشاركة محمد الخامس (الواجهة)؛ ومقال yeseria-arrayanes ينسب «Patio de Comares o de los Arrayanes» إلى محمد الخامس نحو 1370. لا نص صريح بلفظ «إتمام».','https://www.alhambra-patronato.es/edificios-lugares/fachada-de-comares','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-201','AST-012','LIB-PRI-036','مصدر أولي','ج2 ص198 (ضمن حوادث «سنة ٣١٦» المعنونة في ج2 ص196)','وفي هذه السنة، رأى الناصر أن تكون الدعوة له في مخاطباته والمخاطبات له في جميع ما يجري ذكره فيه، بأمير المؤمنين','يدعم','مطابق حرفيًا (فحص مباشر عبر وصلة الشاملة، نص النسخة الرقمية)','عنوان السنة في ج2 ص196: «وفي سنة ٣١٦، كان غزاة أمير المؤمنين الناصر إلى مدينة ببشتر»؛ وفي ص198 أنه عهد إلى القاضي أحمد بن بقي «بأن تكون الخطبة يوم الجمعة مستهل ذي الحجة بذلك» (مستهل ذي الحجة 316هـ ≈ 15 يناير 929م بالتحويل الجدولي).','https://shamela.ws/book/11782/506','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-202','AST-012','LIB-PRI-039','مصدر أولي','ص13، ولاية عبد الرحمن الناصر','وجرى على ذلك عبد الرحمن بن محمد إلى آخر السنة السابعة عشر من ولايته، فلما بلغه ضعف الخلافة بالعراق في أيام المقتدر، وظهور الشيعة بالقيروان، تسمى عبد الرحمن بأمير المؤمنين، وتلقب بالناصر لدين الله','يدعم جزئيًا','مطابق حرفيًا (فحص مباشر عبر وصلة الشاملة، نص النسخة الرقمية)','تأريخ نسبي بسنوات الولاية لا بسنة هجرية صريحة؛ يتسق مع أواخر 316هـ ولا يحسم وحده.','https://shamela.ws/book/5742/13','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-203','AST-027','LIB-PRI-036','مصدر أولي','ج2 ص198 (ضمن حوادث سنة 316)','وقد رأينا أن تكون الدعوة لنا بأمير المؤمنين، وخروج الكتب عنا وورودها علينا بذلك','يدعم','مطابق حرفيًا (فحص مباشر عبر وصلة الشاملة، نص النسخة الرقمية)','من نص الرسالة التي أنفذها الناصر إلى العمال، كما أوردها ابن عذاري.','https://shamela.ws/book/11782/506','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-204','AST-017','LIB-PRI-039','مصدر أولي','ص13، ولاية عبد الرحمن الناصر','وتلقب بالناصر لدين الله، وكان يكنى أبا المطرف','يدعم','مطابق حرفيًا (فحص مباشر عبر وصلة الشاملة، نص النسخة الرقمية)',NULL,'https://shamela.ws/book/5742/13','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-205','AST-019','LIB-PRI-039','مصدر أولي','ص13، ولاية الحكم المستنصر','ثم ولى بعده ابنه الحكم بن عبد الرحمن، ويلقب بالمستنصر بالله، وله إذ ولى سبع وأربعون سنة، يكنى أبا العاص','يدعم','مطابق حرفيًا (فحص مباشر عبر وصلة الشاملة، نص النسخة الرقمية)',NULL,'https://shamela.ws/book/5742/13','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-206','AST-021','LIB-PRI-039','مصدر أولي','ص78، ترجمة محمد بن أبي عامر','محمد بن أبي عامر أبو عامر، أمير الأندلس في دولة هشام المؤيد','يدعم','مطابق حرفيًا (فحص مباشر عبر وصلة الشاملة، نص النسخة الرقمية)','وفي الصفحة نفسها: «وحجب هشاماً المؤيد، وتلقب بالمنصور»؛ وفي ص79 عن ابن حزم: «معافري النسب من حمير».','https://shamela.ws/book/5742/78','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-207','AST-023','LIB-PRI-028','مصدر أولي','ص162، حرف الخاء، من اسمه خلف','خلف بن عباس الزهراوي، يكنى: أبا القاسم','يدعم','مطابق حرفيًا (فحص مباشر عبر وصلة الشاملة، نص النسخة الرقمية)','ينقل ابن بشكوال وصفه عن الحميدي وثناءه عن ابن حزم.','https://shamela.ws/book/22788/151','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-208','AST-022','LIB-PRI-028','مصدر أولي','ص162، حرف الخاء، من اسمه خلف','مات بالأندلس بعد الأربع مئة','يدعم جزئيًا','مطابق حرفيًا (فحص مباشر عبر وصلة الشاملة، نص النسخة الرقمية)','يحدّ الوفاة بما بعد 400هـ (بعد أغسطس 1009م) دون سنة بعينها؛ الميلاد غير مذكور. سنة 1013 تبقى من Britannica وحدها.','https://shamela.ws/book/22788/151','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-209','AST-G13','LIB-PRI-038','مصدر أولي','ج1 ص41','ثم لم ينشب أن تملّكها أمير المسلمين الغالب بالله محمد بن يوسف بن نصر الخزرجي','يدعم','مطابق حرفيًا (فحص مباشر عبر وصلة الشاملة، نص النسخة الرقمية)','والكنية في ج1 ص200: «أمير المسلمين أبي عبد الله الغالب بالله».','https://shamela.ws/book/11682/74','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-210','AST-G15','LIB-PRI-038','مصدر أولي','ج2 ص50، ترجمة محمد بن يوسف بن إسماعيل (محمد الخامس)، «مولده السعيد النشيئة»','في نحو ثلث ليلة الاثنين والعشرين من جمادى الآخرة عام تسعة وثلاثين وسبعمائة. قلت: ووافقه من التاريخ الأعجمي رابع ينير من عام ألف وثلاثمائة وسبعة وسبعين','يدعم','مطابق حرفيًا (فحص مباشر عبر وصلة الشاملة، نص النسخة الرقمية)','22 جمادى الآخرة 739هـ = 4/5 يناير 1339م (الجدولي يعطي 5 يناير؛ والنص يذكر 4 يناير بتقويم الصفر = 1377−38 = 1339م). القيمة السابقة 1338 خطأ. (يصحح القيمة السابقة 1338)','https://shamela.ws/book/11682/421','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-211','AST-G16','LIB-PRI-038','مصدر أولي','ج4 ص548، آخر ترجمة ابن الخطيب لنفسه','مولدي: في الخامس والعشرين لرجب عام ثلاثة عشر وسبعمائة','يدعم','مطابق حرفيًا (فحص مباشر عبر وصلة الشاملة، نص النسخة الرقمية)','25 رجب 713هـ ≈ 15 نوفمبر 1313م بالتحويل الجدولي.','https://shamela.ws/book/11682/1794','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-212','AST-G17','LIB-PRI-037','مصدر أولي','ج7 ص160، باب تلامذة لسان الدين، ترجمة ابن زمرك','مولده رابع عشر شوال من عام ثلاثة وثلاثين وسبعمائة','يدعم','مطابق حرفيًا لنص المقري؛ والمقري ينقله عن الإحاطة (نقل بواسطة)','14 شوال 733هـ ≈ 28 يونيو 1333م. النص قول ابن الخطيب في الإحاطة كما نقله المقري.','https://shamela.ws/book/1002/3845','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-213','AST-G17','LIB-PRI-037','مصدر أولي','ج7 ص170، ترجمة ابن زمرك','وقد فهم من مضمون ما سبق أن قتل ابن زمرك بعد عام خمسة وتسعين وسبعمائة، ولم أقف من أمره على غير ما تقدم.','يدعم جزئيًا','مطابق حرفيًا (فحص مباشر عبر وصلة الشاملة، نص النسخة الرقمية)','المقري لا يعرف سنة القتل؛ يحدها بما بعد 795هـ (795هـ = 17 نوفمبر 1392 – 5 نوفمبر 1393م). سنة 1393 إذن حدّ أدنى لا تاريخ وفاة، وسنة 797هـ/1395 عند عنان تحتاج مصدرها.','https://shamela.ws/book/1002/3855','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-214','AST-G17','EXT-PATRONATO','مرجع مؤسسي','صفحة «Ibn Zamrak, un poeta en la Alhambra»','Ibn Zamrak (1333-1394)','يخالف','مطابق حرفيًا (فحص الصفحة الحية عبر WebFetch بنموذج مساعد، 2026-09-23 — يُعاد بالعين قبل النشر)','موقع الباترونato نفسه غير متسق: 1393 في صفحة «Yesería Arrayanes» و1394 هنا؛ وعنان 1395؛ والمصدر الأولي (المقري) «بعد 795هـ» فقط.','https://www.alhambra-patronato.es/ibn-zamrak-un-poeta-en-la-alhambra','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-257','AST-G33','LIB-BK-005','دراسة حديثة','ج5 ص38 (بحسب ترقيم الشاملة للمطبوع)','وولد محمد بن يوسف في أرجونة سنة ٥٩٥ هـ (١١٩٨ م)','يخالف','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','رواية مرجوحة أمام نص الإحاطة (591هـ).','https://shamela.ws/book/1009/2512','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-215','AST-011','LIB-PRI-039','مصدر أولي','ص9','واستولى عبد الرحمن على قرطبة يوم الأضحى من العام المذكور','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','العام المذكور = 138هـ؛ يوم الأضحى 10 ذي الحجة 138هـ ≈ 15 مايو 756م (جدولي).','https://shamela.ws/book/5742/9','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-216','AST-001','LIB-PRI-039','مصدر أولي','ص9','واستولى عبد الرحمن على قرطبة يوم الأضحى من العام المذكور','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','العام المذكور = 138هـ؛ يوم الأضحى 10 ذي الحجة 138هـ ≈ 15 مايو 756م (جدولي).','https://shamela.ws/book/5742/9','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-217','AST-007','LIB-PRI-039','مصدر أولي','ص9','فاتصلت ولايته إلى أن مات سنة اثنتين وسبعين ومائة','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','172هـ = 788/789م.','https://shamela.ws/book/5742/9','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-218','AST-008','LIB-PRI-039','مصدر أولي','ص12، ولاية عبد الله بن محمد','فلم يزل كذلك طول ولايته إلى أن مات مستهل ربيع الأول سنة ثلاث مائة','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','وفاة الأمير عبد الله وولاية حفيده عبد الرحمن: مستهل ربيع الأول 300هـ ≈ 16 أكتوبر 912م.','https://shamela.ws/book/5742/12','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-219','AST-016','LIB-PRI-039','مصدر أولي','ص12، ولاية عبد الرحمن الناصر','فولى الأمر وله اثنتان وعشرون سنة','يدعم جزئيًا','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','سنّه عند الولاية سنة 300هـ تجعل مولده نحو 277/278هـ (890/891م)؛ تأريخ تقريبي بالسن.','https://shamela.ws/book/5742/12','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-220','AST-009','LIB-PRI-039','مصدر أولي','ص13','ثم اتصلت ولايته إلى أن مات في صدر رمضان سنة خمسين وثلاث مائة','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','صدر رمضان 350هـ ≈ منتصف أكتوبر 961م.','https://shamela.ws/book/5742/13','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-221','AST-016','LIB-PRI-039','مصدر أولي','ص13','ثم اتصلت ولايته إلى أن مات في صدر رمضان سنة خمسين وثلاث مائة','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','صدر رمضان 350هـ ≈ منتصف أكتوبر 961م.','https://shamela.ws/book/5742/13','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-222','AST-018','LIB-PRI-039','مصدر أولي','ص13، ولاية الحكم المستنصر','وله إذ ولى سبع وأربعون سنة','يدعم جزئيًا','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','سنّه عند الولاية (350هـ) تجعل مولده نحو 302/303هـ (915م)؛ تأريخ تقريبي بالسن.','https://shamela.ws/book/5742/13','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-223','AST-010','LIB-PRI-039','مصدر أولي','ص16','فاتصلت ولايته إلى أن مات في صفر سنة ست وستين وثلاث مائة','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','صفر 366هـ ≈ أكتوبر 976م.','https://shamela.ws/book/5742/16','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-224','AST-018','LIB-PRI-039','مصدر أولي','ص16','فاتصلت ولايته إلى أن مات في صفر سنة ست وستين وثلاث مائة','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','صفر 366هـ ≈ أكتوبر 976م.','https://shamela.ws/book/5742/16','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-225','AST-005','LIB-PRI-039','مصدر أولي','ص17، ولاية هشام المؤيد','إلى أن قام عليه محمد بن هشام بن عبد الجبار يوم الثلاثاء لثمان عشرة ليلة خلت من جمادى الآخرة سنة تسع وتسعين وثلثمائة','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','18 جمادى الآخرة 399هـ ≈ 17 فبراير 1009م (جدولي؛ وعنان 16 فبراير).','https://shamela.ws/book/5742/17','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-226','AST-014','LIB-PRI-039','مصدر أولي','ص17، ولاية هشام المؤيد','إلى أن قام عليه محمد بن هشام بن عبد الجبار يوم الثلاثاء لثمان عشرة ليلة خلت من جمادى الآخرة سنة تسع وتسعين وثلثمائة','يدعم جزئيًا','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','18 جمادى الآخرة 399هـ ≈ 17 فبراير 1009م (جدولي؛ وعنان 16 فبراير).','https://shamela.ws/book/5742/17','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-227','AST-006','LIB-PRI-039','مصدر أولي','ص28، ولاية هشام بن محمد المعتد','ولم يبق إلا يسيراً حتى قامت عليه فرقة من الجند، فخلع، وجرت أمور يكثر شرحها، وانقطعت الذعوة الأموية من يومئذ فيها','يدعم جزئيًا','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','بعد دخوله قرطبة 8 ذي الحجة 420هـ؛ الحميدي لا يذكر سنة الخلع (422هـ/1031م عند غيره). «الذعوة» تصحيف «الدعوة» في النسخة الرقمية.','https://shamela.ws/book/5742/28','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-228','AST-004','LIB-PRI-039','مصدر أولي','ص28، ولاية هشام بن محمد المعتد','ولم يبق إلا يسيراً حتى قامت عليه فرقة من الجند، فخلع، وجرت أمور يكثر شرحها، وانقطعت الذعوة الأموية من يومئذ فيها','يدعم جزئيًا','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','بعد دخوله قرطبة 8 ذي الحجة 420هـ؛ الحميدي لا يذكر سنة الخلع (422هـ/1031م عند غيره). «الذعوة» تصحيف «الدعوة» في النسخة الرقمية.','https://shamela.ws/book/5742/28','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-229','AST-013','LIB-PRI-037','مصدر أولي','ج1 ص567','بدأ عبد الرحمن الناصر لدين الله بنيان الزهراء أول سنة خمس وعشرين وثلاثمائة','يدعم','مطابق حرفيًا بعد حذف رقم الحاشية (٤) (فحص آلي بأداة verify_quote، 2026-09-23)','نقل بواسطة: ابن حيان عن خط ابن دحون عن مسلمة بن عبد الله العريف المهندس. أول 325هـ ≈ نوفمبر 936م.','https://shamela.ws/book/1002/586','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-230','AST-020','LIB-PRI-036','مصدر أولي','ج2 ص301','وفي سنة ٣٩٢، توفى المنصور ابن أبي عامر ﵀ ليلة الاثنين لثلاث بقين لرمضان المعظم، وهو ابن خمس وستين سنة وعشرة أشهر','يدعم جزئيًا','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','27 رمضان 392هـ ≈ 9 أغسطس 1002م. والسنّ (65 سنة و10 أشهر قمرية) تجعل مولده نحو ذي القعدة 326هـ (938م)، لا 328هـ كما عند عنان.','https://shamela.ws/book/11782/609','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-231','AST-020','LIB-PRI-039','مصدر أولي','ص79، ترجمة محمد بن أبي عامر','وتوفي في طريق الغزو في أقصى الثغور بمدينة سالم سنة ثلاث وتسعين وثلاث مائة','يخالف','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','رواية مخالفة: 393هـ عند الحميدي، و392هـ عند ابن عذاري (بيوم وشهر) وعنان. الترجيح لـ392 لتفصيل ابن عذاري.','https://shamela.ws/book/5742/79','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-232','AST-G01','LIB-PRI-038','مصدر أولي','ج2 ص56، نقش قبر محمد الأول كما أورده ابن الخطيب','وبويع له يوم الجمعة السادس والعشرين من رمضان عام خمسة وثلاثين وستمائة','يدعم جزئيًا','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','26 رمضان 635هـ ≈ 12 مايو 1238م (عنان: أبريل 1238).','https://shamela.ws/book/11682/427','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-233','AST-G19','LIB-PRI-038','مصدر أولي','ج2 ص56، نقش قبر محمد الأول كما أورده ابن الخطيب','وبويع له يوم الجمعة السادس والعشرين من رمضان عام خمسة وثلاثين وستمائة','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','26 رمضان 635هـ ≈ 12 مايو 1238م (عنان: أبريل 1238).','https://shamela.ws/book/11682/427','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-234','AST-G03','LIB-PRI-038','مصدر أولي','ج2 ص56، نقش قبر محمد الأول','وكانت وفاته يوم الجمعة بعد صلاة العصر التاسع والعشرين لجمادى الآخرة عام أحد وسبعين وستمائة','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','29 جمادى الآخرة 671هـ ≈ 21 يناير 1273م؛ فقول عنان «ديسمبر 1272» سهو في التحويل.','https://shamela.ws/book/11682/427','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-235','AST-G04','LIB-PRI-038','مصدر أولي','ج1 ص41','ثم ولي الأمر بعده ولده وسميّه محمد بن محمد، فقام بها أحمد قيام، وتوفي عام أحد وسبعمائة.','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','701هـ = سبتمبر 1301 – أغسطس 1302م.','https://shamela.ws/book/11682/74','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-236','AST-G05','LIB-PRI-038','مصدر أولي','ج4 ص292، نقش قبر يوسف الأول (من إملاء ابن الخطيب)','وكانت ولايته الملك في غرة اليوم الرابع عشر لذي الحجة من عام ثلاثة وثلاثين وسبعمائة','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','14 ذي الحجة 733هـ ≈ 26 أغسطس 1333م.','https://shamela.ws/book/11682/1539','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-237','AST-G05','LIB-PRI-038','مصدر أولي','ج4 ص292','وذلك في السجدة الأخيرة من صلاة العيد، غرة شوال، من عام خمسة وخمسين وسبعمائة','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','1 شوال 755هـ ≈ 19 أكتوبر 1354م.','https://shamela.ws/book/11682/1539','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-238','AST-G14','LIB-PRI-038','مصدر أولي','ج4 ص292','ومولده في الثامن والعشرين لربيع الآخر عام ثمانية عشر وسبعمائة','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','28 ربيع الآخر 718هـ ≈ 29 يونيو 1318م.','https://shamela.ws/book/11682/1539','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-239','AST-G14','LIB-PRI-038','مصدر أولي','ج4 ص292','وذلك في السجدة الأخيرة من صلاة العيد، غرة شوال، من عام خمسة وخمسين وسبعمائة','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','1 شوال 755هـ ≈ 19 أكتوبر 1354م.','https://shamela.ws/book/11682/1539','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-240','AST-G06','LIB-PRI-038','مصدر أولي','ج2 ص4، ترجمة محمد الخامس','ساق الله إليه الملك طواعية واختيارا، إثر صلاة عيد الفطر على بغتة وفاة المقدّس أبيه، من عام خمسة وخمسين وسبعمائة','يدعم جزئيًا','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','بداية الولاية الأولى: 1 شوال 755هـ (أكتوبر 1354م). نهايتها 28 رمضان 760هـ في أعمال الأعلام ص306 (ATT-262).','https://shamela.ws/book/11682/375','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-241','AST-G07','LIB-PRI-038','مصدر أولي','ج2 ص13، «الحادثة التي جرت عليه»','وكان دخول السلطان دار ملكه، وعوده إلى أريكة سلطانه، وحلوله بمجلس أبيه وجدّه، زوال يوم السبت الموفي عشرين لجمادى الثانية من عام ثلاثة وستين وسبعمائة','يدعم جزئيًا','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','20 جمادى الآخرة 763هـ ≈ 16 أبريل 1362م.','https://shamela.ws/book/11682/384','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-242','AST-G22','LIB-PRI-038','مصدر أولي','ج2 ص13، «الحادثة التي جرت عليه»','وكان دخول السلطان دار ملكه، وعوده إلى أريكة سلطانه، وحلوله بمجلس أبيه وجدّه، زوال يوم السبت الموفي عشرين لجمادى الثانية من عام ثلاثة وستين وسبعمائة','يدعم جزئيًا','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','20 جمادى الآخرة 763هـ ≈ 16 أبريل 1362م.','https://shamela.ws/book/11682/384','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-243','AST-G11','LIB-PRI-037','مصدر أولي','ج4 ص514 (حوادث سنة 887هـ المعنونة في ص512)','وفي هذا اليوم بعينه هرب الأميران أبو عبد الله محمد وأبو الحجاج يوسف خوفاً من أبيهما أن يفتك بهما بإشارة حظيته الرومية ثريا، واستقرا بوادي آش، وقامت بدعوتهما، ثم بايعتهما تلك المرية وبسطة وغرناطة، وهرب أبوهما السلطان أبو الحسن إلى مالقة.','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','اليوم = 27 جمادى الأولى 887هـ ≈ 14 يوليو 1482م.','https://shamela.ws/book/1002/2536','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-244','AST-G08','LIB-PRI-037','مصدر أولي','ج4 ص514 (حوادث سنة 887هـ المعنونة في ص512)','وفي هذا اليوم بعينه هرب الأميران أبو عبد الله محمد وأبو الحجاج يوسف خوفاً من أبيهما أن يفتك بهما بإشارة حظيته الرومية ثريا، واستقرا بوادي آش، وقامت بدعوتهما، ثم بايعتهما تلك المرية وبسطة وغرناطة، وهرب أبوهما السلطان أبو الحسن إلى مالقة.','يدعم جزئيًا','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','اليوم = 27 جمادى الأولى 887هـ ≈ 14 يوليو 1482م.','https://shamela.ws/book/1002/2536','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-245','AST-G11','LIB-PRI-037','مصدر أولي','ج4 ص515','وكان في جملة من أسر السلطان أبو عبد الله، ولم يعرف','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','في ربيع الأول 888هـ (أبريل 1483م) بحسب سياق الصفحة.','https://shamela.ws/book/1002/2537','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-246','AST-G09','LIB-PRI-037','مصدر أولي','ج4 ص515','ولما تعذر أمره قدم أخاه أبا عبد الله، وخلع له نفسه، ونزل بالمنكب، فأقام بها إلى أن مات، واستقل أخوه أبو عبد الله المعروف بالزغل بالملك بعده.','يدعم جزئيًا','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','التسلسل: عودة أبي الحسن ثم نزوله للزغل؛ بلا سنة صريحة (890هـ/1485م عند عنان).','https://shamela.ws/book/1002/2537','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-247','AST-G10','LIB-PRI-037','مصدر أولي','ج4 ص515','ولما تعذر أمره قدم أخاه أبا عبد الله، وخلع له نفسه، ونزل بالمنكب، فأقام بها إلى أن مات، واستقل أخوه أبو عبد الله المعروف بالزغل بالملك بعده.','يدعم جزئيًا','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','التسلسل: عودة أبي الحسن ثم نزوله للزغل؛ بلا سنة صريحة (890هـ/1485م عند عنان).','https://shamela.ws/book/1002/2537','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-248','AST-G10','LIB-PRI-037','مصدر أولي','ج4 ص519 (حوادث 892هـ)','وحين حركتهم بالحملة بلغ السلطان الزغل أن غرناطة بايعت صاحب البيازين','يدعم جزئيًا','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','نهاية حكم الزغل في غرناطة ربيع 892هـ/1487م.','https://shamela.ws/book/1002/2541','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-249','AST-G12','LIB-PRI-037','مصدر أولي','ج4 ص520','وكانت ثورة غرناطة، خامس جمادى الأولى.','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','5 جمادى الأولى 892هـ ≈ 29 أبريل 1487م (عنان: 28 أبريل).','https://shamela.ws/book/1002/2542','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-250','AST-G12','LIB-PRI-037','مصدر أولي','ج4 ص525','ونزل سلطان غرناطة من الحمراء.','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','نهاية حكم أبي عبد الله (897هـ/1492م).','https://shamela.ws/book/1002/2547','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-251','AST-G23','LIB-PRI-037','مصدر أولي','ج4 ص521','فلما تمكن العدو منهم أخذهم أسرى، وذلك أواخر شعبان سنة اثنتين وتسعين وثمانمائة','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','سقوط مالقة: أواخر شعبان 892هـ ≈ أغسطس 1487م.','https://shamela.ws/book/1002/2543','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-252','AST-G25','LIB-PRI-037','مصدر أولي','ج4 ص525','وفي ثاني ربيع الأول من السنة - أعني سنة سبع وتسعين وثمانمائة - استولى النصارى على الحمراء ودخلوها','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','2 ربيع الأول 897هـ = 2/3 يناير 1492م.','https://shamela.ws/book/1002/2547','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-253','AST-G02','LIB-PRI-037','مصدر أولي','ج4 ص525','وفي ثاني ربيع الأول من السنة - أعني سنة سبع وتسعين وثمانمائة - استولى النصارى على الحمراء ودخلوها','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','2 ربيع الأول 897هـ = 2/3 يناير 1492م.','https://shamela.ws/book/1002/2547','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-254','AST-G26','LIB-PRI-037','مصدر أولي','ج4 ص527','إلى أن آل الحال لحملهم المسلمين على التنصر سنة أربع وتسعمائة','يدعم جزئيًا','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','904هـ = أغسطس 1498 – أغسطس 1499م؛ ويذكر بعده قيام أهل البيازين على الحكام.','https://shamela.ws/book/1002/2549','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-255','AST-G33','LIB-PRI-038','مصدر أولي','ج2 ص56، نقش قبر محمد الأول','ولد، ﵁، وأتاه رحمة من لدنه، عام أحد وتسعين وخمسمائة','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','591هـ = 1194/1195م، وفي ج2 ص55 «بأرجونة، عام الأرك» (591هـ). عنان (ج5 ص38): 595هـ/1198م.','https://shamela.ws/book/11682/427','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-256','AST-G33','LIB-PRI-038','مصدر أولي','ج2 ص56، نقش قبر محمد الأول','وكانت وفاته يوم الجمعة بعد صلاة العصر التاسع والعشرين لجمادى الآخرة عام أحد وسبعين وستمائة','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','29 جمادى الآخرة 671هـ ≈ 21 يناير 1273م؛ فقول عنان «ديسمبر 1272» سهو في التحويل.','https://shamela.ws/book/11682/427','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-258','AST-G21','LIB-PRI-038','مصدر أولي','ج3 ص298 (وفاة مترجَم له يوم الوقيعة)','يوم الوقيعة الكبرى على المسلمين بظاهر طريف يوم الاثنين السابع لجمادى الأولى عام واحد وأربعين وسبعمائة','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','7 جمادى الأولى 741هـ ≈ 30 أكتوبر 1340م، مطابق لتاريخ عنان. ومثله في نفح الطيب ج5 ص17.','https://shamela.ws/book/11682/1091','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-259','AST-G20','LIB-PRI-038','مصدر أولي','ج1 ص72، ترجمة ابن الزبير الثقفي','خرج به أبوه عند تغلّب العدوّ عليها عام ثلاثة وأربعين وستمائة','يدعم جزئيًا','مطابق حرفيًا (مطابقة مباشرة للصفحة عبر وصلة الشاملة، 2026-09-23)','الضمير في «عليها» يعود إلى «مدينة جيّان» في الجملة السابقة. يثبت سنة سقوط جيان (643هـ) لا تفاصيل المعاهدة وتبعية غرناطة.','https://shamela.ws/book/11682/104','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-260','AST-002','LIB-PRI-036','مصدر أولي','ج2 ص198 (ضمن حوادث سنة 316)','وفي هذه السنة، رأى الناصر أن تكون الدعوة له في مخاطباته والمخاطبات له في جميع ما يجري ذكره فيه، بأمير المؤمنين','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','نهاية الإمارة ببدء الدعاء بأمير المؤمنين مستهل ذي الحجة 316هـ (يناير 929م).','https://shamela.ws/book/11782/506','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-261','AST-003','LIB-PRI-036','مصدر أولي','ج2 ص198 (ضمن حوادث سنة 316)','وفي هذه السنة، رأى الناصر أن تكون الدعوة له في مخاطباته والمخاطبات له في جميع ما يجري ذكره فيه، بأمير المؤمنين','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-23)','بداية الخلافة: مستهل ذي الحجة 316هـ (يناير 929م).','https://shamela.ws/book/11782/506','2026-09-23');
INSERT INTO "attestations" VALUES('ATT-262','AST-G06','LIB-PRI-040','مصدر أولي','ص306، دولة محمد بن يوسف بن إسماعيل (الأولى)','وتمشّت أيامه على أتمّ ما يكون من الأمان، وخصب الزمان، إلى الثامن والعشرين من شهر الصوم سنة ٧٦٠. وكان التغلّب على دولته الأولى، واستولى على الأمر أخوه إسماعيل','يدعم','مطابق لصورة الصفحة (قراءة بصرية للنسخة المصوّرة 600 نقطة/بوصة، 2026-09-24)','28 رمضان 760هـ ≈ 23 أغسطس 1359م (جدولي). الرقم مكتوب بالأرقام في الطبعة. يكمل ATT-240 (بداية الولاية).','https://archive.org/details/ar106biog55','2026-09-24');
INSERT INTO "attestations" VALUES('ATT-263','AST-G28','LIB-PRI-040','دراسة حديثة (مقدمة المحقق)','المقدمة ص ز','ولكن لم تطل المدة حتى خلع أبو زيّان وولي مكانه أبو العباس المستنصر ( ٧٧٦ ه – ١٣٧٤ م ) فاشتدّ خوف المهاجر المسكين ، وحق له الخوف إذ انتهى به الأمر إلى أن سجن بفاس ، ثم خنقته بسجنه ، في بعض الليالي ،','يدعم جزئيًا','مطابق لصورة الصفحة (قراءة بصرية للنسخة المصوّرة 600 نقطة/بوصة، 2026-09-24)','كلام المحقق ليفي بروفنسال لا ابن الخطيب؛ يضع القتل بعد ولاية المستنصر سنة 776هـ دون يوم أو شهر. تتمة الجملة في ص ح: «رسل أحد أعدائه الحريصين على هلاكه».','https://archive.org/details/ar106biog55','2026-09-24');
INSERT INTO "attestations" VALUES('ATT-264','AST-G28','LIB-PRI-041','مصدر أولي','ج7 ص452 (بحسب ترقيم الشاملة للمطبوع)، «الخبر عن مقتل ابن الخطيب»','ولما استولى السلطان أبو العباس على البلد الجديد دار ملكه فاتح ست وسبعين وسبعمائة','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-24)','الحد الأدنى: الخبر يبدأ باستيلاء أبي العباس على فاس الجديد في مستهل 776هـ (1 محرم 776 ≈ 12 يونيو 1374م بالحساب الجدولي)، ثم يسوق النكبة والقتل بعده.','https://shamela.ws/book/12320/4469','2026-09-24');
INSERT INTO "attestations" VALUES('ATT-265','AST-G28','LIB-PRI-041','مصدر أولي','ج7 ص453 (بحسب ترقيم الشاملة للمطبوع)، «الخبر عن مقتل ابن الخطيب»','فطرقوا السجن ليلا ومعهم زعانفة جاءوا في لفيف الخدم مع سفراء السلطان ابن الأحمر، وقتلوه خنقا في محبسه','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-24)','شاهد معاصر على كيفية القتل (خنقًا في السجن بفاس). ابن خلدون صديق ابن الخطيب وكان بالمغرب حينها.','https://shamela.ws/book/12320/4470','2026-09-24');
INSERT INTO "attestations" VALUES('ATT-266','AST-G28','LIB-PRI-042','مصدر أولي','ص187 (بحسب ترقيم الشاملة للمطبوع)','فلم تنجح تلك السعاية، وقتل ابن الخطيب بمحبسه','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-24)','رواية ابن خلدون عن نفسه: توسّط لابن الخطيب فلم ينجح، فقُتل. يأتي الخبر في سياق أحداث 776هـ.','https://shamela.ws/book/37022/161','2026-09-24');
INSERT INTO "attestations" VALUES('ATT-267','AST-G28','LIB-PRI-042','مصدر أولي','ص187 (بحسب ترقيم الشاملة للمطبوع)','ولحق بي أهلي وولدي من فاس، وأقاموا معي، وذلك في عيد الفطر سنة ست وسبعين','يدعم جزئيًا','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-24)','الحد الأعلى استنتاجًا من ترتيب السرد: خبر القتل يسبق في الصفحة نفسها انتقال ابن خلدون إلى هنين ثم تلمسان ولحاق أهله به في عيد الفطر 776هـ (≈ 5 مارس 1375م). النص لا يصرّح بأن القتل قبل شوال، فهو قرينة لا نص.','https://shamela.ws/book/37022/161','2026-09-24');
INSERT INTO "attestations" VALUES('ATT-268','AST-015','LIB-PRI-040','مصدر أولي','ص117، «أيام هشام بن الحكم ... في المرة الثانية»','وفي أخريات ربيع الأول من هذه السنة ، نزلوا قرطبة ، ودخلوا مدينة الزّهراء . وانضمّ الخلق من الأحواز إلى المدينة ، وانتشرت الغارات','يدعم جزئيًا','مطابق لصورة الصفحة (قراءة بصرية للنسخة المصوّرة، 2026-09-24)','ابن الخطيب يذكر دخول البربر مدينة الزهراء في أواخر ربيع الأول، والسنة غير مصرّح بها: الفصل يبدأ بعد مقتل المهدي في 8 ذي الحجة 400هـ (ص116)، فالسنة 401هـ استنتاجًا (أواخر ربيع الأول 401 ≈ أوائل نوفمبر 1010م)، وهو ما يطابق رواية عنان (ATT-029). النص لا يذكر لفظ الخراب، بل الدخول والغارات.','https://archive.org/details/ar106biog55','2026-09-24');
INSERT INTO "attestations" VALUES('ATT-269','AST-G27','EXT-ORTEGO-2011','دراسة حديثة محكّمة','ص279','el 12 de febrero de 1502 Isabel y Fernando promulgaban una pragmática que ponía fin, tras más de cuatro siglos, a la presencia de mudéjares en Castilla','يدعم','مطابق في استخراجين مستقلين من ملف PDF عبر WebFetch بنموذج مساعد، 2026-09-24 — يُعاد بالعين قبل النشر','يحدد يوم الإصدار: 12 فبراير 1502. الحاشية 1 تحيل إلى Molénat (2001).','https://revistas.uned.es/index.php/ETFIII/article/download/1672/1553/4521','2026-09-24');
INSERT INTO "attestations" VALUES('ATT-270','AST-G27','EXT-ORTEGO-2011','دراسة حديثة محكّمة','ص283','Finalmente, el 12 de febrero de 1502, la promulgación de la pragmática referida pondría fin a la realidad mudéjar al establecer la conversión obligatoria de todos los moros varones mayores de catorce años y mujeres mayores de doce','يدعم','مطابق في استخراجين مستقلين من ملف PDF عبر WebFetch بنموذج مساعد، 2026-09-24 — يُعاد بالعين قبل النشر','مضمون الأمر: التنصير الإلزامي للذكور فوق 14 سنة والإناث فوق 12. الحاشية 23 تحيل إلى Ladero Quesada، Los mudéjares de Castilla، ص127–130، وهو مظنّة نص الوثيقة نفسها.','https://revistas.uned.es/index.php/ETFIII/article/download/1672/1553/4521','2026-09-24');
INSERT INTO "attestations" VALUES('ATT-271','AST-G27','EXT-LADERO-1999','دراسة حديثة','ص179 (فصل «Grupos sociales rurales y urbanos»)','La pragmática real de 12 de febrero de 1502 instaba, como la relativa a los judíos de 31 de marzo de 1492, a optar entre el bautismo y la emigración','يدعم','مطابق لنص OCR للنسخة المرفقة (بحث نصي مباشر، 2026-09-24) — يُقابل بصورة الصفحة قبل النشر','شاهد مستقل ثانٍ لتاريخ 12 فبراير 1502 من كبير المتخصصين في مدجّني قشتالة، وهو المرجع الذي يحيل إليه Ortego Rico. يذكر أيضًا أن أغلب المدجّنين اختاروا التنصير، وأن لمدجّني إشبيلية «capitulaciones» مع الملكين.',NULL,'2026-09-24');
INSERT INTO "attestations" VALUES('ATT-272','AST-G27','EXT-LADERO-1999','دراسة حديثة','بين ص317 وص320 (أرقام الصفحات 318–319 ساقطة من نص OCR)','hasta que, a comienzos de 1502, una pragmática real ordenó -como para los judíos en 1492- la alternativa entre bautismo o expulsión','يدعم','مطابق لنص OCR للنسخة المرفقة (بحث نصي مباشر، 2026-09-24) — يُقابل بصورة الصفحة قبل النشر','يربط الأمر بثورات غرناطة 1500–1501 ويضعه في أوائل 1502.',NULL,'2026-09-24');
INSERT INTO "attestations" VALUES('ATT-273','AST-015','LIB-PRI-043','مصدر أولي','ج1 ص436 (بحسب ترقيم الشاملة للمطبوع)، أخبار المستكفي','وفي أيام المستكفي هذا استؤصل بقية قصوره جده الناصر بالخراب، وطمست أعلام قصر الزهراء، واقتلع نحاس الأبواب ورصاص القني','يدعم','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-24)','أصرح نص أولي في خراب الزهراء بلفظه: الخراب التام في أيام المستكفي، ويتلوه في الصفحة نفسها خلعه «سنة ست عشرة» (416هـ). ويقول بعده: «فعدا عليها قبل تمام المائة»، أي قبل مرور مئة سنة على تأسيسها (325هـ).','https://shamela.ws/book/1035/432','2026-09-24');
INSERT INTO "attestations" VALUES('ATT-274','AST-015','LIB-PRI-039','مصدر أولي','ص26، «ولاية محمد بن عبد الرحمن المستكفى»','وولى محمد بن عبد الرحمن المذكور، وله ثمان وأربعون سنة وأشهر، لأن مولده في سنة ست وستين وثلاث مائة','يدعم جزئيًا','مطابق لنص الصفحة (قراءة مباشرة عبر وصلة الشاملة، 2026-09-24)','يحدد بداية ولاية المستكفي استنتاجًا: 366 + 48 = 414هـ. وفي ص27 أنه ولي «ستة عشر شهراً وأياماً»، فيوافق خلعه سنة 416هـ عند ابن بسام.','https://shamela.ws/book/5742/26','2026-09-24');
INSERT INTO "attestations" VALUES('ATT-275','AST-022','LIB-PRI-044','مصدر أولي','ج2 ص185 (بحسب ترقيم الشاملة للمطبوع)، رسالة في فضل الأندلس','وكتاب التصريف [لمن عجز عن التأليف] لأبي القاسم خلف بن عباس الزهراوي (٣) ، وقد أدركناه وشاهدناه','يدعم جزئيًا','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-24)','شهادة معاصر: ابن حزم (384–456هـ) رأى الزهراوي، فحياته امتدت إلى أوائل القرن الخامس. وهذا يوافق «بعد الأربع مئة» في الصلة، ولا يعطي سنة.','https://shamela.ws/book/1038/625','2026-09-24');
INSERT INTO "attestations" VALUES('ATT-276','AST-022','EXT-ZIRIKLI','دراسة حديثة','ج2 ص310 (بحسب ترقيم الشاملة للمطبوع)','الزَّهْرَاوي (٠٠٠ - ٤٢٧ هـ = ٠٠٠ - ١٠٣٦ م)','يخالف','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-24)','الزركلي يجعل الوفاة 427هـ (1036م) لا 1013م كما عند Britannica. كلا الرقمين تقدير حديث، ولم أعثر ضمن البحث المنفذ على نص أولي بسنة الوفاة.','https://shamela.ws/book/12286/1847','2026-09-24');
INSERT INTO "attestations" VALUES('ATT-277','AST-G17','EXT-ZIRIKLI','دراسة حديثة','ج7 ص154 (بحسب ترقيم الشاملة للمطبوع)','ابن زَمْرَك (٧٣٣ - نحو ٧٩٣ هـ = ١٣٣٣ - نحو ١٣٩٠ م)','يخالف','مطابق حرفيًا (فحص آلي بأداة verify_quote في وصلة الشاملة، 2026-09-24)','تقدير حديث يخالف نص المقري (ATT-213) أن قتله بعد 795هـ. فالمراجع الحديثة الآن: نحو 793 (الزركلي)، و1393/1394 (الباتروناتو)، و797 (عنان).','https://shamela.ws/book/12286/6395','2026-09-24');
CREATE TABLE boundary_sources (
  boundary_source_id TEXT PRIMARY KEY,
  label TEXT NOT NULL,
  url TEXT NOT NULL,
  coverage TEXT,
  rights_status TEXT,
  evidence_grade TEXT,
  intended_use TEXT,
  qa_rule TEXT,
  last_checked TEXT
);
INSERT INTO "boundary_sources" VALUES('BND-SRC-OHM','OpenHistoricalMap','https://api.openhistoricalmap.org/','حدود وأماكن تاريخية عبر الزمن','public-domain project statement; verify current terms','A-','مرشح أول للحدود التاريخية المتجهة','لا تستورد Polygon قبل فحص start/end dates وWikidata/OSM tags والمصدر على مستوى relation.','2026-09-23');
INSERT INTO "boundary_sources" VALUES('BND-SRC-PLEIADES','Pleiades GIS','https://atlantides.org/downloads/pleiades/gis/','أماكن قديمة وGIS مع precision metadata','open scholarly gazetteer; capture exact dataset license at ingest','A','مرجع استمرارية المواقع القديمة وجودة الإحداثية','احترم location_precision؛ rough لا يصبح exact.','2026-09-23');
INSERT INTO "boundary_sources" VALUES('BND-SRC-ATLASPI','AtlasPI','https://github.com/Soil911/AtlasPI','حدود تاريخية + confidence + مصادر','Apache 2.0 project; verify data-source licenses','B+','Cross-check وتوليد قائمة مرشحين','لا يصبح مصدرًا canonical قبل تتبع مصدر كل boundary.','2026-09-23');
INSERT INTO "boundary_sources" VALUES('BND-SRC-BACKTHEN','World Back Then','https://backthen.world/','حدود في سنوات ثابتة من ThinkQuest + سياق Wikipedia','license not sufficiently established for ingest','C','مرجع بصري ومقارنة فقط','لا استيراد إلى قاعدة الإطلاق قبل حسم الحقوق والمنهجية.','2026-09-23');
INSERT INTO "boundary_sources" VALUES('BND-SRC-UCL','Carvajal López — map of northern border of al-Andalus','https://discovery.ucl.ac.uk/10102808/1/Carvajal%2520L%25C3%25B3pez_Al-Andalus.pdf','حد شمالي تقريبي c.720/1000/1150/1250','scholarly publication; map reuse rights to verify','A-','مرجع أكاديمي لمعايرة التحولات الزمنية','يستخدم للتحقق البصري والمنهجي؛ لا digitization قبل مراجعة الترخيص ودقة الرسم.','2026-09-23');
CREATE TABLE change_log(
  change_id TEXT PRIMARY KEY,
  changed_at TEXT NOT NULL,
  component TEXT NOT NULL,
  change_type TEXT NOT NULL,
  summary_ar TEXT NOT NULL,
  source_or_ticket TEXT,
  version TEXT NOT NULL
);
INSERT INTO "change_log" VALUES('CHG-1001','2026-09-23','Sustainability','schema','إضافة ownership/watchlist/source-health/maintenance-runs/change-log/release-manifest.','GATE-SUS','v1.0');
INSERT INTO "change_log" VALUES('CHG-1002','2026-09-23','Sources','monitoring','إنشاء snapshot صحة للمصادر الحرجة مع fallback لـMAN وAl-Qantara.','source-health','v1.0');
INSERT INTO "change_log" VALUES('CHG-1003','2026-09-23','QA','automation','إضافة اختبارات الاستدامة والإصدار وربطها ببوابات release.','QA-009..016','v1.0');
INSERT INTO "change_log" VALUES('CHG-1004','2026-09-23','Evidence','normalization','تطبيع 16 Claims إلى Evidence packets وربطها بالمصادر القائمة.','QA-017','v1.0');
INSERT INTO "change_log" VALUES('CHG-1005','2026-09-23','Publishing','scope','تثبيت نطاق v1.0: لا صور خارجية ولا نصوص أدبية كاملة ولا حدود سياسية تاريخية canonical.','release_scope','v1.0');
INSERT INTO "change_log" VALUES('CHG-1101','2026-09-23','Evidence','merge','إضافة جداول assertions (59) وattestations (122) وربط 9 إسنادات بادعاءات CLM-001 وATLAS-CLM01..03 (+8 ربط مصدر).','EVB→v1.1','v1.1');
INSERT INTO "change_log" VALUES('CHG-1102','2026-09-23','Gazetteer','merge','إضافة 21 مكانًا من الفرع مع أساس الإحداثيات؛ مطابقة 15 مكانًا مشتركًا في id_crosswalk.','EVB→v1.1','v1.1');
INSERT INTO "change_log" VALUES('CHG-1103','2026-09-23','Entities','merge','إضافة 38 شخصًا و8 كيانات سياسية وجداول periods/tenures/person_name_parts/historical_events.','EVB→v1.1','v1.1');
INSERT INTO "change_log" VALUES('CHG-1104','2026-09-23','Sources','fix','إزالة 96 رابطًا إلى نطاق ibntufayl.org المختطف من قاعدة المعرفة (v6.1).','hijacked-domain','v1.1');
INSERT INTO "change_log" VALUES('CHG-1201','2026-09-23','Evidence','add','إضافة 13 شاهدًا من المصادر الأولية (البيان المغرب، نفح الطيب، الإحاطة، جذوة المقتبس، الصلة) بقراءة مباشرة عبر وصلة الشاملة.','shamela.link','v1.2');
INSERT INTO "change_log" VALUES('CHG-1202','2026-09-23','Evidence','resolve','حسم خلاف 316/317هـ لإعلان الخلافة (AST-012/027) من البيان المغرب؛ توثيق الكنى (AST-017/019/021/023/G13) والميلادين (G16) وتصحيح ميلاد محمد الخامس إلى 1339 (G15).','shamela.link','v1.2');
INSERT INTO "change_log" VALUES('CHG-1203','2026-09-23','Evidence','reframe','وفاة ابن زمرك: المصدر الأولي يحدها ببعد 795هـ؛ 1393 حد أدنى لا تاريخ، و1395 تنتظر مصدرًا (AST-G17).','shamela.link','v1.2');
INSERT INTO "change_log" VALUES('CHG-1204','2026-09-23','Sources','add','إضافة المصادر الأولية LIB-PRI-036..039 وربط LIB-PRI-028 بنسخة الشاملة، مع حقوقها.','library-gap','v1.2');
INSERT INTO "change_log" VALUES('CHG-1205','2026-09-23','Evidence','verify','مطابقة 65 شاهدًا من دولة الإسلام في الأندلس (عنان) بأداة verify_quote: 58 حرفيًا، 5 بفروق إملائية أو تركيب أو ترقيم، 1 تصحيح موضع (ج1 ص482)، 1 نص مركّب مضلِّل (ATT-GB15) خُفّض إلى «يدعم جزئيًا».','shamela.link','v1.2');
INSERT INTO "change_log" VALUES('CHG-1206','2026-09-23','Evidence','finding','سنة 797هـ لوفاة ابن زمرك عند عنان تحيل إلى نفح الطيب، ونص النفح لا يذكرها.','shamela.link','v1.2');
INSERT INTO "change_log" VALUES('CHG-1207','2026-09-23','Evidence','verify','مطابقة 49 شاهدًا من المواقع (Met، UNESCO، MWNF، Britannica، الباترونato، مقال Shedet) بالصفحات الحية: 47 حرفيًا و2 بحذف مصرّح؛ وإضافة شاهد ATT-214 (الباترونato 1333–1394) يكشف تضارب المراجع الحديثة في وفاة ابن زمرك.','webfetch','v1.2');
INSERT INTO "change_log" VALUES('CHG-1208','2026-09-23','Evidence','add','إضافة 43 شاهدًا أوليًا (جذوة المقتبس، البيان المغرب، نفح الطيب، الإحاطة) لإسنادات كانت تعتمد على مراجع حديثة وحدها؛ كلها مطابقة حرفيًا بأداة verify_quote.','shamela.link','v1.2');
INSERT INTO "change_log" VALUES('CHG-1209','2026-09-23','Evidence','resolve','مولد يوسف الأول 1318 (AST-G14)؛ مولد محمد الأول 591هـ لا 595 (AST-G33 جديد)؛ وفاة المنصور 392هـ مع رواية 393 عند الحميدي ومولده 326–328هـ (AST-020)؛ وفاة محمد الأول يناير 1273 لا ديسمبر 1272.','shamela.link','v1.2');
INSERT INTO "change_log" VALUES('CHG-1210','2026-09-23','Evidence','add','شواهد أولية لمعركة طريف 741هـ (G21)، وسقوط جيان 643هـ (G20 جزئيًا)، وحدّي الإمارة/الخلافة 929 (AST-002/003).','shamela.link','v1.2');
INSERT INTO "change_log" VALUES('CHG-1211','2026-09-24','Evidence','add','أعمال الأعلام (ط2، دار المكشوف 1956) من صور أرشيف الإنترنت: نهاية الولاية الأولى لمحمد الخامس 28 رمضان 760هـ (AST-G06)، ومقدمة المحقق في مقتل ابن الخطيب بعد 776هـ (AST-G28 جزئيًا). إضافة المصدر LIB-PRI-040.','archive.org','v1.2');
INSERT INTO "change_log" VALUES('CHG-1212','2026-09-24','Evidence','add','شواهد أولية لمقتل ابن الخطيب من ابن خلدون («العبر» ج7 ص452–453، و«الرحلة» ص187) تحصر القتل بين مستهل 776هـ وشوالها (AST-G28)، ودخول البربر الزهراء أواخر ربيع الأول 401هـ من «أعمال الأعلام» ص117 (AST-015 جزئيًا). إضافة المصدرين LIB-PRI-041 وLIB-PRI-042.','shamela.link; archive.org','v1.2');
INSERT INTO "change_log" VALUES('CHG-1213','2026-09-24','Evidence','add','مرسوم 1502 (AST-G27): شاهدان من Ortego Rico 2011 (دراسة محكّمة) يحددان 12 فبراير 1502 ومضمون الأمر، فرُفعت الحالة إلى «موثّق». الشاهد الأولي ما زال مطلوبًا.','revistas.uned.es','v1.2');
INSERT INTO "change_log" VALUES('CHG-1214','2026-09-24','Evidence','add','مرسوم 1502 (AST-G27): شاهدان من Ladero Quesada، Andalucía a fines de la Edad Media (1999)، ص179 وص318–319 تقريبًا، يؤكدان 12 فبراير 1502. المصدر EXT-LADERO-1999 من نسخة PDF أرفقها المستخدم.','user upload','v1.2');
INSERT INTO "change_log" VALUES('CHG-1215','2026-09-24','Evidence','update','مواءمة: وفاة ابن الخطيب في AST-G16 وPER-018 وEVT-021 صارت 776هـ (1374/1375م) وفق AST-G28؛ وقيمة AST-G27 وEVT-020 صارت 12 فبراير 1502 بدقة اليوم.','internal consistency','v1.2');
INSERT INTO "change_log" VALUES('CHG-1216','2026-09-24','Evidence','update','خراب الزهراء (AST-015): صُحح من 1009–1010 إلى مرحلتين، 401هـ ثم الخراب التام في أيام المستكفي 414–416هـ، بشاهد «الذخيرة» ج1 ص436 و«الجذوة» ص26. الزهراوي (AST-022): لا نص أوليًا بسنة الوفاة، وأُضيفت شهادة ابن حزم وتقدير الزركلي 427هـ. ابن زمرك (G17): أُضيف تقدير الزركلي نحو 793هـ مخالفًا. المصادر: LIB-PRI-043 وLIB-PRI-044 وEXT-ZIRIKLI.','shamela.link','v1.2');
CREATE TABLE claim_entities (
  claim_id TEXT NOT NULL,
  entity_id TEXT NOT NULL,
  role TEXT,
  PRIMARY KEY (claim_id, entity_id, role),
  FOREIGN KEY(claim_id) REFERENCES claims(claim_id),
  FOREIGN KEY(entity_id) REFERENCES entities(entity_id)
);
INSERT INTO "claim_entities" VALUES('CLM-011','PLC-CORDOBA','context');
INSERT INTO "claim_entities" VALUES('SOC-CLM04','LANG-HEB','identity/language context');
INSERT INTO "claim_entities" VALUES('ARC-CLM05','PLC-PECHINA','site');
INSERT INTO "claim_entities" VALUES('ARC-CLM07','WRK-FUDALAT','primary source');
INSERT INTO "claim_entities" VALUES('ARC-CLM07','WRK-ANON-COOKBOOK','primary source');
INSERT INTO "claim_entities" VALUES('ARC-CLM07','PER-IBN-RAZIN','author');
INSERT INTO "claim_entities" VALUES('SOC-CLM07','PLC-LEON','place');
INSERT INTO "claim_entities" VALUES('SOC-CLM07','OBJ-LEON-ARCH','evidence object');
INSERT INTO "claim_entities" VALUES('SOC-CLM08','PLC-TOLEDO','place');
INSERT INTO "claim_entities" VALUES('SOC-CLM08','PER-GERARD-CREMONA','translator');
INSERT INTO "claim_entities" VALUES('SOC-CLM08','PER-GUNDISSALINUS','translator');
INSERT INTO "claim_entities" VALUES('SOC-CLM08','PER-ABRAHAM-IBN-DAUD','collaborator');
INSERT INTO "claim_entities" VALUES('SOC-CLM08','WRK-AVICENNA-DE-ANIMA','translated work');
INSERT INTO "claim_entities" VALUES('ARC-CLM09','PER-AL-JILYANI','traveller');
INSERT INTO "claim_entities" VALUES('ARC-CLM09','PLC-GRANADA','origin');
INSERT INTO "claim_entities" VALUES('ARC-CLM09','PLC-DAMASCUS','destination');
INSERT INTO "claim_entities" VALUES('ARC-CLM09','WRK-MANADIH','work');
INSERT INTO "claim_entities" VALUES('ARC-CLM09','PER-SALADIN','patron/addressee');
INSERT INTO "claim_entities" VALUES('CLM-003','LANG-AR-AND','language');
INSERT INTO "claim_entities" VALUES('CLM-003','LANG-ROM-AND','language');
INSERT INTO "claim_entities" VALUES('CLM-003','LANG-HEB','language');
INSERT INTO "claim_entities" VALUES('SOC-CLM10','PLC-MANISES','place');
INSERT INTO "claim_entities" VALUES('SOC-CLM10','OBJ-MANISES-LUSTER','material legacy');
INSERT INTO "claim_entities" VALUES('RUR-CLM03','PLC-ALMARIYYA','place');
INSERT INTO "claim_entities" VALUES('RUR-CLM04','PLC-SAQUNDA','place');
INSERT INTO "claim_entities" VALUES('ARC-CLM04','PLC-PECHINA','place');
INSERT INTO "claim_entities" VALUES('ARC-CLM05','PLC-PECHINA','place');
INSERT INTO "claim_entities" VALUES('ATLAS-CLM01','PLC-MADINAT-ZAHRA','site');
INSERT INTO "claim_entities" VALUES('ATLAS-CLM01','PLC-CORDOBA','political context');
INSERT INTO "claim_entities" VALUES('ATLAS-CLM02','PLC-CORDOBA-WH','site');
INSERT INTO "claim_entities" VALUES('ATLAS-CLM02','PLC-CORDOBA','city');
INSERT INTO "claim_entities" VALUES('ATLAS-CLM03','PLC-ALHAMBRA-WH','site');
INSERT INTO "claim_entities" VALUES('ATLAS-CLM03','PLC-GRANADA','city');
INSERT INTO "claim_entities" VALUES('ATLAS-CLM04','PLC-SEVILLE','city/site context');
CREATE TABLE claim_evidence (
  claim_id TEXT NOT NULL,
  evidence_id TEXT NOT NULL,
  relation TEXT,
  ordinal INTEGER NOT NULL DEFAULT 1,
  PRIMARY KEY (claim_id, evidence_id),
  FOREIGN KEY(claim_id) REFERENCES claims(claim_id),
  FOREIGN KEY(evidence_id) REFERENCES evidence(evidence_id)
);
INSERT INTO "claim_evidence" VALUES('CLM-011','EVD-FELUS-711','supports',1);
INSERT INTO "claim_evidence" VALUES('SOC-CLM04','EVD-JEWISH-MAT','supports',1);
INSERT INTO "claim_evidence" VALUES('ARC-CLM05','EVD-PECHINA-URBAN','supports',1);
INSERT INTO "claim_evidence" VALUES('ARC-CLM07','EVD-COOKBOOKS-13C','supports',1);
INSERT INTO "claim_evidence" VALUES('SOC-CLM07','EVD-LEON-ARCH','supports',1);
INSERT INTO "claim_evidence" VALUES('SOC-CLM08','EVD-TOLEDO-TRANS','supports',1);
INSERT INTO "claim_evidence" VALUES('ARC-CLM09','EVD-AMOI-JILYANI','supports',1);
INSERT INTO "claim_evidence" VALUES('CLM-003','EVD-KHARJAS-CS','supports',1);
INSERT INTO "claim_evidence" VALUES('SOC-CLM10','EVD-MANISES','supports',1);
INSERT INTO "claim_evidence" VALUES('ATLAS-CLM01','EVD-UNESCO-MADINAT','supports',1);
INSERT INTO "claim_evidence" VALUES('ATLAS-CLM02','EVD-UNESCO-CORDOBA','supports',1);
INSERT INTO "claim_evidence" VALUES('ATLAS-CLM03','EVD-UNESCO-GRANADA','supports',1);
INSERT INTO "claim_evidence" VALUES('ATLAS-CLM04','EVD-UNESCO-SEVILLE','supports',1);
INSERT INTO "claim_evidence" VALUES('ARC-CLM01','EVD-PKT-ARC-CLM01','verification packet',1);
INSERT INTO "claim_evidence" VALUES('ARC-CLM03','EVD-PKT-ARC-CLM03','verification packet',1);
INSERT INTO "claim_evidence" VALUES('ARC-CLM04','EVD-PKT-ARC-CLM04','verification packet',1);
INSERT INTO "claim_evidence" VALUES('CLM-001','EVD-PKT-CLM-001','verification packet',1);
INSERT INTO "claim_evidence" VALUES('CLM-002','EVD-PKT-CLM-002','verification packet',1);
INSERT INTO "claim_evidence" VALUES('CLM-010','EVD-PKT-CLM-010','verification packet',1);
INSERT INTO "claim_evidence" VALUES('CLM-018','EVD-PKT-CLM-018','verification packet',1);
INSERT INTO "claim_evidence" VALUES('CLM-MS01','EVD-PKT-CLM-MS01','verification packet',1);
INSERT INTO "claim_evidence" VALUES('CLM-MS02','EVD-PKT-CLM-MS02','verification packet',1);
INSERT INTO "claim_evidence" VALUES('RUR-CLM02','EVD-PKT-RUR-CLM02','verification packet',1);
INSERT INTO "claim_evidence" VALUES('RUR-CLM03','EVD-PKT-RUR-CLM03','verification packet',1);
INSERT INTO "claim_evidence" VALUES('RUR-CLM04','EVD-PKT-RUR-CLM04','verification packet',1);
INSERT INTO "claim_evidence" VALUES('RUR-CLM06','EVD-PKT-RUR-CLM06','verification packet',1);
INSERT INTO "claim_evidence" VALUES('SOC-CLM01','EVD-PKT-SOC-CLM01','verification packet',1);
INSERT INTO "claim_evidence" VALUES('SOC-CLM06','EVD-PKT-SOC-CLM06','verification packet',1);
INSERT INTO "claim_evidence" VALUES('SOC-CLM09','EVD-PKT-SOC-CLM09','verification packet',1);
CREATE TABLE claim_sources (
  claim_id TEXT NOT NULL,
  source_id TEXT NOT NULL,
  ordinal INTEGER NOT NULL DEFAULT 1,
  PRIMARY KEY (claim_id, source_id),
  FOREIGN KEY (claim_id) REFERENCES claims(claim_id),
  FOREIGN KEY (source_id) REFERENCES sources(source_id)
);
INSERT INTO "claim_sources" VALUES('CLM-001','SRC-326B573BBA',1);
INSERT INTO "claim_sources" VALUES('CLM-001','SRC-17A4D51B44',2);
INSERT INTO "claim_sources" VALUES('ARC-CLM01','SRC-1990D2E895',1);
INSERT INTO "claim_sources" VALUES('ARC-CLM03','SRC-3498AB3076',1);
INSERT INTO "claim_sources" VALUES('ARC-CLM03','SRC-F67E8CE018',2);
INSERT INTO "claim_sources" VALUES('RUR-CLM02','SRC-EF1A9587DD',1);
INSERT INTO "claim_sources" VALUES('RUR-CLM04','SRC-22B631316C',1);
INSERT INTO "claim_sources" VALUES('SOC-CLM01','SRC-CB6B8DB2B7',1);
INSERT INTO "claim_sources" VALUES('SOC-CLM01','SRC-C3E09140AE',2);
INSERT INTO "claim_sources" VALUES('CLM-002','SRC-FA9D2D9443',1);
INSERT INTO "claim_sources" VALUES('CLM-002','SRC-2CCB987052',2);
INSERT INTO "claim_sources" VALUES('CLM-010','SRC-1990D2E895',1);
INSERT INTO "claim_sources" VALUES('CLM-010','SRC-FA9D2D9443',2);
INSERT INTO "claim_sources" VALUES('SOC-CLM06','SRC-385ADC829F',1);
INSERT INTO "claim_sources" VALUES('SOC-CLM06','SRC-1D5FE1782E',2);
INSERT INTO "claim_sources" VALUES('RUR-CLM03','SRC-BDD32C0DDC',1);
INSERT INTO "claim_sources" VALUES('RUR-CLM03','SRC-DC54B5ACF6',2);
INSERT INTO "claim_sources" VALUES('ARC-CLM04','SRC-88C32727FD',1);
INSERT INTO "claim_sources" VALUES('SOC-CLM09','SRC-0DBB04D925',1);
INSERT INTO "claim_sources" VALUES('CLM-MS01','SRC-62278995F4',1);
INSERT INTO "claim_sources" VALUES('CLM-MS02','SRC-3D20624E74',1);
INSERT INTO "claim_sources" VALUES('RUR-CLM06','SRC-F86CF814B9',1);
INSERT INTO "claim_sources" VALUES('RUR-CLM06','SRC-13F0EF4EDE',2);
INSERT INTO "claim_sources" VALUES('CLM-018','SRC-C60B7F01E7',1);
INSERT INTO "claim_sources" VALUES('CLM-011','SRC-8585EF64FC',1);
INSERT INTO "claim_sources" VALUES('SOC-CLM04','SRC-08093EBC7F',1);
INSERT INTO "claim_sources" VALUES('SOC-CLM04','SRC-6A3B9BE444',2);
INSERT INTO "claim_sources" VALUES('ARC-CLM05','SRC-88C32727FD',1);
INSERT INTO "claim_sources" VALUES('ARC-CLM05','SRC-82E0C1DE51',2);
INSERT INTO "claim_sources" VALUES('ARC-CLM07','SRC-D8B41C5711',1);
INSERT INTO "claim_sources" VALUES('SOC-CLM07','SRC-94CFFFD3D1',1);
INSERT INTO "claim_sources" VALUES('SOC-CLM07','SRC-495A28E127',2);
INSERT INTO "claim_sources" VALUES('SOC-CLM08','SRC-E29AF5E30C',1);
INSERT INTO "claim_sources" VALUES('SOC-CLM08','SRC-4C230142FA',2);
INSERT INTO "claim_sources" VALUES('ARC-CLM09','SRC-9264D9F9B0',1);
INSERT INTO "claim_sources" VALUES('ARC-CLM09','SRC-0CD20155B6',2);
INSERT INTO "claim_sources" VALUES('CLM-003','SRC-B1CF443098',1);
INSERT INTO "claim_sources" VALUES('CLM-003','SRC-F0F86304B1',2);
INSERT INTO "claim_sources" VALUES('SOC-CLM10','SRC-2D2113D7F8',1);
INSERT INTO "claim_sources" VALUES('SOC-CLM10','SRC-D9F327E4FB',2);
INSERT INTO "claim_sources" VALUES('ATLAS-CLM01','SRC-FF27E1A80B',1);
INSERT INTO "claim_sources" VALUES('ATLAS-CLM02','SRC-B819B01BE2',1);
INSERT INTO "claim_sources" VALUES('ATLAS-CLM03','SRC-F650A5BEAE',1);
INSERT INTO "claim_sources" VALUES('ATLAS-CLM04','SRC-5CED25F7F5',1);
INSERT INTO "claim_sources" VALUES('CLM-001','LIB-BK-005',3);
INSERT INTO "claim_sources" VALUES('CLM-001','LIB-ART-029',4);
INSERT INTO "claim_sources" VALUES('CLM-001','EXT-MET-TOAH',5);
INSERT INTO "claim_sources" VALUES('CLM-001','SRC-B819B01BE2',6);
INSERT INTO "claim_sources" VALUES('ATLAS-CLM01','LIB-BK-005',2);
INSERT INTO "claim_sources" VALUES('ATLAS-CLM01','EXT-MWNF',3);
INSERT INTO "claim_sources" VALUES('ATLAS-CLM02','EXT-MET-TOAH',2);
INSERT INTO "claim_sources" VALUES('ATLAS-CLM03','EXT-PATRONATO',2);
CREATE TABLE claims (
  claim_id TEXT PRIMARY KEY,
  original_claim TEXT,
  verdict TEXT NOT NULL,
  canonical_wording_ar TEXT NOT NULL,
  evidence_type TEXT,
  evidence_relation TEXT,
  confidence TEXT,
  status TEXT,
  last_verified TEXT,
  version TEXT
);
INSERT INTO "claims" VALUES('CLM-001','عبد الرحمن الثالث أعلن الخلافة سنة 929م','مقبول','أعلن عبد الرحمن الثالث نفسه خليفة في 16 يناير 929م؛ وتظهر النقود المعاصرة التحول في الألقاب والسيادة.','نص/وثيقة دبلوماسية مدروسة + نقد','مستقلان نسبيًا','عالٍ جدًا','مغلق','2026-09-23','5.4');
INSERT INTO "claims" VALUES('ARC-CLM01','Tossal de la Vila وEl Molón من أقدم المساجد الأندلسية','مقبول مع ضبط','هما من أقدم أمثلة دور العبادة الإسلامية المؤرخة أثريًا في شبه الجزيرة، ويرجح بناؤهما في العقود الوسطى من القرن الثامن.','حفر + C14 + تحليل معماري','دليل مادي مباشر','عالٍ','مغلق','2026-09-23','5.4');
INSERT INTO "claims" VALUES('ARC-CLM03','بذور الدخن اللؤلؤي في بايرين هي أقدم دليل معروف في الأندلس حتى 2026','مقبول مؤقتًا/حساس للتحديث','تصف EEA بذرتين مؤرختين بالنصف الأول من القرن 11 بأنها أقدم دليل معروف حتى يونيو 2026 في الأندلس؛ لكن أدبيات 2023 سجلت الدخن اللؤلؤي في سياقات إسلامية إيبيرية من 11–12م، لذا تبقى أولوية بايرين قابلة للمراجعة عند نشر الدراسة التفصيلية.','C14 + archaeobotany + مقارنة أدبيات','يوجد تداخل زمني/أولوية تحتاج نشرًا تفصيليًا','متوسط-عالٍ','مفتوح للمراجعة','2026-09-23','5.4');
INSERT INTO "claims" VALUES('RUR-CLM02','أدوار النساء الإنتاجية والرعائية في Xaresa أكثر تداخلًا من التقسيم الحديث الصلب','مقبول مع قيد','تشير الدراسة osteoarchaeological لعينة من 35 هيكلًا من Xaresa إلى مرونة في توزيع العمل وأهمية أعمال الصيانة والرعاية، ولا يجوز تعميمها على كل نساء الأندلس.','Osteoarchaeology + isotopes + gender analysis','دليل مادي مع تفسير اجتماعي','عالٍ','مغلق بصياغة مقيدة','2026-09-23','5.4');
INSERT INTO "claims" VALUES('RUR-CLM04','Šaqunda سجل أثري استثنائي لقرطبة الأموية المبكرة 750–818م','مقبول','الحفر الواسع لنحو 22,000م² والمؤرخ 750–818م يوفر سجلًا مباشرًا للتخطيط الحضري والثقافة المادية والحياة اليومية قبل تدمير الربض.','حفر واسع + مواد + chronology','دليل مادي مباشر','عالٍ','مغلق','2026-09-23','5.4');
INSERT INTO "claims" VALUES('SOC-CLM01','الأندلس ليست نموذج انسجام ديني دائم ولا صراع دائم','مقبول كقاعدة تحرير','العلاقات بين المسلمين والمسيحيين واليهود كانت متغيرة زمانيًا ومكانيًا ومؤسسيًا؛ التعاون والتداخل والتوتر والتراتبية كلها موثقة، لذلك تُرفض السردية الأحادية.','Historiography + legal/social history + museum synthesis','مصادر تفسيرية مستقلة ومتوافقة','عالٍ','مغلق كقاعدة تحرير','2026-09-23','5.4');
INSERT INTO "claims" VALUES('CLM-002','طارق بن زياد أحرق السفن عند فتح الأندلس','غير مثبت/لا ينشر كحقيقة','لا يوجد ما يكفي لنشر حرق السفن كواقعة ثابتة. الرواية تظهر في تقاليد متأخرة، والبحث الحديث يتعامل معها كأسطورة/رواية موضع شك.','Source genealogy + modern historiography','التقليد متأخر قرونًا عن 711','متوسط-عالٍ','مغلق — Myth','2026-09-23','5.4');
INSERT INTO "claims" VALUES('CLM-010','فتح الأندلس يحتاج موازنة النصوص المتأخرة بالمصادر المادية','مقبول','يُعتمد منهجيًا على الجمع بين النقد والأختام والآثار والنصوص لأن جزءًا كبيرًا من الروايات المكتوبة عن الفتح متأخر زمنيًا، كما يظهر بوضوح في دراسة المساجد المبكرة وفي تقليد حرق السفن.','Archaeology + source criticism','مصادر منهجية متقاطعة','عالٍ','مغلق كقاعدة منهجية','2026-09-23','5.4');
INSERT INTO "claims" VALUES('SOC-CLM06','صبح مثال موثق على أن بعض نساء القصر المسترقات استطعن بلوغ نفوذ سياسي كبير','مقبول مع قيد الحالة','صبح (940–999م) حالة استثنائية موثقة لامرأة من أصل مسترق وصلت إلى مكانة سياسية وثقافية بارزة في البلاط الأموي؛ يثبت نقش بُرطمانها العاجي سنة 964م صلتها المباشرة بالبلاط، وتعرض المصادر المتحفية دورها اللاحق بوصفها sayyida وفاعلة في القرار السياسي. لا تعمم حالتها على وضع النساء كله.','قطعة منقوشة مؤرخة + توليف متحفي قائم على المصادر','قطعة أصلية + تفسير تاريخي مؤسسي متوافقان','عالٍ','مغلق بصياغة مقيدة','2026-09-23','5.5');
INSERT INTO "claims" VALUES('RUR-CLM03','كان حي al-Mariyya جزءًا من مدينة ذات اتصال تجاري واسع وبنية مينائية وصناعة نسيجية قوية','مقبول','يكشف الحي الأندلسي المحفوظ عند سفح قصبة ألمرية، مع دراسات مشروع GLOBALM، عن مدينة ذات نشاط إنتاجي وتجاري واسع ارتكز على بنية مينائية وصناعة نسيجية واتصالات قوية؛ ويُعرض هذا بوصفه استنتاجًا من الحي والثقافة المادية والبحث متعدد التخصصات.','حفر معماري + ثقافة مادية + بحث متعدد التخصصات','مصدران مؤسسيان يصفان المشروع نفسه من زاويتين متوافقتين','عالٍ','مغلق بصياغة مقيدة','2026-09-23','5.5');
INSERT INTO "claims" VALUES('ARC-CLM04','كان في بَجّانة مركز متخصص لإنتاج الخزف المزجج في النصف الثاني من القرن التاسع','مقبول','توثق حفريات بَجّانة/پتشينة فرنًا متخصصًا لإنتاج الخزف المزجج عمل في النصف الثاني من القرن التاسع، ثم أُهمل وحل فوقه/بعده حي إسلامي يضم مساكن وشوارع ومحلات وورش.','حفر أثري + علم مواد + نشر جماعي','دليل أثري منشور مؤسسيًا','عالٍ','مغلق','2026-09-23','5.5');
INSERT INTO "claims" VALUES('SOC-CLM09','النقد كان جزءًا واسع الاستخدام من الاقتصاد الأندلسي، مع وظائف ضريبية وتجارية ويومية وتداول خارجي','مقبول مع نطاق','تشير مادة MAN إلى استخدام واسع للنقد في الأندلس في الضرائب والجيش والتجارة والمعاملات اليومية، وإلى تداول الدراهم خارج الأندلس؛ وتُفصل كثافة الاستخدام ومسارات التداول لاحقًا بحسب الفترة والمنطقة.','نقد أصلي + توليف متحفي اقتصادي','دليل مادي مع تفسير مؤسسي','عالٍ','مغلق مع قيد زمني/مكاني','2026-09-23','5.5');
INSERT INTO "claims" VALUES('CLM-MS01','مخطوط ابن ليون 1348 شاهد أولي فريد للزراعة الأندلسية المتأخرة','مقبول','مخطوط ابن ليون الزراعي، المؤلف سنة 1348م والمحفوظ في EEA-CSIC، واحد من خمس نسخ باقية، وهو بحسب EEA النسخة الوحيدة الكاملة والوحيدة التي تحتوي حواشي هامشية؛ لذلك يُعامل بوصفه شاهدًا أوليًا مهمًا على المعرفة الزراعية الأندلسية المتأخرة.','مخطوط + فهرسة وحفظ مؤسسي','مصدر حفظ مباشر','عالٍ جدًا','مغلق','2026-09-23','5.5');
INSERT INTO "claims" VALUES('CLM-MS02','مكتبة EEA تحتوي 130 عملًا عربيًا مخطوطًا في 75 مجلدًا، إضافة إلى كودكس عبري و31 وثيقة عربية غرناطية ومغربية','مقبول ومؤرخ','بحسب بيانات EEA المحدثة في 26 مايو 2026، تضم المجموعة 130 عملًا عربيًا مخطوطًا في 75 مجلدًا، وكودكسًا عبريًا يضم 9 أعمال، و31 وثيقة عربية غرناطية ومغربية، و8 مخطوطات قشتالية. تُحفظ الأرقام مع تاريخ التحقق لأنها قابلة للتغير.','بيانات مجموعة مؤسسية','بيانات مباشرة من مؤسسة الحفظ','عالٍ جدًا','مغلق/حساس للتحديث الدوري','2026-09-23','5.5');
INSERT INTO "claims" VALUES('RUR-CLM06','PUA وHATA يجب أن يشكلا العمود الفقري لاستيراد الأشخاص والأعمال وشبكات النقل الفكري','مقبول كقرار بنيوي','تُعتمد PUA كمصدر أساسي للأشخاص لأنها تضم أكثر من 11,600 شخصية من معاجم التراجم الأندلسية، ويُعتمد HATA للأعمال المؤلفة والمنقولة في الأندلس بين القرنين الثامن والخامس عشر؛ ويستخدم AMOI الربط بين HATA وPUA أساسًا لدراسة انتقال المعرفة.','قواعد بيانات بحثية + وصف مشروع رقمي','موارد مترابطة مؤسسيًا','عالٍ','مغلق/Architecture','2026-09-23','5.5');
INSERT INTO "claims" VALUES('CLM-018','أخبار مجموعة مصدر معاصر مباشر لفتح الأندلس','مرفوض كصياغة','لا تُعامل أخبار مجموعة بوصفها شاهدًا معاصرًا مباشرًا لفتح الأندلس؛ يبين تحليل لويس مولينا أن رواية فتح محددة فيها ترجع إلى أحمد الرازي في القرن العاشر، وأن الكتاب تركيب من مواد تاريخية أقدم لا من مواد تأريخية من الدرجة الأولى.','نقد مصادر + تتبع اعتماد نصي','دراسة مباشرة لسلسلة نقل رواية الفتح','عالٍ','مغلق — Source genealogy','2026-09-23','5.5');
INSERT INTO "claims" VALUES('CLM-011','الفلوس والأختام مصادر أساسية لفهم مسارات الضم والجباية المبكرة','مقبول مع قيد نوع الدليل','تُعد الفلوس والأختام/الـprecintos من أهم المصادر المادية لفهم تشكّل الأندلس في القرنين الثامن والتاسع؛ فالفلوس تقدم قرائن على مسارات الفتح والضم والاستيطان والتبادل، بينما توثق الأختام جوانب من مواثيق الضم والجباية وتقسيم الأراضي. تُربط الاستنتاجات التفصيلية بكل قطعة وسياقها، ولا تُحوَّل هذه القرائن إلى خريطة يقينية شاملة دون تحليل فردي.','Numismatics + seals/precintos + contextual archaeology','أدلة مادية مباشرة؛ التفسير المكاني يحتاج corpus فرديًا','عالٍ','مغلق بصياغة مقيدة','2026-09-23','v5.6');
INSERT INTO "claims" VALUES('SOC-CLM04','جزء كبير من الثقافة المادية اليهودية اليومية قد يكون غير قابل للتمييز أسلوبيًا دون كتابة أو سياق أثري','مقبول','لا يجوز نسبة قطعة من إيبيريا الوسيطة إلى هوية يهودية اعتمادًا على الأسلوب وحده؛ فمواد كثيرة من الحياة اليومية اليهودية تشارك الأشكال والتقنيات المحيطة بها، ويكتسب النقش أو السياق الأثري أو تاريخ الاستعمال أهمية حاسمة في الإسناد.','Museum synthesis + inscribed/bilingual objects + contextual archaeology','أمثلة مادية متعددة مع قاعدة منهجية صريحة','عالٍ','مغلق كقاعدة وصف','2026-09-23','v5.6');
INSERT INTO "claims" VALUES('ARC-CLM05','يكشف حي بَجّانة عن مساكن وشوارع ومحلات وورش تساعد على إعادة بناء الحياة الحضرية اليومية','مقبول','توثق حفريات بَجّانة/پتشينة حيًا إسلاميًا يضم مساكن وشوارع ومحلات وورشًا، تعاقب على منطقة إنتاج خزف مزجج من القرن التاسع؛ ويُستخدم هذا السياق لإعادة بناء الحرف والتجارة والتنظيم الحضري والحياة اليومية في المدينة الأموية مع عدم تعميمه آليًا على بقية مدن الأندلس.','Urban archaeology + material culture + monograph','مصدر مؤسسي + مونوجراف أكاديمي متوافقان','عالٍ','مغلق','2026-09-23','v5.6');
INSERT INTO "claims" VALUES('ARC-CLM07','مصادر الطبخ الأندلسية الباقية قليلة؛ ومن أهمها كتاب مجهول وFuḍālat al-jiwān في القرن الثالث عشر','مقبول مع قيد تمثيل المجتمع','المعرفة المباشرة بالطبخ الأندلسي تعتمد على عدد محدود من المخطوطات؛ ومن أبرز مصادر القرن الثالث عشر كتاب طبخ أندلسي-مغاربي مجهول وFuḍālat al-jiwān لابن رزين التجيبي. يوثقان وصفات وتقنيات وعادات مائدة وصلات ثقافية مع المغرب، لكن لا يُفترَض أنهما يمثلان غذاء جميع الطبقات الاجتماعية.','Primary culinary texts + curated bibliographic synthesis','مصدران أوليان مستقلان نسبيًا يجتمعان في الموضوع','عالٍ','مغلق بصياغة مقيدة','2026-09-23','v5.6');
INSERT INTO "claims" VALUES('SOC-CLM07','تقاليد زخرفية أندلسية أصبحت جزءًا من بعض ثقافات البلاط المسيحي في قشتالة أواخر العصور الوسطى','مقبول','بحلول أواخر القرن الرابع عشر كانت عناصر معمارية وزخرفية ذات تقاليد أندلسية قد أصبحت جزءًا مستقرًا من صورة بعض البلاطات القشتالية، كما يظهر في قوس قصر ملوك ليون؛ لذلك لا تُفسر كل حالة بوصفها اقتباسًا مباشرًا آنيًا من غرناطة، بل ضمن ثقافات بلاطية مشتركة ومتراكمة، مع بقاء فروق واضحة بين البلاطات.','Architecture + epigraphy + comparative court material culture','قطعة/عمارة مؤرخة + مقارنة مؤسسية','عالٍ','مغلق','2026-09-23','v5.6');
INSERT INTO "claims" VALUES('SOC-CLM08','ترجمة المعرفة في القرن الثاني عشر بإيبيريا تضمنت تعاون علماء من خلفيات دينية مختلفة','مقبول مع ضبط الأسماء','كانت طليطلة في النصف الثاني من القرن الثاني عشر مركزًا رئيسيًا للترجمة من العربية إلى اللاتينية، وتوثق الدراسات تعاون مترجمين من خلفيات مختلفة. من أمثلته عمل دومينيكوس غونديسالينوس مع Avendauth، الذي ترجح دراسات معتبرة هويته مع الفيلسوف اليهودي إبراهيم بن داود، إلى جانب نشاط جيرارد الكريموني الواسع. تُذكر مواضع الخلاف في تحديد هويات بعض المترجمين ولا تُعرض «مدرسة طليطلة» كتنظيم موحد ثابت.','History of translation + manuscript paratexts + modern critical scholarship','دراسات مستقلة متوافقة مع تحفظ في هوية Avendauth','متوسط-عالٍ','مغلق مع ملاحظة خلاف','2026-09-23','v5.6');
INSERT INTO "claims" VALUES('ARC-CLM09','انتقلت معارف وأشخاص من الأندلس إلى المشرق بين القرنين الحادي عشر والخامس عشر','مقبول','توثق أبحاث AMOI-II انتقال أشخاص ونصوص وأفكار من الأندلس والمغرب إلى المشرق بين القرنين الحادي عشر والخامس عشر. من الحالات المعروضة الشاعر الغرناطي الجِلياني، الذي انتهت حياته في دمشق سنة 1206 ووجّه عمله Manādiḥ al-mamādiḥ إلى صلاح الدين. تُبنى خريطة الأطلس على مسارات أفراد وأعمال محددة بدل سهم عام «الغرب→الشرق».','Research project + case studies + historiography','مشروع بحثي مؤسسي مع حالة فردية قابلة للنمذجة','عالٍ','مغلق مع استمرار Population للمسارات','2026-09-23','v5.6');
INSERT INTO "claims" VALUES('CLM-003','المجتمع الأندلسي كان متعدد اللغات ويظهر تماسًا بين العربية والرومانسية والعبرية','مقبول مع ضبط زمني واجتماعي','كان المشهد اللغوي في الأندلس متغيرًا ومتعدد الطبقات، وشمل العربية والرومانسية الأندلسية والعبرية في أدوار وسجلات تختلف بحسب الزمن والجماعة والمجال. وتقدم الخرجات العربية-الرومانسية دليلًا مباشرًا على التماس والتبديل اللغوي؛ فلا تُحوَّل «التعددية اللغوية» إلى افتراض أن جميع السكان كانوا متعددي اللغات بالدرجة نفسها.','Historical sociolinguistics + literary corpus + code-switching analysis','توليف أكاديمي + corpus كمي مباشر','عالٍ','مغلق بصياغة مقيدة','2026-09-23','v5.6');
INSERT INTO "claims" VALUES('SOC-CLM10','Manises كامتداد أندلسي بعد التحول السياسي','مقبول كطبقة إرث لا كجزء من الدولة الأندلسية','يمثل خزف البريق المعدني في مانيسس خلال القرنين الرابع عشر والخامس عشر امتدادًا تقنيًا وفنيًا قويًا لتقاليد أندلسية/نصرية داخل بيئة سياسية مسيحية، مع حضور حرفيين مسلمين وخدمة جماعات دينية متعددة. لذلك يُعرض في الأطلس ضمن «الإرث والتحولات بعد انتقال السلطة»، لا بوصفه جزءًا سياسيًا من الأندلس.','Craft history + museum objects + documentary synthesis','أدلة مادية + تفسير مؤسسي','عالٍ','مغلق/Legacy','2026-09-23','v5.6');
INSERT INTO "claims" VALUES('ATLAS-CLM01','مدينة الزهراء مقر خلافة قرطبة في القرن العاشر','مقبول','تصف UNESCO مدينة الزهراء بأنها مدينة جديدة شيدها الأمويون في منتصف القرن العاشر لتكون مقر خلافة قرطبة، ثم دُمّرت في الحرب الأهلية سنة 1009–1010؛ ويحفظ الموقع بنية حضرية تشمل الطرق والجسور والمياه والمباني والأشياء اليومية.','UNESCO heritage site + archaeology','وصف مؤسسي مباشر للموقع','عالٍ جدًا','مغلق','2026-09-23','v5.8');
INSERT INTO "claims" VALUES('ATLAS-CLM02','وسط قرطبة التاريخي شاهد على الخلافة والجامع الكبير','مقبول','يعد وسط قرطبة التاريخي شاهدًا رئيسيًا على ازدهار المدينة في العصر الإسلامي؛ وتذكر UNESCO أن الجامع الكبير بُني في القرن الثامن فوق بقايا بازيليكا قوطية وتوسع على امتداد ثلاثة قرون.','UNESCO heritage synthesis','وصف مؤسسي للموقع والعمارة','عالٍ جدًا','مغلق','2026-09-23','v5.8');
INSERT INTO "claims" VALUES('ATLAS-CLM03','الحمراء والبيازين وجنة العريف تمثل القلب الوسيط لغرناطة','مقبول','تصف UNESCO الحمراء والبيازين بأنهما يشكلان الجزء الوسيط من غرناطة، وتصف جنة العريف بأنها مقر ريفي للأمراء في القرنين الثالث عشر والرابع عشر؛ ويُعامل العقار المركب كوحدة تراثية مع الحفاظ على تمييز مكوناته.','UNESCO heritage synthesis','وصف مؤسسي مباشر للعقار المركب','عالٍ جدًا','مغلق','2026-09-23','v5.8');
INSERT INTO "claims" VALUES('ATLAS-CLM04','إشبيلية تحفظ طبقات معمارية أندلسية مهمة في القصر والجيرالدا.','مقبول','يحفظ مجمع إشبيلية طبقات مادية أندلسية بارزة: تذكر UNESCO أن النواة الأصلية للقصر شُيدت في القرن العاشر مقرًا للحاكم المسلم، وأن أجزاءً من القصر الموحدي باقية، بينما كانت الجيرالدا مئذنة للمسجد وتعد تحفة من العمارة الموحدية؛ وتُقرأ هذه العناصر أيضًا ضمن تاريخ إعادة الاستخدام والتحول بعد 1248م.','UNESCO heritage synthesis + architecture','وصف مؤسسي مباشر للموقع ومراحله المعمارية','عالٍ جدًا','مغلق','2026-09-23','v5.9');
CREATE TABLE entities (
  entity_id TEXT PRIMARY KEY,
  entity_type TEXT NOT NULL,
  preferred_name_ar TEXT,
  preferred_name_latn TEXT,
  start_date TEXT,
  end_date TEXT,
  notes TEXT
);
INSERT INTO "entities" VALUES('PER-SUBH','Person','صبح','Subh','0940','0999','أم هشام الثاني؛ حالة موثقة من نساء البلاط الأموي.');
INSERT INTO "entities" VALUES('PER-ALHAKAM-II','Person','الحكم المستنصر بالله','al-Hakam II','0915','0976','خليفة أموي بقرطبة؛ أمر بصنع بُرطمان صبح.');
INSERT INTO "entities" VALUES('PER-HISHAM-II','Person','هشام المؤيد بالله','Hisham II',NULL,NULL,'ابن صبح والحكم الثاني.');
INSERT INTO "entities" VALUES('PER-IBN-LUYUN','Person','ابن ليون','Ibn Luyun',NULL,NULL,'مؤلف رسالة الزراعة المؤلفة سنة 1348م.');
INSERT INTO "entities" VALUES('PLC-CORDOBA','Place','قرطبة','Córdoba',NULL,NULL,'عاصمة أموية وموقع سياقات عدة في القاعدة.');
INSERT INTO "entities" VALUES('PLC-ALMARIYYA','Place','ألمرية','Almería / al-Mariyya',NULL,NULL,'مدينة مينائية وصناعية؛ GLOBALM.');
INSERT INTO "entities" VALUES('PLC-PECHINA','Place','بَجّانة','Pechina / Baŷŷāna',NULL,NULL,'مركز خزف مزجج وحي حضري مبكر.');
INSERT INTO "entities" VALUES('PLC-XERESA','Place','خيريسة/شيريسا','Xeresa / Xaresa',NULL,NULL,'مقبرة/مجتمع فلاحي موضوع دراسة osteoarchaeology.');
INSERT INTO "entities" VALUES('PLC-SAQUNDA','Place','شقندة/الربض','Šaqunda, Córdoba','0750','0818','ربض قرطبي مؤرخ أثريًا حتى تدميره سنة 818م.');
INSERT INTO "entities" VALUES('WRK-IBN-LUYUN-AGRI','Work','كتاب إبداء الملاحة وإنهاء الرجاحة في أصول صناعة الفلاحة','Kitab ibda'' al-malaha...','1348',NULL,'عمل زراعي أندلسي متأخر.');
INSERT INTO "entities" VALUES('MS-IBN-LUYUN-EEA','Manuscript','مخطوط ابن ليون الزراعي في EEA','Ibn Luyun agricultural manuscript (EEA)',NULL,NULL,'النسخة الكاملة الوحيدة بحسب EEA؛ تحتوي حواشي هامشية.');
INSERT INTO "entities" VALUES('OBJ-SUBH-PYXIS','Object','بُرطمان/علبة صبح العاجية','Subh pyxis','0964',NULL,'قطعة عاجية من ورش مدينة الزهراء، تحمل نقشًا مؤرخًا.');
INSERT INTO "entities" VALUES('RES-PUA','DigitalResource','بروسوبوغرافيا علماء الأندلس','PUA',NULL,NULL,'أكثر من 11,600 شخصية وفق CSIC.');
INSERT INTO "entities" VALUES('RES-HATA','DigitalResource','تاريخ مؤلفي وناقلي الأندلس','HATA',NULL,NULL,'أعمال مؤلفة ومنقولة في الأندلس من القرن 8 إلى 15.');
INSERT INTO "entities" VALUES('RES-AMOI','DigitalResource','الأندلس والمغرب في المشرق الإسلامي','AMOI',NULL,NULL,'مشروع انتقال المعرفة المبني على HATA والربط مع PUA.');
INSERT INTO "entities" VALUES('PLC-TOLEDO','Place','طليطلة','Toledo',NULL,NULL,'مركز رئيسي للترجمة العربية-اللاتينية في القرن 12.');
INSERT INTO "entities" VALUES('PER-GERARD-CREMONA','Person','جيرارد الكريموني','Gerard of Cremona','1114','1187','مترجم بارز من العربية إلى اللاتينية، نشط في طليطلة.');
INSERT INTO "entities" VALUES('PER-GUNDISSALINUS','Person','دومينيكوس غونديسالينوس','Dominicus Gundissalinus','1115','1190?','فيلسوف ومترجم نشط في طليطلة؛ التواريخ تقريبية.');
INSERT INTO "entities" VALUES('PER-ABRAHAM-IBN-DAUD','Person','إبراهيم بن داود','Abraham ibn Daud','1110?','1180?','فيلسوف يهودي أندلسي؛ ترجح دراسات هويته مع Avendauth مع بقاء نقاش.');
INSERT INTO "entities" VALUES('WRK-AVICENNA-DE-ANIMA','Work','كتاب النفس لابن سينا / الترجمة اللاتينية','Avicenna De anima / Latin translation',NULL,NULL,'مثال على سلسلة نقل عربية→لاتينية في طليطلة.');
INSERT INTO "entities" VALUES('PER-AL-JILYANI','Person','الجِلياني','al-Jilyani',NULL,'1206','شاعر غرناطي؛ توفي في دمشق بحسب AMOI-II case study.');
INSERT INTO "entities" VALUES('PLC-GRANADA','Place','غرناطة','Granada',NULL,NULL,'مدينة أندلسية؛ نقطة منشأ لمسار الجِلياني.');
INSERT INTO "entities" VALUES('PLC-DAMASCUS','Place','دمشق','Damascus',NULL,NULL,'محطة شرقية في شبكات انتقال الأندلسيين.');
INSERT INTO "entities" VALUES('WRK-MANADIH','Work','مناديح المماديح','Manadih al-mamadih',NULL,NULL,'عمل للجِلياني مرتبط بمدائح صلاح الدين.');
INSERT INTO "entities" VALUES('PER-SALADIN','Person','صلاح الدين الأيوبي','Saladin','1137?','1193','سلطان أيوبي؛ متلقٍ/موضوع عمل الجِلياني في الحالة المعروضة.');
INSERT INTO "entities" VALUES('PER-IBN-RAZIN','Person','ابن رزين التجيبي','Ibn Razin al-Tujibi',NULL,NULL,'مؤلف Fuḍālat al-jiwān؛ من مرسية.');
INSERT INTO "entities" VALUES('WRK-FUDALAT','Work','فضالة الخوان في طيبات الطعام والألوان','Fudalat al-jiwan','13c',NULL,'كتاب طبخ أندلسي من القرن 13.');
INSERT INTO "entities" VALUES('WRK-ANON-COOKBOOK','Work','كتاب الطبخ الأندلسي-المغاربي المجهول','Anonymous Hispano-Maghribi cookbook','13c',NULL,'مصدر أولي للطبخ في العصر الموحدي/الغرب الإسلامي.');
INSERT INTO "entities" VALUES('PLC-LEON','Place','ليون','León',NULL,NULL,'موقع قصر ملوك ليون ذي القوس المزخرف بتقاليد أندلسية.');
INSERT INTO "entities" VALUES('OBJ-LEON-ARCH','Object','قوس قصر ملوك ليون','Arch from Palace of the Kings of León','1370s',NULL,'مثال على ثقافة بلاطية مشتركة في أواخر القرن 14.');
INSERT INTO "entities" VALUES('PLC-MANISES','Place','مانيسس','Manises',NULL,NULL,'مركز خزف بريق معدني في بلنسية بعد انتقال السلطة.');
INSERT INTO "entities" VALUES('OBJ-MANISES-LUSTER','Object','خزف البريق المعدني في مانيسس','Manises lustreware','14c','15c','امتداد تقني وفني لتقاليد نصرية/أندلسية في بيئة مسيحية.');
INSERT INTO "entities" VALUES('LANG-AR-AND','Language','العربية الأندلسية','Andalusi Arabic',NULL,NULL,'سجل لغوي تاريخي في الأندلس.');
INSERT INTO "entities" VALUES('LANG-ROM-AND','Language','الرومانسية الأندلسية','Andalusi Romance',NULL,NULL,'مجموعة تنوعات رومانسية في الأندلس.');
INSERT INTO "entities" VALUES('LANG-HEB','Language','العبرية','Hebrew',NULL,NULL,'لغة دينية/أدبية وثقافية مهمة في المجتمع اليهودي الأندلسي.');
INSERT INTO "entities" VALUES('PLC-BAIREN','Place','بايرين','Bairén / Gandia',NULL,NULL,'حصن أندلسي قرب Gandia؛ الإحداثية الحالية مرساة بلدية وليست موضع الحصن الدقيق.');
INSERT INTO "entities" VALUES('PLC-EL-MOLON','Place','المولون','El Molón / Camporrobles',NULL,NULL,'موقع أثري مبكر؛ الإحداثية الحالية مرساة Camporrobles وليست نقطة الحفر.');
INSERT INTO "entities" VALUES('PLC-TOSSAL-VILA','Place','توسال دي لا فيلا','El Tossal de la Vila',NULL,NULL,'موقع أثري مبكر؛ الإحداثية الحالية مرساة Sierra Engarcerán وليست نقطة الحفر.');
INSERT INTO "entities" VALUES('PLC-MADINAT-ZAHRA','Place','مدينة الزهراء','Medina Azahara',NULL,NULL,'مدينة خلافية أموية؛ إحداثية UNESCO مرجع للعقار لا مضلعًا للحدود.');
INSERT INTO "entities" VALUES('PLC-CORDOBA-WH','Place','وسط قرطبة التاريخي','Historic Centre of Cordoba',NULL,NULL,'عقار تراث عالمي؛ نقطة UNESCO مرجع تمثيلي.');
INSERT INTO "entities" VALUES('PLC-ALHAMBRA-WH','Place','الحمراء وجنة العريف والبيازين','Alhambra, Generalife and Albayzín',NULL,NULL,'عقار مركب في غرناطة؛ نقطة UNESCO مرجع للعقار ككل.');
INSERT INTO "entities" VALUES('PLC-SEVILLE','Place','إشبيلية','Seville',NULL,NULL,'مرساة جغرافية لتوسيع Gazetteer؛ لا يثبت هذا السجل وحده الدور التاريخي للمدينة.');
INSERT INTO "entities" VALUES('PLC-ZARAGOZA','Place','سرقسطة','Zaragoza',NULL,NULL,'مرساة جغرافية لتوسيع Gazetteer؛ لا يثبت هذا السجل وحده الدور التاريخي للمدينة.');
INSERT INTO "entities" VALUES('PLC-VALENCIA','Place','بلنسية','Valencia',NULL,NULL,'مرساة جغرافية لتوسيع Gazetteer؛ لا يثبت هذا السجل وحده الدور التاريخي للمدينة.');
INSERT INTO "entities" VALUES('PLC-MALAGA','Place','مالقة','Málaga',NULL,NULL,'مرساة جغرافية لتوسيع Gazetteer؛ لا يثبت هذا السجل وحده الدور التاريخي للمدينة.');
INSERT INTO "entities" VALUES('PLC-MURCIA','Place','مرسية','Murcia',NULL,NULL,'مرساة جغرافية لتوسيع Gazetteer؛ لا يثبت هذا السجل وحده الدور التاريخي للمدينة.');
INSERT INTO "entities" VALUES('PLC-PALMA','Place','مدينة ميورقة/بالما','Palma / Madina Mayurqa',NULL,NULL,'مرساة جغرافية لتوسيع Gazetteer؛ لا يثبت هذا السجل وحده الدور التاريخي للمدينة.');
INSERT INTO "entities" VALUES('PLC-ALICANTE','Place','لقنت/أليكانتي','Alicante',NULL,NULL,'مرساة جغرافية لتوسيع Gazetteer؛ لا يثبت هذا السجل وحده الدور التاريخي للمدينة.');
INSERT INTO "entities" VALUES('PLC-BADAJOZ','Place','بطليوس','Badajoz',NULL,NULL,'مرساة جغرافية لتوسيع Gazetteer؛ لا يثبت هذا السجل وحده الدور التاريخي للمدينة.');
INSERT INTO "entities" VALUES('PLC-RONDA','Place','رندة','Ronda',NULL,NULL,'مرساة جغرافية لتوسيع Gazetteer؛ لا يثبت هذا السجل وحده الدور التاريخي للمدينة.');
INSERT INTO "entities" VALUES('PLC-JAEN','Place','جيّان','Jaén',NULL,NULL,'مرساة جغرافية لتوسيع Gazetteer؛ لا يثبت هذا السجل وحده الدور التاريخي للمدينة.');
INSERT INTO "entities" VALUES('PLC-HUELVA','Place','ولبة/هويلفا','Huelva',NULL,NULL,'مرساة جغرافية لتوسيع Gazetteer؛ لا يثبت هذا السجل وحده الدور التاريخي للمدينة.');
INSERT INTO "entities" VALUES('PLC-ECIJA','Place','إستجة/إيثيخا','Écija',NULL,NULL,'مرساة جغرافية لتوسيع Gazetteer؛ لا يثبت هذا السجل وحده الدور التاريخي للمدينة.');
INSERT INTO "entities" VALUES('PLC-MEDINA-SIDONIA','Place','شذونة/مدينة سيدونيا','Medina-Sidonia',NULL,NULL,'مرساة جغرافية لتوسيع Gazetteer؛ لا يثبت هذا السجل وحده الدور التاريخي للمدينة.');
INSERT INTO "entities" VALUES('PLC-TORTOSA','Place','طرطوشة','Tortosa',NULL,NULL,'مرساة جغرافية لتوسيع Gazetteer؛ لا يثبت هذا السجل وحده الدور التاريخي للمدينة.');
INSERT INTO "entities" VALUES('PLC-ALGECIRAS','Place','الجزيرة الخضراء','Algeciras',NULL,NULL,'مرساة جغرافية لتوسيع Gazetteer؛ لا يثبت هذا السجل وحده الدور التاريخي للمدينة.');
INSERT INTO "entities" VALUES('PLC-MERIDA','Place','ماردة','Mérida',NULL,NULL,'مرساة جغرافية لتوسيع Gazetteer؛ لا يثبت هذا السجل وحده الدور التاريخي للمدينة.');
INSERT INTO "entities" VALUES('PLC-008','Place','دانية','Dāniya',NULL,NULL,'فرع الأدلة؛ الأب: —؛ يحتاج توثيق تفصيلي');
INSERT INTO "entities" VALUES('PLC-013','Place','مرتلة','Mārtula',NULL,NULL,'فرع الأدلة؛ الأب: —؛ متحقق من المركز الأثري');
INSERT INTO "entities" VALUES('PLC-014','Place','شلب','Shilb',NULL,NULL,'فرع الأدلة؛ الأب: —؛ يحتاج توثيق تفصيلي');
INSERT INTO "entities" VALUES('PLC-015','Place','لشبونة','al-Ushbūna',NULL,NULL,'فرع الأدلة؛ الأب: —؛ يحتاج توثيق تفصيلي');
INSERT INTO "entities" VALUES('PLC-016','Place','شنترين','Shantarīn',NULL,NULL,'فرع الأدلة؛ الأب: —؛ يحتاج توثيق تفصيلي');
INSERT INTO "entities" VALUES('PLC-017','Place','باجة','Bāja',NULL,NULL,'فرع الأدلة؛ الأب: —؛ يحتاج توثيق تفصيلي');
INSERT INTO "entities" VALUES('PLC-019','Place','وشقة','Washqa',NULL,NULL,'فرع الأدلة؛ الأب: —؛ يحتاج توثيق تفصيلي');
INSERT INTO "entities" VALUES('PLC-C01','Place','البيازين','al-Bayyāzīn',NULL,NULL,'فرع الأدلة؛ الأب: PLC-003؛ متحقق كبوابة؛ التفاصيل لاحقًا');
INSERT INTO "entities" VALUES('PLC-C02','Place','حدرّه','Wādī Dāru',NULL,NULL,'فرع الأدلة؛ الأب: PLC-003؛ مرشح ربط');
INSERT INTO "entities" VALUES('PLC-C03','Place','قصر الجعفرية','al-Jaʿfariyya',NULL,NULL,'فرع الأدلة؛ الأب: PLC-006؛ متحقق سابقًا');
INSERT INTO "entities" VALUES('PLC-C06','Place','وادي آش','Wādī Āsh',NULL,NULL,'فرع الأدلة؛ الأب: —؛ يحتاج مصدر مكاني مباشر');
INSERT INTO "entities" VALUES('PLC-D01','Place','وادي الحجارة','Wādī al-Ḥijāra',NULL,NULL,'فرع الأدلة؛ الأب: —؛ مرشح');
INSERT INTO "entities" VALUES('PLC-D02','Place','Priego de Córdoba','Priego de Córdoba',NULL,NULL,'فرع الأدلة؛ الأب: —؛ متحقق كسياق الكنز');
INSERT INTO "entities" VALUES('PLC-D03','Place','الزاهرة','al-Zāhira',NULL,NULL,'فرع الأدلة؛ الأب: PLC-001؛ مرشح مهم');
INSERT INTO "entities" VALUES('PLC-D04','Place','مُنية السرور','Munyat al-Surūr',NULL,NULL,'فرع الأدلة؛ الأب: PLC-D03؛ موثق نصيًا');
INSERT INTO "entities" VALUES('PLC-G01','Place','الحمراء','al-Ḥamrāʾ',NULL,NULL,'فرع الأدلة؛ الأب: PLC-003؛ جديد v5.3');
INSERT INTO "entities" VALUES('PLC-G02','Place','جنة العريف','Jannat al-ʿArīf',NULL,NULL,'فرع الأدلة؛ الأب: PLC-003؛ جديد v5.3');
INSERT INTO "entities" VALUES('PLC-G03','Place','بسطة','Basṭa',NULL,NULL,'فرع الأدلة؛ الأب: —؛ جديد v5.3');
INSERT INTO "entities" VALUES('PLC-G04','Place','لوشة','Lawsha',NULL,NULL,'فرع الأدلة؛ الأب: —؛ جديد v5.3');
INSERT INTO "entities" VALUES('PLC-G05','Place','المنكب','al-Munakkab',NULL,NULL,'فرع الأدلة؛ الأب: —؛ جديد v5.3');
INSERT INTO "entities" VALUES('PLC-G06','Place','البشرات','al-Bushārāt',NULL,NULL,'فرع الأدلة؛ الأب: —؛ جديد v5.3');
INSERT INTO "entities" VALUES('POL-001','Polity','إمارة قرطبة الأموية','Umayyad Emirate of Córdoba','0756','0929','إمارة؛ العاصمة PLC-CORDOBA');
INSERT INTO "entities" VALUES('POL-002','Polity','خلافة قرطبة','Caliphate of Córdoba','0929','1031','خلافة؛ العاصمة PLC-CORDOBA');
INSERT INTO "entities" VALUES('POL-003','Polity','طائفة إشبيلية','Taifa of Seville',NULL,NULL,'طائفة؛ العاصمة PLC-SEVILLE');
INSERT INTO "entities" VALUES('POL-004','Polity','طائفة سرقسطة','Taifa of Zaragoza',NULL,NULL,'طائفة؛ العاصمة PLC-ZARAGOZA');
INSERT INTO "entities" VALUES('POL-005','Polity','طائفة دانية','Taifa of Dénia',NULL,NULL,'طائفة؛ العاصمة PLC-008');
INSERT INTO "entities" VALUES('POL-006','Polity','الدولة المرابطية في الأندلس','Almoravid rule in al-Andalus',NULL,NULL,'دولة؛ العاصمة —');
INSERT INTO "entities" VALUES('POL-007','Polity','الدولة الموحدية في الأندلس','Almohad rule in al-Andalus',NULL,NULL,'دولة؛ العاصمة —');
INSERT INTO "entities" VALUES('POL-008','Polity','مملكة غرناطة النصرية','Nasrid Kingdom of Granada',NULL,'1492','مملكة؛ العاصمة PLC-GRANADA');
INSERT INTO "entities" VALUES('PER-001','Person','عبد الرحمن الداخل','ʿAbd al-Raḥmān I','0731','0788',NULL);
INSERT INTO "entities" VALUES('PER-002','Person','عبد الرحمن الثالث الناصر','ʿAbd al-Raḥmān III','0891','0961','ولد 22 رمضان 277هـ (= 7 يناير 891م بالتحويل الجدولي)؛ صُحح من 889 في v5.2');
INSERT INTO "entities" VALUES('PER-004','Person','المنصور ابن أبي عامر','al-Manṣūr Ibn Abī ʿĀmir','0939','1002','توفي 27 رمضان 392هـ (أغسطس 1002م) بمدينة سالم (البيان المغرب)؛ 393هـ عند الحميدي؛ المولد نحو 326–328هـ (938–940م)');
INSERT INTO "entities" VALUES('PER-005','Person','ابن حيان القرطبي','Ibn Ḥayyān','0987','1076',NULL);
INSERT INTO "entities" VALUES('PER-006','Person','ابن حزم','Ibn Ḥazm','0994','1064',NULL);
INSERT INTO "entities" VALUES('PER-007','Person','ابن زيدون','Ibn Zaydūn','1003','1071',NULL);
INSERT INTO "entities" VALUES('PER-008','Person','ولادة بنت المستكفي','Wallāda bint al-Mustakfī',NULL,NULL,'نحو 994–1091م');
INSERT INTO "entities" VALUES('PER-009','Person','المعتمد بن عباد','al-Muʿtamid ibn ʿAbbād','1040','1095',NULL);
INSERT INTO "entities" VALUES('PER-010','Person','ابن عمار','Ibn ʿAmmār','1031','1086',NULL);
INSERT INTO "entities" VALUES('PER-011','Person','صاعد الأندلسي','Ṣāʿid al-Andalusī','1029','1070',NULL);
INSERT INTO "entities" VALUES('PER-012','Person','الزهراوي','al-Zahrāwī',NULL,NULL,'توفي بعد 400هـ (الصلة ص162)، وعاصره ابن حزم (رسائله ج2 ص185)؛ نحو 936–1013م عند Britannica، والوفاة 427هـ/1036م عند الزركلي — لا نص أوليًا بسنة الوفاة');
INSERT INTO "entities" VALUES('PER-013','Person','الزرقالي','al-Zarqālī',NULL,NULL,'القرن 11م');
INSERT INTO "entities" VALUES('PER-014','Person','ابن باجة','Ibn Bājja',NULL,'1139',NULL);
INSERT INTO "entities" VALUES('PER-015','Person','ابن طفيل','Ibn Ṭufayl',NULL,'1185','نحو 1105–1185م');
INSERT INTO "entities" VALUES('PER-016','Person','ابن رشد','Ibn Rushd','1126','1198',NULL);
INSERT INTO "entities" VALUES('PER-017','Person','ابن عربي','Ibn ʿArabī','1165','1240',NULL);
INSERT INTO "entities" VALUES('PER-018','Person','لسان الدين ابن الخطيب','Ibn al-Khaṭīb','1313','1374','ولد 25 رجب 713هـ (نوفمبر 1313م) بنص الإحاطة ج4 ص548؛ قُتل خنقًا في سجنه بفاس سنة 776هـ، بين مستهلّها وشوالها (منتصف 1374م إلى أوائل 1375م) بحسب ابن خلدون: العبر ج7 ص452–453، والرحلة ص187');
INSERT INTO "entities" VALUES('PER-019','Person','ابن سعيد المغربي','Ibn Saʿīd al-Maghribī','1213','1286',NULL);
INSERT INTO "entities" VALUES('PER-020','Person','الإدريسي','al-Idrīsī',NULL,NULL,'نحو 1100–1165/66م');
INSERT INTO "entities" VALUES('PER-021','Person','ابن البيطار','Ibn al-Bayṭār',NULL,'1248',NULL);
INSERT INTO "entities" VALUES('PER-022','Person','ابن قزمان','Ibn Quzmān',NULL,'1160','نحو 1087–1160م');
INSERT INTO "entities" VALUES('PER-023','Person','حفصة الركونية','Ḥafṣa al-Rakūniyya',NULL,NULL,'القرن 12م');
INSERT INTO "entities" VALUES('PER-024','Person','صموئيل بن نغريلة','Samuel ibn Naghrīla','0993',NULL,'ت 1055/56م');
INSERT INTO "entities" VALUES('PER-025','Person','يهوذا اللاوي','Judah Halevi',NULL,'1141','نحو 1075–1141م');
INSERT INTO "entities" VALUES('PER-026','Person','موسى بن عزرا','Moses ibn Ezra',NULL,NULL,'نحو 1055–بعد 1135م');
INSERT INTO "entities" VALUES('PER-027','Person','عباس بن ناصح','ʿAbbās b. Nāṣiḥ',NULL,NULL,'ت نحو 852م');
INSERT INTO "entities" VALUES('PER-W01','Person','عائشة بنت أحمد القرطبية','ʿĀʾisha bint Aḥmad al-Qurṭubiyya',NULL,'1010','ت 1009–1010م');
INSERT INTO "entities" VALUES('PER-W02','Person','أم الحسن الطنجالية','Umm al-Ḥasan al-Tanyāliyya',NULL,NULL,'منتصف 14م');
INSERT INTO "entities" VALUES('PER-028','Person','المقتدر بن هود','al-Muqtadir ibn Hūd',NULL,'1081','حكم 1046–1081م (v4.9)');
INSERT INTO "entities" VALUES('PER-029','Person','مجاهد العامري','Mujāhid al-ʿĀmirī',NULL,NULL,'القرن 11م — يحتاج ضبط السنوات');
INSERT INTO "entities" VALUES('PER-030','Person','محمد الأول ابن الأحمر','Muḥammad I ibn al-Aḥmar','1194','1273','ولد 591هـ (عام الأرك) بأرجونة؛ بويع بغرناطة 26 رمضان 635هـ؛ توفي 29 جمادى الآخرة 671هـ (الإحاطة ج2 ص55–56)');
INSERT INTO "entities" VALUES('PER-031','Person','محمد الثاني عشر أبو عبد الله','Muḥammad XII (Boabdil)',NULL,NULL,'حكم 1482–1483 و1487–1492م');
INSERT INTO "entities" VALUES('PER-032','Person','محمد الثاني الفقيه','Muḥammad II al-Faqīh',NULL,'1302','توفي شعبان 701هـ (أبريل–مايو 1302م)');
INSERT INTO "entities" VALUES('PER-033','Person','يوسف الأول','Yūsuf I','1318','1354','ولد 28 ربيع الآخر 718هـ (يونيو 1318م)؛ ولي 14 ذي الحجة 733هـ؛ قُتل 1 شوال 755هـ (الإحاطة ج4 ص292)');
INSERT INTO "entities" VALUES('PER-034','Person','محمد الخامس الغني بالله','Muḥammad V','1339','1391','ولد 22 جمادى الآخرة 739هـ (4/5 يناير 1339م) بنص الإحاطة ج2 ص50؛ توفي 793هـ (1390/1391م)');
INSERT INTO "entities" VALUES('PER-035','Person','ابن زمرك','Ibn Zamrak','1333',NULL,'ولد 14 شوال 733هـ (يونيو 1333م)؛ قُتل بعد 795هـ بحسب المقري (نفح الطيب ج7 ص170)؛ 797هـ/1395م عند عنان بلا مصدر مفحوص');
INSERT INTO "entities" VALUES('PER-036','Person','أبو الحسن علي','Abū l-Ḥasan ʿAlī (Muley Hacén)',NULL,'1485','توفي بالمنكب 890هـ (1485م)');
INSERT INTO "entities" VALUES('PER-037','Person','محمد الزغل','Muḥammad al-Zaghal',NULL,NULL,'حاكم مالقة ثم سلطان 1485–1487م');
CREATE TABLE entity_aliases (
  alias_id TEXT PRIMARY KEY,
  entity_id TEXT NOT NULL,
  alias TEXT NOT NULL,
  script TEXT,
  language TEXT,
  normalized TEXT,
  FOREIGN KEY(entity_id) REFERENCES entities(entity_id)
);
INSERT INTO "entity_aliases" VALUES('ALIAS-TOLEDO-AR','PLC-TOLEDO','طليطلة','Arabic','ar','طليطلة');
INSERT INTO "entity_aliases" VALUES('ALIAS-TOLEDO-LA','PLC-TOLEDO','Toledo','Latin','es/en','toledo');
INSERT INTO "entity_aliases" VALUES('ALIAS-GERARD-01','PER-GERARD-CREMONA','Gerardus Cremonensis','Latin','la','gerardus cremonensis');
INSERT INTO "entity_aliases" VALUES('ALIAS-GUND-01','PER-GUNDISSALINUS','Domingo Gundisalvo','Latin','es','domingo gundisalvo');
INSERT INTO "entity_aliases" VALUES('ALIAS-IBNDAUD-01','PER-ABRAHAM-IBN-DAUD','Avendauth','Latin','la','avendauth');
INSERT INTO "entity_aliases" VALUES('ALIAS-JILYANI-01','PER-AL-JILYANI','al-Ǧilyānī','Latin transliteration','ar-latn','al-jilyani');
INSERT INTO "entity_aliases" VALUES('ALIAS-GRANADA-01','PLC-GRANADA','غرناطة','Arabic','ar','غرناطة');
INSERT INTO "entity_aliases" VALUES('ALIAS-DAMASCUS-01','PLC-DAMASCUS','دمشق','Arabic','ar','دمشق');
INSERT INTO "entity_aliases" VALUES('ALIAS-IBNRAZIN-01','PER-IBN-RAZIN','Ibn Razīn al-Tuŷībī','Latin transliteration','ar-latn','ibn razin al tujibi');
INSERT INTO "entity_aliases" VALUES('ALIAS-ROMANCE-01','LANG-ROM-AND','الروماندلسي / الرومانسية الأندلسية','Arabic','ar','الرومانسية الاندلسية');
CREATE TABLE event_persons(event_id TEXT NOT NULL, person_id TEXT NOT NULL, PRIMARY KEY(event_id, person_id),
  FOREIGN KEY(event_id) REFERENCES historical_events(event_id), FOREIGN KEY(person_id) REFERENCES entities(entity_id));
INSERT INTO "event_persons" VALUES('EVT-002','PER-001');
INSERT INTO "event_persons" VALUES('EVT-003','PER-002');
INSERT INTO "event_persons" VALUES('EVT-004','PER-002');
INSERT INTO "event_persons" VALUES('EVT-008','PER-030');
INSERT INTO "event_persons" VALUES('EVT-009','PER-031');
INSERT INTO "event_persons" VALUES('EVT-013','PER-030');
INSERT INTO "event_persons" VALUES('EVT-014','PER-030');
INSERT INTO "event_persons" VALUES('EVT-015','PER-033');
INSERT INTO "event_persons" VALUES('EVT-016','PER-034');
INSERT INTO "event_persons" VALUES('EVT-018','PER-031');
INSERT INTO "event_persons" VALUES('EVT-021','PER-018');
CREATE TABLE evidence (
  evidence_id TEXT PRIMARY KEY,
  evidence_type TEXT NOT NULL,
  label_ar TEXT NOT NULL,
  date_text TEXT,
  place_entity_id TEXT,
  description_ar TEXT,
  confidence TEXT,
  source_id TEXT,
  FOREIGN KEY(place_entity_id) REFERENCES entities(entity_id),
  FOREIGN KEY(source_id) REFERENCES sources(source_id)
);
INSERT INTO "evidence" VALUES('EVD-FELUS-711','Coin','فلوس فتح الأندلس، ومنها قطعة 711–712م','711-712','PLC-CORDOBA','مصدر نقدي منخفض القيمة يُستخدم كقرينة على مسارات الفتح والضم والتبادل.','عالٍ','SRC-8585EF64FC');
INSERT INTO "evidence" VALUES('EVD-JEWISH-MAT','ObjectSet','مجموعة الثقافة المادية اليهودية في MAN','Medieval Iberia',NULL,'توضح صعوبة إسناد الهوية الدينية بالأسلوب وحده وأهمية النقوش والسياق.','عالٍ','SRC-08093EBC7F');
INSERT INTO "evidence" VALUES('EVD-PECHINA-URBAN','Archaeology','حي بَجّانة: مساكن وشوارع ومحلات وورش','9-10c','PLC-PECHINA','سياق حضري فوق/بعد مركز خزف مزجج مبكر.','عالٍ','SRC-88C32727FD');
INSERT INTO "evidence" VALUES('EVD-COOKBOOKS-13C','TextCorpus','كتابا الطبخ الأندلسيان في القرن 13','13c',NULL,'مصدران أوليان للوصفات والتقنيات وعادات المائدة والصلات مع المغرب.','عالٍ','SRC-D8B41C5711');
INSERT INTO "evidence" VALUES('EVD-LEON-ARCH','Architecture','قوس قصر ملوك ليون','1370s','PLC-LEON','قوس بزخارف ونقوش عربية من تقاليد أندلسية في قصر ملكي قشتالي.','عالٍ','SRC-94CFFFD3D1');
INSERT INTO "evidence" VALUES('EVD-TOLEDO-TRANS','TextualTransmission','برنامج الترجمة العربية-اللاتينية في طليطلة','12c','PLC-TOLEDO','توثيق نشاط Gerard وGundissalinus وشبكات تعاون الترجمة.','متوسط-عالٍ','SRC-E29AF5E30C');
INSERT INTO "evidence" VALUES('EVD-AMOI-JILYANI','RouteCase','مسار الجِلياني من غرناطة إلى دمشق','before 1206','PLC-DAMASCUS','حالة AMOI-II لانتقال شخص وعمل ومعرفة من الأندلس إلى المشرق.','عالٍ','SRC-9264D9F9B0');
INSERT INTO "evidence" VALUES('EVD-KHARJAS-CS','LiteraryCorpus','Corpus الخرجات العربية-الرومانسية وتحليل التبديل اللغوي','11-14c',NULL,'دراسة كمية لـ43 خرجة تسجل 104 حالات تبديل لغوي.','عالٍ','SRC-F0F86304B1');
INSERT INTO "evidence" VALUES('EVD-MANISES','CraftObjectSet','خزف البريق المعدني في مانيسس','14-15c','PLC-MANISES','امتداد لتقنيات أندلسية/نصرية في ورش بعد انتقال السلطة.','عالٍ','SRC-2D2113D7F8');
INSERT INTO "evidence" VALUES('EVD-UNESCO-MADINAT','HERITAGE/ARCH','مدينة الزهراء — عقار UNESCO','منتصف 10م؛ دمار 1009–1010','PLC-MADINAT-ZAHRA','موقع حضري أموي كامل نسبيًا، مع طرق ومياه ومبانٍ وأشياء يومية.','عالٍ جدًا','SRC-FF27E1A80B');
INSERT INTO "evidence" VALUES('EVD-UNESCO-CORDOBA','HERITAGE/ARCH','وسط قرطبة التاريخي — UNESCO','8–10م وما بعده','PLC-CORDOBA-WH','موقع حضري يضم الجامع الكبير وسياقات الخلافة.','عالٍ جدًا','SRC-B819B01BE2');
INSERT INTO "evidence" VALUES('EVD-UNESCO-GRANADA','HERITAGE/ARCH','الحمراء وجنة العريف والبيازين — UNESCO','13–15م أساسًا','PLC-ALHAMBRA-WH','عقار مركب يضم مدينة قصر وحيًا وسيطًا ومقرًا ريفيًا.','عالٍ جدًا','SRC-F650A5BEAE');
INSERT INTO "evidence" VALUES('EVD-UNESCO-SEVILLE','HERITAGE/ARCH','قصر إشبيلية والجيرالدا — UNESCO','القرن 10–13م وما بعده','PLC-SEVILLE','شهادة معمارية متعددة الطبقات: نواة قصر من القرن العاشر، عناصر من القصر الموحدي، ومئذنة الجيرالدا المرتبطة بالمسجد السابق.','عالٍ جدًا','SRC-5CED25F7F5');
INSERT INTO "evidence" VALUES('EVD-PKT-ARC-CLM01','VERIFICATION_PACKET','حزمة تحقق ARC-CLM01',NULL,NULL,'تطبيع طبقة التحقق: هما من أقدم أمثلة دور العبادة الإسلامية المؤرخة أثريًا في شبه الجزيرة، ويرجح بناؤهما في العقود الوسطى من القرن الثامن.','مطابق لثقة Claim','SRC-1990D2E895');
INSERT INTO "evidence" VALUES('EVD-PKT-ARC-CLM03','VERIFICATION_PACKET','حزمة تحقق ARC-CLM03',NULL,NULL,'تطبيع طبقة التحقق: تصف EEA بذرتين مؤرختين بالنصف الأول من القرن 11 بأنها أقدم دليل معروف حتى يونيو 2026 في الأندلس؛ لكن أدبيات 2023 سجلت الدخن اللؤلؤي في سياقات إسلامية إيبيرية من 11–12م، لذا تبقى أولوية بايرين قابلة للمراجعة عند نشر الدراسة التفصيلية.','مطابق لثقة Claim','SRC-3498AB3076');
INSERT INTO "evidence" VALUES('EVD-PKT-ARC-CLM04','VERIFICATION_PACKET','حزمة تحقق ARC-CLM04',NULL,NULL,'تطبيع طبقة التحقق: توثق حفريات بَجّانة/پتشينة فرنًا متخصصًا لإنتاج الخزف المزجج عمل في النصف الثاني من القرن التاسع، ثم أُهمل وحل فوقه/بعده حي إسلامي يضم مساكن وشوارع ومحلات وورش.','مطابق لثقة Claim','SRC-88C32727FD');
INSERT INTO "evidence" VALUES('EVD-PKT-CLM-001','VERIFICATION_PACKET','حزمة تحقق CLM-001',NULL,NULL,'تطبيع طبقة التحقق: أعلن عبد الرحمن الثالث نفسه خليفة في 16 يناير 929م؛ وتظهر النقود المعاصرة التحول في الألقاب والسيادة.','مطابق لثقة Claim','SRC-326B573BBA');
INSERT INTO "evidence" VALUES('EVD-PKT-CLM-002','VERIFICATION_PACKET','حزمة تحقق CLM-002',NULL,NULL,'تطبيع طبقة التحقق: لا يوجد ما يكفي لنشر حرق السفن كواقعة ثابتة. الرواية تظهر في تقاليد متأخرة، والبحث الحديث يتعامل معها كأسطورة/رواية موضع شك.','مطابق لثقة Claim','SRC-FA9D2D9443');
INSERT INTO "evidence" VALUES('EVD-PKT-CLM-010','VERIFICATION_PACKET','حزمة تحقق CLM-010',NULL,NULL,'تطبيع طبقة التحقق: يُعتمد منهجيًا على الجمع بين النقد والأختام والآثار والنصوص لأن جزءًا كبيرًا من الروايات المكتوبة عن الفتح متأخر زمنيًا، كما يظهر بوضوح في دراسة المساجد المبكرة وفي تقليد حرق السفن.','مطابق لثقة Claim','SRC-1990D2E895');
INSERT INTO "evidence" VALUES('EVD-PKT-CLM-018','VERIFICATION_PACKET','حزمة تحقق CLM-018',NULL,NULL,'تطبيع طبقة التحقق: لا تُعامل أخبار مجموعة بوصفها شاهدًا معاصرًا مباشرًا لفتح الأندلس؛ يبين تحليل لويس مولينا أن رواية فتح محددة فيها ترجع إلى أحمد الرازي في القرن العاشر، وأن الكتاب تركيب من مواد تاريخية أقدم لا من مواد تأريخية من الدرجة الأولى.','مطابق لثقة Claim','SRC-C60B7F01E7');
INSERT INTO "evidence" VALUES('EVD-PKT-CLM-MS01','VERIFICATION_PACKET','حزمة تحقق CLM-MS01',NULL,NULL,'تطبيع طبقة التحقق: مخطوط ابن ليون الزراعي، المؤلف سنة 1348م والمحفوظ في EEA-CSIC، واحد من خمس نسخ باقية، وهو بحسب EEA النسخة الوحيدة الكاملة والوحيدة التي تحتوي حواشي هامشية؛ لذلك يُعامل بوصفه شاهدًا أوليًا مهمًا على المعرفة الزراعية الأندلسية المتأخرة.','مطابق لثقة Claim','SRC-62278995F4');
INSERT INTO "evidence" VALUES('EVD-PKT-CLM-MS02','VERIFICATION_PACKET','حزمة تحقق CLM-MS02',NULL,NULL,'تطبيع طبقة التحقق: بحسب بيانات EEA المحدثة في 26 مايو 2026، تضم المجموعة 130 عملًا عربيًا مخطوطًا في 75 مجلدًا، وكودكسًا عبريًا يضم 9 أعمال، و31 وثيقة عربية غرناطية ومغربية، و8 مخطوطات قشتالية. تُحفظ الأرقام مع تاريخ التحقق لأنها قابلة للتغير.','مطابق لثقة Claim','SRC-3D20624E74');
INSERT INTO "evidence" VALUES('EVD-PKT-RUR-CLM02','VERIFICATION_PACKET','حزمة تحقق RUR-CLM02',NULL,NULL,'تطبيع طبقة التحقق: تشير الدراسة osteoarchaeological لعينة من 35 هيكلًا من Xaresa إلى مرونة في توزيع العمل وأهمية أعمال الصيانة والرعاية، ولا يجوز تعميمها على كل نساء الأندلس.','مطابق لثقة Claim','SRC-EF1A9587DD');
INSERT INTO "evidence" VALUES('EVD-PKT-RUR-CLM03','VERIFICATION_PACKET','حزمة تحقق RUR-CLM03',NULL,NULL,'تطبيع طبقة التحقق: يكشف الحي الأندلسي المحفوظ عند سفح قصبة ألمرية، مع دراسات مشروع GLOBALM، عن مدينة ذات نشاط إنتاجي وتجاري واسع ارتكز على بنية مينائية وصناعة نسيجية واتصالات قوية؛ ويُعرض هذا بوصفه استنتاجًا من الحي والثقافة المادية والبحث متعدد التخصصات.','مطابق لثقة Claim','SRC-BDD32C0DDC');
INSERT INTO "evidence" VALUES('EVD-PKT-RUR-CLM04','VERIFICATION_PACKET','حزمة تحقق RUR-CLM04',NULL,NULL,'تطبيع طبقة التحقق: الحفر الواسع لنحو 22,000م² والمؤرخ 750–818م يوفر سجلًا مباشرًا للتخطيط الحضري والثقافة المادية والحياة اليومية قبل تدمير الربض.','مطابق لثقة Claim','SRC-22B631316C');
INSERT INTO "evidence" VALUES('EVD-PKT-RUR-CLM06','VERIFICATION_PACKET','حزمة تحقق RUR-CLM06',NULL,NULL,'تطبيع طبقة التحقق: تُعتمد PUA كمصدر أساسي للأشخاص لأنها تضم أكثر من 11,600 شخصية من معاجم التراجم الأندلسية، ويُعتمد HATA للأعمال المؤلفة والمنقولة في الأندلس بين القرنين الثامن والخامس عشر؛ ويستخدم AMOI الربط بين HATA وPUA أساسًا لدراسة انتقال المعرفة.','مطابق لثقة Claim','SRC-F86CF814B9');
INSERT INTO "evidence" VALUES('EVD-PKT-SOC-CLM01','VERIFICATION_PACKET','حزمة تحقق SOC-CLM01',NULL,NULL,'تطبيع طبقة التحقق: العلاقات بين المسلمين والمسيحيين واليهود كانت متغيرة زمانيًا ومكانيًا ومؤسسيًا؛ التعاون والتداخل والتوتر والتراتبية كلها موثقة، لذلك تُرفض السردية الأحادية.','مطابق لثقة Claim','SRC-CB6B8DB2B7');
INSERT INTO "evidence" VALUES('EVD-PKT-SOC-CLM06','VERIFICATION_PACKET','حزمة تحقق SOC-CLM06',NULL,NULL,'تطبيع طبقة التحقق: صبح (940–999م) حالة استثنائية موثقة لامرأة من أصل مسترق وصلت إلى مكانة سياسية وثقافية بارزة في البلاط الأموي؛ يثبت نقش بُرطمانها العاجي سنة 964م صلتها المباشرة بالبلاط، وتعرض المصادر المتحفية دورها اللاحق بوصفها sayyida وفاعلة في القرار السياسي. لا تعمم حالتها على وضع النساء كله.','مطابق لثقة Claim','SRC-385ADC829F');
INSERT INTO "evidence" VALUES('EVD-PKT-SOC-CLM09','VERIFICATION_PACKET','حزمة تحقق SOC-CLM09',NULL,NULL,'تطبيع طبقة التحقق: تشير مادة MAN إلى استخدام واسع للنقد في الأندلس في الضرائب والجيش والتجارة والمعاملات اليومية، وإلى تداول الدراهم خارج الأندلس؛ وتُفصل كثافة الاستخدام ومسارات التداول لاحقًا بحسب الفترة والمنطقة.','مطابق لثقة Claim','SRC-0DBB04D925');
CREATE TABLE historical_events(event_id TEXT PRIMARY KEY, title_ar TEXT NOT NULL, start_year INTEGER, end_year INTEGER, precision TEXT, hijri TEXT,
  place_id TEXT, period_id TEXT, polity_id TEXT, confidence TEXT, legacy_refs TEXT,
  FOREIGN KEY(place_id) REFERENCES entities(entity_id), FOREIGN KEY(period_id) REFERENCES periods(period_id), FOREIGN KEY(polity_id) REFERENCES entities(entity_id));
INSERT INTO "historical_events" VALUES('EVT-001','فتح شبه الجزيرة وبداية الأندلس',711,711,'سنة','92هـ',NULL,'PRD-01',NULL,'عالٍ (الحدث)؛ التفاصيل مختلف فيها','EVT-001; CLM-002');
INSERT INTO "historical_events" VALUES('EVT-002','قيام الإمارة الأموية',756,756,'سنة','138هـ','PLC-CORDOBA','PRD-02','POL-001','عالٍ','EVT-002');
INSERT INTO "historical_events" VALUES('EVT-003','إعلان الخلافة',929,929,'سنة','316هـ','PLC-CORDOBA','PRD-03','POL-002','عالٍ','EVT-003; EVT-B01; CLM-001');
INSERT INTO "historical_events" VALUES('EVT-004','بدء بناء مدينة الزهراء',936,936,'سنة','محرم 325هـ','PLC-MADINAT-ZAHRA','PRD-03','POL-002','عالٍ','EVT-004');
INSERT INTO "historical_events" VALUES('EVT-005','انهيار الخلافة (الفتنة)',1009,1031,'نطاق سنوات','399–422هـ','PLC-CORDOBA','PRD-03a','POL-002','عالٍ','EVT-005; EVT-B02');
INSERT INTO "historical_events" VALUES('EVT-006','سقوط طليطلة',1085,1085,'سنة','478هـ','PLC-TOLEDO','PRD-04',NULL,'عالٍ','EVT-006');
INSERT INTO "historical_events" VALUES('EVT-007','التدخل المرابطي (الزلاقة وما بعدها)',1086,NULL,'سنة','479هـ',NULL,'PRD-05','POL-006','متوسط','EVT-007');
INSERT INTO "historical_events" VALUES('EVT-008','قيام الدولة النصرية (البيعة ثم دخول غرناطة)',1232,1238,'نطاق سنوات','629–635هـ','PLC-GRANADA','PRD-07','POL-008','عالٍ','EVT-008');
INSERT INTO "historical_events" VALUES('EVT-009','تسليم غرناطة',1492,1492,'يوم','2 يناير 1492م (ربيع الأول 897هـ)','PLC-GRANADA','PRD-07','POL-008','عالٍ','EVT-009');
INSERT INTO "historical_events" VALUES('EVT-010','طرد الموريسكيين',1609,1614,'نطاق سنوات','1018–1023هـ',NULL,'PRD-08',NULL,'عالٍ','EVT-010');
INSERT INTO "historical_events" VALUES('EVT-012','خراب مدينة الزهراء في الفتنة',1010,1025,'نطاق سنوات','401–416هـ','PLC-MADINAT-ZAHRA','PRD-03a','POL-002','عالٍ','جديد v5.2');
INSERT INTO "historical_events" VALUES('EVT-011','سك دينار يوسف بن تاشفين في شاطبة',1103,1104,'نطاق سنوات','497هـ',NULL,'PRD-05','POL-006','عالٍ','EVT-B03; COIN-005');
INSERT INTO "historical_events" VALUES('EVT-013','دخول محمد الأول غرناطة',1238,1238,'سنة','635هـ','PLC-GRANADA','PRD-07','POL-008','عالٍ','جديد v5.3');
INSERT INTO "historical_events" VALUES('EVT-014','معاهدة جيان وتبعية غرناطة لقشتالة',1245,1246,'نطاق سنوات','643هـ',NULL,'PRD-07','POL-008','عالٍ','جديد v5.3');
INSERT INTO "historical_events" VALUES('EVT-015','معركة طريف (نهر سالادو)',1340,1340,'يوم','30 أكتوبر 1340م (جمادى الأولى 741هـ)',NULL,'PRD-07','POL-008','عالٍ','جديد v5.3');
INSERT INTO "historical_events" VALUES('EVT-016','بناء قصر الأسود في الحمراء',1362,1391,'نطاق سنوات','ق8هـ','PLC-G01','PRD-07','POL-008','عالٍ','جديد v5.3');
INSERT INTO "historical_events" VALUES('EVT-017','سقوط مالقة',1487,1487,'سنة','أواخر شعبان 892هـ (أغسطس 1487م)','PLC-MALAGA','PRD-07','POL-008','عالٍ','جديد v5.3');
INSERT INTO "historical_events" VALUES('EVT-018','معاهدة تسليم غرناطة',1491,1491,'يوم','25 نوفمبر 1491م (21 محرم 897هـ)','PLC-GRANADA','PRD-07','POL-008','عالٍ','جديد v5.3');
INSERT INTO "historical_events" VALUES('EVT-019','ثورة البشرات الأولى',1499,1501,'نطاق سنوات','905–906هـ','PLC-G06','PRD-08',NULL,'متوسط','جديد v5.3');
INSERT INTO "historical_events" VALUES('EVT-020','التنصير القسري لمسلمي قشتالة (الأمر الملكي 12 فبراير 1502)',1502,1502,'يوم','نحو 4 شعبان 907هـ (بالحساب الجدولي)',NULL,'PRD-08',NULL,'متوسط','جديد v5.3');
INSERT INTO "historical_events" VALUES('EVT-021','مقتل لسان الدين ابن الخطيب في فاس',1374,1375,'نطاق سنوات','776هـ (بين مستهلّها وشوالها)',NULL,'PRD-07',NULL,'عالٍ','جديد v5.3');
CREATE TABLE id_crosswalk(branch_id TEXT NOT NULL, release_id TEXT NOT NULL, entity_kind TEXT, match_basis TEXT, distance_km REAL,
  PRIMARY KEY(branch_id, release_id), FOREIGN KEY(release_id) REFERENCES entities(entity_id));
INSERT INTO "id_crosswalk" VALUES('PLC-001','PLC-CORDOBA','Place','تطابق الاسم العربي',1.48);
INSERT INTO "id_crosswalk" VALUES('PLC-003','PLC-GRANADA','Place','تطابق الاسم العربي',1.4);
INSERT INTO "id_crosswalk" VALUES('PLC-007','PLC-ALMARIYYA','Place','تطابق الاسم العربي',0.58);
INSERT INTO "id_crosswalk" VALUES('PLC-005','PLC-TOLEDO','Place','تطابق الاسم العربي',0.67);
INSERT INTO "id_crosswalk" VALUES('PLC-002','PLC-MADINAT-ZAHRA','Place','تطابق الاسم العربي',0.0);
INSERT INTO "id_crosswalk" VALUES('PLC-004','PLC-SEVILLE','Place','تطابق الاسم العربي',1.22);
INSERT INTO "id_crosswalk" VALUES('PLC-006','PLC-ZARAGOZA','Place','تطابق الاسم العربي',1.27);
INSERT INTO "id_crosswalk" VALUES('PLC-009','PLC-VALENCIA','Place','تطابق الاسم العربي',0.53);
INSERT INTO "id_crosswalk" VALUES('PLC-010','PLC-MALAGA','Place','تطابق الاسم العربي',0.16);
INSERT INTO "id_crosswalk" VALUES('PLC-011','PLC-MURCIA','Place','تطابق الاسم العربي',0.58);
INSERT INTO "id_crosswalk" VALUES('PLC-012','PLC-BADAJOZ','Place','تطابق الاسم العربي',0.17);
INSERT INTO "id_crosswalk" VALUES('PLC-C04','PLC-RONDA','Place','تطابق الاسم العربي',0.02);
INSERT INTO "id_crosswalk" VALUES('PLC-020','PLC-TORTOSA','Place','تطابق الاسم العربي',0.28);
INSERT INTO "id_crosswalk" VALUES('PLC-C05','PLC-ALGECIRAS','Place','تطابق الاسم العربي',0.03);
INSERT INTO "id_crosswalk" VALUES('PLC-018','PLC-MERIDA','Place','تطابق الاسم العربي',0.2);
INSERT INTO "id_crosswalk" VALUES('PER-003','PER-ALHAKAM-II','Person','تطابق الشخص (الحكم المستنصر)',NULL);
INSERT INTO "id_crosswalk" VALUES('PLC-G01','PLC-ALHAMBRA-WH','Place','جزء من عقار UNESCO 314 (ليس تطابقًا)',NULL);
INSERT INTO "id_crosswalk" VALUES('PLC-G02','PLC-ALHAMBRA-WH','Place','جزء من عقار UNESCO 314 (ليس تطابقًا)',NULL);
INSERT INTO "id_crosswalk" VALUES('PLC-C01','PLC-ALHAMBRA-WH','Place','جزء من عقار UNESCO 314 (ليس تطابقًا)',NULL);
CREATE TABLE learning_module_steps (
  module_id TEXT NOT NULL,
  ordinal INTEGER NOT NULL,
  step_type TEXT NOT NULL,
  title_ar TEXT NOT NULL,
  body_ar TEXT NOT NULL,
  claim_id TEXT,
  place_entity_id TEXT,
  interaction_hint TEXT,
  PRIMARY KEY(module_id,ordinal),
  FOREIGN KEY(module_id) REFERENCES learning_modules(module_id),
  FOREIGN KEY(claim_id) REFERENCES claims(claim_id),
  FOREIGN KEY(place_entity_id) REFERENCES entities(entity_id)
);
INSERT INTO "learning_module_steps" VALUES('EDU-01',1,'concept','قاعدة البداية','مصادر الفتح المكتوبة كثيرة الأهمية، لكن جزءًا مهمًا منها متأخر؛ لذلك نبدأ بالموازنة بين النص والمادة.','CLM-010',NULL,'افتح بطاقة Claim ثم اعرض أنواع الدليل.');
INSERT INTO "learning_module_steps" VALUES('EDU-01',2,'evidence','الفلوس والأختام','النقد والأختام لا تحكي القصة كاملة، لكنها تقدم قرائن معاصرة نسبيًا على الضم والجباية والتبادل.','CLM-011',NULL,'قارن بين Evidence مادي ورواية نصية.');
INSERT INTO "learning_module_steps" VALUES('EDU-01',3,'genealogy','من أين جاءت الرواية؟','Source Genealogy يمنعنا من معاملة كتاب متأخر كشاهد عيان، ويعيد كل خبر قدر الإمكان إلى طبقته المصدرية.','CLM-018',NULL,'أظهر سلسلة المصدر.');
INSERT INTO "learning_module_steps" VALUES('EDU-01',4,'myth','حرق السفن','الرواية مشهورة، لكن الشهرة ليست دليلًا. تُعرض هنا كقصة موضع شك لا كحقيقة ثابتة.','CLM-002',NULL,'زر: ما الذي يجعل الرواية Myth؟');
INSERT INTO "learning_module_steps" VALUES('EDU-02',1,'place','شقندة قبل 818م','الحفر الواسع يفتح نافذة على الشوارع والمباني والحياة اليومية في قرطبة الأموية المبكرة.','RUR-CLM04','PLC-SAQUNDA','حدد الموقع على الخريطة.');
INSERT INTO "learning_module_steps" VALUES('EDU-02',2,'politics','929م: إعلان الخلافة','يتحول الادعاء السياسي إلى Claim قوي عندما يلتقي النص المؤرخ مع النقود المعاصرة.','CLM-001','PLC-CORDOBA','شغّل خط الزمن إلى 929.');
INSERT INTO "learning_module_steps" VALUES('EDU-02',3,'place','مدينة الزهراء','مدينة جديدة للخلافة في القرن العاشر، لا مجرد «قصر» منفرد؛ التخطيط والمياه والطرق جزء من الدليل.','ATLAS-CLM01','PLC-MADINAT-ZAHRA','انتقل إلى نقطة UNESCO.');
INSERT INTO "learning_module_steps" VALUES('EDU-02',4,'architecture','الجامع والمدينة','وسط قرطبة التاريخي يسمح بقراءة تراكمات المدينة والجامع الكبير عبر قرون.','ATLAS-CLM02','PLC-CORDOBA-WH','قارن المدينة بالمركز الخلافي الجديد.');
INSERT INTO "learning_module_steps" VALUES('EDU-03',1,'craft','بَجّانة: من الفرن إلى الحي','فرن خزف مزجج من القرن التاسع يعقبه حي بمساكن وشوارع ومحلات وورش.','ARC-CLM04','PLC-PECHINA','فعّل طبقة الحرفة.');
INSERT INTO "learning_module_steps" VALUES('EDU-03',2,'urban','ألمرية: الميناء والنسيج','الموقع والمواد ومشروع GLOBALM يقدمون مدينة مرتبطة بالإنتاج والميناء وشبكات واسعة.','RUR-CLM03','PLC-ALMARIYYA','اعرض محور الاقتصاد.');
INSERT INTO "learning_module_steps" VALUES('EDU-03',3,'rural','شيريسا: العمل والرعاية','التحليل العظمي يتيح سؤالًا مختلفًا: كيف عاش الناس وعملوا ورعوا بعضهم؟','RUR-CLM02','PLC-XERESA','افتح Evidence الصحي/العظمي.');
INSERT INTO "learning_module_steps" VALUES('EDU-03',4,'text','كتب الطبخ','الوصفات مصدر ثمين، لكنها لا تمثل كل المجتمع أو كل الطبقات تلقائيًا.','ARC-CLM07',NULL,'قارن النص بالأثر.');
INSERT INTO "learning_module_steps" VALUES('EDU-03',5,'economy','النقد في الحياة اليومية','العملات ترتبط بالضرائب والجيش والتجارة والمعاملات، مع اختلاف كثافة الاستخدام عبر الزمن والمكان.','SOC-CLM09',NULL,'اربط النقد بمحاور الاقتصاد.');
INSERT INTO "learning_module_steps" VALUES('EDU-04',1,'concept','لا «جنة» ولا «صراع دائم»','العلاقات بين الجماعات تتغير حسب الزمن والمكان والسلطة والقانون؛ لا Narrative واحد يصلح لثمانية قرون.','SOC-CLM01',NULL,'اعرض حالات مختلفة بدل شعار واحد.');
INSERT INTO "learning_module_steps" VALUES('EDU-04',2,'method','هل للقطعة هوية دينية؟','الأسلوب وحده لا يكفي لنسبة قطعة إلى جماعة دينية؛ النقش والسياق أهم.','SOC-CLM04',NULL,'اختبار إسناد الهوية.');
INSERT INTO "learning_module_steps" VALUES('EDU-04',3,'person','صبح: استثناء موثق','وصول صبح إلى نفوذ سياسي كبير حالة موثقة مهمة، لكنها لا تتحول إلى وصف إحصائي لوضع النساء عامة.','SOC-CLM06','PLC-CORDOBA','بطاقة شخص/Claim.');
INSERT INTO "learning_module_steps" VALUES('EDU-04',4,'language','المشهد اللغوي','العربية والرومانسية الأندلسية والعبرية تؤدي أدوارًا مختلفة عبر الفترات والسياقات.','CLM-003',NULL,'اعرض طبقات اللغة بدل خريطة لغة واحدة.');
INSERT INTO "learning_module_steps" VALUES('EDU-05',1,'translation','طليطلة والترجمة','التعاون بين مترجمين من خلفيات متعددة لا يلغي الخلافات حول المؤسسات والأسماء؛ لذلك نوثق عملًا بعمل.','SOC-CLM08','PLC-TOLEDO','اعرض عقدة ترجمة.');
INSERT INTO "learning_module_steps" VALUES('EDU-05',2,'network','الأندلس إلى المشرق','انتقال أشخاص ونصوص وأفكار يُبنى كمسارات موثقة، لا كخطوط سفر تخمينية.','ARC-CLM09','PLC-DAMASCUS','اعرض route مع تحذير التمثيل.');
INSERT INTO "learning_module_steps" VALUES('EDU-05',3,'legacy','ثقافة البلاط','بعض العناصر الأندلسية أصبحت جزءًا من ثقافات بلاط قشتالية، لا مجرد «نسخ» لحظي.','SOC-CLM07','PLC-LEON','فعّل Legacy.');
INSERT INTO "learning_module_steps" VALUES('EDU-05',4,'craft','مانيسس بعد تغير السلطة','استمرار تقنيات البريق المعدني يقدم مثالًا على بقاء الحرفة بعد تغير الإطار السياسي.','SOC-CLM10','PLC-MANISES','قارن الزمن السياسي بزمن التقنية.');
INSERT INTO "learning_module_steps" VALUES('EDU-06',1,'place','نواة القصر','تذكر UNESCO أن النواة الأصلية للقصر في إشبيلية شُيدت في القرن العاشر مقرًا للحاكم المسلم.','ATLAS-CLM04','PLC-SEVILLE','اذهب إلى إشبيلية.');
INSERT INTO "learning_module_steps" VALUES('EDU-06',2,'architecture','القصر الموحدي','بعض غرف وباحات وحدائق القصر الموحدي بقيت داخل مجمع أعيد بناؤه مرارًا.','ATLAS-CLM04','PLC-SEVILLE','فعّل طبقة heritage.');
INSERT INTO "learning_module_steps" VALUES('EDU-06',3,'architecture','الجيرالدا','كانت الجيرالدا مئذنة للمسجد، وتصفها UNESCO بأنها تحفة من العمارة الموحدية.','ATLAS-CLM04','PLC-SEVILLE','أظهر مفهوم reuse.');
INSERT INTO "learning_module_steps" VALUES('EDU-06',4,'concept','الاستمرار لا يعني الثبات','بقاء عنصر معماري لا يعني بقاء وظيفته أو سياقه السياسي؛ القراءة الصحيحة تتتبع التحول أيضًا.','ATLAS-CLM04','PLC-SEVILLE','سؤال انعكاسي.');
CREATE TABLE learning_modules (
  module_id TEXT PRIMARY KEY,
  title_ar TEXT NOT NULL,
  summary_ar TEXT NOT NULL,
  level TEXT NOT NULL,
  estimated_minutes INTEGER,
  period_label TEXT,
  learning_objectives_json TEXT,
  status TEXT NOT NULL,
  version TEXT NOT NULL
);
INSERT INTO "learning_modules" VALUES('EDU-01','كيف نعرف؟ أدلة فتح الأندلس','مدخل في نقد المصادر: لماذا لا نكتفي بالروايات الأدبية المتأخرة، وكيف تعمل العملات والأختام وSource Genealogy معًا.','تمهيدي',22,'711–756','["يميز بين المصدر المعاصر والمتأخر", "يفهم قيمة الفلوس والأختام", "يكتشف الفرق بين الحدث والأسطورة"]','جاهز','0.1');
INSERT INTO "learning_modules" VALUES('EDU-02','قرطبة: من الربض إلى الخلافة','مسار مكاني وزمني من شقندة إلى إعلان الخلافة ومدينة الزهراء والجامع الكبير.','متوسط',28,'750–1031','["يربط التحول السياسي بالعمران", "يفهم وظيفة الدليل الأثري والنقدي", "يقرأ المكان عبر طبقات زمنية"]','جاهز','0.1');
INSERT INTO "learning_modules" VALUES('EDU-03','الحياة اليومية: بيت وورشة وسوق وميناء','تجربة تقرأ الحياة اليومية من بَجّانة وألمرية وشيريسا والعملات وكتب الطبخ بدل الاقتصار على تاريخ الأسر الحاكمة.','متوسط',30,'9–13م','["يتعرف إلى مصادر الحياة اليومية", "يفصل بين النص والممارسة المادية", "يقارن الريف بالمدينة"]','جاهز','0.1');
INSERT INTO "learning_modules" VALUES('EDU-04','مجتمع متعدد… لا قالب واحد','وحدة تفكك التبسيط الشائع لفكرة «الثقافات الثلاث» عبر الهوية والمادة والجندر واللغة.','متوسط',26,'10–14م','["يتجنب تعميم convivencia", "يفهم حدود إسناد الهوية للقطعة", "يرى الاستثناءات دون تحويلها إلى قاعدة"]','جاهز','0.1');
INSERT INTO "learning_modules" VALUES('EDU-05','شبكات المعرفة والامتداد','من طليطلة وغرناطة إلى المشرق، ومن البلاطات إلى الحرف: كيف تنتقل النصوص والأشخاص والتقنيات بعد تغير السلطة.','متقدم',32,'11–15م','["يميز بين طريق شخصي وشبكة معرفة", "يربط الترجمة بالسياق الاجتماعي", "يفهم الامتداد التقني والثقافي"]','جاهز','0.1');
INSERT INTO "learning_modules" VALUES('EDU-06','إشبيلية: طبقات القصر والمئذنة','وحدة قصيرة تقرأ القصر والجيرالدا بوصفهما طبقات أندلسية ثم مسارات إعادة استخدام وتحول معماري بعد 1248م.','تمهيدي',14,'10–16م','["يتعرف إلى الطبقات المعمارية", "يفصل بين البقاء المادي واستمرار الوظيفة", "يفهم معنى إعادة الاستخدام"]','جاهز','0.1');
CREATE TABLE maintenance_owners(
  owner_role TEXT PRIMARY KEY,
  responsibility_ar TEXT NOT NULL,
  scope TEXT NOT NULL,
  backup_role TEXT,
  escalation_days INTEGER NOT NULL,
  status TEXT NOT NULL
);
INSERT INTO "maintenance_owners" VALUES('Research Steward','مراجعة Claims الحساسة، النزاعات المصدرية، وصياغة الادعاء النهائي.','Claims/Evidence','Release Owner',7,'نشط');
INSERT INTO "maintenance_owners" VALUES('Data Maintainer','سلامة SQLite، المخطط، الاستيراد، الروابط بين الكيانات، ونسخ البيانات.','Database/API','Release Owner',3,'نشط');
INSERT INTO "maintenance_owners" VALUES('Source Monitor','صحة الروابط، البدائل الدائمة، تواريخ last_checked، ومراقبة تغيّر المصادر.','Sources','Research Steward',5,'نشط');
INSERT INTO "maintenance_owners" VALUES('Rights Reviewer','مراجعة تراخيص النصوص والصور والوسائط وإعادة الاستخدام.','Rights','Release Owner',7,'نشط');
INSERT INTO "maintenance_owners" VALUES('Education Reviewer','تزامن الوحدات والأسئلة مع Claims ونسخ المحتوى.','Education','Research Steward',7,'نشط');
INSERT INTO "maintenance_owners" VALUES('Release Owner','تشغيل بوابات الإصدار واعتماد manifest ومنع الإصدار عند فشل بوابة.','Release/QA','Data Maintainer',1,'نشط');
CREATE TABLE maintenance_rules (
  rule_id TEXT PRIMARY KEY,
  target_scope TEXT NOT NULL,
  cadence_days INTEGER,
  trigger_condition TEXT,
  action_ar TEXT NOT NULL,
  severity TEXT NOT NULL,
  next_review TEXT,
  status TEXT NOT NULL
, owner_role TEXT);
INSERT INTO "maintenance_rules" VALUES('MNT-001','Claims مفتوحة/حساسة للتحديث',30,'status LIKE ''%مراجعة%'' OR status LIKE ''%حساس%''','إعادة فحص أحدث الأدبيات والمصدر المؤسسي قبل إبقاء صياغة «الأقدم/الأول».','عالٍ','2026-10-23','نشط','Research Steward');
INSERT INTO "maintenance_rules" VALUES('MNT-002','روابط المصادر',30,'أي HTTP 4xx/5xx أو تغيير وجهة','تحديث الرابط مع الحفاظ على المصدر الأصلي وسجل التغيير.','متوسط','2026-10-23','نشط','Source Monitor');
INSERT INTO "maintenance_rules" VALUES('MNT-003','حقوق وإعادة الاستخدام',180,'مصدر جديد أو وسيط جديد','فحص ترخيص النص والصورة كلٌ على حدة قبل النشر.','عالٍ','2027-03-22','نشط','Rights Reviewer');
INSERT INTO "maintenance_rules" VALUES('MNT-004','Gazetteer candidates',60,'مرساة بلا Claim لمدة دورتين','إما ربطها بدليل موثوق أو إبقاؤها مرجعًا مكانيًا منخفض الأولوية.','متوسط','2026-11-22','نشط','Research Steward');
INSERT INTO "maintenance_rules" VALUES('MNT-005','API regression',0,'كل إصدار','تشغيل integrity + endpoints + orphan checks + quiz/claim linkage.','عالٍ',NULL,'نشط','Data Maintainer');
INSERT INTO "maintenance_rules" VALUES('MNT-006','مواد التعليم',90,'تغيير Claim canonical أو Evidence','إعادة توليد السؤال/الشرح المرتبطين بالـClaim المتغير.','عالٍ','2026-12-22','نشط','Education Reviewer');
INSERT INTO "maintenance_rules" VALUES('MNT-007','Release manifest',0,'كل إصدار مرشح','تشغيل QA الكامل، حفظ manifest/hash، وعدم تغيير release_ready إلى 1 إلا إذا مرت كل البوابات.','عالٍ',NULL,'نشط','Release Owner');
INSERT INTO "maintenance_rules" VALUES('MNT-008','Source genealogy/dependencies',90,'مصدر جديد أو تغيير Claim منقول','فحص الاعتماد النصي/المصدري وتسجيل upstream/downstream قبل النشر.','متوسط','2026-12-22','نشط','Research Steward');
CREATE TABLE maintenance_runs(
  run_id TEXT PRIMARY KEY,
  run_date TEXT NOT NULL,
  run_type TEXT NOT NULL,
  result TEXT NOT NULL,
  checks_run INTEGER NOT NULL,
  failures INTEGER NOT NULL,
  note_ar TEXT
);
INSERT INTO "maintenance_runs" VALUES('RUN-20260923-RELEASE','2026-09-23','release-readiness','PASS',16,0,'SQLite integrity + FK + release gates + sustainability ownership/watchlist/health.');
CREATE TABLE periods(period_id TEXT PRIMARY KEY, label_ar TEXT NOT NULL, label_en TEXT, start_earliest INTEGER NOT NULL, start_latest INTEGER NOT NULL,
  end_earliest INTEGER NOT NULL, end_latest INTEGER NOT NULL, hijri TEXT, spatial TEXT, note_ar TEXT, parent_id TEXT,
  CHECK(start_earliest<=start_latest AND end_earliest<=end_latest AND start_earliest<=end_latest));
INSERT INTO "periods" VALUES('PRD-01','الفتح وعصر الولاة','Conquest and Governors',711,711,756,756,'92–138هـ','الأندلس','البداية بعبور 711؛ النهاية بقيام الإمارة الأموية.',NULL);
INSERT INTO "periods" VALUES('PRD-02','الإمارة الأموية','Umayyad Emirate',756,756,929,929,'138–316هـ','الأندلس','= POL-001.',NULL);
INSERT INTO "periods" VALUES('PRD-03','الخلافة الأموية','Umayyad Caliphate',929,929,1009,1031,'316–399/422هـ','الأندلس','تعريفان للنهاية: 1009 (بداية الفتنة) أو 1031 (إلغاء الخلافة رسميًا). = POL-002 (929–1031).',NULL);
INSERT INTO "periods" VALUES('PRD-03a','الفتنة','Fitna of al-Andalus',1009,1009,1031,1031,'399–422هـ','الأندلس','مرحلة فرعية داخل PRD-03 أو انتقالية إلى الطوائف بحسب التعريف المختار.','PRD-03');
INSERT INTO "periods" VALUES('PRD-04','ملوك الطوائف الأولى','First Taifa Period',1009,1031,1086,1091,'5هـ','الأندلس','البداية تتداخل مع الفتنة؛ النهاية بين الزلاقة 1086 وخلع ملوك الطوائف 1090–1091.',NULL);
INSERT INTO "periods" VALUES('PRD-05','المرابطون في الأندلس','Almoravid al-Andalus',1086,1091,1145,1147,'479/484–540/542هـ','الأندلس','= POL-006. نهاية مرنة مع الطوائف الثانية.',NULL);
INSERT INTO "periods" VALUES('PRD-05a','الطوائف الثانية','Second Taifa Period',1144,1145,1147,1172,'539–568هـ تقريبًا','الأندلس','تتفاوت نهايتها بحسب الإقليم (مثل مرسية ابن مردنيش حتى 1172).',NULL);
INSERT INTO "periods" VALUES('PRD-06','الموحدون في الأندلس','Almohad al-Andalus',1147,1147,1228,1232,'541–625/629هـ','الأندلس','= POL-007. تعريف النهاية: الانسحاب من الأندلس أو قيام ابن هود.',NULL);
INSERT INTO "periods" VALUES('PRD-06a','الطوائف الثالثة والانتقال','Third Taifas / transition',1228,1228,1238,1248,'625–646هـ','الأندلس','ابن هود وسقوط قرطبة 1236 وإشبيلية 1248.',NULL);
INSERT INTO "periods" VALUES('PRD-07','غرناطة النصرية','Nasrid Granada',1232,1238,1492,1492,'629/635–897هـ','مملكة غرناطة','= POL-008. البداية: إعلان ابن الأحمر 1232 أو دخول غرناطة 1238.',NULL);
INSERT INTO "periods" VALUES('PRD-08','المدجنون والموريسكيون','Mudejars and Moriscos',1492,1502,1609,1614,'897–1023هـ','إيبيريا المسيحية','من سقوط غرناطة/التنصير القسري حتى الطرد.',NULL);
CREATE TABLE person_name_parts(entity_id TEXT PRIMARY KEY, ism TEXT, kunya TEXT, nasab TEXT, nisba TEXT, laqab TEXT, origin TEXT NOT NULL,
  FOREIGN KEY(entity_id) REFERENCES entities(entity_id));
INSERT INTO "person_name_parts" VALUES('PER-001','عبد الرحمن','أبو المطرف','بن معاوية بن هشام بن عبد الملك','الأموي','الداخل','ref — تُطابق مع PUA قبل النشر');
INSERT INTO "person_name_parts" VALUES('PER-002','عبد الرحمن','أبو المطرف','بن محمد بن عبد الله','الأموي','الناصر لدين الله','ref — تُطابق مع PUA قبل النشر');
INSERT INTO "person_name_parts" VALUES('PER-ALHAKAM-II','الحكم','أبو العاص','بن عبد الرحمن الناصر','الأموي','المستنصر بالله','ref — تُطابق مع PUA قبل النشر');
INSERT INTO "person_name_parts" VALUES('PER-004','محمد','أبو عامر','بن عبد الله بن أبي عامر','المعافري','المنصور','ref — تُطابق مع PUA قبل النشر');
INSERT INTO "person_name_parts" VALUES('PER-005','حيان','أبو مروان','بن خلف بن حسين بن حيان','القرطبي','','ref — تُطابق مع PUA قبل النشر');
INSERT INTO "person_name_parts" VALUES('PER-006','علي','أبو محمد','بن أحمد بن سعيد بن حزم','القرطبي; الظاهري','','ref — تُطابق مع PUA قبل النشر');
INSERT INTO "person_name_parts" VALUES('PER-007','أحمد','أبو الوليد','بن عبد الله بن زيدون','المخزومي','','ref — تُطابق مع PUA قبل النشر');
INSERT INTO "person_name_parts" VALUES('PER-008','ولادة','','بنت محمد المستكفي','الأموية','','ref — تُطابق مع PUA قبل النشر');
INSERT INTO "person_name_parts" VALUES('PER-009','محمد','أبو القاسم','بن عباد بن محمد','','المعتمد على الله','ref — تُطابق مع PUA قبل النشر');
INSERT INTO "person_name_parts" VALUES('PER-011','صاعد','أبو القاسم','بن أحمد','الأندلسي; الطليطلي','','ref — تُطابق مع PUA قبل النشر');
INSERT INTO "person_name_parts" VALUES('PER-012','خلف','أبو القاسم','بن عباس','الزهراوي','','ref — تُطابق مع PUA قبل النشر');
INSERT INTO "person_name_parts" VALUES('PER-013','إبراهيم','أبو إسحاق','بن يحيى','النقاش','الزرقالي','ref — تُطابق مع PUA قبل النشر');
INSERT INTO "person_name_parts" VALUES('PER-015','محمد','أبو بكر','بن عبد الملك بن طفيل','القيسي','','ref — تُطابق مع PUA قبل النشر');
INSERT INTO "person_name_parts" VALUES('PER-016','محمد','أبو الوليد','بن أحمد بن محمد بن رشد','القرطبي','الحفيد','ref — تُطابق مع PUA قبل النشر');
INSERT INTO "person_name_parts" VALUES('PER-017','محمد','أبو بكر','بن علي بن محمد','الحاتمي; الطائي','محيي الدين','ref — تُطابق مع PUA قبل النشر');
INSERT INTO "person_name_parts" VALUES('PER-018','محمد','أبو عبد الله','بن عبد الله','السلماني','لسان الدين','ref — تُطابق مع PUA قبل النشر');
INSERT INTO "person_name_parts" VALUES('PER-019','علي','أبو الحسن','بن موسى بن سعيد','المغربي','','ref — تُطابق مع PUA قبل النشر');
INSERT INTO "person_name_parts" VALUES('PER-020','محمد','أبو عبد الله','بن محمد','الإدريسي','','ref — تُطابق مع PUA قبل النشر');
INSERT INTO "person_name_parts" VALUES('PER-021','عبد الله','أبو محمد','بن أحمد','المالقي','ضياء الدين','ref — تُطابق مع PUA قبل النشر');
INSERT INTO "person_name_parts" VALUES('PER-022','محمد','أبو بكر','بن عيسى بن عبد الملك بن قزمان','القرطبي','','ref — تُطابق مع PUA قبل النشر');
INSERT INTO "person_name_parts" VALUES('PER-023','حفصة','','بنت الحاج','الركونية','','ref — تُطابق مع PUA قبل النشر');
INSERT INTO "person_name_parts" VALUES('PER-024','إسماعيل','أبو إبراهيم','بن يوسف بن نغريلة','','الناغيد (بالعبرية)','ref — تُطابق مع PUA قبل النشر');
INSERT INTO "person_name_parts" VALUES('PER-030','محمد','أبو عبد الله','بن يوسف بن نصر','الأنصاري الخزرجي','الغالب بالله','ref — تُطابق مع PUA قبل النشر');
INSERT INTO "person_name_parts" VALUES('PER-031','محمد','أبو عبد الله','بن علي بن سعد','النصري','','ref — تُطابق مع PUA قبل النشر');
CREATE TABLE place_geometry (
  entity_id TEXT PRIMARY KEY,
  lat REAL NOT NULL,
  lon REAL NOT NULL,
  geometry_type TEXT NOT NULL DEFAULT 'Point',
  spatial_quality TEXT NOT NULL,
  anchor_type TEXT,
  coordinate_source TEXT,
  last_verified TEXT,
  FOREIGN KEY(entity_id) REFERENCES entities(entity_id)
);
INSERT INTO "place_geometry" VALUES('PLC-CORDOBA',37.8914,-4.7725,'Point','municipal centroid','modern city anchor','https://www.geonames.org/search.html?country=ES&q=','2026-09-23');
INSERT INTO "place_geometry" VALUES('PLC-GRANADA',37.18817,-3.60667,'Point','municipal centroid','modern city anchor','https://www.geonames.org/2517117/granada.html','2026-09-23');
INSERT INTO "place_geometry" VALUES('PLC-ALMARIYYA',36.83814,-2.45974,'Point','municipal centroid','modern city anchor','https://www.geonames.org/search.html?country=ES&q=','2026-09-23');
INSERT INTO "place_geometry" VALUES('PLC-PECHINA',36.9667,-2.4,'Point','municipal centroid','modern municipality anchor','https://www.geonames.org/advanced-search.html?country=ES&q=Ba%C3%B1os','2026-09-23');
INSERT INTO "place_geometry" VALUES('PLC-XERESA',39.01667,-0.21667,'Point','municipal centroid','modern municipality anchor','https://www.geonames.org/advanced-search.html?country=ES&q=Valensija&startRow=200','2026-09-23');
INSERT INTO "place_geometry" VALUES('PLC-TOLEDO',39.85806,-4.0225,'Point','municipal centroid','modern city anchor','https://www.geonames.org/search.html?country=ES&q=','2026-09-23');
INSERT INTO "place_geometry" VALUES('PLC-LEON',42.60003,-5.57032,'Point','municipal centroid','modern city anchor','https://www.geonames.org/3118532/leon.html','2026-09-23');
INSERT INTO "place_geometry" VALUES('PLC-MANISES',39.49139,-0.46349,'Point','municipal centroid','modern municipality anchor','https://www.geonames.org/advanced-search.html?q=Valencia%2F&startRow=50','2026-09-23');
INSERT INTO "place_geometry" VALUES('PLC-BAIREN',38.96667,-0.18333,'Point','municipal anchor, not exact fortress','modern Gandia anchor','https://www.geonames.org/search.html?country=ES&q=Costa&startRow=0','2026-09-23');
INSERT INTO "place_geometry" VALUES('PLC-EL-MOLON',39.65,-1.4,'Point','municipal anchor, not exact site','Camporrobles anchor','https://www.geonames.org/search.html?country=ES&q=&startRow=950','2026-09-23');
INSERT INTO "place_geometry" VALUES('PLC-TOSSAL-VILA',40.269,-0.019,'Point','municipal anchor, not exact site','Sierra Engarcerán anchor','https://www.geonames.org/postal-codes/ES/VC/CS/castellon.html','2026-09-23');
INSERT INTO "place_geometry" VALUES('PLC-DAMASCUS',33.51563,36.28032,'Point','administrative centroid','modern city/admin anchor','https://www.geonames.org/advanced-search.html?country=SY&q=Damas','2026-09-23');
INSERT INTO "place_geometry" VALUES('PLC-MADINAT-ZAHRA',37.8858889,-4.8676944,'Point','UNESCO property representative coordinate','UNESCO World Heritage property point','https://whc.unesco.org/en/list/1560/','2026-09-23');
INSERT INTO "place_geometry" VALUES('PLC-CORDOBA-WH',37.8791944,-4.7797222,'Point','UNESCO property representative coordinate','UNESCO World Heritage property point','https://whc.unesco.org/en/list/313','2026-09-23');
INSERT INTO "place_geometry" VALUES('PLC-ALHAMBRA-WH',37.1767778,-3.5899167,'Point','UNESCO property representative coordinate','UNESCO World Heritage property point','https://whc.unesco.org/en/list/314','2026-09-23');
INSERT INTO "place_geometry" VALUES('PLC-SAQUNDA',37.8791944,-4.7797222,'Point','city-level anchor, not exact excavation','Cordoba UNESCO property point used as city anchor','https://whc.unesco.org/en/list/313','2026-09-23');
INSERT INTO "place_geometry" VALUES('PLC-SEVILLE',37.382826,-5.973167,'Point','municipal/city centroid','modern city anchor','https://www.geonames.org/advanced-search.html?country=ES&q=Spagna','2026-09-23');
INSERT INTO "place_geometry" VALUES('PLC-ZARAGOZA',41.6560643302881,-0.877339839935303,'Point','municipal/city centroid','modern city anchor','https://www.geonames.org/advanced-search.html?country=ES&q=Spagna','2026-09-23');
INSERT INTO "place_geometry" VALUES('PLC-VALENCIA',39.47391,-0.37966,'Point','municipal/city centroid','modern city anchor','https://www.geonames.org/advanced-search.html?country=ES&q=Spagna','2026-09-23');
INSERT INTO "place_geometry" VALUES('PLC-MALAGA',36.7201559059499,-4.42034482955933,'Point','municipal/city centroid','modern city anchor','https://www.geonames.org/advanced-search.html?country=ES&q=Spagna','2026-09-23');
INSERT INTO "place_geometry" VALUES('PLC-MURCIA',37.987041,-1.130042,'Point','municipal/city centroid','modern city anchor','https://www.geonames.org/advanced-search.html?country=ES&q=Spagna','2026-09-23');
INSERT INTO "place_geometry" VALUES('PLC-PALMA',39.5693907933761,2.65023708343506,'Point','municipal/city centroid','modern city anchor','https://www.geonames.org/advanced-search.html?country=ES&q=Spagna','2026-09-23');
INSERT INTO "place_geometry" VALUES('PLC-ALICANTE',38.3451735357475,-0.481488704681396,'Point','municipal/city centroid','modern city anchor','https://www.geonames.org/advanced-search.html?country=ES&q=Spagna','2026-09-23');
INSERT INTO "place_geometry" VALUES('PLC-BADAJOZ',38.877894,-6.970613,'Point','municipal/city centroid','modern city anchor','https://www.geonames.org/advanced-search.html?country=ES&q=Spagna','2026-09-23');
INSERT INTO "place_geometry" VALUES('PLC-RONDA',36.742305959004,-5.16709327697754,'Point','municipal/city centroid','modern city anchor','https://www.geonames.org/advanced-search.html?continentCode=EU&featureClass=P&q=&startRow=4200','2026-09-23');
INSERT INTO "place_geometry" VALUES('PLC-JAEN',3.77692221020112199e+01,-3.790283203125,'Point','municipal/city centroid','modern city anchor','https://www.geonames.org/advanced-search.html?country=ES&q=Spagna','2026-09-23');
INSERT INTO "place_geometry" VALUES('PLC-HUELVA',37.266385,-6.940044,'Point','municipal/city centroid','modern city anchor','https://www.geonames.org/advanced-search.html?country=ES&q=Spagna','2026-09-23');
INSERT INTO "place_geometry" VALUES('PLC-ECIJA',37.5422,-5.0826,'Point','municipal/city centroid','modern city anchor','https://www.geonames.org/2518770','2026-09-23');
INSERT INTO "place_geometry" VALUES('PLC-MEDINA-SIDONIA',36.39688,-5.8675,'Point','municipal area centroid, not exact historic core','modern municipality anchor','https://www.geonames.org/6356938/medina-sidonia.html','2026-09-23');
INSERT INTO "place_geometry" VALUES('PLC-TORTOSA',40.81,0.522,'Point','postal locality coordinate','modern locality anchor','https://www.geonames.org/postal-codes/ES/CT/T/tarragona.html','2026-09-23');
INSERT INTO "place_geometry" VALUES('PLC-ALGECIRAS',36.133257,-5.450511,'Point','municipal/city centroid','modern city anchor','https://www.geonames.org/advanced-search.html?country=ES&q=Spagna','2026-09-23');
INSERT INTO "place_geometry" VALUES('PLC-MERIDA',38.91778,-6.34278,'Point','municipal/city centroid','modern city anchor','https://www.geonames.org/search.html?q=Espa%C3%B1a','2026-09-23');
INSERT INTO "place_geometry" VALUES('PLC-008',38.8408,0.1057,'Point','municipal/city centroid','modern city anchor','andalus_knowledge_base v4.9 — المعجم الجغرافي','2026-09-23');
INSERT INTO "place_geometry" VALUES('PLC-013',37.6382,-7.6639,'Point','archaeological site point','site point','andalus_knowledge_base v4.9 — المعجم الجغرافي','2026-09-23');
INSERT INTO "place_geometry" VALUES('PLC-014',37.1892,-8.4382,'Point','municipal/city centroid','modern city anchor','andalus_knowledge_base v4.9 — المعجم الجغرافي','2026-09-23');
INSERT INTO "place_geometry" VALUES('PLC-015',38.7223,-9.1393,'Point','municipal/city centroid','modern city anchor','andalus_knowledge_base v4.9 — المعجم الجغرافي','2026-09-23');
INSERT INTO "place_geometry" VALUES('PLC-016',39.2369,-8.685,'Point','municipal/city centroid','modern city anchor','andalus_knowledge_base v4.9 — المعجم الجغرافي','2026-09-23');
INSERT INTO "place_geometry" VALUES('PLC-017',38.0151,-7.8632,'Point','municipal/city centroid','modern city anchor','andalus_knowledge_base v4.9 — المعجم الجغرافي','2026-09-23');
INSERT INTO "place_geometry" VALUES('PLC-019',42.1401,-0.4089,'Point','municipal/city centroid','modern city anchor','andalus_knowledge_base v4.9 — المعجم الجغرافي','2026-09-23');
INSERT INTO "place_geometry" VALUES('PLC-C01',37.1858,-3.5925,'Point','district centroid','modern city anchor','GeoNames 2518754 El Albaicín (N 37°11′9″ W 3°35′33″)','2026-09-23');
INSERT INTO "place_geometry" VALUES('PLC-C06',37.2992,-3.1392,'Point','municipal/city centroid','modern city anchor','GeoNames 2516925 Guadix (N 37°17′57″ W 3°8′21″)','2026-09-23');
INSERT INTO "place_geometry" VALUES('PLC-G01',37.1768,-3.5899,'Point','archaeological site point','site point','UNESCO 314 (property coordinates N37 10 36.4 W3 35 23.7); consistent with GeoNames 7302839 Alhambra (N 37°10′36″ W 3°35′23″)','2026-09-23');
INSERT INTO "place_geometry" VALUES('PLC-G02',37.1778,-3.5853,'Point','archaeological site point','site point','GeoNames 8849185 Palacio de Generalife (N 37°10′40″ W 3°35′7″)','2026-09-23');
INSERT INTO "place_geometry" VALUES('PLC-G03',37.4906,-2.7725,'Point','municipal/city centroid','modern city anchor','GeoNames 2521215 Baza (N 37°29′26″ W 2°46′21″)','2026-09-23');
INSERT INTO "place_geometry" VALUES('PLC-G04',37.1686,-4.1511,'Point','municipal/city centroid','modern city anchor','GeoNames 2514946 Loja (N 37°10′7″ W 4°9′4″)','2026-09-23');
INSERT INTO "place_geometry" VALUES('PLC-G05',36.7322,-3.6917,'Point','municipal/city centroid','modern city anchor','GeoNames 2521847 Almuñécar (N 36°43′56″ W 3°41′30″)','2026-09-23');
CREATE TABLE qa_test_runs (
  qa_id TEXT PRIMARY KEY,
  run_date TEXT NOT NULL,
  gate TEXT NOT NULL,
  test_name TEXT NOT NULL,
  result TEXT NOT NULL,
  observed_value TEXT,
  target_value TEXT,
  note_ar TEXT
);
INSERT INTO "qa_test_runs" VALUES('QA-001','2026-09-23','Database','SQLite integrity','PASS','ok','ok','سلامة القاعدة');
INSERT INTO "qa_test_runs" VALUES('QA-002','2026-09-23','Education','كل سؤال مرتبط بـClaim موجود','PASS','0','0','لا أسئلة يتيمة');
INSERT INTO "qa_test_runs" VALUES('QA-003','2026-09-23','Education','كل خطوة تعليمية مرتبطة بـClaim عند وجود claim_id','PASS','0','0','لا روابط مكسورة');
INSERT INTO "qa_test_runs" VALUES('QA-004','2026-09-23','Atlas','المواقع verified_claim_linked لها Claim','PASS','checked','0 orphan verified place','فحص ترابط');
INSERT INTO "qa_test_runs" VALUES('QA-005','2026-09-23','Sources','Claims الجديدة لها source rights','PASS','0','0','حقوق مصدر إشبيلية مسجلة');
INSERT INTO "qa_test_runs" VALUES('QA-006','2026-09-23','Education','عدد الوحدات التعليمية','PASS','6','>=6','ست وحدات');
INSERT INTO "qa_test_runs" VALUES('QA-007','2026-09-23','Education','عدد أسئلة التقويم','PASS','15','>=15','بنك أسئلة أولي');
INSERT INTO "qa_test_runs" VALUES('QA-008','2026-09-23','Sustainability','قواعد الصيانة','PASS','6','>=6','بذرة استدامة تشغيلية');
INSERT INTO "qa_test_runs" VALUES('QA-009','2026-09-23','Sustainability','Operational owner roles defined','PASS','6','>=6','ملكية تشغيلية role-based موثقة مع backup/escalation.');
INSERT INTO "qa_test_runs" VALUES('QA-010','2026-09-23','Sustainability','Active maintenance rules have owners','PASS','0','0','لا قواعد نشطة بلا مالك.');
INSERT INTO "qa_test_runs" VALUES('QA-011','2026-09-23','Sustainability','Critical source watchlist','PASS','8','>=8','ثمانية مصادر حرجة بدورة فحص شهرية.');
INSERT INTO "qa_test_runs" VALUES('QA-012','2026-09-23','Sustainability','Critical source health snapshot','PASS','8','8/8 have usable access/fallback','جميع المصادر الحرجة لها وصول مباشر أو fallback موثق.');
INSERT INTO "qa_test_runs" VALUES('QA-013','2026-09-23','Sustainability','Release manifest policy','PASS','MNT-007','required','منع release_ready ما لم تمر كل البوابات.');
INSERT INTO "qa_test_runs" VALUES('QA-014','2026-09-23','QA','Source genealogy maintenance','PASS','MNT-008','active','قاعدة مراجعة دورية للاعتماد المصدري.');
INSERT INTO "qa_test_runs" VALUES('QA-015','2026-09-23','QA','Foreign key check','PASS','0','0','PRAGMA foreign_key_check بلا مخالفات.');
INSERT INTO "qa_test_runs" VALUES('QA-016','2026-09-23','Release','All release gates','PASS','8','8','جميع بوابات المشروع PASS بعد إغلاق الاستدامة.');
INSERT INTO "qa_test_runs" VALUES('QA-017','2026-09-23','Evidence','كل Claim canonical له Evidence record','PASS','0','0','تم تطبيع Evidence packet للادعاءات التي كان دليلها موجودًا في المصادر فقط.');
INSERT INTO "qa_test_runs" VALUES('QA-018','2026-09-23','Publishing','كل Claim canonical له Source','PASS','0','0','لا Claims منشورة بلا مصدر.');
INSERT INTO "qa_test_runs" VALUES('QA-019','2026-09-23','Publishing','كل مكان جغرافي له coordinate source','PASS','0','0','كل مرساة مكانية تحتفظ بالمصدر وجودة الإسناد.');
INSERT INTO "qa_test_runs" VALUES('QA-020','2026-09-23','Publishing','حقوق الصور والنصوص خارج النطاق','PASS','external media=0; full literary text=0','0 unlicensed republished items','الإصدار ينشر بيانات/Claims فقط؛ الوسائط والنصوص الكاملة محجوبة حتى rights check.');
CREATE TABLE quiz_items (
  quiz_id TEXT PRIMARY KEY,
  module_id TEXT NOT NULL,
  ordinal INTEGER NOT NULL,
  question_type TEXT NOT NULL,
  prompt_ar TEXT NOT NULL,
  choices_json TEXT NOT NULL,
  correct_index INTEGER NOT NULL,
  explanation_ar TEXT NOT NULL,
  claim_id TEXT NOT NULL,
  difficulty TEXT NOT NULL,
  status TEXT NOT NULL,
  FOREIGN KEY(module_id) REFERENCES learning_modules(module_id),
  FOREIGN KEY(claim_id) REFERENCES claims(claim_id)
);
INSERT INTO "quiz_items" VALUES('Q-001','EDU-01',1,'mcq','أي نوع من الأدلة يفيد مباشرة في دراسة الجباية والضم المبكر؟','["كتب طبخ القرن 13", "الأختام/precintos والفلوس", "عمارة مانيسس", "قصر الحمراء"]',1,'الفلوس والأختام من أهم الأدلة المادية للقرنين 8–9، ويمكن أن تقدم قرائن على الجباية والضم والتبادل.','CLM-011','سهل','جاهز');
INSERT INTO "quiz_items" VALUES('Q-002','EDU-01',2,'mcq','لماذا لا تُنشر رواية حرق السفن كحقيقة ثابتة؟','["لأنها محرمة شرعًا", "لأنها وردت في نقش معاصر", "لأنها تظهر في تقاليد متأخرة والبحث الحديث يشكك فيها", "لأن طارق لم يصل إلى الأندلس"]',2,'المشكلة مصدرية: شهرة الرواية لا تعوض تأخر تقاليدها وضعف ثبوتها.','CLM-002','سهل','جاهز');
INSERT INTO "quiz_items" VALUES('Q-003','EDU-01',3,'mcq','ما وظيفة Source Genealogy؟','["رسم أنساب الأسر فقط", "تتبع اعتماد الروايات والنصوص على مصادر أقدم", "تحديد الإحداثيات", "حساب أسعار العملات"]',1,'الهدف معرفة طبقة المصدر ومسافة الخبر عن الحدث، وعدم معاملة النص المتأخر كشاهد عيان.','CLM-018','متوسط','جاهز');
INSERT INTO "quiz_items" VALUES('Q-004','EDU-02',1,'mcq','ما الذي يميز شقندة كمصدر لفهم قرطبة المبكرة؟','["قصائد فقط", "حفر واسع مؤرخ 750–818م", "خريطة عثمانية", "مخطوط طبخ"]',1,'الحفر الواسع يقدم سجلًا مباشرًا للعمران والثقافة المادية والحياة اليومية قبل 818م.','RUR-CLM04','سهل','جاهز');
INSERT INTO "quiz_items" VALUES('Q-005','EDU-02',2,'mcq','متى أعلن عبد الرحمن الثالث الخلافة وفق Claim المتحقق؟','["711م", "756م", "929م", "1031م"]',2,'الـClaim canonical يثبت الإعلان في 16 يناير 929م.','CLM-001','سهل','جاهز');
INSERT INTO "quiz_items" VALUES('Q-006','EDU-02',3,'mcq','مدينة الزهراء في نموذج الأطلس تُقرأ أساسًا بوصفها:','["ميناء تجاري فقط", "مدينة جديدة للخلافة ذات بنية حضرية", "مقبرة ريفية", "مدرسة ترجمة"]',1,'UNESCO تصفها كمدينة جديدة للخلافة مع طرق ومياه ومبانٍ وأشياء يومية.','ATLAS-CLM01','سهل','جاهز');
INSERT INTO "quiz_items" VALUES('Q-007','EDU-03',1,'mcq','ما تسلسل بَجّانة الأثري المهم في هذه الوحدة؟','["قصر ثم ميناء", "فرن خزف مزجج ثم حي إسلامي", "مقبرة ثم كنيسة", "سد ثم منجم"]',1,'الحفريات توثق مركز إنتاج خزف مزجج ثم حيًا بمساكن وشوارع ومحلات وورش.','ARC-CLM04','متوسط','جاهز');
INSERT INTO "quiz_items" VALUES('Q-008','EDU-03',2,'mcq','لماذا لا تمثل كتب الطبخ كل المجتمع تلقائيًا؟','["لأنها بلا لغة", "لأنها نصوص قد تعكس بيئات وطبقات محددة وتحتاج مقارنة بأدلة أخرى", "لأنها كلها حديثة", "لأنها لا تحتوي وصفات"]',1,'المصدر النصي مهم، لكن تحويله إلى وصف شامل لكل السكان يتجاوز دلالته.','ARC-CLM07','متوسط','جاهز');
INSERT INTO "quiz_items" VALUES('Q-009','EDU-04',1,'mcq','أي عبارة أقرب لقاعدة التحرير في موضوع convivencia؟','["تسامح كامل دائم", "صراع ديني دائم", "علاقات متغيرة تجمع التعاون والتوتر والتراتبية بحسب السياق", "لا توجد جماعات دينية"]',2,'المشروع يرفض السردية الأحادية في الاتجاهين ويطلب التفكيك زمانيًا ومكانيًا.','SOC-CLM01','سهل','جاهز');
INSERT INTO "quiz_items" VALUES('Q-010','EDU-04',2,'mcq','هل يكفي الأسلوب الفني وحده لنسبة قطعة إلى هوية يهودية؟','["نعم دائمًا", "لا؛ يلزم نقش أو سياق أو دليل إضافي", "فقط إذا كانت من القرن 10", "فقط إذا كانت ذهبية"]',1,'الثقافة المادية اليومية قد تتشارك أشكالًا وتقنيات بين الجماعات.','SOC-CLM04','سهل','جاهز');
INSERT INTO "quiz_items" VALUES('Q-011','EDU-05',1,'mcq','كيف نمثل انتقال المعرفة من الأندلس إلى المشرق؟','["كخط سفر دقيق دون مصادر", "كمسارات أشخاص/أعمال موثقة مع تمييز ما نعرفه عما نفترضه", "كحدود سياسية", "كقائمة مدن بلا مصادر"]',1,'الخطوط التعليمية لا تصبح طريق سفر تاريخيًا إلا إذا توفرت أدلة على المحطات والمسار.','ARC-CLM09','متوسط','جاهز');
INSERT INTO "quiz_items" VALUES('Q-012','EDU-05',2,'mcq','ما الذي يوضحه خزف مانيسس في المشروع؟','["توقف كل التقنيات بعد تغير السلطة", "استمرار تقنيات فنية أندلسية/نصرية في بيئة سياسية لاحقة", "أنه موقع في دمشق", "أنه عملة"]',1,'الاستمرار التقني لا يطابق دائمًا حدود الدولة السياسية.','SOC-CLM10','متوسط','جاهز');
INSERT INTO "quiz_items" VALUES('Q-013','EDU-06',1,'mcq','ماذا كانت الجيرالدا أصلًا؟','["برجًا رومانيًا", "مئذنة مسجد", "حصنًا بحريًا", "مخزنًا"]',1,'تصف UNESCO الجيرالدا بأنها المئذنة السابقة للمسجد وتحفة من العمارة الموحدية.','ATLAS-CLM04','سهل','جاهز');
INSERT INTO "quiz_items" VALUES('Q-014','EDU-06',2,'mcq','ما تاريخ النواة الأصلية للقصر وفق UNESCO؟','["القرن 8", "القرن 10", "القرن 13 فقط", "القرن 16"]',1,'النواة الأصلية للقصر شُيدت في القرن العاشر مقرًا للحاكم المسلم.','ATLAS-CLM04','سهل','جاهز');
INSERT INTO "quiz_items" VALUES('Q-015','EDU-06',3,'mcq','ما القاعدة المنهجية عند رؤية عنصر أندلسي باقٍ بعد تغير السلطة؟','["نفترض بقاء الوظيفة والسياسة كما هي", "نميز بين بقاء العنصر وتغير الوظيفة والسياق", "نهمل العنصر", "ننسبه تلقائيًا للعصر المتأخر فقط"]',1,'الاستمرار المادي يمكن أن يترافق مع تحول في الوظيفة والمعنى والسياق السياسي.','ATLAS-CLM04','متوسط','جاهز');
CREATE TABLE relations (
  relation_id TEXT PRIMARY KEY,
  subject_id TEXT NOT NULL,
  predicate TEXT NOT NULL,
  object_id TEXT NOT NULL,
  confidence TEXT,
  claim_id TEXT,
  FOREIGN KEY (subject_id) REFERENCES entities(entity_id),
  FOREIGN KEY (object_id) REFERENCES entities(entity_id),
  FOREIGN KEY (claim_id) REFERENCES claims(claim_id)
);
INSERT INTO "relations" VALUES('REL-001','OBJ-SUBH-PYXIS','made_for','PER-SUBH','high','SOC-CLM06');
INSERT INTO "relations" VALUES('REL-002','PER-ALHAKAM-II','commissioned','OBJ-SUBH-PYXIS','high','SOC-CLM06');
INSERT INTO "relations" VALUES('REL-003','PER-SUBH','mother_of','PER-HISHAM-II','high','SOC-CLM06');
INSERT INTO "relations" VALUES('REL-004','WRK-IBN-LUYUN-AGRI','authored_by','PER-IBN-LUYUN','high','CLM-MS01');
INSERT INTO "relations" VALUES('REL-005','MS-IBN-LUYUN-EEA','copy_of','WRK-IBN-LUYUN-AGRI','high','CLM-MS01');
INSERT INTO "relations" VALUES('REL-006','RES-AMOI','built_on','RES-HATA','high','RUR-CLM06');
INSERT INTO "relations" VALUES('REL-007','RES-AMOI','planned_link_to','RES-PUA','high','RUR-CLM06');
INSERT INTO "relations" VALUES('REL-008','PER-GERARD-CREMONA','active_in','PLC-TOLEDO','عالٍ','SOC-CLM08');
INSERT INTO "relations" VALUES('REL-009','PER-GUNDISSALINUS','active_in','PLC-TOLEDO','عالٍ','SOC-CLM08');
INSERT INTO "relations" VALUES('REL-010','PER-GUNDISSALINUS','collaborated_with','PER-ABRAHAM-IBN-DAUD','متوسط-عالٍ','SOC-CLM08');
INSERT INTO "relations" VALUES('REL-011','PER-GUNDISSALINUS','translated','WRK-AVICENNA-DE-ANIMA','متوسط-عالٍ','SOC-CLM08');
INSERT INTO "relations" VALUES('REL-012','PER-AL-JILYANI','associated_with','PLC-GRANADA','عالٍ','ARC-CLM09');
INSERT INTO "relations" VALUES('REL-013','PER-AL-JILYANI','died_in','PLC-DAMASCUS','عالٍ','ARC-CLM09');
INSERT INTO "relations" VALUES('REL-014','PER-AL-JILYANI','authored','WRK-MANADIH','عالٍ','ARC-CLM09');
INSERT INTO "relations" VALUES('REL-015','WRK-MANADIH','addressed_to','PER-SALADIN','متوسط-عالٍ','ARC-CLM09');
INSERT INTO "relations" VALUES('REL-016','PER-IBN-RAZIN','authored','WRK-FUDALAT','عالٍ','ARC-CLM07');
INSERT INTO "relations" VALUES('REL-017','OBJ-LEON-ARCH','located_in','PLC-LEON','عالٍ','SOC-CLM07');
INSERT INTO "relations" VALUES('REL-018','OBJ-MANISES-LUSTER','produced_in','PLC-MANISES','عالٍ','SOC-CLM10');
INSERT INTO "relations" VALUES('REL-ATLAS-001','PLC-MADINAT-ZAHRA','near/within cultural landscape of','PLC-CORDOBA','عالٍ','ATLAS-CLM01');
INSERT INTO "relations" VALUES('REL-ATLAS-002','PLC-CORDOBA-WH','part_of','PLC-CORDOBA','عالٍ','ATLAS-CLM02');
INSERT INTO "relations" VALUES('REL-ATLAS-003','PLC-ALHAMBRA-WH','part_of','PLC-GRANADA','عالٍ','ATLAS-CLM03');
INSERT INTO "relations" VALUES('REL-ATLAS-004','PLC-SAQUNDA','part_of_historic_urban_context','PLC-CORDOBA','عالٍ','RUR-CLM04');
CREATE TABLE release_gates (
  gate_id TEXT PRIMARY KEY,
  label_ar TEXT NOT NULL,
  status TEXT NOT NULL,
  evidence_ar TEXT,
  last_checked TEXT NOT NULL
);
INSERT INTO "release_gates" VALUES('GATE-POP','Population','PASS','تم بناء طبقات أشخاص/أماكن/أدلة/Claims متعددة المحاور.','2026-09-23');
INSERT INTO "release_gates" VALUES('GATE-VER','Verification','PASS','قائمة الأولوية السابقة أغلقت مع بقاء Claims حساسة للتحديث كمراقبة لا كمانع.','2026-09-23');
INSERT INTO "release_gates" VALUES('GATE-DB','Database/API','PASS','SQLite + API read endpoints + OpenAPI + integrity checks.','2026-09-23');
INSERT INTO "release_gates" VALUES('GATE-ATLAS','Atlas','PASS','Gazetteer + GeoJSON + طبقات + قصص + جودة إسناد مكاني.','2026-09-23');
INSERT INTO "release_gates" VALUES('GATE-IX','Interactive Experience','PASS','Prototype v0.3: خريطة/زمن/مرشحات/قصص/تعلم/اختبار.','2026-09-23');
INSERT INTO "release_gates" VALUES('GATE-EDU','Education','PASS','6 وحدات و15 سؤالًا مرتبطة مباشرة بـClaims.','2026-09-23');
INSERT INTO "release_gates" VALUES('GATE-QA','QA','PASS','اختبارات قاعدة/روابط/تعليم/حقوق مع regression suite.','2026-09-23');
INSERT INTO "release_gates" VALUES('GATE-SUS','Sustainability','PASS','ملكية تشغيلية موثقة لـ6 أدوار + 8 قواعد صيانة مالكة + watchlist لـ8 مصادر حرجة + source-health snapshot + regression/CI scripts + release manifest policy.','2026-09-23');
CREATE TABLE release_manifest(
  version TEXT PRIMARY KEY,
  release_date TEXT NOT NULL,
  knowledge_base_version TEXT NOT NULL,
  db_version TEXT NOT NULL,
  api_version TEXT NOT NULL,
  atlas_version TEXT NOT NULL,
  learning_version TEXT NOT NULL,
  gates_pass INTEGER NOT NULL,
  gates_total INTEGER NOT NULL,
  release_ready INTEGER NOT NULL,
  manifest_sha256 TEXT,
  note_ar TEXT
);
INSERT INTO "release_manifest" VALUES('v1.0','2026-09-23','v6.0','v1.0','v1.0','v0.3','v0.1',8,8,1,'2b367444923c8946c54a11d34faa9e23c268de03e131762b4f6fe480bf382ef1','نسخة الإطلاق الأولى: جميع بوابات Population/Verification/Database-API/Atlas/Interactive/Education/QA/Sustainability PASS. جميع Claims canonical مرتبطة الآن بسجل Evidence؛ ونطاق الحقوق مثبت.');
INSERT INTO "release_manifest" VALUES('v1.1','2026-09-23','v6.1','v1.1','v1.1','v1.1','v0.1',8,8,1,NULL,'دمج فرع الأدلة: عصور بحدود مرنة، ولايات، أجزاء أسماء، أحداث تاريخية، 59 ادعاءً حقليًا و122 شاهدًا بمواضعها، وجدول مطابقة المعرفات. لا تعديل على سجلات v1.0.');
INSERT INTO "release_manifest" VALUES('v1.2','2026-09-23','v6.1','v1.2','v1.1','v1.2','v0.1',8,8,1,NULL,'شواهد المصادر الأولية: 199 شاهدًا لـ60 إسنادًا، لـ50 منها شاهد من مصدر أولي (الشاملة، وأعمال الأعلام، وابن خلدون، والذخيرة). حسم 316/317هـ، وتصحيح مواليد محمد الخامس ويوسف الأول ومحمد الأول، وتحديد مقتل ابن الخطيب 776هـ ومرسوم 12 فبراير 1502، وتصحيح خراب الزهراء إلى مرحلتين (401هـ و414–416هـ).');
CREATE TABLE release_scope(
 scope_id TEXT PRIMARY KEY, component TEXT NOT NULL, included INTEGER NOT NULL,
 policy_ar TEXT NOT NULL, gate_effect TEXT NOT NULL);
INSERT INTO "release_scope" VALUES('SCOPE-001','Canonical claims and source metadata',1,'ينشر النص المعرفي المختصر والمراجع وروابط المصادر مع provenance.','يسمح باجتياز Gate المصدر/الادعاء.');
INSERT INTO "release_scope" VALUES('SCOPE-002','Third-party images/media',0,'لا تتضمن v1.0 صورًا خارجية معاد نشرها؛ أي صورة مستقبلية تتطلب rights على مستوى العنصر.','يجعل Gate الصور PASS ضمن نطاق v1.0 دون تعميم ترخيص الصفحة.');
INSERT INTO "release_scope" VALUES('SCOPE-003','Full literary texts/editions',0,'لا تعيد v1.0 نشر نصوص أدبية/تحقيقات كاملة؛ تعرض metadata وClaims فقط حتى تثبت النسبة والطبعة والحقوق.','يجعل Gate النص الأدبي PASS ضمن نطاق v1.0.');
INSERT INTO "release_scope" VALUES('SCOPE-004','Historical political boundary polygons',0,'لا تنشر v1.0 حدودًا سياسية تاريخية canonical؛ المضلعات الحالية تحليلية وموسومة بذلك.','يمنع تحويل مظروف تحليلي إلى ادعاء تاريخي.');
CREATE TABLE route_stops (
  route_id TEXT NOT NULL,
  ordinal INTEGER NOT NULL,
  place_entity_id TEXT,
  person_entity_id TEXT,
  work_entity_id TEXT,
  note TEXT,
  PRIMARY KEY(route_id, ordinal),
  FOREIGN KEY(route_id) REFERENCES routes(route_id),
  FOREIGN KEY(place_entity_id) REFERENCES entities(entity_id),
  FOREIGN KEY(person_entity_id) REFERENCES entities(entity_id),
  FOREIGN KEY(work_entity_id) REFERENCES entities(entity_id)
);
INSERT INTO "route_stops" VALUES('ROUTE-001',1,'PLC-GRANADA','PER-AL-JILYANI','WRK-MANADIH','منشأ أندلسي');
INSERT INTO "route_stops" VALUES('ROUTE-001',2,'PLC-DAMASCUS','PER-AL-JILYANI','WRK-MANADIH','الوفاة بدمشق 1206؛ سياق عرض AMOI-II');
CREATE TABLE routes (
  route_id TEXT PRIMARY KEY,
  label_ar TEXT NOT NULL,
  route_type TEXT,
  start_date TEXT,
  end_date TEXT,
  claim_id TEXT,
  notes TEXT,
  FOREIGN KEY(claim_id) REFERENCES claims(claim_id)
);
INSERT INTO "routes" VALUES('ROUTE-001','الجِلياني: غرناطة → دمشق','KnowledgeMigration',NULL,'1206','ARC-CLM09','Seed route from AMOI-II; to be enriched with intermediate stops if directly sourced.');
CREATE TABLE source_dependencies (
  dependency_id TEXT PRIMARY KEY,
  upstream TEXT NOT NULL,
  downstream TEXT NOT NULL,
  relation_type TEXT,
  period TEXT,
  claim_or_use TEXT,
  reference TEXT,
  confidence TEXT,
  url TEXT
);
INSERT INTO "source_dependencies" VALUES('DEP-001','Ahmad al-Razi','Ajbar Majmu''a','نقل/اعتماد في رواية من روايات الفتح','10م → تدوين لاحق','CLM-018','Al-Qantara 1998','عالٍ','https://al-qantara.revistas.csic.es/index.php/al-qantara/article/view/485');
INSERT INTO "source_dependencies" VALUES('DEP-002','Ibn Hayyan, al-Muqtabis','al-Umari, Masalik al-Absar','اعتماد شبه كلي في ملخص تاريخ الأمويين بالأندلس','11م → 14م','Source genealogy','Al-Qantara 2005','عالٍ','https://al-qantara.revistas.csic.es/index.php/al-qantara/article/view/119');
INSERT INTO "source_dependencies" VALUES('DEP-003','HATA','AMOI','قاعدة انطلاق/مصدر بنيوي للمشروع','قاعدة رقمية → مشروع رقمي','RUR-CLM06','CSIC exea','عالٍ','https://exea.csic.es/es/AMOI');
INSERT INTO "source_dependencies" VALUES('DEP-004','PUA','AMOI','ربط مخطط بين قاعدة الأشخاص وشبكات النقل','قاعدة رقمية → مشروع رقمي','RUR-CLM06','CSIC exea','عالٍ','https://exea.csic.es/es/AMOI');
INSERT INTO "source_dependencies" VALUES('DEP-005','EEA manuscript catalogue','Atlas Manuscript Registry','استيراد metadata مع الحفاظ على shelfmark والمستودع','2026 → Atlas','CLM-MS02','EEA-CSIC','عالٍ','https://www.eea.csic.es/biblioteca/catalogos-y-colecciones/coleccion-bibliografica/');
INSERT INTO "source_dependencies" VALUES('DEP-006','Avicenna, De anima (Arabic)','Latin De anima by Gundissalinus + Avendauth','translation','mid-12c','SOC-CLM08','UAB Gundissalinus Working Group','متوسط-عالٍ','https://ddd.uab.cat/pub/pagweb/gundisalvi/index.html.2');
INSERT INTO "source_dependencies" VALUES('DEP-007','Arabic scientific/philosophical corpus in Toledo','Gerard of Cremona Latin translations','translation program','late-12c','SOC-CLM08','Burnett 2001','عالٍ','https://www.cambridge.org/core/journals/science-in-context/article/abs/coherence-of-the-arabiclatin-translation-program-in-toledo-in-the-twelfth-century/E898FAE696E4D7EA152616BEB6D92345');
INSERT INTO "source_dependencies" VALUES('DEP-008','Andalusi Arabic/Romance kharjas','Modern code-switching analysis','scholarly analysis','11-14c -> 2012','CLM-003','Sayahi & Thomas 2012','عالٍ','https://scholarsarchive.library.albany.edu/cas_llc_scholar/41/');
INSERT INTO "source_dependencies" VALUES('DEP-009','Manadih al-mamadih','AMOI-II case study','reception/research mapping','12c -> 2026','ARC-CLM09','EEA-CSIC AMOI-II','عالٍ','https://www.eea.csic.es/exposicion-al-andalus-en-el-mashriq/');
CREATE TABLE source_health(
  source_id TEXT NOT NULL,
  checked_at TEXT NOT NULL,
  status TEXT NOT NULL,
  method TEXT NOT NULL,
  observed TEXT,
  fallback_url TEXT,
  next_check TEXT,
  PRIMARY KEY(source_id,checked_at),
  FOREIGN KEY(source_id) REFERENCES sources(source_id)
);
INSERT INTO "source_health" VALUES('SRC-B819B01BE2','2026-09-23','OK','web.open','UNESCO page reachable; current descriptive text exposes CC-BY-SA IGO 3.0',NULL,'2026-10-23');
INSERT INTO "source_health" VALUES('SRC-FF27E1A80B','2026-09-23','OK','web.open','UNESCO Medina Azahara page reachable',NULL,'2026-10-23');
INSERT INTO "source_health" VALUES('SRC-F650A5BEAE','2026-09-23','OK','web.open','UNESCO Alhambra/Generalife/Albayzin page reachable',NULL,'2026-10-23');
INSERT INTO "source_health" VALUES('SRC-5CED25F7F5','2026-09-23','OK','web.open','UNESCO Seville property page reachable',NULL,'2026-10-23');
INSERT INTO "source_health" VALUES('SRC-3D20624E74','2026-09-23','OK','web.open','EEA-CSIC collection page reachable',NULL,'2026-10-23');
INSERT INTO "source_health" VALUES('SRC-F86CF814B9','2026-09-23','OK','web.open','PUA / exea page reachable',NULL,'2026-10-23');
INSERT INTO "source_health" VALUES('SRC-0DBB04D925','2026-09-23','OK_WITH_REDIRECT','web.search','Spanish direct fetch degraded in tool; French MAN equivalent indexed/reachable','https://www.man.es/man/fr/exposiciones/recorridos-tematicos/dracma-euro/dirham.html','2026-10-23');
INSERT INTO "source_health" VALUES('SRC-C60B7F01E7','2026-09-23','OK_WITH_FALLBACK','web.search','Direct fetch returned 502 in one probe; indexed article and DOI reachable via search','https://doi.org/10.3989/alqantara.1998.v19.i1.485','2026-10-23');
CREATE TABLE source_rights (
  source_id TEXT PRIMARY KEY,
  license_label TEXT,
  license_url TEXT,
  reuse_note TEXT,
  last_verified TEXT,
  FOREIGN KEY(source_id) REFERENCES sources(source_id)
);
INSERT INTO "source_rights" VALUES('SRC-F5A0FFE9E5','CC BY 4.0','https://creativecommons.org/licenses/by/4.0/','الإحداثيات وبيانات الأسماء قابلة لإعادة الاستخدام مع الإسناد؛ لا تُحوَّل مرساة مدينة حديثة إلى موضع أثري دقيق.','2026-09-23');
INSERT INTO "source_rights" VALUES('SRC-B819B01BE2','CC BY-SA IGO 3.0 (descriptive text)','https://creativecommons.org/licenses/by-sa/3.0/igo/','ترخيص الوصف النصي لا يعني أن كل الصور/الوسائط تحمل الترخيص نفسه؛ تحقق من حقوق كل وسيط قبل إعادة النشر.','2026-09-23');
INSERT INTO "source_rights" VALUES('SRC-FF27E1A80B','CC BY-SA IGO 3.0 (descriptive text)','https://creativecommons.org/licenses/by-sa/3.0/igo/','يُستخدم وصف UNESCO ونقطة العقار المرجعية؛ لا تُستنتج حدود العقار من نقطة واحدة.','2026-09-23');
INSERT INTO "source_rights" VALUES('SRC-F650A5BEAE','CC BY-SA IGO 3.0 (descriptive text)','https://creativecommons.org/licenses/by-sa/3.0/igo/','نقطة UNESCO تمثل العقار المركب وليست إحداثية منفصلة للحمراء أو البيازين أو جنة العريف.','2026-09-23');
INSERT INTO "source_rights" VALUES('SRC-5CED25F7F5','CC BY-SA IGO 3.0 (descriptive text)','https://creativecommons.org/licenses/by-sa/3.0/igo/','ترخيص الوصف النصي لا ينسحب تلقائيًا على الصور/الفيديو؛ حقوق الوسائط تُفحص لكل عنصر.','2026-09-23');
INSERT INTO "source_rights" VALUES('LIB-PRI-036','نص تراثي في الملك العام؛ التحقيق والحواشي لأصحابها','https://shamela.ws/book/11782','يُستشهد بنص المؤلف مع الإحالة؛ لا تُعاد نشر حواشي المحقق ولا صفّ الطبعة؛ الترقيم ترقيم الطبعة كما تعرضه الشاملة ويُقابل بالمطبوع قبل النشر.','2026-09-23');
INSERT INTO "source_rights" VALUES('LIB-PRI-037','نص تراثي في الملك العام؛ التحقيق والحواشي لأصحابها','https://shamela.ws/book/1002','يُستشهد بنص المؤلف مع الإحالة؛ لا تُعاد نشر حواشي المحقق ولا صفّ الطبعة؛ الترقيم ترقيم الطبعة كما تعرضه الشاملة ويُقابل بالمطبوع قبل النشر.','2026-09-23');
INSERT INTO "source_rights" VALUES('LIB-PRI-038','نص تراثي في الملك العام؛ التحقيق والحواشي لأصحابها','https://shamela.ws/book/11682','يُستشهد بنص المؤلف مع الإحالة؛ لا تُعاد نشر حواشي المحقق ولا صفّ الطبعة؛ الترقيم ترقيم الطبعة كما تعرضه الشاملة ويُقابل بالمطبوع قبل النشر.','2026-09-23');
INSERT INTO "source_rights" VALUES('LIB-PRI-039','نص تراثي في الملك العام؛ التحقيق والحواشي لأصحابها','https://shamela.ws/book/5742','يُستشهد بنص المؤلف مع الإحالة؛ لا تُعاد نشر حواشي المحقق ولا صفّ الطبعة؛ الترقيم ترقيم الطبعة كما تعرضه الشاملة ويُقابل بالمطبوع قبل النشر.','2026-09-23');
INSERT INTO "source_rights" VALUES('LIB-PRI-028','نص تراثي في الملك العام؛ التحقيق والحواشي لأصحابها','https://shamela.ws/book/22788','يُستشهد بنص المؤلف مع الإحالة؛ لا تُعاد نشر حواشي المحقق ولا صفّ الطبعة؛ الترقيم ترقيم الطبعة كما تعرضه الشاملة ويُقابل بالمطبوع قبل النشر.','2026-09-23');
INSERT INTO "source_rights" VALUES('LIB-PRI-040','النص التراثي في الملك العام؛ الطبعة ومقدمة المحقق وحواشيه محفوظة الحقوق لدار المكشوف','https://archive.org/details/ar106biog55','يُستشهد بنص ابن الخطيب مع الإحالة إلى صفحة الطبعة؛ لا تُعاد نشر صور الصفحات ولا مقدمة المحقق. النسخة المصوّرة المتداولة مصدرها موقع تحميل غير رسمي.','2026-09-24');
INSERT INTO "source_rights" VALUES('LIB-PRI-041','نص تراثي في الملك العام؛ التحقيق والحواشي لأصحابها','https://shamela.ws/book/12320','يُستشهد بنص المؤلف مع الإحالة؛ لا تُعاد نشر حواشي المحقق ولا صفّ الطبعة؛ الترقيم ترقيم الطبعة كما تعرضه الشاملة ويُقابل بالمطبوع قبل النشر.','2026-09-24');
INSERT INTO "source_rights" VALUES('LIB-PRI-042','نص تراثي في الملك العام؛ التحقيق والحواشي لأصحابها','https://shamela.ws/book/37022','يُستشهد بنص المؤلف مع الإحالة؛ لا تُعاد نشر حواشي المحقق ولا صفّ الطبعة؛ الترقيم ترقيم الطبعة كما تعرضه الشاملة ويُقابل بالمطبوع قبل النشر.','2026-09-24');
INSERT INTO "source_rights" VALUES('EXT-ORTEGO-2011','لم أتحقق من رخصة المقال','https://revistas.uned.es/index.php/ETFIII/article/download/1672/1553/4521','يُستشهد بعبارة قصيرة مع الإحالة؛ لا يُعاد نشر النص.','2026-09-24');
INSERT INTO "source_rights" VALUES('EXT-LADERO-1999','محفوظ الحقوق (© Universidad de Cádiz)',NULL,'يُستشهد بعبارة قصيرة مع الإحالة؛ لا يُعاد نشر النص. قُرئ من نص OCR لنسخة PDF أرفقها المستخدم.','2026-09-24');
INSERT INTO "source_rights" VALUES('LIB-PRI-043','نص تراثي في الملك العام؛ التحقيق والحواشي لأصحابها','https://shamela.ws/book/1035','يُستشهد بعبارة قصيرة مع الإحالة؛ لا يُعاد نشر النص ولا حواشي المحقق.','2026-09-24');
INSERT INTO "source_rights" VALUES('LIB-PRI-044','نص تراثي في الملك العام؛ التحقيق والحواشي لأصحابها','https://shamela.ws/book/1038','يُستشهد بعبارة قصيرة مع الإحالة؛ لا يُعاد نشر النص ولا حواشي المحقق.','2026-09-24');
INSERT INTO "source_rights" VALUES('EXT-ZIRIKLI','عمل حديث محفوظ الحقوق','https://shamela.ws/book/12286','يُستشهد بعبارة قصيرة مع الإحالة؛ لا يُعاد نشر النص ولا حواشي المحقق.','2026-09-24');
CREATE TABLE source_watchlist(
  source_id TEXT PRIMARY KEY,
  priority TEXT NOT NULL,
  owner_role TEXT NOT NULL,
  check_cadence_days INTEGER NOT NULL,
  expected_access TEXT NOT NULL,
  fallback_strategy_ar TEXT,
  active INTEGER NOT NULL DEFAULT 1,
  FOREIGN KEY(source_id) REFERENCES sources(source_id),
  FOREIGN KEY(owner_role) REFERENCES maintenance_owners(owner_role)
);
INSERT INTO "source_watchlist" VALUES('SRC-B819B01BE2','P1','Source Monitor',30,'public web','UNESCO stable record / archived citation',1);
INSERT INTO "source_watchlist" VALUES('SRC-FF27E1A80B','P1','Source Monitor',30,'public web','UNESCO stable record / archived citation',1);
INSERT INTO "source_watchlist" VALUES('SRC-F650A5BEAE','P1','Source Monitor',30,'public web','UNESCO stable record / archived citation',1);
INSERT INTO "source_watchlist" VALUES('SRC-5CED25F7F5','P1','Source Monitor',30,'public web','UNESCO stable record / archived citation',1);
INSERT INTO "source_watchlist" VALUES('SRC-3D20624E74','P1','Source Monitor',30,'public web','CSIC catalogue / institutional search',1);
INSERT INTO "source_watchlist" VALUES('SRC-F86CF814B9','P1','Source Monitor',30,'public web','CSIC exea discovery / catalogue export',1);
INSERT INTO "source_watchlist" VALUES('SRC-0DBB04D925','P1','Source Monitor',30,'public web','MAN multilingual equivalent or thematic index',1);
INSERT INTO "source_watchlist" VALUES('SRC-C60B7F01E7','P1','Source Monitor',30,'public web','DOI 10.3989/alqantara.1998.v19.i1.485 / search index',1);
CREATE TABLE sources (
  source_id TEXT PRIMARY KEY,
  label TEXT,
  url TEXT UNIQUE NOT NULL,
  domain TEXT,
  publisher TEXT,
  source_class TEXT,
  last_checked TEXT
);
INSERT INTO "sources" VALUES('SRC-326B573BBA','Cambridge study of 317H letter','https://www.cambridge.org/core/books/abs/medieval-strategies-of-entreaty-from-north-africa-to-eurasia/forging-historical-and-diplomatic-ties-in-the-islamic-west-the-letter-of-a-berber-emir-to-the-umayyad-caliph-317-ah-929-ce/4791003AFF24DE5C2421FC9DBE905880','cambridge.org','Cambridge University Press','institutional_or_scholarly','2026-09-23');
INSERT INTO "sources" VALUES('SRC-17A4D51B44','MAN dirham 316H','https://www.man.es/man/en/exposiciones/recorridos-tematicos/dracma-euro/dirham.html','man.es','Museo Arqueológico Nacional / Ministerio de Cultura','institutional_or_scholarly','2026-09-23');
INSERT INTO "sources" VALUES('SRC-1990D2E895','JMIS 2025/2026','https://www.tandfonline.com/doi/full/10.1080/17546559.2025.2590585','tandfonline.com','Taylor & Francis','institutional_or_scholarly','2026-09-23');
INSERT INTO "sources" VALUES('SRC-3498AB3076','EEA 2026','https://www.eea.csic.es/finaliza-la-tercera-fase-del-plan-director-de-la-fortaleza-andalusi-de-bairen/','eea.csic.es','Escuela de Estudios Árabes / CSIC','institutional_or_scholarly','2026-09-23');
INSERT INTO "sources" VALUES('SRC-F67E8CE018','Springer 2023','https://link.springer.com/article/10.1007/s00334-023-00971-9','link.springer.com','Springer','institutional_or_scholarly','2026-09-23');
INSERT INTO "sources" VALUES('SRC-EF1A9587DD','Arqueología y Territorio Medieval 33','https://revistaselectronicas.ujaen.es/index.php/ATM/article/view/9703','revistaselectronicas.ujaen.es','revistaselectronicas.ujaen.es','institutional_or_scholarly','2026-09-23');
INSERT INTO "sources" VALUES('SRC-22B631316C','MAN/UAM presentation','https://www.man.es/man/actividades/cursos-y-conferencias/2025-2026-ciclo-actualidad-arqueologica-7/20250428-arrabal-saqunda.html','man.es','Museo Arqueológico Nacional / Ministerio de Cultura','institutional_or_scholarly','2026-09-23');
INSERT INTO "sources" VALUES('SRC-CB6B8DB2B7','Akasoy 2010','https://www.cambridge.org/core/journals/international-journal-of-middle-east-studies/article/abs/convivencia-and-its-discontents-interfaith-life-in-alandalus/1B36E1C27D9B659F1598699C9C1587AD','cambridge.org','Cambridge University Press','institutional_or_scholarly','2026-09-23');
INSERT INTO "sources" VALUES('SRC-C3E09140AE','Safran 2013 + MAN','https://academic.oup.com/cornell-scholarship-online/book/23953/chapter-abstract/185297505','academic.oup.com','Oxford University Press','institutional_or_scholarly','2026-09-23');
INSERT INTO "sources" VALUES('SRC-FA9D2D9443','Beck 2018','https://www.tandfonline.com/doi/full/10.1080/00822884.2018.1435463','tandfonline.com','Taylor & Francis','institutional_or_scholarly','2026-09-23');
INSERT INTO "sources" VALUES('SRC-2CCB987052','Al-Muntaqa source-chain discussion','https://ojs.acrps.ai/index.php/almuntaqa/ar/article/view/issue006-art03/html','ojs.acrps.ai','ojs.acrps.ai','institutional_or_scholarly','2026-09-23');
INSERT INTO "sources" VALUES('SRC-385ADC829F','MAN — Bote de Subh','https://www.man.es/man/exposiciones/recorridos-tematicos/imprescindibles/bote-subh.html','man.es','Museo Arqueológico Nacional / Ministerio de Cultura','institutional_or_scholarly','2026-09-23');
INSERT INTO "sources" VALUES('SRC-1D5FE1782E','MAN — Una favorita vascona','https://www.man.es/man/fr/exposiciones/recorridos-tematicos/tres-culturas/04-favorita-vascona.html','man.es','Museo Arqueológico Nacional / Ministerio de Cultura','institutional_or_scholarly','2026-09-23');
INSERT INTO "sources" VALUES('SRC-BDD32C0DDC','MAN — al-Mariyya 2026','https://www.man.es/man/fr/actividades/cursos-y-conferencias/2025-2026-ciclo-actualidad-arqueologica-7/20260602-al-mariyya.html','man.es','Museo Arqueológico Nacional / Ministerio de Cultura','institutional_or_scholarly','2026-09-23');
INSERT INTO "sources" VALUES('SRC-DC54B5ACF6','EEA-CSIC — GLOBALM 2026','https://www.eea.csic.es/conferencia-de-elena-salinas-en-el-museo-arqueologico-nacional/','eea.csic.es','Escuela de Estudios Árabes / CSIC','institutional_or_scholarly','2026-09-23');
INSERT INTO "sources" VALUES('SRC-88C32727FD','EEA-CSIC — Baŷŷāna–Pechina 2025','https://www.eea.csic.es/volumen-sobre-ba%C7%A7%C7%A7ana-pechina-coeditado-por-elena-salinas/','eea.csic.es','Escuela de Estudios Árabes / CSIC','institutional_or_scholarly','2026-09-23');
INSERT INTO "sources" VALUES('SRC-0DBB04D925','MAN — El dírham','https://www.man.es/man/exposiciones/recorridos-tematicos/dracma-euro/dirham.html','man.es','Museo Arqueológico Nacional / Ministerio de Cultura','institutional_or_scholarly','2026-09-23');
INSERT INTO "sources" VALUES('SRC-62278995F4','EEA-CSIC — Ibn Luyūn restoration','https://www.eea.csic.es/el-manuscrito-de-ibn-luyun-regresa-a-la-eea-tras-su-restauracion/','eea.csic.es','Escuela de Estudios Árabes / CSIC','institutional_or_scholarly','2026-09-23');
INSERT INTO "sources" VALUES('SRC-3D20624E74','EEA-CSIC — Colección bibliográfica','https://www.eea.csic.es/biblioteca/catalogos-y-colecciones/coleccion-bibliografica/','eea.csic.es','Escuela de Estudios Árabes / CSIC','institutional_or_scholarly','2026-09-23');
INSERT INTO "sources" VALUES('SRC-F86CF814B9','CSIC exea — PUA','https://exea.csic.es/es/PUA','exea.csic.es','CSIC exea','institutional_or_scholarly','2026-09-23');
INSERT INTO "sources" VALUES('SRC-13F0EF4EDE','CSIC exea/Al-Qantara — HATA/AMOI','https://exea.csic.es/es/AMOI','exea.csic.es','CSIC exea','institutional_or_scholarly','2026-09-23');
INSERT INTO "sources" VALUES('SRC-C60B7F01E7','Luis Molina, Al-Qantara 1998','https://al-qantara.revistas.csic.es/index.php/al-qantara/article/view/485','al-qantara.revistas.csic.es','Al-Qantara / CSIC','institutional_or_scholarly','2026-09-23');
INSERT INTO "sources" VALUES('SRC-8585EF64FC','MAN — Feluses y precintos','https://www.man.es/man/actividades/cursos-y-conferencias/anteriores/2025/20251211-feluses.html','man.es','Museo Arqueológico Nacional / Ministerio de Cultura','Institutional research summary','2026-09-23');
INSERT INTO "sources" VALUES('SRC-08093EBC7F','MAN — Cultura material judía','https://www.man.es/man/exposiciones/recorridos-tematicos/tres-culturas/07-cultura-judia.html','man.es','Museo Arqueológico Nacional / Ministerio de Cultura','Museum synthesis','2026-09-23');
INSERT INTO "sources" VALUES('SRC-6A3B9BE444','MAN — Espacios compartidos I','https://www.man.es/man/exposiciones/recorridos-tematicos/tres-culturas/10-espacios-compartidos-1.html','man.es','Museo Arqueológico Nacional / Ministerio de Cultura','Museum object interpretation','2026-09-23');
INSERT INTO "sources" VALUES('SRC-82E0C1DE51','UGR — Baŷŷāna/Pechina monograph','https://editorial.ugr.es/libro/bayyana-pechina_139625/','editorial.ugr.es','Editorial Universidad de Granada','Academic monograph','2026-09-23');
INSERT INTO "sources" VALUES('SRC-D8B41C5711','EEA — Cocinar en al-Andalus','https://www.eea.csic.es/lecturas-escogidas-11-cocinar-en-al-andalus-dos-recetarios-del-siglo-xiii/','eea.csic.es','Escuela de Estudios Árabes, CSIC','Curated primary-source guide','2026-09-23');
INSERT INTO "sources" VALUES('SRC-94CFFFD3D1','MAN — Culturas cortesanas compartidas','https://www.man.es/man/exposiciones/recorridos-tematicos/tres-culturas/08-culturas-cortesanas.html','man.es','Museo Arqueológico Nacional / Ministerio de Cultura','Museum object interpretation','2026-09-23');
INSERT INTO "sources" VALUES('SRC-495A28E127','MAN — Arte de fusión','https://www.man.es/man/exposiciones/recorridos-tematicos/tres-culturas/09-arte-fusion.html','man.es','Museo Arqueológico Nacional / Ministerio de Cultura','Museum object interpretation','2026-09-23');
INSERT INTO "sources" VALUES('SRC-E29AF5E30C','Burnett — Toledo translation program','https://www.cambridge.org/core/journals/science-in-context/article/abs/coherence-of-the-arabiclatin-translation-program-in-toledo-in-the-twelfth-century/E898FAE696E4D7EA152616BEB6D92345','cambridge.org','Cambridge University Press','Peer-reviewed scholarship','2026-09-23');
INSERT INTO "sources" VALUES('SRC-4C230142FA','UAB — Gundissalinus Working Group','https://ddd.uab.cat/pub/pagweb/gundisalvi/index.html.2','uab.cat','Universitat Autònoma de Barcelona','Academic project','2026-09-23');
INSERT INTO "sources" VALUES('SRC-9264D9F9B0','EEA-CSIC — Al-Andalus en el Mashriq','https://www.eea.csic.es/exposicion-al-andalus-en-el-mashriq/','eea.csic.es','Escuela de Estudios Árabes, CSIC','Research project exhibition','2026-09-23');
INSERT INTO "sources" VALUES('SRC-0CD20155B6','ILC-CSIC — AMOI-II','https://ilc.csic.es/es/research-project/andalus-magrib-oriente-islamico-movilidad-migracion-memoria-amoi-ii','ilc.csic.es','CSIC','Research project','2026-09-23');
INSERT INTO "sources" VALUES('SRC-B1CF443098','Cambridge — Language in al-Andalus','https://www.cambridge.org/core/books/abs/literature-of-alandalus/language/FBA9950D0150F8F03F0AC0EAEB9EB8CF','cambridge.org','Cambridge University Press','Academic synthesis','2026-09-23');
INSERT INTO "sources" VALUES('SRC-F0F86304B1','Sayahi & Thomas 2012','https://scholarsarchive.library.albany.edu/cas_llc_scholar/41/','albany.edu','Journal of Language Contact / University at Albany','Peer-reviewed open access','2026-09-23');
INSERT INTO "sources" VALUES('SRC-2D2113D7F8','MAN — Manises medieval ceramics','https://www.man.es/man/fr/exposiciones/recorridos-tematicos/tres-culturas/14-auge-arte.html','man.es','Museo Arqueológico Nacional / Ministerio de Cultura','Museum synthesis','2026-09-23');
INSERT INTO "sources" VALUES('SRC-D9F327E4FB','MAN — Pervivencia loza dorada','https://www.man.es/man/exposiciones/recorridos-tematicos/tres-culturas/15-pervivencia-arte.html','man.es','Museo Arqueológico Nacional / Ministerio de Cultura','Museum synthesis','2026-09-23');
INSERT INTO "sources" VALUES('SRC-F5A0FFE9E5','GeoNames geographical database','https://www.geonames.org/','geonames.org','GeoNames','geospatial_reference','2026-09-23');
INSERT INTO "sources" VALUES('SRC-B819B01BE2','UNESCO — Historic Centre of Cordoba','https://whc.unesco.org/en/list/313','whc.unesco.org','UNESCO World Heritage Centre','institutional_or_scholarly','2026-09-23');
INSERT INTO "sources" VALUES('SRC-FF27E1A80B','UNESCO — Caliphate City of Medina Azahara','https://whc.unesco.org/en/list/1560/','whc.unesco.org','UNESCO World Heritage Centre','institutional_or_scholarly','2026-09-23');
INSERT INTO "sources" VALUES('SRC-F650A5BEAE','UNESCO — Alhambra, Generalife and Albayzín','https://whc.unesco.org/en/list/314','whc.unesco.org','UNESCO World Heritage Centre','institutional_or_scholarly','2026-09-23');
INSERT INTO "sources" VALUES('SRC-5CED25F7F5','UNESCO — Cathedral, Alcázar and Archivo de Indias in Seville','https://whc.unesco.org/en/list/383','whc.unesco.org','UNESCO World Heritage Centre','institutional_or_scholarly','2026-09-23');
INSERT INTO "sources" VALUES('LIB-BK-005','دولة الإسلام في الأندلس','https://shamela.ws/book/1009','shamela.ws','مكتبة الخانجي، القاهرة','library_v1_1','2026-09-23');
INSERT INTO "sources" VALUES('EXT-MET-TOAH','Metropolitan Museum — Heilbrunn Timeline of Art History','https://www.metmuseum.org/essays/','metmuseum.org','The Metropolitan Museum of Art','museum_essay','2026-09-23');
INSERT INTO "sources" VALUES('LIB-ART-029','The Coinage of al-Andalus','https://doi.org/10.36816/shedet.004.05','doi.org','(انظر تفاصيل المجلة)','library_v1_1','2026-09-23');
INSERT INTO "sources" VALUES('EXT-MWNF','Discover Islamic Art (Museum With No Frontiers)','https://islamicart.museumwnf.org/','islamicart.museumwnf.org','Museum With No Frontiers','museum_database','2026-09-23');
INSERT INTO "sources" VALUES('EXT-BRITANNICA','Encyclopaedia Britannica (مرجعي عام)','https://www.britannica.com/','britannica.com','Encyclopaedia Britannica','general_reference','2026-09-23');
INSERT INTO "sources" VALUES('EXT-PATRONATO','Patronato de la Alhambra y Generalife','https://www.alhambra-patronato.es/','alhambra-patronato.es','Patronato de la Alhambra y Generalife','heritage_institution','2026-09-23');
INSERT INTO "sources" VALUES('LIB-PRI-036','ابن عذاري المراكشي (ت بعد 712هـ؛ تاريخ الشاملة 695)، البيان المغرب في أخبار الأندلس والمغرب — نسخة الشاملة 11782','https://shamela.ws/book/11782','shamela.ws','بيانات الطبعة (الناشر/المحقق/السنة) غير متوفرة في فهرس الشاملة — لم أتحقق منها','primary_text','2026-09-23');
INSERT INTO "sources" VALUES('LIB-PRI-037','المقري التلمساني (ت 1041هـ)، نفح الطيب من غصن الأندلس الرطيب، تحقيق إحسان عباس — نسخة الشاملة 1002','https://shamela.ws/book/1002','shamela.ws','بيانات الطبعة (الناشر/المحقق/السنة) غير متوفرة في فهرس الشاملة — لم أتحقق منها','primary_text','2026-09-23');
INSERT INTO "sources" VALUES('LIB-PRI-038','لسان الدين ابن الخطيب (ت 776هـ)، الإحاطة في أخبار غرناطة — نسخة الشاملة 11682','https://shamela.ws/book/11682','shamela.ws','بيانات الطبعة (الناشر/المحقق/السنة) غير متوفرة في فهرس الشاملة — لم أتحقق منها','primary_text','2026-09-23');
INSERT INTO "sources" VALUES('LIB-PRI-039','الحميدي (ت 488هـ)، جذوة المقتبس في ذكر ولاة الأندلس — نسخة الشاملة 5742','https://shamela.ws/book/5742','shamela.ws','بيانات الطبعة (الناشر/المحقق/السنة) غير متوفرة في فهرس الشاملة — لم أتحقق منها','primary_text','2026-09-23');
INSERT INTO "sources" VALUES('LIB-PRI-028','ابن بشكوال (ت 578هـ)، الصلة في تاريخ أئمة الأندلس — نسخة الشاملة 22788 (قد تختلف عن طبعة بشار عواد المفهرسة)','https://shamela.ws/book/22788','shamela.ws','بيانات الطبعة (الناشر/المحقق/السنة) غير متوفرة في فهرس الشاملة — لم أتحقق منها','primary_text','2026-09-23');
INSERT INTO "sources" VALUES('LIB-PRI-040','لسان الدين ابن الخطيب (ت 776هـ)، تاريخ إسبانية الإسلامية أو كتاب أعمال الأعلام، تحقيق إ. ليفي بروفنسال، ط2، بيروت: دار المكشوف، آذار 1956','https://archive.org/details/ar106biog55','archive.org','دار المكشوف (بيروت)، الطبعة الثانية، آذار 1956','primary_text','2026-09-24');
INSERT INTO "sources" VALUES('LIB-PRI-041','ابن خلدون (ت 808هـ)، تاريخ ابن خلدون (كتاب العبر) — نسخة الشاملة 12320','https://shamela.ws/book/12320','shamela.ws','بيانات الطبعة (الناشر/المحقق/السنة) غير متوفرة في فهرس الشاملة — لم أتحقق منها','primary_text','2026-09-24');
INSERT INTO "sources" VALUES('LIB-PRI-042','ابن خلدون (ت 808هـ)، رحلة ابن خلدون (التعريف بابن خلدون ورحلته غربًا وشرقًا) — نسخة الشاملة 37022','https://shamela.ws/book/37022','shamela.ws','بيانات الطبعة (الناشر/المحقق/السنة) غير متوفرة في فهرس الشاملة — لم أتحقق منها','primary_text','2026-09-24');
INSERT INTO "sources" VALUES('EXT-ORTEGO-2011','Pablo Ortego Rico، «Cristianos y mudéjares ante la conversión de 1502. Mercedes a moros. Mercedes de bienes de moros»، Espacio, Tiempo y Forma, Serie III, Historia Medieval، ع24 (2011)، ص279–318','https://revistas.uned.es/index.php/ETFIII/article/download/1672/1553/4521','revistas.uned.es','UNED (Universidad Nacional de Educación a Distancia)','peer_reviewed_article','2026-09-24');
INSERT INTO "sources" VALUES('EXT-LADERO-1999','Miguel Ángel Ladero Quesada، Andalucía a fines de la Edad Media: estructuras, valores, sucesos، قادس: Servicio de Publicaciones de la Universidad de Cádiz، 1999، 364 ص، ISBN 84-7786-645-7','urn:isbn:84-7786-645-7',NULL,'Servicio de Publicaciones de la Universidad de Cádiz','book','2026-09-24');
INSERT INTO "sources" VALUES('LIB-PRI-043','ابن بسام الشنتريني (ت 542هـ)، الذخيرة في محاسن أهل الجزيرة — نسخة الشاملة 1035','https://shamela.ws/book/1035','shamela.ws','بيانات الطبعة (الناشر/المحقق/السنة) غير متوفرة في فهرس الشاملة — لم أتحقق منها','primary_text','2026-09-24');
INSERT INTO "sources" VALUES('LIB-PRI-044','ابن حزم (ت 456هـ)، رسائل ابن حزم (رسالة في فضل الأندلس) — نسخة الشاملة 1038','https://shamela.ws/book/1038','shamela.ws','بيانات الطبعة (الناشر/المحقق/السنة) غير متوفرة في فهرس الشاملة — لم أتحقق منها','primary_text','2026-09-24');
INSERT INTO "sources" VALUES('EXT-ZIRIKLI','خير الدين الزركلي (ت 1396هـ)، الأعلام — نسخة الشاملة 12286','https://shamela.ws/book/12286','shamela.ws','بيانات الطبعة (الناشر/المحقق/السنة) غير متوفرة في فهرس الشاملة — لم أتحقق منها','reference_work','2026-09-24');
CREATE TABLE tenures(tenure_id TEXT PRIMARY KEY, person_id TEXT NOT NULL, polity_id TEXT NOT NULL, role TEXT, start_year INTEGER, end_year INTEGER,
  precision TEXT, note_ar TEXT, FOREIGN KEY(person_id) REFERENCES entities(entity_id), FOREIGN KEY(polity_id) REFERENCES entities(entity_id));
INSERT INTO "tenures" VALUES('TEN-001','PER-001','POL-001','أمير',756,788,'سنة','مؤسس الإمارة الأموية المستقلة');
INSERT INTO "tenures" VALUES('TEN-002a','PER-002','POL-001','أمير',912,929,'سنة','إمارة حتى إعلان الخلافة');
INSERT INTO "tenures" VALUES('TEN-002b','PER-002','POL-002','خليفة',929,961,'سنة','أعلن الخلافة 929م');
INSERT INTO "tenures" VALUES('TEN-003','PER-ALHAKAM-II','POL-002','خليفة',961,976,'سنة',NULL);
INSERT INTO "tenures" VALUES('TEN-004','PER-009','POL-003','ملك طائفة',1069,1091,'سنة','آخر أبرز حكام بني عباد');
INSERT INTO "tenures" VALUES('TEN-005','PER-028','POL-004','ملك طائفة',1046,1081,'سنة','مرتبط بقصر الجعفرية');
INSERT INTO "tenures" VALUES('TEN-006','PER-029','POL-005','ملك طائفة',NULL,NULL,'قرن','القرن 11م — يحتاج ضبط السنوات');
INSERT INTO "tenures" VALUES('TEN-007','PER-030','POL-008','سلطان',1232,1273,'نطاق سنوات','«تقريبًا» في v4.9');
INSERT INTO "tenures" VALUES('TEN-009','PER-032','POL-008','سلطان',1273,1302,'سنة',NULL);
INSERT INTO "tenures" VALUES('TEN-010','PER-033','POL-008','سلطان',1333,1354,'سنة',NULL);
INSERT INTO "tenures" VALUES('TEN-011a','PER-034','POL-008','سلطان',1354,1359,'سنة','الولاية الأولى');
INSERT INTO "tenures" VALUES('TEN-011b','PER-034','POL-008','سلطان',1362,1391,'سنة','الولاية الثانية');
INSERT INTO "tenures" VALUES('TEN-012a','PER-036','POL-008','سلطان',1464,1482,'نطاق سنوات','البداية 868هـ (1463/1464م) عند عنان؛ 1466 عند Britannica — يُفحص في Fábregas');
INSERT INTO "tenures" VALUES('TEN-012b','PER-036','POL-008','سلطان',1483,1485,'سنة',NULL);
INSERT INTO "tenures" VALUES('TEN-013','PER-037','POL-008','سلطان',1485,1487,'سنة',NULL);
INSERT INTO "tenures" VALUES('TEN-008a','PER-031','POL-008','سلطان',1482,1483,'سنة','الولاية الأولى');
INSERT INTO "tenures" VALUES('TEN-008b','PER-031','POL-008','سلطان',1487,1492,'سنة','الولاية الثانية');
CREATE INDEX idx_claims_status ON claims(status);
CREATE INDEX idx_claims_confidence ON claims(confidence);
CREATE INDEX idx_entities_type ON entities(entity_type);
CREATE INDEX idx_relations_subject ON relations(subject_id);
CREATE INDEX idx_relations_object ON relations(object_id);
CREATE INDEX idx_claim_sources_source ON claim_sources(source_id);
CREATE INDEX idx_claim_entities_entity ON claim_entities(entity_id);
CREATE INDEX idx_evidence_source ON evidence(source_id);
CREATE VIEW v_claim_detail AS
SELECT c.claim_id,c.canonical_wording_ar,c.verdict,c.confidence,c.status,c.last_verified,
       COUNT(DISTINCT cs.source_id) AS source_count,
       COUNT(DISTINCT ce.evidence_id) AS evidence_count,
       COUNT(DISTINCT cent.entity_id) AS entity_count
FROM claims c
LEFT JOIN claim_sources cs ON cs.claim_id=c.claim_id
LEFT JOIN claim_evidence ce ON ce.claim_id=c.claim_id
LEFT JOIN claim_entities cent ON cent.claim_id=c.claim_id
GROUP BY c.claim_id;
CREATE VIEW v_entity_graph_degree AS
SELECT e.entity_id,e.entity_type,e.preferred_name_ar,
       (SELECT COUNT(*) FROM relations r WHERE r.subject_id=e.entity_id OR r.object_id=e.entity_id) AS relation_degree,
       (SELECT COUNT(*) FROM claim_entities ce WHERE ce.entity_id=e.entity_id) AS claim_degree
FROM entities e;
CREATE INDEX idx_place_geometry_lat_lon ON place_geometry(lat, lon);
CREATE VIEW v_places_geo AS
SELECT e.entity_id,e.preferred_name_ar,e.preferred_name_latn,e.notes,
       g.lat,g.lon,g.geometry_type,g.spatial_quality,g.anchor_type,g.coordinate_source,g.last_verified,
       (SELECT COUNT(*) FROM claim_entities ce WHERE ce.entity_id=e.entity_id) AS claim_count
FROM entities e JOIN place_geometry g ON g.entity_id=e.entity_id
WHERE e.entity_type='Place';
CREATE VIEW v_places_atlas AS
SELECT vp.*, m.period_group,m.theme,m.historical_status,m.display_priority,m.note_ar
FROM v_places_geo vp
LEFT JOIN atlas_place_metadata m ON m.entity_id=vp.entity_id;
CREATE INDEX idx_atlas_meta_period ON atlas_place_metadata(period_group);
CREATE INDEX idx_atlas_meta_status ON atlas_place_metadata(historical_status);
CREATE VIEW v_learning_modules AS
SELECT m.*,
 (SELECT COUNT(*) FROM learning_module_steps s WHERE s.module_id=m.module_id) AS step_count,
 (SELECT COUNT(*) FROM quiz_items q WHERE q.module_id=m.module_id) AS quiz_count
FROM learning_modules m;
CREATE VIEW v_quiz_ready AS
SELECT q.*, c.confidence AS claim_confidence, c.status AS claim_status
FROM quiz_items q JOIN claims c ON c.claim_id=q.claim_id;
CREATE VIEW v_assertion_status AS SELECT a.*, (SELECT COUNT(*) FROM attestations t WHERE t.assertion_id=a.assertion_id) attestation_count,
  (SELECT COUNT(*) FROM attestations t WHERE t.assertion_id=a.assertion_id AND t.verbatim_check LIKE 'مطابق حرفيًا%') verbatim_ok FROM assertions a;
CREATE VIEW v_tenures AS SELECT t.*, p.preferred_name_ar person_name, pol.preferred_name_ar polity_name FROM tenures t
  JOIN entities p ON p.entity_id=t.person_id JOIN entities pol ON pol.entity_id=t.polity_id;
COMMIT;
