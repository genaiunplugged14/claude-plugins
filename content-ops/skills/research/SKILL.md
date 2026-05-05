---
name: research
description: Research a topic and produce a structured brief at drafts/{slug}-research.md. Calls the researcher agent with web tools.
arguments:
  - name: topic
    description: The topic to research
    required: true
---

Use the **researcher** agent to research the topic: **$ARGUMENTS**

The researcher should:
1. Slugify the topic (lowercase, hyphenate spaces, strip non-alphanumeric, truncate to 60 chars).
2. Search Perplexity and the web for authoritative sources on this topic.
3. Identify 2-3 specific gaps in existing coverage.
4. Pull 5-10 concrete, citable facts.
5. Write three candidate hook lines.
6. Save the brief to `drafts/{slug}-research.md`.

After the researcher finishes, confirm the file was written and show me the path. Do not start drafting — that's the job of `/content-ops:draft`.
