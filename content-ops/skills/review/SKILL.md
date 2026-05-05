---
name: review
description: Audit the most recent draft against the brand voice rules and a 25-point quality checklist. Calls the reviewer agent in read-only mode (cannot edit the draft).
---

Use the **reviewer** agent to audit the most recent draft.

The reviewer should:
1. Find the most recently modified `drafts/*-draft.md` file. If there isn't one, stop and tell me to run `/content-ops:draft <topic>` first.
2. Derive the slug from that filename.
3. Read `templates/brand-voice.md` for the voice rules.
4. Run through the 25-point quality checklist.
5. Write the review to `drafts/{slug}-review.md` with a score, top 3 fixes, blockers, and an honest reader's-perspective paragraph.

The reviewer is read-only. It will NEVER edit the draft. After the review is written, show me the score and the top 3 fixes inline.
