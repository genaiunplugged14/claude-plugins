---
name: repurpose
description: Turn a finished draft into platform-specific copy (LinkedIn post, X thread, 3 Substack notes). Calls the multiplier agent. Writes to distribution/{slug}/.
arguments:
  - name: draft_path
    description: Explicit path to the draft, e.g. drafts/my-topic-draft.md
    required: true
---

Use the **multiplier** agent to repurpose: **$ARGUMENTS**

The multiplier should:
1. Read the draft at the given path.
2. Derive the slug from the filename (strip `-draft.md`).
3. Find the strongest line, the sharpest contradiction, and the most specific number.
4. Write three files in `distribution/{slug}/`:
   - `linkedin.md` — one LinkedIn post (1,200-1,500 chars, hook + 4-6 paragraphs + closing question)
   - `x-thread.md` — one X/Twitter thread (6-10 tweets, numbered)
   - `notes.md` — three Substack notes (80-160 chars each, separated by ---)

Each piece must work standalone. After the multiplier finishes, show me the three file paths and the LinkedIn opening line.

Note: this skill REPURPOSES (writes platform-specific copy to disk). It does NOT distribute (post to platforms). That's a separate problem with API tokens and scheduling.
