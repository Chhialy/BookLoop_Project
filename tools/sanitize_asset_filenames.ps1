# Rename files in mobile/flutter/assets to safe filenames (replace invalid characters with '_')
# Usage: Run from repo root in PowerShell:
#   powershell -ExecutionPolicy Bypass -File .\tools\sanitize_asset_filenames.ps1

 $assetDir = Join-Path (Get-Location) 'mobile\\flutter\\assets'
if (-not (Test-Path $assetDir)) {
  Write-Host "Assets directory not found: $assetDir" -ForegroundColor Yellow
  exit 0
}

function Convert-ToSnakeCaseFilename([string]$name) {
  if (-not $name) { return $name }
  # Separate base name and extension
  $base = [System.IO.Path]::GetFileNameWithoutExtension($name)
  $ext = [System.IO.Path]::GetExtension($name)

  # Replace invalid filename chars with underscores
  $inv = [System.IO.Path]::GetInvalidFileNameChars() + @(':')
  foreach ($c in $inv) {
    $esc = [regex]::Escape($c)
    $base = $base -replace $esc, '_'
  }

  # Replace whitespace and punctuation with underscore
  $base = $base -replace '[\s\p{P}]', '_'

  # Collapse multiple underscores
  $base = $base -replace '_{2,}', '_'

  # Trim leading/trailing underscores
  $base = $base.Trim('_')

  # Lowercase
  $base = $base.ToLowerInvariant()

  # If empty after cleanup, fallback to a safe name
  if ([string]::IsNullOrWhiteSpace($base)) { $base = 'asset' }

  return "$base$ext"
}

Get-ChildItem -Path $assetDir -File -Recurse | ForEach-Object {
  $orig = $_.FullName
  $dir = $_.DirectoryName
  $newName = Convert-ToSnakeCaseFilename $_.Name
  if ($newName -ne $_.Name) {
    $target = Join-Path $dir $newName
    $i = 1
    # If target exists, append a numeric suffix to avoid collision
    while (Test-Path $target) {
      $base = [System.IO.Path]::GetFileNameWithoutExtension($newName)
      $ext = [System.IO.Path]::GetExtension($newName)
      $target = Join-Path $dir ("{0}_{1}{2}" -f $base, $i, $ext)
      $i++
    }
    Write-Host "Renaming '$orig' -> '$target'"
    Rename-Item -Path $orig -NewName ([System.IO.Path]::GetFileName($target))
  }
}

Write-Host "Sanitization complete." -ForegroundColor Green
