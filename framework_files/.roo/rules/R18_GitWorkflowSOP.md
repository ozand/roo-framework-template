### R18: Git Workflow SOP
When performing any Git operations, you MUST follow this procedure:

1. Status Check: Always start with `git status`.
2. Branch Check/Creation: Ensure you're not in main/master. If in main, you MUST create a new branch (`git checkout -b <type>/<description>`).
3. Staging: Add files to staging (`git add .`).
4. Commit: Make a commit with a clear message (`git commit -m "..."`).
5. Push: Push the branch to remote (`git push -u origin <branch-name>`).