# Andalus light UI: design QA

Source visual truth: `/workspace/scratch/1b0305dff00a/generated_images/exec-4d340645-b4d9-41bf-9cb3-2139495b3129.png`.
Implementation screenshot: `/workspace/scratch/andalus-light-preview.jpg`. Mobile evidence: `/workspace/scratch/andalus-mobile-qa.jpg`.
Full-view comparison: `design-comparison.jpg` (source left, implementation right).
Viewport: desktop 1363×936 CSS pixels; mobile iframe 390×844 CSS pixels (375px content width after scrollbar).
Source raster: (1487, 1058); implementation raster: (1348, 926). Screenshot drawable area: 1348×926 pixels (browser screenshot excludes scrollbars); capture 1×; comparison images uniformly scaled to fit 800×650 each, preserving aspect ratio. No density-induced cropping.
State: light theme, general audience, home at 960 CE, Cordoba selected.

## Findings
No actionable P0/P1/P2 findings remain.
- Typography: original licensed Reem Kufi / IBM Plex Arabic retained; smaller 28–30px headings, 16px body, readable credits and RTL wrapping.
- Layout: right navigation rail, dominant map, split spotlight with source attribution, three contextual cards. Reduced page gaps, uniform rounded controls and card padding.
- Colors: off-white surfaces, muted green land, light blue sea, deep teal actions and gold timeline. Status colors remain semantically distinct.
- Assets: real original Commons photos and their exact credits/notes retained. Natural Earth geometry comes from the existing repository GeoJSON. Generated reference terrain and generic photographs were deliberately not treated as geographic or historical evidence. Standard Lucide icons replace navigation/category illustrations, with upstream license retained.
- Copy: original graph facts unchanged. Home context derives from existing dated entities. Source/provenance panel preserves uncertainty and corrections.

## Comparison history
1. P2 mobile timeline details covered year label; fixed details to normal flow.
2. P2 mobile map caution overlapped spotlight action; increased map stage and reserved bottom space. Post-fix mobile evidence shows separated controls and readable note.
3. P2 Cordoba / Medina Azahara labels overlapped; applied opposite vertical offsets to those labels, preserving coordinates. Post-fix desktop evidence shows distinct labels.
Full view suffices for palette, major region proportions and spacing; mobile evidence separately verifies typography, credits, note and touch controls.

## Interactions and checks
- Search for al-Zahrawi opens correct entity.
- Home year slider changes 960→961 and updates contextual events.
- Atlas zoom changes 100%→150%; sources tab lists existing model references.
- Entity proof opens and displays original partially documented claim with supporting sources.
- Al-Zahrawi 1544 note and original Commons image remain visible.
- Sources page renders 81 source entries; desktop and mobile checked for overflow.
- Mobile home, entity and museum captured at 390px. Home and museum body scrollWidth equals clientWidth (375).
- JavaScript syntax and git whitespace checks passed.
- Browser error logs reviewed: only Chrome extension metadata errors, no application errors observed.
- Historical graph, evidence, schema, media and original geography files have no diff.
- Release ZIP has exactly 10 approved runtime files, excluding research docs, prototype and office files.

## Follow-up polish / test gaps
P3: optional licensed relief imagery could enrich the map in a later release. All supported phones and every learning/game route have not been exhaustively tested; existing underlying behavior is retained.

## Production verification
Deployed via authenticated cPanel File Manager to `/home/othmanas/public_html/andalus`. Extraction confirmed all 10 runtime files. Live version verified at `https://othmana.sa/andalus/?v=5f9eccc#/` (unversioned address initially served the previous cached HTML). Live home stylesheet/map/photo, search result for al-Zahrawi, entity note and image were confirmed; no horizontal overflow on home/entity. Root Rasd files were outside the extraction destination. GitHub export was initially blocked by approval review. The user authorized the named branch on 2026-10-01; the connected GitHub API is being used because terminal Git has no authentication credentials.

final result: passed
