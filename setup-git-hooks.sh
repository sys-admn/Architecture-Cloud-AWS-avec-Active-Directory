#!/bin/bash
# Bash script to set up Git hooks for secret detection
# Run this script from the root of your repository

# Define colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Setting up Git hooks for secret detection...${NC}"

# Check if .git directory exists
if [ ! -d ".git" ]; then
    echo -e "${RED}Error: This script must be run from the root of a Git repository.${NC}"
    echo -e "${YELLOW}Please navigate to the repository root and try again.${NC}"
    exit 1
fi

# Create hooks directory if it doesn't exist
if [ ! -d ".git/hooks" ]; then
    mkdir -p .git/hooks
    echo -e "${GREEN}Created .git/hooks directory${NC}"
fi

# Copy the pre-commit hook to the hooks directory
cp pre-commit .git/hooks/pre-commit
echo -e "${GREEN}Copied pre-commit hook to .git/hooks/pre-commit${NC}"

# Make the pre-commit hook executable
chmod +x .git/hooks/pre-commit
echo -e "${GREEN}Made pre-commit hook executable${NC}"

# Create a .gitattributes file to ensure hooks are executable on checkout
if [ ! -f ".gitattributes" ]; then
    echo "# Ensure Git hooks are executable on checkout" > .gitattributes
    echo ".git/hooks/* text eol=lf" >> .gitattributes
    echo -e "${GREEN}Created .gitattributes file to ensure hooks are executable on checkout${NC}"
fi

echo -e "${GREEN}Git hooks setup complete!${NC}"
echo -e "${YELLOW}The pre-commit hook will now check for secrets before each commit.${NC}"
echo -e "${YELLOW}If you need to bypass the check in special cases, use: git commit --no-verify${NC}"