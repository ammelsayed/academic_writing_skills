---
name: academic-paper
description: >
  Write and revise academic papers in LaTeX across any discipline: empirical
  articles, theory papers, theses, and reports. Covers structure, paragraph
  discipline, claim-evidence alignment, self-review, and the build. Use when
  asked to write a paper, draft a manuscript, write up notes or results,
  write a thesis chapter, or produce any document with citations.
license: MIT
compatibility: Requires a TeX engine (latexmk, pdflatex, xelatex, or tectonic) for PDF output. Works without one, delivering .tex only.
metadata:
  author: ammelsayed
  version: "1.0.0"
  homepage: https://github.com/ammelsayed/academic_writing_skills
---

# Academic paper

A `.tex` that compiles to a PDF a reviewer takes seriously. Academic argument,
not a blog post with formulas.

## Check the engine first

```bash
command -v latexmk pdflatex xelatex tectonic 2>/dev/null
```

No engine means no PDF. Say so in one line and deliver the `.tex` anyway —
never claim it compiled.

## House rules (non-negotiable)

1. **hyperref** always loaded exactly like this:

   ```latex
   \usepackage[colorlinks=true,linkcolor=blue!45!black,citecolor=blue!45!black,urlcolor=blue!45!black]{hyperref}
   ```

   The `blue!45!black` mixing syntax needs `\usepackage{xcolor}` — hyperref's
   driver does not supply it. **`xcolor` is required, not unused.**

2. **Bibliography** is always external `references.bib`, never inline
   `thebibliography`:

   ```latex
   \usepackage[numbers,sort&compress]{natbib}
   ...
   \bibliographystyle{plainnat}
   \bibliography{references}
   \end{document}
   ```

3. **Figures** go in `figures/`. `\includegraphics{figures/name.pdf}`. Draw
   plots in a standalone `.tex` and export PDF; do not inline `tikzpicture` for
   a plot.

4. **Article → one file.** Even past 50 pages, do not split into
   `sections/*.tex`. **Thesis → split** into `chapters/` or `sections/`, files
   named after their content (`introduction.tex`, `detector.tex`, `results.tex`).

5. **Never include:**

   ```latex
   \urlstyle{same}
   \hypersetup{pdftitle=..., pdfauthor=...}
   \pdfinfoomitdate=1
   \pdfsuppressptexinfo=15
   \setlength{\emergencystretch}{2em}
   ```

6. **No unused packages.** Every `\usepackage` must be earned by the content.
   Drop `graphicx` with no figures, `booktabs`/`array` with no tables,
   `pgfplots` once figures are pre-built. Exception: `xcolor` (rule 1).

7. **Delete compiler artifacts after building.** Keep `.tex`, `.bib`, `.pdf`,
   figure sources, data/scripts. Remove `*.aux *.log *.bbl *.blg *.out *.fls
   *.fdb_latexmk *.synctex.gz *.toc` and per-figure equivalents.

## Minimal preamble

```latex
\documentclass[11pt]{article}
\usepackage[T1]{fontenc}
\usepackage{mathpazo,microtype}
\usepackage[margin=1in]{geometry}
\usepackage{amsmath,amssymb,amsthm}
\usepackage[numbers,sort&compress]{natbib}
\usepackage{xcolor}
\usepackage[colorlinks=true,linkcolor=blue!45!black,citecolor=blue!45!black,urlcolor=blue!45!black]{hyperref}
```

Add `graphicx` for figures, `booktabs`+`array` for tables, `listings` for code.
Theorem environments share one counter numbered by section.

## Before writing: route the paper

Do not start drafting until the type is fixed — it decides the structure.

| Type | Skeleton |
|---|---|
| Empirical | Intro, Related work, Method, Results, Discussion, Limitations, Conclusion |
| Theoretical | Intro, Preliminaries, Main result + proof, Applications, Discussion |
| Review | Intro + question, Scope/method, Themes, Convergences & disagreements, Gaps, Outlook |
| Thesis | Chapter per contribution; each self-contained with its own intro and summary |
| Report | Executive summary, Background, Approach, Findings, Recommendations |

If the user gives no type and none is implied, pick the obvious one and say
which in one line — do not interview them.

## Structure

1. **Abstract** — the claim, its scope, and the evidence, in one paragraph. No
   motivation, no "in this paper we".
2. **Introduction** — the claim stated in full; a literature paragraph placing
   it (what was known, by whom, cited); then `\paragraph{Organisation.}` naming
   what each section does and which inputs are classical vs new.
3. **Body** — one idea per section. Non-obvious claims get a
   `proposition`/`lemma` + `proof`, or an explicit experimental basis.
4. **Limitations** — what the result does not cover. Mandatory, not optional.
5. **Appendix** — self-contained proofs of quoted facts, or experimental
   details, forward-referenced from where they are used.
6. **Bibliography** — `references.bib`, full data: author, title, journal,
   volume, pages, year, DOI or arXiv id.

## Paragraph discipline

The rules that most separate a paper from a draft:

- **One paragraph, one message.** If you cannot state it in one sentence, it is
  two paragraphs.
- **Topic sentence first.** The first sentence says what the paragraph does.
- **Every sentence connects to the previous one** by cause, contrast,
  consequence, refinement, or example. No orphan sentences.
- **Self-contained nouns.** Define a term before reusing it.
- **No throat-clearing.** Delete "In this section, we will discuss…" and start
  with the claim.

### Reverse outline (run on every section)

Write down, in order: the section thesis, each paragraph's topic sentence, and
the evidence under each. Then check the mapping: every topic sentence supports
the thesis, every piece of evidence supports its topic sentence. Any paragraph
that cannot be mapped is cut or rewritten.

See `references/writing.md` for the full diagnostic and section-by-section
guides.

## Claim-evidence discipline

- **Every claim is either cited, proved, or backed by your own data.**
- Keep a claim-evidence map while drafting:
  `Claim: … | Evidence: … | Status: supported / needs evidence`.
- If a claim cannot be supported, **weaken or delete it**.
- Scope sentences ("we do not assert…") belong in the abstract or right after
  the claim.
- Argue against yourself once. A discussion that concedes where the result does
  not bite is more credible than one that does not.

## Anti-patterns

| # | Don't | Do |
|---|---|---|
| 1 | "delve into", "crucial", "it is important to note" | the discipline's own precise term |
| 2 | Em dashes that interrupt the argument | parentheses, commas, or restructure |
| 3 | Throat-clearing openers | start with the claim |
| 4 | Padding a paragraph to hit a length | give each point the space it needs |
| 5 | **Fabricated citations** | verify every DOI/arXiv id before citing |
| 6 | Sycophantic acceptance of all feedback | disagree with evidence when the reviewer is wrong |
| 7 | Scope creep during revision | address the stated concern only |
| 8 | A padded bibliography | every entry cited; uncited entries are a defect |

## Mandatory inclusions

Check before delivering; add the ones that apply: data availability, author
contributions (CRediT), conflict of interest, funding acknowledgement, ethics
declaration, limitations section, AI-use statement where the venue requires it.

## Before saying it is done

```bash
latexmk -pdf -interaction=nonstopmode -halt-on-error main.tex
```

With `natbib` the sequence is `pdflatex`, `bibtex main`, `pdflatex`, `pdflatex`.
Then check, in this order:

1. Log greps: `undefined`, `Citation`, `Reference`, `Overfull`.
2. **Every bib entry is cited** — count `\cite` keys against bib entries.
3. Every DOI/arXiv id resolves. A wrong id is worse than no citation.
4. Render a page or two to PNG and look at them. Tables overflow and figures
   float away from their lead-in; the log does not always say so.
5. Delete the artifacts (rule 7).

Then report what you actually verified, and name what you did not check.

## Related skills

- `academic-literature-review` — when the task is a survey, related-work
  section, or annotated bibliography rather than a paper.
- `academic-paper-review` — when the task is to review someone else's paper.
