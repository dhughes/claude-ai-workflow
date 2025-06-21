---
applies_to:
  - file_patterns: []
  - contexts: ["git", "main", "stash", "switching"]
  - actions: ["before_switching_to_main"]
timing: "before"
summary: "Always stash local changes before switching to main if they would be overwritten"
version: "1.0.0"
---

# Rule: Always Stash Before Switching to Main

<purpose>
This rule ensures that when switching to main branch, any local changes that would be overwritten are safely stashed first and then restored after the switch, preventing loss of work and enabling smooth branch transitions.
</purpose>

<instructions>
When switching to main branch, if you encounter an error about local changes being overwritten, you MUST:

1. **Stash the changes**: Run `git stash` to save local modifications
2. **Switch to main**: Run `git checkout main` (should now succeed)
3. **Pull latest changes**: Follow the pull-after-switch rule with `git pull`
4. **Restore changes**: Run `git stash pop` to restore the stashed changes

This workflow ensures no work is lost while enabling clean branch switches.
</instructions>

<error_detection>
**Watch for these error messages:**
- "Your local changes to the following files would be overwritten by checkout"
- "Please commit your changes or stash them before you switch branches"
- "Aborting" after checkout attempt

**When you see these errors:**
1. Do NOT force the checkout
2. Do NOT lose the changes
3. Follow the stash workflow instead
</error_detection>

<stash_workflow>
**Complete workflow when encountering checkout errors:**

```bash
# Step 1: Attempt normal checkout (may fail)
git checkout main
# If error occurs: "local changes would be overwritten"

# Step 2: Stash the conflicting changes
git stash

# Step 3: Switch to main (should now succeed)
git checkout main

# Step 4: Pull latest changes (follow pull rule)
git pull

# Step 5: Restore stashed changes
git stash pop
```

**Result:** Main branch is updated AND local changes are preserved
</stash_workflow>

<stash_management>
**Stash best practices:**
- Use `git stash` for quick temporary storage
- Use `git stash pop` to restore and remove from stash
- Use `git stash list` to see all stashes if needed
- Use `git stash drop` to discard if changes are no longer needed

**Stash behavior:**
- Saves both staged and unstaged changes
- Does NOT save untracked files by default
- Restores changes to their original staged/unstaged state
- May cause merge conflicts if main has conflicting changes
</stash_management>

<examples>
<correct>
Handling checkout error with stash:
```bash
git checkout main
# Error: Your local changes to the following files would be overwritten:
#        .claude/settings.local.json
# Please commit your changes or stash them before you switch branches.

git stash
# Saved working directory and index state WIP on feature-branch

git checkout main
# Switched to branch 'main'

git pull
# Already up to date.

git stash pop
# On branch main
# Changes restored successfully
```

Smooth workflow when no conflicts:
```bash
git checkout main
# Switched to branch 'main' (no error - no stash needed)

git pull
# Updated main branch
```
</correct>

<incorrect>
Ignoring the error and forcing:
```bash
git checkout main
# Error: local changes would be overwritten
git checkout -f main  # ❌ WRONG - loses changes
```

Committing temporary work just to switch:
```bash
git checkout main
# Error: local changes would be overwritten
git commit -m "temp commit"  # ❌ WRONG - pollutes history
git checkout main
```

Manually backing up files:
```bash
git checkout main
# Error: local changes would be overwritten
cp .claude/settings.local.json /tmp/backup  # ❌ WRONG - manual process
git checkout -f main
# Lost other changes, manual restore needed
```
</incorrect>
</examples>

<conflict_resolution>
**If `git stash pop` causes conflicts:**

1. **Resolve conflicts manually**: Edit files to resolve merge conflicts
2. **Add resolved files**: `git add [resolved-files]`
3. **Complete the pop**: `git stash drop` (since changes are now applied)

**Example conflict resolution:**
```bash
git stash pop
# Auto-merging .claude/settings.local.json
# CONFLICT (content): Merge conflict in .claude/settings.local.json

# Edit file to resolve conflicts
# Remove conflict markers and choose correct content

git add .claude/settings.local.json
git stash drop  # Remove stash since changes are applied
```
</conflict_resolution>

<timing>
This rule applies:
- BEFORE attempting to switch to main branch
- AFTER encountering "local changes would be overwritten" error
- AS PART OF the main branch switching workflow
- BEFORE the pull-after-switch rule execution
</timing>

<integration_with_other_rules>
**Works with these rules:**
- `git-main-always-pull-after-switching.rule.md` - Pull happens after stash workflow
- `git-workflow-always-switch-to-main-after-pr-merge.rule.md` - May trigger stash workflow

**Workflow order:**
1. Attempt switch to main
2. If error → Apply this stash rule
3. After successful switch → Apply pull rule
4. Continue with normal workflow
</integration_with_other_rules>

<validation>
After completing stash workflow, verify:
- [ ] Successfully switched to main branch
- [ ] Local changes have been restored with `git stash pop`
- [ ] No conflicts remain unresolved
- [ ] Stash list is clean (no unnecessary stashes)
- [ ] Ready to continue with normal main branch workflow
</validation>

<edge_cases>
**Multiple stashes:**
- Each `git stash` creates a new stash entry
- Use `git stash list` to see all stashes
- Use `git stash pop` to restore the most recent
- Use `git stash pop stash@{1}` for specific stash

**Untracked files:**
- Standard `git stash` doesn't save untracked files
- Use `git stash -u` if untracked files need to be saved
- Usually not necessary for main branch switches

**Already on main:**
- If already on main, no switch needed
- Stash workflow doesn't apply
- Continue with normal main branch operations
</edge_cases>

<troubleshooting>
**If stash pop fails:**
1. Check `git status` for conflicts
2. Resolve conflicts manually
3. Add resolved files: `git add [files]`
4. Drop the stash: `git stash drop`

**If unsure about stash contents:**
1. Check stash: `git stash show -p`
2. List all stashes: `git stash list`
3. Apply without popping: `git stash apply` (keeps stash)

**If you forget to stash:**
- Can't undo a forced checkout that lost changes
- Prevention is key - always follow this rule
</troubleshooting>