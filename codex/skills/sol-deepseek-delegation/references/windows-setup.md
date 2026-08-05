# Windows DeepSeek setup and recovery

## 1. Configure the provider

Patch, do not replace, `%USERPROFILE%\.codex\config.toml`:

```toml
[model_providers.deepseek]
name = "DeepSeek"
base_url = "https://api.deepseek.com/"
wire_api = "responses"
env_key = "DEEPSEEK_API_KEY"
env_key_instructions = "Set DEEPSEEK_API_KEY in the user environment, then restart Codex."
```

If `collaboration.spawn_agent` already exposes the DeepSeek role and it works, keep the existing provider block unchanged.

## 2. Store the API key safely

Run interactively in PowerShell. Do not paste the key into a repository, task file, command log, or chat transcript.

```powershell
$secureKey = Read-Host "DeepSeek API key" -AsSecureString
$pointer = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($secureKey)
try {
    $plainKey = [Runtime.InteropServices.Marshal]::PtrToStringBSTR($pointer)
    [Environment]::SetEnvironmentVariable("DEEPSEEK_API_KEY", $plainKey, "User")
} finally {
    if ($pointer -ne [IntPtr]::Zero) {
        [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($pointer)
    }
    $plainKey = $null
    $secureKey.Dispose()
}
```

Restart Codex completely so the desktop process inherits the new user variable. Never verify by echoing its value; check only presence.

## 3. Fix Windows sandbox TEMP/TMP failures

DeepSeek subagents may fail when the Codex process inherits `C:\Windows\Temp`. Configure a writable per-user directory:

```powershell
$codexTemp = Join-Path $env:LOCALAPPDATA "Temp"
New-Item -ItemType Directory -Path $codexTemp -Force | Out-Null
[Environment]::SetEnvironmentVariable("TEMP", $codexTemp, "User")
[Environment]::SetEnvironmentVariable("TMP", $codexTemp, "User")
```

Restart Codex and run the diagnostic script. Do not repurpose `$HOME`, `$home`, or `$CODEX_HOME`.

## 4. Verify without exposing secrets

From the skill directory:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\check-deepseek-setup.ps1
```

Expected checks:

- Provider block exists and references `DEEPSEEK_API_KEY`.
- Process or user API-key variable is present.
- Process and user TEMP/TMP do not point at `C:\Windows\Temp`.
- The effective temp directory exists and accepts a create/delete probe.

## 5. Preserve quotes in the native patch fallback

Prefer the `apply_patch` tool. If DeepSeek receives only shell access, locate the Codex executable from `$env:CODEX_CLI_PATH` or the desktop installation, then escape embedded double quotes before passing a patch through Windows native argument parsing:

```powershell
$escapedPatch = $patch.Replace('"', '\"')
& $codexCli --codex-run-as-apply-patch $escapedPatch
```

Without this replacement, Kotlin/Java string quotes can disappear and the patch may fail or corrupt code. Test the mechanism only on a disposable file outside production source, then remove the probe.

## 6. Common recovery decisions

- `401` or authentication failure: confirm key presence, account/API access, provider URL, then restart.
- Sandbox ACL or temp initialization failure: fix user TEMP/TMP and restart.
- Agent is running but cannot read its task: use the task-file fallback.
- Non-ASCII arguments become mojibake: require ASCII-only tool arguments and Unicode escapes.
- Patch repeatedly fails: use smaller file-ordered hunks; never delete-and-readd a production file.
- Agent stalls after a failed tool call: interrupt it and spawn a fresh bounded task.
