$ErrorActionPreference = 'Stop'

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = (Resolve-Path (Join-Path $scriptDir '..')).Path
$srcDir = Join-Path $repoRoot 'Documents\Documentation\src'
$outDir = Join-Path $repoRoot 'Documents\Documentation\generated'

New-Item -ItemType Directory -Force -Path $outDir | Out-Null

$generatedAt = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'

function Build-GameList {
    $lines = @()
    $lines += "| Jeu | Script | description.txt | bouton.txt | photo_small.png |"
    $lines += "| --- | --- | --- | --- | --- |"

    $projetDir = Join-Path $repoRoot 'projet'
    if (Test-Path $projetDir) {
        Get-ChildItem -Path $projetDir -Directory | ForEach-Object {
            $name = $_.Name
            $script = Join-Path $repoRoot "$name.sh"
            $desc = Join-Path $_.FullName 'description.txt'
            $bouton = Join-Path $_.FullName 'bouton.txt'
            $photo = Join-Path $_.FullName 'photo_small.png'

            $sOk = if (Test-Path $script) { 'OK' } else { 'MANQUANT' }
            $dOk = if (Test-Path $desc) { 'OK' } else { 'MANQUANT' }
            $bOk = if (Test-Path $bouton) { 'OK' } else { 'MANQUANT' }
            $pOk = if (Test-Path $photo) { 'OK' } else { 'MANQUANT' }

            $lines += "| $name | $sOk | $dOk | $bOk | $pOk |"
        }
    }

    return $lines -join "`n"
}

$gameList = Build-GameList

Get-ChildItem -Path $srcDir -Filter '*.md' | ForEach-Object {
    $srcPath = $_.FullName
    $outPath = Join-Path $outDir $_.Name

    $lines = Get-Content -Path $srcPath
    $outLines = New-Object System.Collections.Generic.List[string]

    foreach ($line in $lines) {
        $updated = $line -replace '\{\{GENERATED_AT\}\}', $generatedAt
        if ($updated -eq '{{GAME_LIST}}') {
            $outLines.AddRange(($gameList -split "`n"))
        } else {
            $outLines.Add($updated)
        }
    }

    Set-Content -Path $outPath -Value $outLines -Encoding UTF8
    Write-Host "Généré: $outPath"
}

$docMin = Join-Path $repoRoot 'Documents\Documentation\doc_minimale.md'
if (Test-Path $docMin) {
    Copy-Item -Force $docMin (Join-Path $outDir 'doc_minimale.md')
}

Write-Host "Documentation générée dans $outDir"