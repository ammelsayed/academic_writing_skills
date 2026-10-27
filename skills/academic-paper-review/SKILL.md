---
name: academic-paper-review
description: >
  Review a paper as a referee would: reconstruct the claims, test each against
  the evidence provided, check the statistics and the citations, and write a
  report the authors can act on. Covers claim-evidence auditing, methodological
  checks, severity ranking, and review etiquette. Use for "review this paper",
  "critique my draft", "find the weaknesses in this argument", "is this
  analysis sound", or "write referee comments".
license: MIT
metadata:
  author: ammelsayed
  version: "1.0.0"
  homepage: https://github.com/ammelsayed/academic_writing_skills
---

# Paper review

A review that says "the paper is well written and the experiments are
thorough" is worthless. A review names the specific claim that is unsupported
and what evidence would support it.

## Read in this order

1. **Abstract and conclusion only.** Write down what the paper claims. Do not
   read the body yet — this is the claim as a reader will meet it.
2. **Figures and tables only.** Ask what the data actually show, independent of
   what the text says they show.
3. **Now the body.** For each claim from step 1, find the section that supports
   it. Mark it: supported / partially / unsupported / contradicted.

This order catches the most common defect: a claim in the abstract that the
body does not establish.

## The claim-evidence audit

Produce this table. It is the core of the review.

```text
Claim:        <verbatim from abstract or intro>
Evidence:     <section, figure, or table that is supposed to support it>
Status:       supported | partial | unsupported | contradicted
Gap:          <what is missing, in one sentence>
```

A claim marked *partial* usually means the paper shows the effect in one
setting and asserts it in general.

## Methodological checks

Run the ones that apply. Each is a real reviewer question, not a formality.

**Statistics**
- Is there a variance estimate, or a single run presented as a result?
- How many comparisons were made? Multiple comparisons inflate the best result.
- Is the effect size reported, or only a p-value?
- Is the test appropriate to the data's distribution and dependence structure?

**Experimental design**
- Is the baseline the strongest available, or a strawman?
- Is the test set genuinely held out, including for hyperparameter selection?
- Are the splits random, or does the data have structure (time, group,
  subject) that random splits leak?
- Is the sample size justified, or is it "as much as we had"?

**Reproducibility**
- Are the data, code, and hyperparameters available or specified?
- Could a competent reader re-run this? If not, what is missing?
- Are the versions of dependencies pinned?

**Theory**
- Are the assumptions stated, and are they used, or decorative?
- Does the proof actually establish the stated theorem, or a weaker one?
- Are edge cases (empty set, zero, boundary, infinite) handled?

## Citation checks

- Does the cited work actually support the sentence it is attached to?
- Is the claim attributed to the original, or to a later paper that restated
  it?
- Are there missing citations to obvious prior work?
- Does every reference resolve? Spot-check the DOIs and arXiv ids.
- Is the paper citing itself to inflate its own importance?

## Severity ranking

Every finding gets one of these. A review with ten "major" issues is a review
that has not prioritised.

| Severity | Meaning |
|---|---|
| **Critical** | The central claim is unsupported or contradicted. Reject. |
| **Major** | A significant gap that needs new work, not just rewriting. |
| **Minor** | Fixable by rewriting, adding a citation, or clarifying. |
| **Nit** | Cosmetic. Group these into one paragraph, never a list. |

## Writing the report

Structure:

1. **Summary in two sentences.** What the paper does, in the reviewer's words.
   This proves you read it and shows the authors whether their message landed.
2. **Assessment.** One paragraph: is the claim established, and what is the
   single biggest problem.
3. **Major points.** Numbered. Each one: what is wrong, why it matters, what
   would fix it.
4. **Minor points.** Numbered, short.
5. **Recommendation.** With the reason, in one sentence.

### Etiquette that is also strategy

- Criticise the work, never the author. "This analysis ignores X" not "the
  authors seem unaware of X".
- Every criticism gets a concrete suggestion. A problem with no path forward
  is just discouragement.
- Say what is good, specifically. "The ablation in Table 3 is the right
  experiment" is useful; "the experiments are thorough" is not.
- If you are unsure whether something is wrong, say "I could not follow X"
  rather than "X is wrong". The first invites clarification; the second invites
  a fight.
- Do not ask for experiments that would be a different paper. Ask for what
  would establish *this* claim.

## Self-review before submitting

Run the same audit on your own draft before a reviewer does. The claim-evidence
table you produce for yourself is the single highest-value hour in the whole
writing process.
