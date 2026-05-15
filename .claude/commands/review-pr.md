# /review-pr

$ARGUMENTS

1. Fetch the open PR information (if a URL or number is provided)
2. Check out the PR branch locally or fetch the remote ref
3. Review the diff for:
   - Logic errors or edge cases
   - Security issues (secrets, injection risks)
   - Performance problems
   - Style consistency with existing code
   - Missing tests or documentation
4. Post a summary of findings as a comment on the PR, or print it here if no remote access
