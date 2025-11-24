# Add FIGMA_API_TOKEN to the repository using GitHub CLI (interactive)
# Usage: Run this from the repository root in PowerShell.
# Requires: `gh` (GitHub CLI) installed and `gh auth login` done.

param(
  [string]$repo = ''
)

Write-Host "\n=== Add FIGMA_API_TOKEN to GitHub Secrets ===" -ForegroundColor Cyan

# Check gh availability
try {
  gh --version | Out-Null
} catch {
  Write-Error "GitHub CLI 'gh' is not available in PATH. Install it: https://cli.github.com/"
  exit 2
}

# Determine repo if not provided
if (-not $repo -or $repo.Trim() -eq '') {
  try {
    $repo = gh repo view --json nameWithOwner --jq .nameWithOwner
  } catch {
    Write-Host "Could not detect repository automatically. Provide repo as parameter or run from a git repo that gh can access." -ForegroundColor Yellow
    $repo = Read-Host -Prompt 'Repository (owner/repo)'
  }
}

if (-not $repo -or $repo.Trim() -eq '') {
  Write-Error "Repository not specified. Aborting."
  exit 3
}

Write-Host "Adding secret to repository: $repo" -ForegroundColor Green

# Prompt for token securely
$secure = Read-Host -Prompt 'Paste your new Figma Personal Access Token (input hidden)' -AsSecureString
$ptr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secure)
$plain = [System.Runtime.InteropServices.Marshal]::PtrToStringBSTR($ptr)
[System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($ptr)

if (-not $plain -or $plain.Trim() -eq '') {
  Write-Error "No token entered. Aborting."
  exit 4
}

# Confirm with masked preview
$preview = if ($plain.Length -gt 8) { $plain.Substring(0,4) + '...' + $plain.Substring($plain.Length-4) } else { '***masked***' }
Write-Host "Token preview: $preview" -ForegroundColor Yellow

# Set secret using gh
try {
  gh secret set FIGMA_API_TOKEN --repo $repo --body "$plain"
  Write-Host "Secret 'FIGMA_API_TOKEN' set on $repo" -ForegroundColor Green
  Write-Host "Note: Secrets are encrypted and cannot be retrieved after save."
} catch {
  Write-Error "Failed to set secret: $($_.Exception.Message)"
  exit 5
}

Write-Host "\nRecommended next steps:" -ForegroundColor Cyan
Write-Host " - Revoke the exposed token in Figma immediately (https://www.figma.com/developers/api)." -ForegroundColor Yellow
Write-Host " - Run the downloader locally to verify the token: .\\tools\\download_figma_assets.ps1 -fileKey '<fileKey>' -nodeIds '<ids>' -outDir 'mobile/flutter/assets' -format 'png'" -ForegroundColor Yellow
Write-Host " - Re-dispatch the workflow or run: gh workflow run download_figma_assets_auto_pr.yml -f fileKey='<fileKey>' -f nodeIds='<ids>' -f format='png' -f outDir='mobile/flutter/assets' -f targetBranch='feat/figma-implement-mobile'" -ForegroundColor Yellow
