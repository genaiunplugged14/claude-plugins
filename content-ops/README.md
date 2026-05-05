# content-ops

A Claude Code plugin that turns one topic into a publishable article + three platform-specific repurposed pieces in about 45 minutes.

Pipeline: **research → draft → review → repurpose**, wired through 4 specialist agents, 5 namespaced skills, and 3 production hooks.

Built from the [GenAI Unplugged Claude Code Masterclass](https://www.genaiunplugged.com/courses/claude-code/), Lesson 6.

## Install

From inside Claude Code:

```
/plugin marketplace add genaiunplugged14/claude-plugins
/plugin install content-ops@genaiunplugged14
```

After install, type `/` in any project and you'll see the namespaced skills:

- `/content-ops:research <topic>`
- `/content-ops:draft <topic>`
- `/content-ops:review`
- `/content-ops:repurpose <draft-path>`
- `/content-ops:brand-voice-check <file-path>`

## What you need before the first run

Two API keys. Both have free tiers that comfortably cover personal use.

| Variable | Where to get it | Free tier |
|---|---|---|
| `PERPLEXITY_API_KEY` | https://perplexity.ai/settings/api | 1,000 requests / month (~50 articles) |
| `FIRECRAWL_API_KEY` | https://firecrawl.dev | 500 pages / month (~100 articles) |

The plugin will prompt you for both on first install (via the `userConfig` section of the manifest).

## Quick start

```
/content-ops:research Claude Code hooks tutorial
# → drafts/claude-code-hooks-tutorial-research.md  (~5 minutes, ~865 words)

/content-ops:draft Claude Code hooks tutorial
# → drafts/claude-code-hooks-tutorial-draft.md  (~8 minutes, ~2,800 words)

/content-ops:review
# → drafts/claude-code-hooks-tutorial-review.md  (~3 minutes, score + top 3 fixes)

/content-ops:repurpose drafts/claude-code-hooks-tutorial-draft.md
# → distribution/claude-code-hooks-tutorial/{linkedin,x-thread,notes}.md  (~4 minutes)
```

Total: ~20 minutes of compute, ~$1.50 of API spend, four files you would have spent three hours producing manually.

## Customize the brand voice

The only file you need to edit is `templates/brand-voice.md`. Replace the GenAI Unplugged defaults with your own voice rules:

- Forbidden phrases (the `quality-check.sh` hook flags these in long drafts)
- Hook formulas
- Sentence-length targets
- Article structure

The writer agent reads this file at every draft. Tune over your first 3-5 articles and the writer will sound like you.

## What's inside

```
content-ops/
├── .claude-plugin/
│   └── plugin.json              # manifest (name, version, userConfig)
├── agents/                      # 4 specialist agents
│   ├── researcher.md            # Sonnet + Perplexity + Firecrawl
│   ├── writer.md                # Sonnet, brand-voice preloaded
│   ├── reviewer.md              # Sonnet, permissionMode: plan, read-only
│   └── multiplier.md            # Sonnet, three-platform output
├── skills/                      # 5 namespaced slash commands
│   ├── research/SKILL.md
│   ├── draft/SKILL.md
│   ├── review/SKILL.md
│   ├── repurpose/SKILL.md
│   └── brand-voice-check/SKILL.md
├── hooks/
│   ├── hooks.json               # PreToolUse + PostToolUse matchers
│   ├── block-dangerous.sh       # blocks rm -rf, git push --force, etc.
│   ├── format-on-save.sh        # prettier on drafts/*.md and distribution/*.md
│   └── quality-check.sh         # dual-guard hook: drafts/*-draft.md AND >=1000 words
├── .mcp.json                    # Perplexity + Firecrawl MCP server config
├── templates/
│   └── brand-voice.md           # the only file you customize
└── README.md
```

## Hooks behavior

- **`block-dangerous.sh`** fires on every Bash command and refuses `rm -rf /`, `git push --force`, `drop table`, fork bombs, raw `dd` writes. Fires regardless of permission mode.
- **`format-on-save.sh`** runs `prettier --write` on `.md` files in `drafts/` and `distribution/`. Silently skips if prettier isn't installed.
- **`quality-check.sh`** flags em-dashes and forbidden phrases. Dual guard (`drafts/*-draft.md` AND `>=1000 words`) prevents the writer/hook feedback loop. Warns to stderr; never blocks.

## Permission modes

The `reviewer` agent ships with `permissionMode: plan` and `disallowedTools: Edit` baked into its frontmatter. It cannot edit the draft no matter what your prompt says — that's by design.

The other three agents work in any permission mode you set for the session.

## Costs

| Stage | Tokens | Approx. cost (Claude Sonnet) |
|---|---|---|
| Research | ~3K in, ~2K out | $0.10 + Perplexity API call |
| Draft | ~8K in, ~6K out | $0.45 |
| Review | ~10K in, ~3K out | $0.40 |
| Repurpose | ~9K in, ~3K out | $0.35 |
| **Per article** | | **~$1.30 + ~$0.20 external API** |

Eight articles a month = roughly $12 of pipeline cost.

## Troubleshooting

| Symptom | Cause | Fix |
|---|---|---|
| Skills don't appear after install | Plugin not enabled | `/plugin enable content-ops@genaiunplugged14` |
| "Hook script not found" | Old install, paths cached | `/plugin uninstall content-ops` then re-install |
| Researcher fails immediately | Missing API keys | `/plugin enable content-ops@genaiunplugged14` re-prompts for keys |
| Writer keeps using a phrase you hate | Brand voice file not edited | Edit `templates/brand-voice.md` and add the phrase to the forbidden list |
| `/content-ops:draft` says no research brief | Slug mismatch | Pass the same topic to `/content-ops:research` and `/content-ops:draft` — they derive the slug identically |

## Repository

Source: https://github.com/genaiunplugged14/claude-plugins/tree/main/content-ops

Issues: https://github.com/genaiunplugged14/claude-plugins/issues

## License

MIT. See [LICENSE](../LICENSE) at the marketplace root.

## Related

- [Claude Code Masterclass — Lesson 6](https://www.genaiunplugged.com/courses/claude-code/) — the article that walks through this plugin from scratch
- [Agents Toolkit](https://store.genaiunplugged.com/) — the production-grade version with research, SEO, and quality agents tested across 100+ articles
