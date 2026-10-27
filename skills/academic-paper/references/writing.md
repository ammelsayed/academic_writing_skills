# Writing: diagnostics and section guides

Load the section you are editing. Do not read all of it at once.

## The paragraph clarity check

Run this whenever a paragraph "feels off" or a reviewer says it does not flow.

1. **Read as an outsider.** Does the paragraph have one explicit message? Does
   its first sentence say what it will do? Are all key nouns readable without
   hidden context? Does each sentence connect to the previous one?
2. **Reverse outline the section.** Write the thesis, then each paragraph's
   topic sentence, then the evidence under each. Check the mapping: topic
   sentence → thesis, evidence → topic sentence. Cut or rewrite anything that
   does not map.
3. **If flow is still weak**, add temporary headers and explicit transitions
   during revision, then remove the headers you do not need.

## Abstract

- One paragraph. The claim, its scope, the evidence.
- No motivation, no roadmap, no "in this paper we".
- Every number in the abstract must appear in the body.
- A reader who reads only the abstract should know what was established and
  what was not.

## Introduction

Four moves, in order:

1. **The problem** — what is unknown, and why it matters. Two paragraphs at most.
2. **What was known** — the literature paragraph. Cite the originals, not the
   reviews. Name the specific gap, not "little work exists".
3. **What this paper does** — the claim, stated in full, with its scope.
4. **Organisation** — one `\paragraph{Organisation.}` naming each section.

The introduction is where overclaiming does the most damage. Every sentence
that says "we show" must be checkable against a later section.

## Related work

- Group by **approach**, not by paper. A list of one-line summaries is not a
  related-work section.
- For each group: what it does, what it cannot do, and how this paper differs.
- Be fair. A strawman comparison is the fastest way to lose a reviewer.
- Cite the paper that introduced an idea, not the one that popularised it,
  unless the popularisation is the point.

## Method

- State the problem formally before the solution.
- Define every symbol at first use; keep notation stable for the whole paper.
- Motivate each design choice: what breaks if you do it the obvious way?
- Separate what is novel from what is standard, explicitly. A reader should
  never have to guess which part you invented.

## Experiments / Results

- State the question each experiment answers **before** the numbers.
- Report the baseline that a sceptic would ask for, not the weakest one.
- Give the metric, the split, the number of runs, and the variance.
- A table with no variance is a claim that the difference is real, and it is
  usually not.
- Negative results belong in the paper. Burying them is a finding waiting to be
  discovered by a reviewer.

## Conclusion

- Restate the claim, not the abstract.
- State the limitation that matters most.
- One sentence on what would falsify or extend it.
- Do not introduce new claims here.

## Tables and figures

- A table should be readable at 100% zoom without the caption.
- Units in the column header, not in every cell.
- The caption states what is shown and what the reader should notice.
- `booktabs` rules only: `\toprule`, `\midrule`, `\bottomrule`. No vertical
  rules, no double rules.
- Every figure must be referenced from the text before it appears, and the text
  must say what it shows — not "see Figure 1".
