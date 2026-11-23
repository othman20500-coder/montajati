# Product

<!-- impeccable:product-schema 1 -->

## Platform

web

## Users

- The owner (عثمان) and his household. Family members search too, so the site must work for someone who does not know the catalog's conventions.
- Two scenes, used about equally: on a phone standing in front of the bookcases looking for a book, and on a computer reviewing titles, correcting the catalog and planning the rearrangement.

## Product Purpose

«مكتبة آل عثمان» indexes one real home library (two white bookcases: A with six shelves, B with four) from photos of its shelves. It answers: do I own this book, which shelf, and where on the shelf; which books do I own on a topic (e.g. «القيم»), with the count and why each is related. Success: a family member finds a physical book in seconds, and the owner trusts the catalog because it never claims more than the photos show.

## Positioning

Every record is tied to the actual photo of the actual shelf: the location answer is a crop of the owner's own photo with the book framed, plus its position counted from the left. Confirmed readings are kept apart from unconfirmed ones, and topics proven by the title are kept apart from suggested topics.

## Operating Context

- Static page with no build step (index.html, app.js, style.css, data/books.js, photos/). Edits are saved in the browser's localStorage, with JSON/CSV export and import.
- Tabs: the shelves as they are now, the book catalog, the real photos, records needing review, the rearrangement plan, editing and data.
- The rearrangement plan is a suggestion only; nothing moves on the map until the owner confirms he moved the book.

## Capabilities and Constraints

- Arabic interface, RTL. The shelf drawing itself reads left to right, matching the photos; position 1 is the far left of a shelf.
- Search tolerates Arabic spelling variants (hamza, alif maqsura, ta marbuta, diacritics) and accepts topic questions phrased naturally.
- No build tools, npm packages or server.
- The photos are taken inside the home: they stay out of the public repository and are published only to the owner's private page.

## Evidence on Hand

- Catalog: 323 records (262 with a confirmed reading, 61 needing review), 8 multi-volume sets, in `data/books.js`.
- 18 shelf photos (`photos/P1.jpg` … `P18.jpg`), local only.
- No testimonials, users or metrics beyond this household; none may be invented.

## Product Principles

1. Location first: the answer to "where is it" comes before any metadata.
2. Never show a book as owned unless a photo or the owner confirms it; uncertainty is labelled, never hidden.
3. The physical arrangement is the truth; classification never moves a book on the map by itself.
4. Usable by a family member who did not build the catalog.

## Accessibility & Inclusion

Readable by family members of different ages on a phone: large legible Arabic text, comfortable tap targets, no reliance on colour alone.
