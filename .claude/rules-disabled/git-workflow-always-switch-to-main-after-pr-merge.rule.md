---
applies_to:
  - file_patterns: []
  - contexts: ["git", "workflow", "pr", "merge"]
  - actions: ["after_pr_merge"]
timing: "after"
summary: "Always switch back to main branch after successfully merging a PR"
version: "1.0.0"
---

# Rule: Always Switch to Main After PR Merge

<purpose>
This rule ensures that after successfully merging a pull request, Claude automatically switches back to the main branch to maintain proper git workflow and prepare for future work on a clean main branch state.
</purpose>

<instructions>
IMMEDIATELY after successfully merging any pull request, you MUST:

1. **Switch to main branch**: Run `git checkout main`
2. **Verify the switch**: Confirm you're on main with `git branch --show-current`
3. **Clean up**: The feature branch can remain (user may delete it separately)

This ensures you're always working from the latest main branch state after completing PR workflows.
</instructions>

<workflow_steps>
After executing a successful PR merge (like `gh pr merge`):

1. Run: `git checkout main`
2. Verify: `git branch --show-current` should show "main"
3. Ready for next work cycle on clean main branch
</workflow_steps>

<examples>
<correct>
After merging PR #5:
```bash
gh pr merge 5 --squash
# PR merge successful
git checkout main
git branch --show-current  # Shows: main
```

After merging current branch's PR:
```bash
gh pr merge --squash
# PR merge successful  
git checkout main
git branch --show-current  # Shows: main
```
</correct>

<incorrect>
Staying on feature branch after merge:
```bash
gh pr merge 3 --squash
# PR merge successful
# Still on feature/auth-system branch - VIOLATION
```

Forgetting to switch back:
```bash
gh pr merge --squash
# Continuing work without switching to main - VIOLATION
```
</incorrect>
</examples>

<timing>
This rule applies:
- AFTER any successful PR merge operation
- AFTER confirming the merge completed successfully
- BEFORE starting any new work or file modifications
</timing>

<validation>
After PR merge, verify:
- [ ] PR merge command completed successfully
- [ ] Switched to main branch with `git checkout main`
- [ ] Confirmed on main with `git branch --show-current`
- [ ] Ready to start fresh work from main branch
</validation>

<exceptions>
Do NOT switch to main when:
- PR merge failed or was cancelled
- User explicitly requests to stay on current branch
- Working on multiple related PRs that require staying on feature branch
- User has explicitly checked out a different target branch
</exceptions>