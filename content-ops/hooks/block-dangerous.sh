#!/usr/bin/env bash
# block-dangerous.sh — PreToolUse hook on Bash.
# Blocks destructive commands regardless of permission mode.
# Reads the tool input from CLAUDE_TOOL_INPUT env var (JSON), grep for dangerous patterns.

set -euo pipefail

INPUT="${CLAUDE_TOOL_INPUT:-}"

# If we can't read the input, fail open (don't block legitimate work)
if [ -z "$INPUT" ]; then
  exit 0
fi

# Patterns to block
PATTERNS=(
  'rm[[:space:]]+-rf[[:space:]]+/'             # rm -rf /
  'rm[[:space:]]+-rf[[:space:]]+\$HOME'        # rm -rf $HOME
  'rm[[:space:]]+-rf[[:space:]]+~'             # rm -rf ~
  'git[[:space:]]+push[[:space:]].*--force'    # git push --force
  'git[[:space:]]+push[[:space:]].*-f($|[[:space:]])'  # git push -f
  'drop[[:space:]]+(database|table)'           # drop database/table (case-insensitive below)
  ':\(\)\{.*:\|:\&\};:'                         # fork bomb
  'mkfs\.'                                      # filesystem format
  'dd[[:space:]]+if=.*of=/dev/'                # dd to a raw device
)

# Lowercase the input once for case-insensitive matching
INPUT_LC=$(echo "$INPUT" | tr '[:upper:]' '[:lower:]')

for pattern in "${PATTERNS[@]}"; do
  if echo "$INPUT_LC" | grep -qE "$pattern"; then
    echo "🛑 block-dangerous.sh: command matches forbidden pattern: $pattern" >&2
    echo "   Refusing to run: $INPUT" >&2
    exit 1
  fi
done

exit 0
