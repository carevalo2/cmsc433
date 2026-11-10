# Rebuild only: this script never rewrites your .tex answers.
$ErrorActionPreference = 'Stop'
Push-Location -LiteralPath $PSScriptRoot
try {
    $portableCompiler = Join-Path $PSScriptRoot '.tools\tectonic.exe'
    $env:TECTONIC_CACHE_DIR = Join-Path $PSScriptRoot '.tools\cache'
    $fontConfig = Join-Path $PSScriptRoot '.tools\fonts.conf'
    if (Test-Path -LiteralPath $fontConfig) { $env:FONTCONFIG_FILE = $fontConfig }
    if (Test-Path -LiteralPath $portableCompiler) {
        & $portableCompiler --only-cached --untrusted --keep-logs --synctex study-guide.tex
        if ($LASTEXITCODE -ne 0) { throw 'LaTeX compilation failed; see study-guide.log.' }
    } elseif (Get-Command tectonic -ErrorAction SilentlyContinue) {
        & tectonic --untrusted --keep-logs --synctex study-guide.tex
        if ($LASTEXITCODE -ne 0) { throw 'LaTeX compilation failed; see study-guide.log.' }
    } elseif (Get-Command pdflatex -ErrorAction SilentlyContinue) {
        1..2 | ForEach-Object {
            & pdflatex -interaction=nonstopmode -halt-on-error study-guide.tex
            if ($LASTEXITCODE -ne 0) { throw 'LaTeX compilation failed; see study-guide.log.' }
        }
    } else {
        throw 'No LaTeX compiler found. The existing study-guide.pdf can still be opened.'
    }
    Write-Output "PDF ready: $(Join-Path $PSScriptRoot 'study-guide.pdf')"
} finally {
    Pop-Location
}
