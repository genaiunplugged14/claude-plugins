# content-team

A three-agent content team for Claude Code: a researcher, a writer and a reviewer, each with its own command, plus one guard that blocks brochure phrases in drafts.

Built live in Lesson 7 of the GenAI Unplugged Claude Code Full Course.

## Install

```
/plugin marketplace add genaiunplugged14/claude-plugins
/plugin install content-team@genaiunplugged14
```

Then, once per project:

```
/content-team:setup
```

That copies the starter context files into your project. Edit `context-profiles/` and `brand-voice.md` so the team writes for your business. They ship filled in for a Himalayan travel blog so you can see a complete example.

## Use

```
/content-team:research Spiti winter road trip 2026 via Shimla
/content-team:draft Spiti winter road trip 2026 via Shimla
/content-team:review Spiti winter road trip 2026 via Shimla
```

| Command | Agent | Writes |
|---|---|---|
| `/content-team:research` | researcher | `research-briefs/{slug}-brief.md` |
| `/content-team:draft` | writer | `drafts/{slug}-draft.md` |
| `/content-team:review` | reviewer (read-only) | `drafts/{slug}-review.md` |

Use the same topic in all three. The slug is built from the topic, so the three commands find each other's files.

## What is inside

```
content-team/
  .claude-plugin/plugin.json    the manifest
  agents/                       researcher, writer, reviewer
  skills/                       research, draft, review, setup
  hooks/                        hooks.json and voice-guard.sh
  templates/                    starter context files that setup copies
```

## The guard

`voice-guard.sh` runs after every Write or Edit. If a file matching `drafts/*-draft.md` contains a brochure phrase (nestled, breathtaking, hidden gem and ten more), it blocks the save and sends the offending lines back to the writer. Every check is logged to `voice-guard.log` in your project.

Change the phrase list by editing the `PHRASES` line in `hooks/voice-guard.sh`.

## Before you run it

- **Tavily.** The researcher and the reviewer search with Tavily. No plugin should carry your keys, so connect it yourself, with the server named `tavily`:

  ```
  claude mcp add --transport http tavily "https://mcp.tavily.com/mcp/?tavilyApiKey=YOUR_KEY"
  ```

  Without it the researcher falls back to the built-in web search, and the reviewer cannot verify facts.
- **jq.** The guard reads its input with `jq`. It ships with recent macOS. On Linux, install it with your package manager.

## Important: terms of use, disclaimer, and privacy

This plugin is shipped FOR EDUCATIONAL AND PERSONAL USE under the MIT License. Read this section before installing.

### Educational and at-your-own-risk

The plugin, every agent inside it, and the `voice-guard.sh` hook are provided as a teaching companion to the [Claude Code Masterclass](https://www.genaiunplugged.com/courses/claude-code/). They show how to package an agent team as a Claude Code plugin. They are NOT a security product, NOT a production safety system, and NOT a substitute for human review of AI output.

In particular:

- `voice-guard.sh` is a teaching example of a PostToolUse hook. It checks a short list of phrases in draft files. It is NOT a quality guarantee and MUST NOT be relied on as one.
- The researcher, writer and reviewer agents produce AI-generated content. AI output can be wrong, biased, or fabricated. Verify every factual claim before publishing. Edit every draft with human judgement. The reviewer finds problems, it does not guarantee there are none.
- The starter files describe a travel blog. Route, permit and road-status facts in anything the team writes must be confirmed against an official source before anyone travels on them.

### Disclaimer of warranty (MIT)

This plugin is provided "AS IS", without warranty of any kind, express or implied, including but not limited to the warranties of merchantability, fitness for a particular purpose, and noninfringement. In no event shall the authors or copyright holders be liable for any claim, damages, or other liability, whether in an action of contract, tort, or otherwise, arising from, out of, or in connection with the plugin or the use or other dealings in the plugin.

Full text in [LICENSE](../LICENSE) at the marketplace root.

### Costs and third-party services

You are responsible for any costs your usage incurs.

- **Anthropic (Claude).** Every command uses Claude tokens. A Pro or Max subscription covers most personal use. Pay-per-use API access bills your account.
- **Tavily.** If you connect it, the researcher and reviewer send your search queries to Tavily. Usage beyond the free tier bills your Tavily account. Subject to [Tavily's privacy policy](https://www.tavily.com/privacy) and [terms](https://www.tavily.com/terms).

### File system writes

The commands create files in `research-briefs/` and `drafts/`, the setup command copies starter files into the project root, and the guard writes `voice-guard.log`. Run the plugin in a folder you are comfortable having modified.

### Privacy and terms, GenAI Unplugged

The plugin itself does not collect or transmit any data to GenAI Unplugged. For the broader GenAI Unplugged service, see:

- [Privacy Policy](https://www.genaiunplugged.com/privacy/)
- [Terms of Service](https://www.genaiunplugged.com/terms/)

### Reporting issues and security concerns

Bug reports and PRs welcome at [the repo issues page](https://github.com/genaiunplugged14/claude-plugins/issues). For security disclosures, email support@genaiunplugged.com.

## License

MIT. See [LICENSE](../LICENSE) at the marketplace root.
