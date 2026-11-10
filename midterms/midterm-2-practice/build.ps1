param(
    [string]$Part = '*',
    [ValidateSet('All','Practice','Mock')][string]$Document = 'All'
)
# Compile existing sources only. Never generates/replaces your answers.
$ErrorActionPreference = 'Stop'
$root = $PSScriptRoot
$portable = Join-Path $root '.tools\tectonic.exe'
if (Test-Path -LiteralPath $portable) {
    $env:TECTONIC_CACHE_DIR = Join-Path $root '.tools\cache'
    $fontConfig = Join-Path $root '.tools\fonts.conf'
    if (Test-Path -LiteralPath $fontConfig) { $env:FONTCONFIG_FILE = $fontConfig }
}
$folders = @(Get-ChildItem -LiteralPath (Join-Path $root 'practice') -Directory |
    Where-Object { $_.Name -like "$Part*" })
if ($folders.Count -eq 0) { throw "No practice folder matches '$Part'." }
$count = 0
foreach ($folder in $folders) {
    $sources = @(Get-ChildItem -LiteralPath $folder.FullName -Filter '*.tex' |
        Where-Object { $Document -eq 'All' -or $_.BaseName -eq $Document })
    foreach ($source in $sources) {
        Push-Location -LiteralPath $folder.FullName
        try {
            if (Test-Path -LiteralPath $portable) {
                & $portable --only-cached --untrusted $source.Name
                if ($LASTEXITCODE -ne 0) { throw "Compile failed: $($source.FullName)" }
            } elseif (Get-Command tectonic -ErrorAction SilentlyContinue) {
                & tectonic --untrusted $source.Name
                if ($LASTEXITCODE -ne 0) { throw "Compile failed: $($source.FullName)" }
            } elseif (Get-Command pdflatex -ErrorAction SilentlyContinue) {
                foreach ($pass in 1..2) {
                    & pdflatex -interaction=nonstopmode -halt-on-error $source.Name
                    if ($LASTEXITCODE -ne 0) { throw "Compile failed: $($source.FullName)" }
                }
            } else { throw 'No LaTeX compiler found.' }
            $count++
        } finally { Pop-Location }
    }
}
Write-Output "Built $count worksheet PDF(s). Coding parts use .hs files directly."
