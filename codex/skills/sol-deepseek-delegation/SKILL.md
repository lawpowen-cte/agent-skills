---
name: sol-deepseek-delegation
description: Orchestrate software work with a GPT Sol main agent and DeepSeek high-reasoning subagents. Use when the user asks Sol/Codex to delegate implementation, debugging, refactoring, tests, or reviews to DeepSeek while the main agent retains planning, safety, code review, integration, and final validation. Also use to configure or troubleshoot the DeepSeek provider, API key, Windows TEMP/TMP, encrypted delegation payloads, Unicode patching, or stalled DeepSeek agents.
---

# Sol + DeepSeek Delegation

Use Sol as the accountable lead. Delegate bounded production work to DeepSeek; never delegate final acceptance.

## Start with environment readiness

1. Check whether `collaboration.spawn_agent` exposes `agent_type: "deepseek"`.
2. On Windows, run `scripts/check-deepseek-setup.ps1` before the first delegation or after provider failures.
3. If any check fails, read [references/windows-setup.md](references/windows-setup.md), repair only the failed item, restart Codex when environment variables changed, and rerun the diagnostic.
4. Never print, log, store in the repository, or pass the DeepSeek API key to a subagent.

## Plan ownership before spawning

Keep these responsibilities with Sol:

- Confirm scope and acceptance criteria.
- Inspect repository instructions and user changes.
- Split work into independently verifiable phases with explicit file ownership.
- Decide safety-sensitive operations and external writes.
- Review every diff, integrate phases, run final tests/build, and report limitations.

Give DeepSeek concrete implementation or investigation work. Prefer one subsystem or 1–3 related files per phase. State that other agents may be editing the repository and that it must preserve their work.

Do not spawn parallel workers on overlapping files. Avoid a single full-application task when models, services, UI, and integration can be phased.

## Deliver the task reliably

Use `fork_turns: "none"`, `agent_type: "deepseek"`, and the highest supported DeepSeek reasoning setting requested by the user. Put all necessary context in a concise task message.

If the DeepSeek provider cannot read collaboration payloads:

1. Read [references/task-file-fallback.md](references/task-file-fallback.md).
2. Write an authoritative, bounded task file under the workspace `.agents/` directory.
3. Add a temporary, clearly delimited instruction to the repository `AGENTS.md` telling the new agent which task file to read.
4. Spawn a fresh DeepSeek agent with a short ASCII message that points to `AGENTS.md`.
5. Remove only the temporary block and task file after completion. Preserve any pre-existing `AGENTS.md` content.

## Apply Windows guardrails

For DeepSeek tool calls on a host that corrupts non-ASCII arguments:

- Use relative ASCII paths and ASCII-only shell arguments.
- Read UTF-8 source with explicit UTF-8 encoding.
- Use narrow ASCII patch anchors.
- Encode new non-ASCII Kotlin/Java strings as `\uXXXX` when necessary.
- Prefer the native `apply_patch` tool. If it is unavailable, use the verified escaped-patch fallback in [references/windows-setup.md](references/windows-setup.md).
- Never delete a source file as an intermediate replacement step.
- Never use shell redirection, Python, Node, `Set-Content`, or `WriteAllText` to bypass patch failures.
- Split failed patches into smaller, file-ordered hunks.

## Supervise execution

Send concise user progress updates at least once per minute during long work.

Treat these as intervention signals:

- No relevant file modification after repeated long reasoning cycles.
- Repeated patch-format experiments.
- Reading large files outside assigned ownership.
- A source file is deleted before its replacement exists.
- The same tool failure repeats.

On intervention, inspect the shared workspace first. Restore any damaged file immediately, interrupt the agent, tighten the task, and spawn a fresh bounded DeepSeek agent. Do not keep extending a polluted or context-exhausted turn.

## Review and integrate

For every phase, Sol must:

1. Read the changed files and diff; do not rely on the agent summary.
2. Check requirements, backward compatibility, persistence, boundary cases, and unrelated regressions.
3. Run the narrowest relevant tests.
4. Fix or return concrete defects before starting the next phase.
5. Run the repository's complete test/build command after integration.
6. Verify deliverables such as APKs or binaries with size and SHA-256 when relevant.

Report which work DeepSeek performed, which corrections Sol made during review, test counts, artifact paths, and known unverified behavior.

## Recommended phase pattern

For a cross-layer feature, prefer:

1. Pure models and state-machine tests.
2. Persistence/history codecs and compatibility tests.
3. Service or backend integration.
4. UI and independent settings/persistence.
5. Sol integration review, full tests/build, documentation, and artifact delivery.

Adjust the phases to the codebase; explicit ownership matters more than this exact ordering.
