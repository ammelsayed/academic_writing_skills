#!/usr/bin/env bash
# Install the academic-writing-skills into every AI agent found on this machine.
#
#   curl -fsSL https://raw.githubusercontent.com/ammelsayed/academic_writing_skills/main/install.sh | bash
#
# or, from a clone:
#
#   ./install.sh              # install
#   ./install.sh --dry-run    # show what would happen
#   ./install.sh --uninstall  # remove
set -euo pipefail

REPO="https://github.com/ammelsayed/academic_writing_skills.git"
RAW="https://raw.githubusercontent.com/ammelsayed/academic_writing_skills/main"
DRY=0
UNINSTALL=0

for arg in "$@"; do
  case "$arg" in
    --dry-run) DRY=1 ;;
    --uninstall) UNINSTALL=1 ;;
    -h|--help) sed -n '2,10p' "$0"; exit 0 ;;
  esac
done

# Agent skill directories, in the order we report them.
# Each entry: "Label|path"
TARGETS=(
  "Claude Code|$HOME/.claude/skills"
  "Codex|$HOME/.codex/skills"
  "OpenCode|$HOME/.config/opencode/skills"
  "Cursor|$HOME/.cursor/skills"
  "zcode|$HOME/.zcode/skills"
  "DSH|$HOME/.dsh/skills"
  "WorkBuddy|$HOME/.workbuddy/skills"
  "Agent Skills (universal)|$HOME/.agents/skills"
)

# Resolve the source: use a local clone if this script sits in one.
SRC=""
if [ -f "$(dirname "$0")/skills/academic-paper/SKILL.md" ]; then
  SRC="$(cd "$(dirname "$0")" && pwd)/skills"
else
  TMP="$(mktemp -d)"
  trap 'rm -rf "$TMP"' EXIT
  echo "Fetching skills from $REPO ..."
  git clone --depth 1 --quiet "$REPO" "$TMP/repo"
  SRC="$TMP/repo/skills"
fi

SKILLS=(academic-paper academic-literature-review academic-paper-review)

say() { printf '%s\n' "$*"; }
run() { if [ "$DRY" -eq 1 ]; then say "  [dry-run] $*"; else "$@"; fi; }

if [ "$UNINSTALL" -eq 1 ]; then
  say "Uninstalling academic writing skills"
  for entry in "${TARGETS[@]}"; do
    label="${entry%%|*}"; dir="${entry##*|}"
    for s in "${SKILLS[@]}"; do
      if [ -e "$dir/$s" ]; then
        run rm -rf "$dir/$s"
        say "  removed  $label  $s"
      fi
    done
  done
  exit 0
fi

installed=0
for entry in "${TARGETS[@]}"; do
  label="${entry%%|*}"; dir="${entry##*|}"
  parent="$(dirname "$dir")"

  # Only install where the agent actually exists on this machine.
  if [ ! -d "$parent" ]; then
    continue
  fi

  run mkdir -p "$dir"
  for s in "${SKILLS[@]}"; do
    run rm -rf "$dir/$s"
    run cp -R "$SRC/$s" "$dir/$s"
    say "  installed  $label  ->  $dir/$s"
    installed=$((installed + 1))
  done
done

if [ "$installed" -eq 0 ]; then
  say "No supported agent found. Create one of these directories and re-run:"
  for entry in "${TARGETS[@]}"; do say "  ${entry##*|}"; done
  exit 1
fi

say ""
say "Done. $installed skill installs. Restart the agent, or run its reload command."
