#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# start-worktrees.sh
# Launches 5 parallel Claude Code worktree sessions
# Inspired by Boris Cherny's workflow
# ============================================================

REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
REPO_NAME="$(basename "$REPO_ROOT")"

echo "==> Repo: $REPO_NAME"
echo "==> Root: $REPO_ROOT"
echo ""

# Create 5 worktrees if they don't exist
for i in {1..5}; do
    WT_PATH="$REPO_ROOT/../${REPO_NAME}-wt-$i"
    if [ ! -d "$WT_PATH" ]; then
        echo "Creating worktree $i: ${REPO_NAME}-wt-$i"
        git worktree add "$WT_PATH" -b "wt-$i" 2>/dev/null || git worktree add "$WT_PATH" "wt-$i" 2>/dev/null || true
    else
        echo "Worktree $i already exists: ${REPO_NAME}-wt-$i"
    fi
done

echo ""
echo "==> Worktree layout:"
echo "    Main:  $REPO_ROOT"
for i in {1..5}; do
    echo "    WT $i: $REPO_ROOT/../${REPO_NAME}-wt-$i"
done

echo ""
echo "==> Launch commands for each worktree:"
echo ""
for i in {1..5}; do
    WT_PATH="$REPO_ROOT/../${REPO_NAME}-wt-$i"
    case $i in
        1) ROLE="Feature" ;;
        2) ROLE="Tests" ;;
        3) ROLE="PR Review" ;;
        4) ROLE="Debug" ;;
        5) ROLE="Docs" ;;
    esac
    echo "--- WT-$i ($ROLE) ---"
    echo "cd \"$WT_PATH\" && claude"
    echo ""
done

echo "==> Tips:"
echo "    - Open 5 terminal tabs and paste the commands above"
echo "    - Each worktree is an independent checkout; merge when done"
echo "    - CLAUDE.md is shared: edit in main, pull into worktrees via git"
echo ""
