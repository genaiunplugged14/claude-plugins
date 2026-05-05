#!/usr/bin/env bash
# format-on-save.sh — PostToolUse hook on Edit|Write.
# Reads JSON from stdin, runs `prettier --write` on .md files in drafts/ and distribution/.
# Silently exits 0 if prettier isn't installed or jq isn't available.

set -euo pipefail

# Tolerate missing jq (so the hook never errors out the editor)
if ! command -v jq >/dev/null 2>&1; then
  exit 0
fi

INPUT_JSON=$(cat)
FILE_PATH=$(echo "$INPUT_JSON" | jq -r '.tool_input.file_path // ""' 2>/dev/null || echo "")

# No file path = nothing to do
if [ -z "$FILE_PATH" ]; then
  exit 0
fi

# Only format markdown files in drafts/ or distribution/
case "$FILE_PATH" in
  *drafts/*.md|*distribution/*.md)
    ;;
  *)
    exit 0
    ;;
esac

# Skip if neither prettier nor npx is available
if ! command -v prettier >/dev/null 2>&1 && ! command -v npx >/dev/null 2>&1; then
  exit 0
fi

# Prefer locally-installed prettier, fall back to npx
if command -v prettier >/dev/null 2>&1; then
  prettier --write "$FILE_PATH" >/dev/null 2>&1 || true
else
  npx --no-install prettier --write "$FILE_PATH" >/dev/null 2>&1 || true
fi

exit 0
