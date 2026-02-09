$ErrorActionPreference = 'Stop'

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = (Resolve-Path (Join-Path $scriptDir '..')).Path

Set-Location $repoRoot

# Met à jour depuis le dépôt distant si possible
try {
    git rev-parse --is-inside-work-tree | Out-Null
    if (git remote -v) {
        git pull --rebase
    }
} catch {
    # ignore
}

# Compilation
& "$repoRoot\compilation.sh"

# Redémarrage du service si présent (Linux uniquement)
try {
    systemctl is-enabled borne-arcade.service | Out-Null
    systemctl restart borne-arcade.service
} catch {
    # ignore on Windows
}

Write-Host "Mise à jour terminée."
