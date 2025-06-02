# Minimal pre-commit hook
Write-Host "Checking for secrets..." -ForegroundColor Yellow

# Check only for the most critical items
$keyFiles = git diff --cached --name-only | Where-Object { $_ -match "\.(pem|key|ppk)$" }
$tfvarsFiles = git diff --cached --name-only | Where-Object { $_ -match "\.tfvars$" -and $_ -notmatch "example" }
$awsKeyFiles = git diff --cached --name-only | Where-Object {
    (Test-Path $_) -and 
    (Get-Content $_ -Raw -ErrorAction SilentlyContinue) -match "AKIA[A-Z0-9]{16}"
}

# Report findings
if ($keyFiles -or $tfvarsFiles -or $awsKeyFiles) {
    if ($keyFiles) {
        Write-Host "Private key files detected: $($keyFiles -join ', ')" -ForegroundColor Red
    }
    if ($tfvarsFiles) {
        Write-Host "Terraform variable files detected: $($tfvarsFiles -join ', ')" -ForegroundColor Red
    }
    if ($awsKeyFiles) {
        Write-Host "AWS keys found in: $($awsKeyFiles -join ', ')" -ForegroundColor Red
    }
    Write-Host "Commit blocked. Remove secrets to proceed." -ForegroundColor Red
    exit 1
}

Write-Host "No secrets found." -ForegroundColor Green
exit 0