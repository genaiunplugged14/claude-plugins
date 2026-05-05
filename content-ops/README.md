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

## Important: terms of use, disclaimer, and privacy

This plugin is shipped FOR EDUCATIONAL AND PERSONAL USE under the MIT License. Read this section before installing.

### Educational and at-your-own-risk

The plugin, every agent inside it, and every hook script (including `block-dangerous.sh`, `format-on-save.sh`, and `quality-check.sh`) are provided as a teaching companion to the [Claude Code Masterclass](https://www.genaiunplugged.com/courses/claude-code/). They demonstrate how to package a content pipeline as a Claude Code plugin. They are NOT a security product, NOT a production safety system, and NOT a substitute for human review of AI output.

In particular:

- `block-dangerous.sh` is a teaching example of a PreToolUse hook. It blocks a small set of obvious patterns (`rm -rf /`, `git push --force`, fork bombs, raw `dd` writes). It is NOT a comprehensive security control and MUST NOT be relied on as one. A determined attacker, a creative typo, or a command structured slightly differently can bypass it. Use real OS-level permissions, version control, and backups for actual safety.
- The researcher, writer, reviewer, and multiplier agents produce AI-generated content. AI output can be wrong, biased, or fabricated. Verify every factual claim before publishing. Edit every draft with human judgement.

### Disclaimer of warranty (MIT)

This plugin is provided "AS IS", without warranty of any kind, express or implied, including but not limited to the warranties of merchantability, fitness for a particular purpose, and noninfringement. In no event shall the authors or copyright holders be liable for any claim, damages, or other liability, whether in an action of contract, tort, or otherwise, arising from, out of, or in connection with the plugin or the use or other dealings in the plugin.

Full text in [LICENSE](../LICENSE) at the marketplace root.

### Costs and third-party services

You are responsible for any costs your usage incurs.

- **Anthropic (Claude API)** — every skill invocation uses Claude tokens. Anthropic Pro / Max subscriptions cover most personal use; pay-per-use API access bills your account.
- **Perplexity API** — the researcher agent calls Perplexity's search API. Free tier is 1,000 requests/month; usage beyond that bills your Perplexity account. Subject to [Perplexity's privacy policy](https://www.perplexity.ai/hub/legal/privacy-policy) and [terms](https://www.perplexity.ai/hub/legal/terms-of-service).
- **Firecrawl API** — the researcher agent calls Firecrawl to extract page content from URLs. Free tier is 500 pages/month; usage beyond that bills your Firecrawl account. Subject to [Firecrawl's privacy policy](https://www.firecrawl.dev/privacy) and [terms](https://www.firecrawl.dev/terms-of-service).

When you install the plugin, your search queries flow through Perplexity and the URLs you scrape flow through Firecrawl. Review their respective policies before installing.

### File system writes

The plugin's skills create files in `drafts/` and `distribution/` inside whatever project you run them in. Run the plugin in a folder you are comfortable having modified. Don't run it inside system folders, sensitive repos, or production deployments without understanding what it will write.

### Privacy and terms — GenAI Unplugged

The plugin itself does not collect or transmit any data to GenAI Unplugged. For the broader GenAI Unplugged service, see:

- [Privacy Policy](https://www.genaiunplugged.com/legal/privacy-policy)
- [Terms of Service](https://www.genaiunplugged.com/legal/terms-of-service)

### Reporting issues and security concerns

Bug reports and PRs welcome at [the repo issues page](https://github.com/genaiunplugged14/claude-plugins/issues). For security disclosures, email support@genaiunplugged.com.

## License

MIT. See [LICENSE](../LICENSE) at the marketplace root.

## Related

- [Claude Code Masterclass — Lesson 6](https://www.genaiunplugged.com/courses/claude-code/) — the article that walks through this plugin from scratch
- [Agents Toolkit](https://store.genaiunplugged.com/) — the production-grade version with research, SEO, and quality agents tested across 100+ articles
