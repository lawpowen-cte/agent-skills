# Agent Skills

可复用的 AI Agent 技能合集。仓库先按 Agent 平台分类，再在各平台目录中维护可独立安装的 Skill。

Reusable AI agent skills, grouped by agent platform. Each skill is kept as an independently installable package.

## 目录结构

```text
agent-skills/
├── codex/
│   └── skills/
│       └── sol-deepseek-delegation/
├── claude/       # 需要时再添加
└── gemini/       # 需要时再添加
```

## 当前内容

### Codex

- [`sol-deepseek-delegation`](codex/skills/sol-deepseek-delegation/): 由 GPT Sol 主 Agent 负责规划和验收，DeepSeek 高推理子 Agent 负责执行软件任务；包含 Windows 配置检查和任务文件回退流程。

安装和使用方法见 [`codex/README.md`](codex/README.md)。

## 仓库约定

- 顶层目录表示目标 Agent 平台。
- 每个平台的 `skills/` 下，每个一级子目录都是一个可独立安装的 Skill。
- Skill 自身的运行说明、脚本和参考资料保存在其目录内。
- 密钥、令牌、本机配置文件和诊断输出不得提交。
- 跨平台 Skill 可以分别提供平台适配版本，避免用符号链接制造安装兼容问题。

## License

本仓库采用 [MIT License](LICENSE)。各 Skill 如需不同许可证，会在其目录内单独说明。
