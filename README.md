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

## License

MIT — see [LICENSE](LICENSE).

## About

Built and maintained by [Dheeraj Sharma](https://genaiunplugged.com). Documentation, full course, and the production-grade Agents Toolkit at [genaiunplugged.com](https://genaiunplugged.com).
