#!/usr/bin/env bash
# block-dangerous.sh — PreToolUse hook on Bash.
# Reads JSON from stdin, blocks destructive commands regardless of permission mode.

set -euo pipefail

# Read the entire hook payload from stdin
INPUT_JSON=$(cat)

# Extract the command (Bash tool); fall back to empty if missing
COMMAND=$(echo "$INPUT_JSON" | jq -r '.tool_input.command // ""' 2>/dev/null || echo "")

# Nothing to check
if [ -z "$COMMAND" ]; then
  exit 0
fi

# Patterns to block (case-insensitive)
PATTERNS=(
  'rm[[:space:]]+-rf?[[:space:]]+/'              # rm -rf /  or rm -r /
  'rm[[:space:]]+-rf?[[:space:]]+\$home'         # rm -rf $HOME
  'rm[[:space:]]+-rf?[[:space:]]+~'              # rm -rf ~
  'git[[:space:]]+push[[:space:]].*--force'      # git push --force
  'git[[:space:]]+push[[:space:]].*-f($|[[:space:]])'  # git push -f
  'drop[[:space:]]+(database|table)'             # drop database/table
  ':\(\)\{.*:\|:\&\};:'                           # fork bomb
  'mkfs\.'                                        # filesystem format
  'dd[[:space:]]+if=.*of=/dev/'                  # dd to a raw device
)

COMMAND_LC=$(echo "$COMMAND" | tr '[:upper:]' '[:lower:]')

for pattern in "${PATTERNS[@]}"; do
  if echo "$COMMAND_LC" | grep -qE "$pattern"; then
    # Return a structured deny decision per Claude Code's hook protocol
    jq -n --arg reason "Refused: command matches forbidden pattern \"$pattern\". Edit hooks/block-dangerous.sh to relax." '{
      hookSpecificOutput: {
        hookEventName: "PreToolUse",
        permissionDecision: "deny",
        permissionDecisionReason: $reason
      }
    }'
    exit 0
  fi
done

# No match → allow (silent exit 0)
exit 0
