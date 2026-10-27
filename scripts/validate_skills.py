#!/usr/bin/env python3
"""Validate every SKILL.md against the Agent Skills specification.

Checks the fields a client will reject on:
  - name present, 1-64 chars, lowercase alphanumeric + single hyphens,
    no leading/trailing hyphen, no '--', matches its directory name
  - description present, 1-1024 chars
  - frontmatter delimited by --- on the first line
  - body non-empty

Exits 1 if any skill fails. No third-party dependencies.
"""
import re
import sys
from pathlib import Path

NAME_RE = re.compile(r"^[a-z0-9]+(-[a-z0-9]+)*$")
MAX_NAME = 64
MAX_DESC = 1024


def parse_frontmatter(text):
    """Return (frontmatter dict, body) or (None, reason)."""
    if not text.startswith("---"):
        return None, "file does not start with '---'"
    lines = text.splitlines()
    try:
        end = next(i for i in range(1, len(lines)) if lines[i].strip() == "---")
    except StopIteration:
        return None, "frontmatter is not closed with '---'"

    fm, key, buf = {}, None, []
    for line in lines[1:end]:
        if not line.strip():
            continue
        if re.match(r"^[A-Za-z0-9_-]+:", line):
            if key is not None:
                fm[key] = " ".join(buf).strip()
            key, _, rest = line.partition(":")
            key, buf = key.strip(), [rest.strip()]
        elif key is not None:
            buf.append(line.strip())
    if key is not None:
        fm[key] = " ".join(buf).strip()

    # A '>' or '|' block scalar marker is not part of the value.
    for k, v in fm.items():
        fm[k] = re.sub(r"^[>|][+-]?\s*", "", v)

    return fm, "\n".join(lines[end + 1:])


def validate(skill_dir: Path):
    problems = []
    skill_md = skill_dir / "SKILL.md"

    if not skill_md.is_file():
        return [f"{skill_dir.name}: no SKILL.md"]

    fm, body = parse_frontmatter(skill_md.read_text(encoding="utf-8"))
    if fm is None:
        return [f"{skill_dir.name}: {body}"]

    name = fm.get("name", "")
    desc = fm.get("description", "")

    if not name:
        problems.append(f"{skill_dir.name}: missing 'name'")
    else:
        if len(name) > MAX_NAME:
            problems.append(f"{skill_dir.name}: name longer than {MAX_NAME} chars")
        if not NAME_RE.match(name):
            problems.append(
                f"{skill_dir.name}: name '{name}' must be lowercase alphanumeric "
                "with single hyphens, no leading/trailing hyphen"
            )
        if name != skill_dir.name:
            problems.append(
                f"{skill_dir.name}: name '{name}' must match directory name '{skill_dir.name}'"
            )

    if not desc:
        problems.append(f"{skill_dir.name}: missing 'description'")
    elif len(desc) > MAX_DESC:
        problems.append(
            f"{skill_dir.name}: description is {len(desc)} chars (max {MAX_DESC})"
        )

    if not body.strip():
        problems.append(f"{skill_dir.name}: body is empty")

    return problems


def main():
    root = Path(__file__).resolve().parent.parent
    skills = sorted(
        p for p in (root / "skills").iterdir() if p.is_dir() and not p.name.startswith(".")
    )
    if not skills:
        print("No skills found under skills/")
        return 1

    all_problems = []
    for s in skills:
        problems = validate(s)
        if problems:
            all_problems.extend(problems)
            print(f"FAIL  {s.name}")
            for p in problems:
                print(f"      {p}")
        else:
            print(f"ok    {s.name}")

    print()
    if all_problems:
        print(f"{len(all_problems)} problem(s) across {len(skills)} skill(s)")
        return 1
    print(f"All {len(skills)} skills valid")
    return 0


if __name__ == "__main__":
    sys.exit(main())
