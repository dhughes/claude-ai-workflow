---
applies_to:
  - file_patterns: []
  - contexts: ["git", "push", "workflow"]
  - actions: ["after_commit"]
timing: "after"
summary: "Always push commits to GitHub and set upstream branch if needed"
version: "1.0.0"
---

# Rule: Always Push After Commits

<purpose>
This rule ensures that all commits are automatically pushed to GitHub, maintaining synchronization between local and remote repositories and setting upstream tracking for new branches as needed.
</purpose>

<instructions>
After EVERY successful git commit, you MUST:

1. CHECK if the current branch has an upstream with `git status`
2. IF branch has no upstream (new branch):
   - Push and set upstream: `git push -u origin [branch-name]`
3. IF branch already has upstream:
   - Simple push: `git push`
4. VERIFY the push was successful
5. NEVER skip pushing unless user explicitly requests local-only work

This applies to:
- All commits on any branch
- First-time pushes of new branches
- Subsequent pushes to existing branches
- Both feature branches and main branch commits
</instructions>

<push_workflow>
Standard workflow after commit:

1. Check upstream status: `git status`
2. Determine push command needed:
   - No upstream: `git push -u origin [current-branch]`
   - Has upstream: `git push`
3. Execute push command
4. Confirm success from output
5. Continue with next tasks

The `-u` flag sets the upstream relationship so future pushes can use simple `git push`.
</push_workflow>

<branch_scenarios>
<new_branch>
For new branches (no upstream):
```bash
git status  # Shows "no upstream branch"
git push -u origin feature/user-authentication
# Sets upstream and pushes
```
</new_branch>

<existing_branch>
For existing branches (has upstream):
```bash
git status  # Shows "Your branch is ahead of 'origin/main' by 1 commit"
git push
# Simple push since upstream exists
```
</existing_branch>

<first_commit_main>
For first commit on main:
```bash
git status  # May show no upstream
git push -u origin main
# Sets upstream for main branch
```
</first_commit_main>
</branch_scenarios>

<examples>
<correct>
After committing on new feature branch:
```bash
git commit --author="Claude Hughes <doug+ai@doughughes.net>" -m "Add login component"
# Rule triggers
git status  # Shows no upstream
git push -u origin feature/user-login
# Output: Branch 'feature/user-login' set up to track remote branch
```

After committing on existing branch:
```bash
git commit --author="Claude Hughes <doug+ai@doughughes.net>" -m "Fix validation bug"
# Rule triggers  
git status  # Shows "ahead of origin/main by 1 commit"
git push
# Output: Successfully pushed to origin/main
```

Multiple commits in sequence:
```bash
git commit --author="Claude Hughes <doug+ai@doughughes.net>" -m "Add feature A"
git push -u origin feature/new-functionality  # First push sets upstream
git commit --author="Claude Hughes <doug+ai@doughughes.net>" -m "Add feature B" 
git push  # Subsequent pushes use simple push
```
</correct>

<incorrect>
Forgetting to push after commit:
```bash
git commit --author="Claude Hughes <doug+ai@doughughes.net>" -m "Add feature"
# Missing: git push command
# Violates rule - commits must be pushed
```

Wrong push command for new branch:
```bash
git commit --author="Claude Hughes <doug+ai@doughughes.net>" -m "Add feature"
git push  # On new branch without upstream
# Error: "no upstream branch exists"
# Should use: git push -u origin [branch-name]
```

Not checking status first:
```bash
git commit --author="Claude Hughes <doug+ai@doughughes.net>" -m "Add feature"
git push -u origin feature/wrong-branch  # Didn't check current branch name
# Should check git status or git branch first
```
</incorrect>
</examples>

<status_interpretation>
Common git status messages and required actions:

"No upstream branch exists":
- Action: `git push -u origin [current-branch-name]`

"Your branch is ahead of 'origin/[branch]' by X commits":
- Action: `git push`

"Your branch is up to date with 'origin/[branch]'":
- Action: No push needed (no new commits)

"Your branch and 'origin/[branch]' have diverged":
- Action: Resolve conflicts first, then push
</status_interpretation>

<error_handling>
If push fails:

1. READ the error message carefully
2. COMMON issues and solutions:
   - Authentication: Check GitHub credentials
   - Conflicts: Pull and resolve, then push
   - Branch protection: May need pull request instead
   - Network: Retry after connection restored

3. DO NOT proceed with other work until push succeeds
4. INFORM user if manual intervention needed
</error_handling>

<exclusions>
Do NOT auto-push when:
- User explicitly requests local-only work
- Working in experimental/temporary branches user wants to keep local
- Push fails due to conflicts (need manual resolution)
- User is doing rapid iteration and wants to batch pushes
- Repository has branch protection requiring pull requests
</exclusions>

<validation>
After every commit, verify:
- [ ] Git status checked to determine upstream status
- [ ] Appropriate push command executed (with or without -u)
- [ ] Push completed successfully
- [ ] No error messages in push output
- [ ] Remote repository updated (if accessible)
- [ ] Ready to continue with next tasks
</validation>