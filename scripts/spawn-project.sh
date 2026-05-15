#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# spawn-project.sh
# Boris-style Claude Code project generator
# Usage: bash spawn-project.sh <project-name>
# ============================================================

TEMPLATE_DIR="/c/Users/huiqi/claude-workflow-template"
PROJECTS_DIR="/c/Users/huiqi/Projects"
PROJECT_NAME="${1:-}"

if [ -z "$PROJECT_NAME" ]; then
    echo "Usage: spawn-project.sh <project-name>"
    echo "Example: spawn-project.sh my-new-app"
    exit 1
fi

PROJECT_PATH="$PROJECTS_DIR/$PROJECT_NAME"

if [ -d "$PROJECT_PATH" ]; then
    echo "Error: $PROJECT_PATH already exists."
    exit 1
fi

echo "==> Spawning new project: $PROJECT_NAME"
echo "==> Destination: $PROJECT_PATH"

# Create Projects dir if it doesn't exist
mkdir -p "$PROJECTS_DIR"

# Copy template (excluding .git and this script's own repo artifacts)
mkdir -p "$PROJECT_PATH"
cp -r "$TEMPLATE_DIR/CLAUDE.md" "$PROJECT_PATH/"
cp -r "$TEMPLATE_DIR/.claude" "$PROJECT_PATH/"
cp -r "$TEMPLATE_DIR/.github" "$PROJECT_PATH/"
cp -r "$TEMPLATE_DIR/scripts" "$PROJECT_PATH/"

# Remove the spawn-project.sh from the spawned project (it's only for the template)
rm -f "$PROJECT_PATH/scripts/spawn-project.sh"

cd "$PROJECT_PATH"

# Initialize git
git init
# Set local git identity (falls back to defaults if global is missing)
git config user.email "$(git config --global user.email 2>/dev/null || echo 'developer@local.dev')"
git config user.name "$(git config --global user.name 2>/dev/null || echo 'Claude Developer')"
git add -A
git commit -m "chore: initial scaffold from claude-workflow-template"

echo ""
echo "==> Project scaffold created at $PROJECT_PATH"

# GitHub CLI integration
if command -v gh &> /dev/null; then
    if gh auth status &> /dev/null; then
        echo "==> Creating GitHub repository..."
        gh repo create "$PROJECT_NAME" --public --source=. --push || true
    else
        echo ""
        echo "[!] gh is installed but not authenticated."
        echo "    Run: gh auth login"
        echo "    Then re-run: gh repo create $PROJECT_NAME --public --source=. --push"
    fi
else
    echo ""
    echo "[!] GitHub CLI (gh) not found."
    echo "    Install from: https://cli.github.com/"
    echo "    Then run: gh auth login"
fi

echo ""
echo "==> Next steps:"
echo "    cd $PROJECT_PATH"
echo "    bash scripts/start-worktrees.sh"
echo ""
