<#
Simple PowerShell helper to download assets from Figma using a personal access token.

Usage:
  $env:FIGMA_API_TOKEN = 'your_token_here'
  ./download_figma_assets.ps1 -fileKey '<FIGMA_FILE_KEY>' -nodeIds '15-1429,15-1430' -outDir '.\mobile\flutter\assets'

This script is a convenience scaffold — it demonstrates how to call the Figma REST API and
save image/png exports to the project's `mobile/flutter/assets` directory. It does not
handle every edge case; keep secrets like `FIGMA_API_TOKEN` out of version control.
#>

param(
  [Parameter(Mandatory=$true)][string]$fileKey,
  [Parameter(Mandatory=$true)][string]$nodeIds,
  [string]$outDir = "mobile/flutter/assets"
)

if (-not $env:FIGMA_API_TOKEN) {
  Write-Error "FIGMA_API_TOKEN environment variable not set. Export your Figma token and retry."
  exit 2
}

if (-not (Test-Path $outDir)) { New-Item -ItemType Directory -Path $outDir -Force | Out-Null }

$headers = @{ 'X-Figma-Token' = $env:FIGMA_API_TOKEN }

# Export images as PNG for the given node IDs
## Basic validation for common placeholder mistakes
if (-not $fileKey -or $fileKey.Trim() -eq '') {
  Write-Error "fileKey is empty. Provide the Figma file key (no angle brackets)."
  exit 2
}
if ($fileKey -match '^<.+>$') {
  Write-Error "fileKey appears to be a placeholder (contains angle brackets). Remove '<' and '>' and retry."
  exit 2
}
if (-not $nodeIds -or $nodeIds.Trim() -eq '') {
  Write-Error "nodeIds is empty. Provide a comma-separated list of node ids (e.g. 15-217,15-440)."
  exit 2
}

# URL-encode nodeIds to be safe
$encodedNodeIds = [System.Uri]::EscapeDataString($nodeIds)
$exportUrl = "https://api.figma.com/v1/images/$($fileKey.Trim())?ids=$encodedNodeIds&format=png"
Write-Host "Requesting exports: $exportUrl"

$response = Invoke-RestMethod -Uri $exportUrl -Headers $headers -Method Get -ErrorAction Stop

# Use PowerShell 5.1-compatible operators (-or instead of ||)
if (-not $response -or -not $response.images) {
  Write-Error "No images returned. Response: $($response | ConvertTo-Json -Depth 3)"
  exit 3
}

foreach ($kv in $response.images.GetEnumerator()) {
  $nodeId = $kv.Key
  $url = $kv.Value
  if (-not $url) { continue }
  $outPath = Join-Path $outDir "$($nodeId.Replace('/','_')).png"
  Write-Host "Downloading $nodeId -> $outPath"
  Invoke-RestMethod -Uri $url -OutFile $outPath -ErrorAction Stop
}

Write-Host "Downloaded assets to: $outDir"
