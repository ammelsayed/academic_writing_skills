---
name: academic-literature-review
description: >
  Build a literature review, survey, related-work section, or annotated
  bibliography by expanding from seed papers through citation graphs rather
  than keyword search alone. Covers search strategy, screening, structured
  notes, cross-paper synthesis, and where themes genuinely do not exist. Use
  for "survey X", "review the literature on Y", "write the related work
  section", "what do recent papers say about Z", or "compare the methods in
  these papers".
license: MIT
compatibility: Needs network access for arXiv, INSPIRE-HEP, or Crossref. Optional helper script requires Python 3.
metadata:
  author: ammelsayed
  version: "1.0.0"
  homepage: https://github.com/ammelsayed/academic_writing_skills
---

# Literature review

A synthesis with a thesis, not an annotated list. If the output could have been
produced by concatenating abstracts, it has failed.

## Decide the review type first

| Type | What it does | Cost |
|---|---|---|
| Narrative | Builds an argument from chosen sources | Days |
| Systematic | Answers one focused question with a pre-registered search and screening protocol | Months, usually a team |
| Scoping | Maps what has been studied and where the gaps are | Weeks |
| Related work | Positions one paper against its neighbours | Hours |

Do not apply systematic-review bookkeeping (PRISMA counts, inclusion tables) to
a narrative review unless the user asks for it. Do not call something a
systematic review when the search was not pre-specified.

## Workflow

### 1. Define the question

Write it as one sentence before searching. "What is the evidence that X affects
Y in Z?" — not "papers about X". A vague question produces a list.

### 2. Seed set (3–10 papers)

Pick: the landmark paper, one or two reviews, the current frontier, the main
competing approach, and a methods paper if the topic depends on a tool. Record
one line per seed on why it matters.

### 3. Expand by citation graph, not keywords

For each seed: read its references, then its cited-by list, then repeat on the
most relevant neighbours until the map stops growing.

- Physics: **INSPIRE-HEP** (`inspirehep.net/api/literature?q=...`) — better
  metadata, report numbers, and citation links than generic search.
- CS/ML/math: **arXiv** (`export.arxiv.org/api/query`).
- Everything else: Crossref, Semantic Scholar, or the field's index.

Keyword search finds what is indexed; citation chasing finds what matters.

**Query discipline** — reduce the topic to 2–3 core terms. `"diffusion
models"` works; `"diffusion models in computer vision"` returns nothing because
arXiv matches the exact phrase. Use a category filter instead of stuffing
qualifiers into the query.

### 4. Screen

Keep a paper if it does at least one of these:

- introduces a mechanism, model, or theorem that later work uses
- supplies a calculation, constraint, or dataset that changed the discussion
- settles a disagreement or clarifies a confusion
- represents a distinct branch you must compare

Drop near-duplicate versions, conference notes with no added substance, and
papers outside the chosen scope. **Report the actual count** — never pad a list
to hit a requested number.

### 5. Structured notes

For each kept paper, compress to this shape. Never "this paper studies X":

```text
prior status → authors' intervention → load-bearing assumptions
→ result → remaining tension
```

Record: bibliographic identity (arXiv id even when a journal ref exists), the
problem it solved, what it did not solve, and whether the result is official,
a recast, a forecast, or exploratory. That last distinction decides how much
weight the claim carries.

### 6. Audit before synthesising

A note that is structurally fine can still be wrong. Check each against the
source: does the stated result match the abstract? Is the claimed assumption
actually load-bearing? Notes that fail stay out of the synthesis.

### 7. Synthesise

The report must contain:

- **3–6 themes** — recurring approaches, framings, or mechanisms
- **Convergences** — where multiple papers agree
- **Disagreements** — where they conflict, or use incompatible methods so the
  results cannot be compared
- **Gaps** — what the collective literature does not address

If the set is too small or too heterogeneous for themes, **say so explicitly**.
Forcing themes is worse than admitting there are none.

### 8. Write

- Organise by **question, mechanism, or tension** — not by paper, and not by
  year.
- Each subsection answers a concrete question and names the papers that bear on
  it.
- A review article is an entry point, not a replacement: cite the original for
  the claim.
- Explain relationships: extends, simplifies, constrains, generalises,
  supersedes, or rules out. That is what a review is for.

## Quality bar

- Every important paper's role is stated, not just its title.
- Seminal papers are distinguished from incremental follow-ups.
- Conceptual genealogy is visible, not just chronology.
- Disagreements are legible — a reader can see why two papers differ.
- Provenance is preserved: arXiv id, and whether a number is official.

## Helper

`scripts/arxiv_search.py` queries arXiv and prints JSON. Optional; the API is
simple enough to call directly.

```bash
python scripts/arxiv_search.py "graph neural networks" --max-results 20 --category cs.LG
```
