# Agent Skills

可复用的 AI Agent 技能合集。仓库先按 Agent 平台分类，再在各平台目录中维护可独立安装的 Skill。

Reusable AI agent skills, grouped by agent platform. Each skill is kept as an independently installable package.

## 目录结构

```text
agent-skills/
├── codex/
│   └── skills/
│       ├── sol-deepseek-delegation/
│       ├── ui-design-standards/
│       ├── ui-ux-pro-max/
│       ├── ui-feedback-patterns/
│       ├── ui-chat-desktop-interactions/
│       └── frontend-design/
├── claude/       # 需要时再添加
└── gemini/       # 需要时再添加
```

## 当前内容

### Codex

- [`sol-deepseek-delegation`](codex/skills/sol-deepseek-delegation/): 由 GPT Sol 主 Agent 负责规划和验收，DeepSeek 高推理子 Agent 负责执行软件任务；包含 Windows 配置检查和任务文件回退流程。

- [UI 规范与配套 Skills 安装包](codex/bundles/ui-design.md)：在另一台 Codex 安装完整的 UI 导航、组件选型、视觉参考、聊天桌面交互与设计检索能力。

安装和使用方法见 [`codex/README.md`](codex/README.md)。

## 仓库约定

- 顶层目录表示目标 Agent 平台。
- 每个平台的 `skills/` 下，每个一级子目录都是一个可独立安装的 Skill。
- Skill 自身的运行说明、脚本和参考资料保存在其目录内。
- 密钥、令牌、本机配置文件和诊断输出不得提交。
- 跨平台 Skill 可以分别提供平台适配版本，避免用符号链接制造安装兼容问题。

## License

本仓库采用 [MIT License](LICENSE)。第三方目录保留其原有许可证；详见 [第三方说明](codex/THIRD-PARTY-NOTICES.md)。
