#!/usr/bin/env bash
# Runs after every Write or Edit. Checks drafts for brochure phrases.
# Exit 2 sends the list back to Claude so the writer fixes it.

INPUT=$(cat)
FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

case "$FILE" in
  */drafts/*-draft.md) ;;
  *) exit 0 ;;
esac

LOG="$CLAUDE_PROJECT_DIR/voice-guard.log"
PHRASES="nestled|breathtaking|hidden gem|must-visit|must-see|bucket list|picturesque|scenic beauty|panoramic views|pristine|majestic|enchanting|mesmerizing"

HITS=$(grep -niE "$PHRASES" "$FILE")

if [ -n "$HITS" ]; then
  echo "$(date +%H:%M:%S) BLOCKED $(basename "$FILE")" >> "$LOG"
  echo "Brochure phrases found in $(basename "$FILE"). Rewrite these lines:" >&2
  echo "$HITS" >&2
  exit 2
fi

echo "$(date +%H:%M:%S) clean   $(basename "$FILE")" >> "$LOG"
exit 0
