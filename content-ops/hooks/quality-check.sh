#!/usr/bin/env bash
# quality-check.sh — PostToolUse hook on Edit|Write.
# Dual guard: only fires on drafts/*-draft.md AND when word count >= 1000.
# Without the dual guard, the hook fires on every intermediate save and creates a writer/hook feedback loop.

set -euo pipefail

FILE_PATH="${CLAUDE_FILE_PATH:-${1:-}}"

# No file path = nothing to do
if [ -z "$FILE_PATH" ]; then
  exit 0
fi

# Guard 1: must match drafts/*-draft.md
case "$FILE_PATH" in
  *drafts/*-draft.md)
    ;;
  *)
    exit 0
    ;;
esac

# File must exist (Write hook fires before file is fully on disk in some cases)
if [ ! -f "$FILE_PATH" ]; then
  exit 0
fi

# Guard 2: word count must be >= 1000
WORD_COUNT=$(wc -w < "$FILE_PATH" 2>/dev/null || echo "0")
if [ "$WORD_COUNT" -lt 1000 ]; then
  exit 0
fi

# Both guards passed. Run the audit.
ISSUES=()

# Check for em-dashes
if grep -q "—\|–" "$FILE_PATH" 2>/dev/null; then
  COUNT=$(grep -o "—\|–" "$FILE_PATH" 2>/dev/null | wc -l | tr -d ' ')
  ISSUES+=("$COUNT em-dash/en-dash usage(s) — brand rule is zero")
fi

# Check for forbidden phrases (case-insensitive)
FORBIDDEN=(
  "in today's fast-paced world"
  "leverage"
  "synergy"
  "unlock the power of"
  "delve into"
  "it's important to note"
  "navigate the landscape"
)

for phrase in "${FORBIDDEN[@]}"; do
  if grep -iq "$phrase" "$FILE_PATH" 2>/dev/null; then
    ISSUES+=("forbidden phrase found: \"$phrase\"")
  fi
done

# Report
if [ ${#ISSUES[@]} -gt 0 ]; then
  echo "" >&2
  echo "⚠️  quality-check.sh flagged $FILE_PATH:" >&2
  for issue in "${ISSUES[@]}"; do
    echo "   • $issue" >&2
  done
  echo "" >&2
  # Exit 0 (warning, not block) so writes still succeed
fi

exit 0
