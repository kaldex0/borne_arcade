$ErrorActionPreference = 'Stop'

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = (Resolve-Path (Join-Path $scriptDir '..')).Path
$hookDir = Join-Path $repoRoot '.git\hooks'

if (!(Test-Path $hookDir)) {
    Write-Error "Ce dossier n'est pas un dépôt git: $repoRoot"
}

$hookPath = Join-Path $hookDir 'post-merge'
$hookContent = @'
#!/bin/bash
set -euo pipefail
REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
"$REPO_ROOT/scripts/update_from_git.sh"
'@

Set-Content -Path $hookPath -Value $hookContent -Encoding UTF8
Write-Host "Hook post-merge installé: $hookPath"
