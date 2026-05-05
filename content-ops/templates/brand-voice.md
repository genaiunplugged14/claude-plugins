# Brand voice rules

This is the file you customize. The starter rules below are GenAI Unplugged's defaults — replace them with your own voice principles before the writer agent's first run.

## Voice principles

- **Conversational, not corporate.** Use "I" and "you". Skip "the team", "we as a company".
- **Specific over abstract.** Replace "many users" with "73 of 100 testers". Replace "fast" with "8 minutes". Numbers > adjectives.
- **Honest VERIFY markers are encouraged.** If you're not sure a fact is current, write `[VERIFY: <claim>]` and let the reviewer agent decide.
- **Build-in-public posture.** Show the actual files, the actual costs, the actual cron lines. Not "imagine if you could..."

## Sentence length

- Average target: 14-18 words.
- Hard limit: no sentence over 30 words. Break it.
- One-sentence paragraphs are fine for emphasis.

## Hook formulas (pick one per article)

1. **The wrong number.** "Most tutorials say X. The current docs say Y. Three different numbers for the same thing."
2. **The thing that broke.** "Three things broke the first time I tried this. Here's what they were."
3. **The contradiction.** "The popular advice says X. The data says the opposite. Here's why."

Always lead with a specific number, named tool, or named contradiction in the first three sentences.

## Forbidden patterns

The `quality-check.sh` hook will flag any of these in `drafts/*-draft.md` files over 1,000 words. Add your own as you encounter them.

- "in today's fast-paced world"
- "leverage"
- "synergy"
- "unlock the power of"
- "delve into"
- "it's important to note"
- "navigate the landscape"
- "in the rapidly evolving"
- em-dashes (use periods, commas, or line breaks instead)

## Article structure

- **Opening (2-3 sentences):** specific number or named contradiction. No throat-clearing.
- **What you're solving (1 paragraph):** the problem in the reader's words.
- **Body (4-7 H2 sections):** one section per major idea, each with a code block, table, or list.
- **Pitfalls (1 H2):** specific failure modes, not generic warnings.
- **Key takeaways (8-10 bullets):** each starting with a bold lead phrase.
- **Mini exercise (5-8 numbered steps):** something the reader does in 15-45 minutes.

## Word count targets

- System-building / tutorial articles: **2,500-3,000 words**
- Theory / mental-model articles: **1,500-2,000 words**
- Anything under 1,200 words: probably a Substack note, not an article.
