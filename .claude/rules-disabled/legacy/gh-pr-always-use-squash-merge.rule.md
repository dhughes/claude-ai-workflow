---
applies_to:
  - file_patterns: []
  - contexts: ["gh", "github", "pr", "merge", "squash"]
  - actions: ["merging_pr"]
timing: "before"
summary: "Always use squash and merge for PR merges, never other merge types"
version: "1.0.0"
---

# Rule: Always Use Squash Merge for PRs

<purpose>
This rule ensures that all pull request merges use the squash and merge strategy, maintaining a clean linear git history by combining all commits from the feature branch into a single commit on the target branch.
</purpose>

<instructions>
When merging any pull request, you MUST:

1. ALWAYS use the `--squash` flag with gh pr merge
2. NEVER use regular merge or rebase merge
3. USE this exact command format:
   ```bash
   gh pr merge [PR-number] --squash
   ```

The squash merge strategy:
- Combines all commits from the PR into one commit
- Maintains clean linear git history
- Preserves PR information in commit message
- Removes feature branch after merge
</instructions>

<merge_command>
Standard squash merge command:
```bash
gh pr merge [PR-number] --squash
```

With optional commit message customization:
```bash
gh pr merge [PR-number] --squash --subject "Custom commit title"
```

Examples:
```bash
gh pr merge 1 --squash
gh pr merge 42 --squash --subject "Add GitHub CLI workflow rules"
```
</merge_command>

<merge_types_comparison>
**Squash Merge (REQUIRED):**
- ✅ Combines all commits into one
- ✅ Clean linear history
- ✅ Easy to revert entire feature
- ✅ Reduces noise in git log

**Regular Merge (FORBIDDEN):**
- ❌ Creates merge commit
- ❌ Preserves all individual commits
- ❌ Can create complex history graph

**Rebase Merge (FORBIDDEN):**
- ❌ Replays commits individually
- ❌ Can create confusing history
- ❌ Loses PR context in history
</merge_types_comparison>

<examples>
<correct>
Squash merging PR #1:
```bash
gh pr merge 1 --squash
```

Squash merging with custom title:
```bash
gh pr merge 5 --squash --subject "Implement user authentication system"
```

Squash merging after approval verification:
```bash
# After verifying approvals
gh pr merge 3 --squash
```
</correct>

<incorrect>
Using regular merge:
```bash
gh pr merge 1  # Missing --squash flag
```

Using rebase merge:
```bash
gh pr merge 1 --rebase  # Wrong merge type
```

Using merge commit:
```bash
gh pr merge 1 --merge  # Wrong merge type
```

Manual git merge:
```bash
git merge feature-branch  # Should use gh pr merge --squash
```
</incorrect>
</examples>

<benefits_of_squash>
Squash merge provides:
- **Clean History**: Linear timeline without feature branch noise
- **Atomic Changes**: Each PR becomes one logical commit
- **Easy Reversion**: Simple to revert entire features
- **Consistent Messages**: PR title/description becomes commit message
- **Simplified Debugging**: Easier to identify when features were added
- **Reduced Complexity**: No merge commit complexity in history
</benefits_of_squash>

<validation>
Before executing merge command, verify:
- [ ] Using gh pr merge command (not manual git merge)
- [ ] Including --squash flag
- [ ] Correct PR number specified
- [ ] Command format is correct
- [ ] Not using --merge or --rebase flags
- [ ] Ready to execute squash merge
</validation>

<post_merge>
After successful squash merge:
- Feature branch is automatically deleted
- Single commit appears in target branch
- PR is marked as merged in GitHub
- Commit message includes PR title and number
- Clean linear history is maintained
</post_merge>