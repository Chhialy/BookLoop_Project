# Diagnostic script to check Figma/MCP auth and endpoint
# Usage: Open PowerShell, run: `.	ools\check_figma_mcp.ps1`

Write-Host "=== Figma/MCP Diagnostic Script ===" -ForegroundColor Cyan

# 1) Show environment variables that might contain tokens
Write-Host "\n-- Environment variables (matching figma|mcp) --" -ForegroundColor Yellow
Get-ChildItem Env: | Where-Object { $_.Name -match 'figma|mcp|FIGMA|MCP' } | ForEach-Object {
    $name = $_.Name
    $val = $_.Value
    if ([string]::IsNullOrEmpty($val)) { Write-Host "$name : <empty>"; return }
    $masked = if ($val.Length -le 10) { '***masked***' } else { $val.Substring(0,4) + '...' + $val.Substring($val.Length-4) }
    Write-Host "$name : $masked"
}

# 2) Show .vscode/mcp.json if present
$workspaceRoot = Join-Path $PSScriptRoot '..' | Resolve-Path -ErrorAction SilentlyContinue
$workspaceRoot = if ($workspaceRoot) { $workspaceRoot.Path } else { (Get-Location).Path }
$mcpPath = Join-Path $workspaceRoot '.vscode\mcp.json'
Write-Host "\n-- mcp.json (if present) --" -ForegroundColor Yellow
if (Test-Path $mcpPath) {
    Get-Content $mcpPath | ForEach-Object { Write-Host $_ }
} else {
    Write-Host "No .vscode/mcp.json found at $mcpPath"
}

# 3) Determine token to use for testing
$envCandidates = @('FIGMA_API_TOKEN','FIGMA_TOKEN','MCP_TOKEN','FIGMA_TOKEN','FIGMA_PERSONAL_TOKEN')
$token = $null
foreach ($n in $envCandidates) {
    if ($env:$n) { $token = $env:$n; Write-Host "\nUsing token from env var: $n"; break }
}
if (-not $token) {
    Write-Host "\nNo token found in env. You can paste one now to test the endpoint, or press Enter to skip." -ForegroundColor Yellow
    $token = Read-Host -Prompt 'Token (plaintext)'
}

if (-not $token) { Write-Host "Skipping network tests (no token provided)."; exit 0 }

# 4) Try authenticated requests with different headers
$uri = 'https://mcp.figma.com/mcp'
$sampleBody = @{ test = 'ping'; ts = (Get-Date).ToString('o') } | ConvertTo-Json

function TryRequest($headers) {
    Write-Host "\nTrying request with headers: $($headers.Keys -join ', ')" -ForegroundColor Cyan
    try {
        $resp = Invoke-WebRequest -Uri $uri -Method Post -Headers $headers -Body $sampleBody -ContentType 'application/json' -UseBasicParsing -ErrorAction Stop
        Write-Host "Success: StatusCode=$($resp.StatusCode)" -ForegroundColor Green
        if ($resp.RawContent) { Write-Host $resp.RawContent }
    } catch {
        $err = $_.Exception
        Write-Host "Request failed: $($_.Exception.Message)" -ForegroundColor Red
        if ($err.Response) {
            $status = $err.Response.StatusCode.value__ 2>$null
            Write-Host "HTTP status: $status"
            try { $body = (New-Object System.IO.StreamReader($err.Response.GetResponseStream())).ReadToEnd(); Write-Host "Response body:`n$body" } catch {}
        }
    }
}

# Try Bearer auth
$headers = @{ Authorization = "Bearer $token" }
TryRequest $headers

# Try X-Figma-Token
$headers = @{ 'X-Figma-Token' = $token }
TryRequest $headers

# Try both
$headers = @{ Authorization = "Bearer $token"; 'X-Figma-Token' = $token }
TryRequest $headers

# 5) If token looks like JWT, decode payload
if ($token -match '\.') {
    Write-Host "\nToken looks like a JWT — decoding payload..." -ForegroundColor Yellow
    $parts = $token.Split('.')
    if ($parts.Length -ge 2) {
        $payload = $parts[1]
        $pad = (4 - ($payload.Length % 4)) % 4
        if ($pad -gt 0) { $payload = $payload + ('=' * $pad) }
        try {
            $decoded = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($payload))
            Write-Host "Decoded payload:`n$decoded"
            try { $json = $decoded | ConvertFrom-Json; Write-Host "`nParsed JSON payload:"; $json | Format-List } catch {}
        } catch { Write-Host "Failed to decode JWT payload: $($_.Exception.Message)" -ForegroundColor Red }
    }
}

Write-Host "\nDiagnostic complete. Review the outputs above to identify token issues, HTTP status codes, or token expiry." -ForegroundColor Cyan
