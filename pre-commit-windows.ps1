# PowerShell pre-commit hook for Windows

Write-Host "Running pre-commit hook to check for secrets..." -ForegroundColor Yellow

# Check for sensitive files
$keyFiles = git diff --cached --name-only | Where-Object { $_ -match "\.(pem|key|ppk|p12|pfx)$" }
$tfvarsFiles = git diff --cached --name-only | Where-Object { $_ -match "\.tfvars$" -and $_ -notmatch "(\.example\.tfvars$|\.tfvars\.example$)" }

# Files to exclude from content checks
$excludeFiles = @("pre-commit", "pre-commit-windows.ps1", "README-SECURITY.md", ".git/")

# Check for sensitive content in files
$sensitivePatterns = @(
    @{Pattern = "AKIA[A-Z0-9]{16}"; Description = "AWS Access Key" }
)

$contentMatches = @()
git diff --cached --name-only | ForEach-Object {
    $file = $_
    $exclude = $false
    foreach ($pattern in $excludeFiles) {
        if ($file -match $pattern) {
            $exclude = $true
            break
        }
    }
    
    if (-not $exclude -and (Test-Path $_)) {
        $content = Get-Content $_ -Raw -ErrorAction SilentlyContinue
        if ($content) {
            foreach ($pattern in $sensitivePatterns) {
                if ($content -match $pattern.Pattern) {
                    $contentMatches += @{File = $_; Description = $pattern.Description}
                    break
                }
            }
        }
    }
}

$secretsFound = $false

if ($keyFiles) {
    Write-Host "Warning: You are attempting to commit private key files:" -ForegroundColor Red
    $keyFiles | ForEach-Object { Write-Host "  - $_" -ForegroundColor Red }
    $secretsFound = $true
}

if ($tfvarsFiles) {
    Write-Host "Warning: You are attempting to commit .tfvars files which may contain secrets:" -ForegroundColor Red
    $tfvarsFiles | ForEach-Object { Write-Host "  - $_" -ForegroundColor Red }
    $secretsFound = $true
}

if ($contentMatches) {
    Write-Host "Warning: Potential secrets found in file content:" -ForegroundColor Red
    $contentMatches | ForEach-Object { 
        Write-Host "  - $($_.File) (matched pattern: $($_.Description))" -ForegroundColor Red 
    }
    $secretsFound = $true
}

if ($secretsFound) {
    Write-Host "Error: Potential secrets found in your commit." -ForegroundColor Red
    Write-Host "Please remove the secrets or add the files to .gitignore before committing." -ForegroundColor Yellow
    Write-Host "If you're sure these aren't actual secrets, you can bypass this check with:" -ForegroundColor Yellow
    Write-Host "  git commit --no-verify" -ForegroundColor Yellow
    exit 1
} else {
    Write-Host "No secrets found. Proceeding with commit." -ForegroundColor Green
    exit 0
}