param(
    [string]$ResultsDirectory = "TestResults",
    [double]$MinimumCoverage = 70
)

$coverageReport = Get-ChildItem `
    -Path $ResultsDirectory `
    -Recurse `
    -Filter "coverage.cobertura.xml" |
    Sort-Object LastWriteTime -Descending |
    Select-Object -First 1

if (-not $coverageReport) {
    Write-Error "Nenhum arquivo coverage.cobertura.xml foi encontrado."
    exit 1
}

[xml]$coverageXml = Get-Content $coverageReport.FullName -Raw

$lineRateText = [string]$coverageXml.coverage.'line-rate'

$lineRate = [double]::Parse(
    $lineRateText,
    [System.Globalization.CultureInfo]::InvariantCulture
)

$coveragePercentage = [Math]::Round($lineRate * 100, 2)

Write-Host "Cobertura de linhas: $coveragePercentage%"
Write-Host "Cobertura mínima exigida: $MinimumCoverage%"

if ($coveragePercentage -lt $MinimumCoverage) {
    Write-Error `
        "Cobertura insuficiente: $coveragePercentage%. Mínimo exigido: $MinimumCoverage%."

    exit 1
}

Write-Host "Cobertura aprovada."
exit 0