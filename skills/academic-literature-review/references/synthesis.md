# Synthesis: turning notes into a review

## The failure mode

A review that reads as a sequence of "Paper A does X. Paper B does Y." is not a
review. It is a bibliography with paragraphs. The reader learns nothing about
how the field actually fits together.

## Organise by tension, not by paper

Bad structure:

```
2.1 Smith et al. (2019)
2.2 Jones et al. (2020)
2.3 Chen et al. (2021)
```

Good structure:

```
2.1 The precision–coverage tradeoff
2.2 Why early approaches could not scale
2.3 The reparameterisation that changed the tradeoff
2.4 What remains unexplained
```

Each subsection is a question or a tension. Papers appear as evidence, several
per subsection.

## The four synthesis outputs

### Themes

3–6 recurring directions. A theme is a claim about the field, not a topic
label. "Uncertainty quantification" is a topic. "The field has converged on
ensemble methods because single-model calibration failed" is a theme.

### Convergences

Where independent work agrees. This is the strongest evidence in a review,
because it survived different methods and different groups. Say how many
independent confirmations there are.

### Disagreements

Two kinds, and they are not the same:

- **Substantive** — different conclusions from comparable data. Real conflict.
- **Methodological** — results cannot be compared because the setups differ.
  This is far more common and usually the real story.

Say which one you are looking at. A methodological incompatibility is not a
contradiction and should not be presented as one.

### Gaps

What nobody has done. Be specific: "no study has measured X at Y scale" beats
"further research is needed". A gap you cannot name precisely is usually a gap
you have not found.

## Writing the comparison

When two papers disagree, the reader needs:

1. what each claims
2. on what data and assumptions
3. why the difference arises
4. which is more likely right, and on what evidence

If you cannot answer 4, say so. "The disagreement is unresolved" is a finding.

## Citation practice in a review

- Cite the original for a claim; cite the review only for the review's own
  synthesis.
- When you attribute a position, make sure the paper actually argues it. The
  most common review error is citing a paper for a claim it argues against.
- Group citations: `\cite{a,b,c}` for a body of work, single citations for
  specific claims.
- Never cite a paper you have not read past the abstract. If you only have the
  abstract, say so in the note.
