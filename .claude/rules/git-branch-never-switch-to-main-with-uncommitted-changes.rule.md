---
timing: "before"
applies_to:
  - file_patterns: []
  - contexts: ["git", "branch", "workflow", "safety"]
  - actions: ["git_checkout_main", "switching_to_main"]
action: "Prevent switching to main branch with uncommitted changes"
---

<purpose>
This rule prevents switching to the main branch when there are uncommitted changes, ensuring work in progress is properly saved and preventing accidental loss of changes or contamination of the main branch.
</purpose>

<condition>
When attempting to switch to the main branch using git checkout or git switch
</condition>

<instructions>
1. CHECK for uncommitted changes with `git status --porcelain`
2. IF uncommitted changes exist, STOP the branch switch
3. INFORM the user about uncommitted changes
4. SUGGEST either:
   - Committing the changes on the current branch
   - Stashing the changes with `git stash`
   - Discarding changes if appropriate
5. DO NOT proceed with switching to main until working directory is clean
</instructions>

<detail>
CRITICAL: Never allow switching to main with uncommitted work
CRITICAL: This includes both staged and unstaged changes
CRITICAL: Check must happen BEFORE attempting the switch

This prevents:
- Loss of work in progress
- Accidental commits to main
- Confusion about which branch contains which changes
- Merge conflicts from uncommitted changes
</detail>