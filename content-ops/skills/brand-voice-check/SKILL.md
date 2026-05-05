---
name: brand-voice-check
description: Quick brand voice audit on any markdown file. Flags forbidden phrases, em-dashes, missing hook patterns. Useful as a pre-publish sanity check.
arguments:
  - name: file_path
    description: Path to the markdown file to audit
    required: true
---

Audit the markdown file at **$ARGUMENTS** against the brand voice rules in `templates/brand-voice.md`.

Report:

1. **Em-dash count** — flag every em-dash (—) and en-dash (–). The brand rule is zero.
2. **Forbidden phrases** — list every match for: "in today's fast-paced world", "leverage", "synergy", "unlock the power of", "delve into", "it's important to note", "navigate the landscape", "in the rapidly evolving". Plus any custom forbidden patterns from `templates/brand-voice.md`.
3. **Hook check** — does the first paragraph contain at least one specific number or named contradiction?
4. **Sentence-length distribution** — average sentence length, longest sentence, count of sentences over 30 words.

If everything passes, return "PASS" plus a one-line summary. If anything fails, return "FAIL" plus a numbered list of issues with line numbers.

Read-only. Do NOT edit the file. The user decides what to fix.
