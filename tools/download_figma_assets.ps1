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
  [string]$outDir = "mobile/flutter/assets",
  [ValidateSet('png','jpg','svg','pdf')][string]$format = 'png'
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
$exportUrl = "https://api.figma.com/v1/images/$($fileKey.Trim())?ids=$encodedNodeIds&format=$format"
Write-Host "Requesting exports: $exportUrl"

try {
  $response = Invoke-RestMethod -Uri $exportUrl -Headers $headers -Method Get -ErrorAction Stop
} catch {
  $err = $_.Exception
  Write-Error "Failed to call Figma Images API: $($err.Message)"
  if ($err.Response) {
    try {
      $status = $err.Response.StatusCode.value__
      $body = (New-Object System.IO.StreamReader($err.Response.GetResponseStream())).ReadToEnd()
      Write-Error "HTTP status: $status"
      Write-Error "Response body:`n$body"
      if ($status -in 401,403) {
        Write-Error "Authentication failed: your FIGMA_API_TOKEN appears invalid or expired."
        Write-Error "If you intended to use the Figma REST API, generate a Personal Access Token at https://www.figma.com/developers/api and set it in the environment as FIGMA_API_TOKEN."
      }
    } catch {
      Write-Error "Also failed to read response body: $($_.Exception.Message)"
    }
  }
  exit 4
}

# Use PowerShell 5.1-compatible operators (-or instead of ||)
if (-not $response -or -not $response.images) {
  Write-Error "No images returned. Response: $($response | ConvertTo-Json -Depth 3)"
  exit 3
}

# Handle different shapes returned by Invoke-RestMethod (hashtable, PSCustomObject, array)
function Sanitize-FileName([string]$name) {
  if (-not $name) { return $name }
  $inv = [System.IO.Path]::GetInvalidFileNameChars()
  foreach ($c in $inv) {
    $esc = [regex]::Escape($c)
    $name = $name -replace $esc, '_'
  }
  # Also replace colon explicitly (some environments may not list it in invalid chars)
  $name = $name -replace ':', '_'
  return $name
}

try {
    if ($response.images -is [System.Collections.IDictionary]) {
    foreach ($kv in $response.images.GetEnumerator()) {
      $nodeId = $kv.Key
      $url = $kv.Value
      if (-not $url) { continue }
      $safeName = Sanitize-FileName $nodeId
      $outPath = Join-Path $outDir "$safeName.png"
      Write-Host "Downloading $nodeId -> $outPath"
      Invoke-RestMethod -Uri $url -OutFile $outPath -ErrorAction Stop
    }
  } elseif ($response.images -is [System.Management.Automation.PSCustomObject]) {
    foreach ($prop in $response.images.PSObject.Properties) {
      $nodeId = $prop.Name
      $url = $prop.Value
      if (-not $url) { continue }
      $safeName = Sanitize-FileName $nodeId
      $outPath = Join-Path $outDir "$safeName.png"
      Write-Host "Downloading $nodeId -> $outPath"
      Invoke-RestMethod -Uri $url -OutFile $outPath -ErrorAction Stop
    }
  } elseif ($response.images -is [System.Array]) {
    foreach ($item in $response.images) {
      # item may be a hashtable like @{ "nodeId" = "url" }
      if ($item -is [System.Management.Automation.PSCustomObject]) {
        foreach ($prop in $item.PSObject.Properties) {
          $nodeId = $prop.Name
          $url = $prop.Value
          if (-not $url) { continue }
          $safeName = Sanitize-FileName $nodeId
          $outPath = Join-Path $outDir "$safeName.png"
          Write-Host "Downloading $nodeId -> $outPath"
          Invoke-RestMethod -Uri $url -OutFile $outPath -ErrorAction Stop
        }
      }
    }
  } else {
    Write-Error "Unexpected 'images' structure: $($response.images.GetType().FullName)"
    Write-Error "Response: $($response | ConvertTo-Json -Depth 3)"
    exit 5
  }
} catch {
  Write-Error "Error while downloading images: $($_.Exception.Message)"
  exit 6
}

Write-Host "Downloaded assets to: $outDir"
