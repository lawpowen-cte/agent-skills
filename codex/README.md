# Codex Skills

本目录收录可供 Codex 安装的 Skills。

## 从 GitHub 安装

仓库发布后，可在 Codex 中让 `$skill-installer` 安装某个 Skill 的 GitHub 目录，例如：

```text
$skill-installer install https://github.com/lawpowen/agent-skills/tree/main/codex/skills/sol-deepseek-delegation
```

安装完成后，技能会在下一轮对话可用；若列表仍未刷新，再重启 Codex。

## 手动安装

把目标 Skill 的完整目录复制到：

```text
%CODEX_HOME%\skills\<skill-name>
```

若未设置 `CODEX_HOME`，Windows 默认位置通常为：

```text
%USERPROFILE%\.codex\skills\<skill-name>
```

不要只复制 `SKILL.md`；`agents/`、`references/` 和 `scripts/` 也属于 Skill 包。

## 已收录 Skills

- [`sol-deepseek-delegation`](skills/sol-deepseek-delegation/)

## UI 规范与配套安装包

完整清单、另一台电脑可直接复制的安装指令、Python 依赖和验证方法见 [UI 安装包](bundles/ui-design.md)。

- [`ui-design-standards`](skills/ui-design-standards/)
- [`ui-ux-pro-max`](skills/ui-ux-pro-max/)
- [`ui-feedback-patterns`](skills/ui-feedback-patterns/)
- [`ui-chat-desktop-interactions`](skills/ui-chat-desktop-interactions/)
- [`frontend-design`](skills/frontend-design/)

许可证与来源见 [第三方说明](THIRD-PARTY-NOTICES.md)。
