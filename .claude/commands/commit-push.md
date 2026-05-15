# /commit-push

$ARGUMENTS

1. Run any available tests and linting for this project
2. Stage all changes: `git add -A`
3. Generate a concise, conventional commit message based on the diff
4. Commit with that message
5. Push to the current branch (`git push`)
6. If there is no upstream tracking branch, print the exact command to create one
