# Claude Code Workflow Template

Boris-style parallel-agent scaffold for Claude Code projects.

## What is this?

This is a master template that generates new projects pre-configured with:

- **5 parallel Claude Code worktrees** for simultaneous tasks
- **Shared `CLAUDE.md`** as persistent project memory
- **Custom slash commands** in `.claude/commands/`
- **Pre-approved permissions** so safe commands run without friction
- **GitHub Action** that auto-updates `CLAUDE.md` from PR review comments

## Quick Start

### 1. Spawn a new project

```bash
bash /c/Users/huiqi/claude-workflow-template/scripts/spawn-project.sh my-new-project
```

This creates:
```
C:\Users\huiqi\Projects\my-new-project/
```

### 2. Launch parallel worktrees

```bash
cd /c/Users/huiqi/Projects/my-new-project
bash scripts/start-worktrees.sh
```

Then open 5 terminal tabs and run the printed `cd ... && claude` commands.

### 3. Work

- Use `/init-project` to detect your tech stack
- Use `/commit-push` when ready to land code
- Use `/add-rule` to record new learnings
- Use `/review-pr` to review pull requests

## File Reference

| File | Purpose |
|------|---------|
| `CLAUDE.md` | Persistent project rules and context |
| `.claude/settings.json` | Pre-approved permissions and hooks |
| `.claude/commands/*.md` | Reusable slash commands |
| `scripts/start-worktrees.sh` | Launch 5 parallel worktree sessions |
| `.github/workflows/claude-feedback.yml` | Auto-update CLAUDE.md from PRs |

## Updating the Template

When you improve your workflow (new rules, new commands), edit the files in this template directory. Future spawned projects will inherit the changes.

## Requirements

- Git Bash (MSYS2) on Windows
- `git` >= 2.53
- `claude` CLI installed
- Optional: `gh` CLI for auto GitHub repo creation
