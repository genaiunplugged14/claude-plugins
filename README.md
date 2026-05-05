# GenAI Unplugged Claude Code plugins

Distributable Claude Code plugins from the [GenAI Unplugged Claude Code Masterclass](https://www.genaiunplugged.com/courses/claude-code/).

## Install

Add this marketplace once. After that, every plugin in this repo is one slash command away.

```
/plugin marketplace add genaiunplugged14/claude-plugins
/plugin install <plugin-name>@genaiunplugged14
```

## Plugins in this marketplace

| Plugin | What it does | Status |
|---|---|---|
| **content-ops** | Research → draft → review → repurpose pipeline. 4 agents, 5 namespaced skills, 3 hooks. | ✅ Live |
| _(more coming)_ | research-team, seo-pack, distribution | 🚧 In progress |

## Repository structure

```
claude-plugins/
├── .claude-plugin/
│   └── marketplace.json     # marketplace manifest (lists every plugin in the repo)
├── content-ops/             # the content pipeline plugin
│   ├── .claude-plugin/plugin.json
│   ├── agents/  skills/  hooks/  templates/
│   ├── .mcp.json
│   └── README.md
└── README.md                # this file
```

## Important

Plugins in this marketplace are shipped FOR EDUCATIONAL AND PERSONAL USE under the MIT License. They are teaching companions to the [Claude Code Masterclass](https://www.genaiunplugged.com/courses/claude-code/). They are NOT security products, NOT production safety systems, and NOT a substitute for human review of AI output.

The `block-dangerous.sh` hook in `content-ops` blocks a small set of obvious destructive patterns as a teaching example. Do NOT rely on it as a comprehensive security control.

You are responsible for any costs your usage incurs (Anthropic, Perplexity, Firecrawl, etc.) and for verifying every AI-generated output before publishing.

See each plugin's own README for full disclaimers, third-party service flow, and usage notes.

## License

MIT — see [LICENSE](LICENSE).

Provided "AS IS", without warranty of any kind. The authors are not liable for any claim, damages, or other liability arising from use of these plugins. See LICENSE for the full clause.

## Privacy and terms (GenAI Unplugged)

The plugins themselves do not collect or transmit data to GenAI Unplugged. For the broader GenAI Unplugged service:

- [Privacy Policy](https://www.genaiunplugged.com/legal/privacy-policy)
- [Terms of Service](https://www.genaiunplugged.com/legal/terms-of-service)

## About

Built and maintained by [Dheeraj Sharma](https://genaiunplugged.com). Documentation, full course, and the production-grade Agents Toolkit at [genaiunplugged.com](https://genaiunplugged.com).

For security disclosures, email support@genaiunplugged.com.
