# Academic Writing Skills

**Turn any AI agent into a competent academic writer.** Three skills that make
agents write papers a reviewer takes seriously, review manuscripts as a referee
would, and synthesise literature instead of listing it.

Works with **Claude Code, Codex, OpenCode, Cursor, zcode, DSH, WorkBuddy**, and
any client that implements the [Agent Skills](https://agentskills.io)
open standard. Install with one command, or use it as a Claude Code plugin
marketplace.

```
npx skills add ammelsayed/academic_writing_skills
```

Requires Node 22.20+. Detects your installed agents and lets you pick where to
install.

---

## The problem this fixes

Ask an AI to write a paper and you get a blog post with formulas. It opens with
"In this section, we will discuss", pads paragraphs to hit a length, cites
papers that do not exist, and claims more in the abstract than the body
supports.

These skills are the rules that stop that. Not prompts — procedures, with
checkable outputs.

## What's inside

| Skill | Use it to | The hard part it enforces |
|---|---|---|
| **`academic-paper`** | Write and build a paper in LaTeX | Paragraph discipline, claim-evidence mapping, a build that actually compiles |
| **`academic-literature-review`** | Survey a field, write related work | Citation-graph expansion, structured notes, synthesis with real themes |
| **`academic-paper-review`** | Referee a manuscript, critique your draft | Claim-evidence audit, severity ranking, reviews authors can act on |

### `academic-paper`

- **LaTeX house rules** — a fixed, opinionated preamble. `natbib` +
  `plainnat` with an external `.bib`, coloured `hyperref` links, figures in
  `figures/`, no unused packages, no compiler artifacts left behind.
- **Routing before drafting** — empirical, theoretical, review, thesis, or
  report. The type decides the skeleton; you do not start writing until it is
  fixed.
- **Paragraph discipline** — one paragraph, one message. Topic sentence first.
  Every sentence connects to the last. With a **reverse outline** procedure that
  finds the paragraph that does not belong.
- **Claim-evidence discipline** — every claim is cited, proved, or backed by
  data. If it cannot be supported, it is weakened or deleted, not hedged.

### `academic-literature-review`

- **Citation-graph expansion** — seed set, then references, then cited-by,
  repeat until the map stops growing. Keyword search finds what is indexed;
  citation chasing finds what matters.
- **Query discipline** — two or three core terms, never the full topic phrase.
  `"diffusion models"` works. `"diffusion models in computer vision"` returns
  nothing.
- **The compression that kills vague summaries** — never "this paper studies
  X". Instead: `prior status → intervention → assumptions → result → remaining
  tension`.
- **Synthesis or admission** — themes, convergences, disagreements, gaps. If
  the papers are too heterogeneous for themes, the skill says so instead of
  inventing them.

### `academic-paper-review`

- **Read in the right order** — abstract and conclusion, then figures and
  tables, *then* the body. This catches the abstract claim the body never
  establishes.
- **Claim-evidence audit table** — every claim marked `supported`, `partial`,
  `unsupported`, or `contradicted`.
- **Methodological checks** — variance, multiple comparisons, split leakage,
  strawman baselines, whether the proof establishes the stated theorem.
- **Severity ranking** — Critical, Major, Minor, Nit. A review with ten "major"
  issues has not prioritised.

## Install

### Any agent, one command

```bash
npx skills add ammelsayed/academic_writing_skills
```

The [`skills` CLI](https://github.com/vercel-labs/skills) (Vercel Labs, 79
supported agents) detects which agents you have and installs into each. Needs
Node 22.20+. Add `-g` to make the skills available across all projects rather
than the current one.

### Claude Code, as a plugin marketplace

```text
/plugin marketplace add ammelsayed/academic_writing_skills
/plugin install academic-writing-skills@academic-writing-skills
```

Then `/academic-writing-skills:academic-paper`.

### Shell installer, every agent at once

macOS / Linux / WSL:

```bash
curl -fsSL https://raw.githubusercontent.com/ammelsayed/academic_writing_skills/main/install.sh | bash
```

Windows:

```powershell
irm https://raw.githubusercontent.com/ammelsayed/academic_writing_skills/main/install.ps1 | iex
```

The installer writes only into agents that exist on your machine, and supports
`--dry-run` / `-DryRun` and `--uninstall` / `-Uninstall`.

### Manual

Copy any skill folder into your agent's skills directory:

| Agent | Directory |
|---|---|
| Claude Code | `~/.claude/skills/` |
| Codex | `~/.codex/skills/` |
| OpenCode | `~/.config/opencode/skills/` or `~/.claude/skills/` |
| Cursor | `~/.cursor/skills/` |
| zcode | `~/.zcode/skills/` |
| DSH | `~/.dsh/skills/` |
| WorkBuddy | `~/.workbuddy/skills/` |
| Any Agent Skills client | `~/.agents/skills/` |

```bash
git clone https://github.com/ammelsayed/academic_writing_skills
cp -R academic_writing_skills/skills/* ~/.claude/skills/
```

### As a plugin

The repo is a valid Claude Code plugin (`.claude-plugin/plugin.json`) and a
valid marketplace (`.claude-plugin/marketplace.json`). Load it for one session
without installing:

```bash
claude --plugin-dir /path/to/academic_writing_skills
```

## Layout

```
academic_writing_skills/
├── .claude-plugin/
│   ├── plugin.json           # plugin manifest
│   └── marketplace.json      # marketplace catalog
├── skills/
│   ├── academic-paper/
│   │   ├── SKILL.md
│   │   └── references/writing.md
│   ├── academic-literature-review/
│   │   ├── SKILL.md
│   │   └── references/synthesis.md
│   └── academic-paper-review/
│       └── SKILL.md
├── scripts/
│   └── validate_skills.py    # spec checker, no dependencies
├── install.sh
└── install.ps1
```

Skills use **progressive disclosure**: only the name and description load at
startup. The body loads when the task matches, and `references/` only when the
agent needs that section. Three skills cost a few hundred tokens until used.

## Verify

```bash
python3 scripts/validate_skills.py
```

```
ok    academic-literature-review
ok    academic-paper
ok    academic-paper-review

All 3 skills valid
```

Checks name format, name/directory match, description length, frontmatter
delimiters, and non-empty body — the things a client rejects on.

## The rules that matter most

If you read nothing else:

1. **Every claim is cited, proved, or backed by data.** Anything else is cut.
2. **One paragraph, one message.** Topic sentence first.
3. **A review that says "well written and thorough" is worthless.** Name the
   claim that is unsupported.
4. **Verify every DOI and arXiv id.** A wrong citation is worse than none.
5. **Say what you did not check.** Every report ends with it.

## Contributing

Issues and PRs welcome. If you add a skill:

1. Put it in `skills/<name>/SKILL.md` — name must match the directory.
2. Run `python3 scripts/validate_skills.py`.
3. Keep the description under 1024 characters and make it say *when* to use
   the skill, not just what it does — that is the only text the agent sees
   before deciding.

## License

MIT. Use it, fork it, ship it.

---

If this saved you a rejected draft, a star helps someone else find it.
