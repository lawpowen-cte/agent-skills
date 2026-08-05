[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$configPath = Join-Path $env:USERPROFILE '.codex\config.toml'
$processKey = [Environment]::GetEnvironmentVariable('DEEPSEEK_API_KEY', 'Process')
$userKey = [Environment]::GetEnvironmentVariable('DEEPSEEK_API_KEY', 'User')
$processTemp = [Environment]::GetEnvironmentVariable('TEMP', 'Process')
$processTmp = [Environment]::GetEnvironmentVariable('TMP', 'Process')
$userTemp = [Environment]::GetEnvironmentVariable('TEMP', 'User')
$userTmp = [Environment]::GetEnvironmentVariable('TMP', 'User')

$configText = if (Test-Path -LiteralPath $configPath) {
    Get-Content -Raw -Encoding UTF8 -LiteralPath $configPath
} else {
    ''
}

$providerPresent = $configText -match '(?m)^\[model_providers\.deepseek\]\s*$'
$envKeyConfigured = $configText -match '(?m)^env_key\s*=\s*["'']DEEPSEEK_API_KEY["'']\s*$'
$apiKeyPresent = -not [string]::IsNullOrWhiteSpace($processKey) -or
    -not [string]::IsNullOrWhiteSpace($userKey)

$effectiveTemp = if (-not [string]::IsNullOrWhiteSpace($processTemp)) {
    $processTemp
} else {
    $userTemp
}

$tempIsSystem = -not [string]::IsNullOrWhiteSpace($effectiveTemp) -and
    $effectiveTemp.TrimEnd('\') -ieq (Join-Path $env:SystemRoot 'Temp').TrimEnd('\')
$tempWritable = $false
$tempProbeError = $null

if (-not [string]::IsNullOrWhiteSpace($effectiveTemp) -and (Test-Path -LiteralPath $effectiveTemp)) {
    $probe = Join-Path $effectiveTemp ('.codex-deepseek-probe-' + [Guid]::NewGuid().ToString('N') + '.tmp')
    try {
        [IO.File]::WriteAllText($probe, 'probe', [Text.Encoding]::ASCII)
        $tempWritable = Test-Path -LiteralPath $probe
    } catch {
        $tempProbeError = $_.Exception.Message
    } finally {
        if (Test-Path -LiteralPath $probe) {
            Remove-Item -LiteralPath $probe -Force
        }
    }
}

$checks = @(
    [pscustomobject]@{ Check = 'DeepSeek provider block'; Passed = $providerPresent; Detail = $configPath }
    [pscustomobject]@{ Check = 'Provider env_key'; Passed = $envKeyConfigured; Detail = 'DEEPSEEK_API_KEY' }
    [pscustomobject]@{ Check = 'API key present'; Passed = $apiKeyPresent; Detail = 'value hidden' }
    [pscustomobject]@{ Check = 'TEMP is per-user'; Passed = -not $tempIsSystem; Detail = $effectiveTemp }
    [pscustomobject]@{ Check = 'TEMP writable'; Passed = $tempWritable; Detail = if ($tempProbeError) { $tempProbeError } else { $effectiveTemp } }
    [pscustomobject]@{ Check = 'User TEMP/TMP agree'; Passed = $userTemp -eq $userTmp; Detail = "TEMP=$userTemp; TMP=$userTmp" }
)

$checks | Format-Table -AutoSize
if ($checks.Passed -contains $false) {
    Write-Error 'DeepSeek setup has one or more failed checks. Read references/windows-setup.md.'
    exit 1
}

Write-Host 'DeepSeek setup checks passed. Restart Codex after any environment change.'
