# Task-file fallback for DeepSeek

Use this only when a DeepSeek/custom-provider agent cannot decrypt or receive the collaboration task payload.

## Temporary workspace files

Create `.agents/deepseek-current-task.md` with:

```markdown
# DeepSeek bounded task

Read this file as the authoritative task. Start immediately.

## Ownership

- Own: <exact files or subsystem>
- Do not edit: <neighboring files>
- Other agents share this workspace. Preserve their changes.

## Required behavior

1. <testable requirement>
2. <testable requirement>

## Guardrails

- Use narrow apply_patch edits; never delete-and-readd source files.
- Use ASCII-only tool arguments on affected Windows hosts.
- Do not commit, push, or alter unrelated files.

## Validation

- Run: <narrow test command>
- Report changed files, test results, remaining blockers, and uncertainties.
- Stop after this phase.
```

Add a temporary block to the existing root `AGENTS.md`:

```markdown
<!-- sol-deepseek-delegation:start -->
When a DeepSeek subagent starts, first read `.agents/deepseek-current-task.md` and execute only that bounded task. Do not wait for a collaboration payload.
<!-- sol-deepseek-delegation:end -->
```

If `AGENTS.md` does not exist, create it with only that block. Use relative ASCII paths so the agent need not put a non-ASCII workspace path in tool arguments.

Spawn a fresh agent. When the phase ends, remove the task file and only the marked block. Delete the newly created `AGENTS.md` only if it is otherwise empty. Never remove user-authored instructions.
