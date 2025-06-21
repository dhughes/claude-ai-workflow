---
applies_to:
  - file_patterns: []
  - contexts: ["git", "main", "pull", "workflow"]
  - actions: ["after_switching_to_main"]
timing: "after"
summary: "Always pull latest changes after switching to main branch"
version: "1.0.0"
---

# Rule: Always Pull After Switching to Main

<purpose>
This rule ensures that after switching to the main branch, Claude always pulls the latest changes from the remote repository to maintain an up-to-date local main branch and prevent conflicts or outdated code.
</purpose>

<instructions>
IMMEDIATELY after switching to the main branch, you MUST:

1. **Pull latest changes**: Run `git pull` 
2. **Verify the pull**: Confirm the pull completed successfully
3. **Ready for work**: Main branch is now up-to-date and ready for new work

This ensures the main branch always reflects the latest remote state.
</instructions>

<workflow_steps>
After executing `git checkout main` or switching to main:

1. Run: `git pull`
2. Verify: Check output for successful pull or "Already up to date"
3. Ready: Main branch now has latest changes from remote
</workflow_steps>

<examples>
<correct>
Switching to main and pulling:
```bash
git checkout main
git pull
# Output: Already up to date. (or successful pull message)
```

After PR merge, switching back to main:
```bash
gh pr merge 5 --squash
git checkout main
git pull  # Gets the merged changes
```
</correct>

<incorrect>
Switching to main without pulling:
```bash
git checkout main
# Starting work without pulling - VIOLATION
```

Forgetting to pull after checkout:
```bash
git checkout main
# Immediately creating new branch without pull - VIOLATION
git checkout -b feature/new-work
```
</incorrect>
</examples>

<timing>
This rule applies:
- AFTER successfully switching to main branch with `git checkout main`
- AFTER any command that results in being on main branch
- BEFORE starting any new work or creating branches from main
</timing>

<validation>
After switching to main, verify:
- [ ] Successfully switched to main branch
- [ ] Ran `git pull` command
- [ ] Pull completed successfully (no errors)
- [ ] Main branch is now up-to-date with remote
- [ ] Ready to proceed with next steps
</validation>

<pull_handling>
**Successful pull scenarios:**
- "Already up to date" - main was current
- "Fast-forward" - pulled new commits successfully
- "Merge made by..." - merged remote changes

**Error scenarios require attention:**
- Merge conflicts - resolve before proceeding
- Network issues - retry or continue offline
- Authentication issues - resolve auth problems

**After successful pull:**
- Main branch reflects latest remote state
- Safe to create new branches
- Safe to start new work cycles
</pull_handling>

<exceptions>
Do NOT pull when:
- Network is unavailable and user explicitly continues offline
- User has explicitly requested to work with specific commit
- Working in detached HEAD state intentionally
- Git pull would cause conflicts and user requests manual handling
</exceptions>