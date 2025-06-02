# PowerShell script to set up Git hooks for secret detection
# Run this script from the root of your repository

# Define colors for output
$Red = "`e[31m"
$Green = "`e[32m"
$Yellow = "`e[33m"
$Reset = "`e[0m"

Write-Host "$Yellow Setting up Git hooks for secret detection... $Reset"

# Check if .git directory exists
if (-not (Test-Path ".git")) {
    Write-Host "$Red Error: This script must be run from the root of a Git repository. $Reset"
    Write-Host "$Yellow Please navigate to the repository root and try again. $Reset"
    exit 1
}

# Create hooks directory if it doesn't exist
if (-not (Test-Path ".git\hooks")) {
    New-Item -ItemType Directory -Path ".git\hooks" | Out-Null
    Write-Host "$Green Created .git\hooks directory $Reset"
}

# Copy the pre-commit hook to the hooks directory
Copy-Item -Path "pre-commit" -Destination ".git\hooks\pre-commit" -Force
Write-Host "$Green Copied pre-commit hook to .git\hooks\pre-commit $Reset"

# Make the pre-commit hook executable (Windows doesn't need this, but for completeness)
if ($IsLinux -or $IsMacOS) {
    & chmod +x .git/hooks/pre-commit
    Write-Host "$Green Made pre-commit hook executable $Reset"
}

# Create a .gitattributes file to ensure hooks are executable on checkout
$gitattributes = @"
# Ensure Git hooks are executable on checkout
.git/hooks/* text eol=lf
"@

if (-not (Test-Path ".gitattributes")) {
    $gitattributes | Out-File -FilePath ".gitattributes" -Encoding utf8
    Write-Host "$Green Created .gitattributes file to ensure hooks are executable on checkout $Reset"
}

Write-Host "$Green Git hooks setup complete! $Reset"
Write-Host "$Yellow The pre-commit hook will now check for secrets before each commit. $Reset"
Write-Host "$Yellow If you need to bypass the check in special cases, use: git commit --no-verify $Reset"