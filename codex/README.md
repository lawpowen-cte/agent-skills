# Codex Skills

本目录收录可供 Codex 安装的 Skills。

## 从 GitHub 安装

仓库发布后，可在 Codex 中让 `$skill-installer` 安装某个 Skill 的 GitHub 目录，例如：

```text
$skill-installer install https://github.com/lawpowen/agent-skills/tree/main/codex/skills/sol-deepseek-delegation
```

安装后如未立即出现，请重新启动 Codex。

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
