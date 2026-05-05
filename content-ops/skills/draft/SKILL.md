---
name: draft
description: Turn the research brief at drafts/{slug}-research.md into a publishable draft at drafts/{slug}-draft.md. Calls the writer agent with brand-voice rules preloaded.
arguments:
  - name: topic
    description: The same topic you passed to /content-ops:research (used to derive the slug)
    required: true
---

Use the **writer** agent to draft an article on: **$ARGUMENTS**

The writer should:
1. Slugify the topic the same way `/content-ops:research` did (lowercase, hyphenate, alphanumerics, max 60 chars).
2. Read `drafts/{slug}-research.md`. If it doesn't exist, stop and tell me to run `/content-ops:research $ARGUMENTS` first.
3. Read `templates/brand-voice.md` and apply every rule (forbidden phrases, sentence-length targets, hook formulas).
4. Use the strongest hook from the brief's "Hook candidates" section.
5. Write 2,500-3,000 words to `drafts/{slug}-draft.md`.
6. Cite every factual claim with a Markdown link to the source.

After the writer finishes, show me the file path and the opening paragraph. Do not auto-review — that's the job of `/content-ops:review`.
