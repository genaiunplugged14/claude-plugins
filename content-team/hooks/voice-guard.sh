#!/usr/bin/env bash
# Checks every saved draft for brochure phrases.
# Exit 2 sends the bad lines back to the writer, who rewrites them.

INPUT=$(cat)
FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')
case "$FILE" in */drafts/*-draft.md) ;; *) exit 0 ;; esac

LOG="$CLAUDE_PROJECT_DIR/voice-guard.log"
PHRASES="nestled|breathtaking|hidden gem|must-visit|must-see|bucket list|picturesque|pristine|majestic"
HITS=$(grep -niE "$PHRASES" "$FILE")

if [ -n "$HITS" ]; then
  echo "$(date +%T) FLAGGED $(basename "$FILE")" >> "$LOG"
  echo "Brochure phrases found. Rewrite these lines:" >&2
  echo "$HITS" >&2
  exit 2
fi
echo "$(date +%T) clean   $(basename "$FILE")" >> "$LOG"
