# Design QA — Andalus / Knowledge Flow

Date: 2026-10-01. Scope: static branch `codex/andalus-light-atlas`, presentation identity and route templates. Production publication is not part of this verification result.

## Reference and comparison

Selected concept: «مجرى المعرفة», with evidence reading from «المتن والهامش» and collection viewing from «فناء الزمن». Reference: the first generated exploration (`exec-4248cafe-f3d8-4394-a71a-ebdc8d875723.png`, 1487×1058). Rendered comparison uses the same CSS viewport and state: home, Cordoba, year 960, light mode. Both normalized to 0.88 scale. Actual historical media and relationships replace concept placeholders; map geometry uses existing Natural Earth data, not generated geography.

Opened and reviewed the combined `reference-comparison.jpg`, plus focused header, context and time comparisons. Reviewed the desktop and mobile boards and the stable individual image views. Evidence is under `design/knowledge-flow-qa-2026-10-01/stable/`; `interface-screens.zip` contains 16 route screenshots in two widths plus desktop/mobile search states (34 JPEGs).

| Fidelity surface | Review and disposition |
|---|---|
| Fonts | IBM Plex Sans Arabic forms the interface; readable heading/body/metadata hierarchy; Noto Naskh is reserved for document quotations. Concept display wordmark simplified to live accessible text. |
| Layout | Map dominates the home canvas; side context and bottom time control preserve reference structure. Mobile reorders map/time before context. Directories use editorial rows; museum/profile layouts differ by content. |
| Colors | Cool light surface, blue map/controls, oxide focus/time. Three semantic themes tested; primary text, muted text and control colors meet 4.5:1 against their intended surfaces. |
| Imagery | Real licensed Cordoba, al-Zahrawi print and Subh pyxis inspected after loading. Source, author, license and historical note retained. Missing and failed media have honest text states. |
| Copy | Actual Arabic data and published relations used; dates, approximate coordinates and source uncertainty remain visible. Concept-only people/relations are not inserted into canonical data. |

## Verification

Captured home, atlas, map, timeline, people, person, places, place, stories, learning, games, museum, artifact, sources, about and design guide on desktop and mobile. Route-ready state awaited before captures. Mobile CSS viewport 390px, usable width 375px with scrollbar; tablet CSS viewport 834px, usable width 819px. No horizontal document overflow in recorded route checks. Responsive checks use browser iframes, not physical-device emulation.

Interaction checks passed: home year arrow updates state; selecting Granada on the mobile map updates context; mobile menu closes on navigation; people filter matches and clears empty state; timeline controls and route states render; grouped search finds places/polities and Arabic-digit years, shows empty state, closes with Escape and returns focus; image viewer opens/zooms/closes; lesson step advances; quiz incorrect/retry/correct and evidence opening work; source records reveal published metadata; mode changes affect interface and map. Keyboard activation of the skip link focuses MAIN. Closed evidence/search are inert and aria-hidden. Forced missing-photo fixture shows an error message while retaining license, author and source.

No application-origin JavaScript error appeared in the final browser error-log check. An unrelated browser-extension metadata error was excluded. Inline scripts and identity.js pass `node --check`. All canonical data files match their original HEAD hashes. The 13-file cPanel archive passes ZIP integrity/content checks and excludes research Markdown, office and prototype files.

## Fixes during reduction and QA

1. Removed oversized repetitive card wrappers and unneeded ornamental media placeholders from the new layouts.
2. Corrected initial legacy-template flash by routing only after the identity layer is ready.
3. Added explicit image loading/failure states without losing credits or notes.
4. Folded map era legend and atlas controls on small screens; enlarged mobile home-map hit areas.
5. Corrected modal focus return/trap and hidden-dialog accessibility; fixed quiz retry and tab state semantics.
6. Unified icon language and removed remaining ornamental glyphs from active controls; restored a keyboard skip link.

## Limits and follow-up

This is targeted visual and interaction QA, not a full WCAG certification. SVG map fallback was inspected; external WebGL tile/network failure combinations were not exhaustively tested. This does not certify all 61 remote Wikimedia images: the critical image views and failure path were checked. Historic political boundaries, an interactive relationship graph editor and a fully new event/polity template are not introduced; existing event/polity content inherits the visual system. The identity mark is PNG; a separately refined vector mark remains a future brand-production task. The live cPanel site has not been replaced by this verification run.

No unresolved P0/P1/P2 issue identified within the tested identity/template scope.

passed
