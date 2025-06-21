---
timing: "after"
applies_to:
  - file_patterns: []
  - contexts: ["git", "branch", "sync", "workflow"]
  - actions: ["git_checkout_main", "switching_to_main"]
action: "Pull latest changes from remote main after switching to main branch"
---

<purpose>
This rule ensures the local main branch is always synchronized with the remote main branch whenever switching to it, preventing work based on outdated code.
</purpose>

<condition>
After successfully switching to the main branch using git checkout or git switch
</condition>

<instructions>
1. VERIFY successful switch to main branch
2. IMMEDIATELY run `git pull origin main` to fetch and merge latest changes
3. INFORM the user about the sync status
4. IF conflicts occur, notify the user (though this should be rare on main)
5. PROCEED with intended actions only after successful pull
</instructions>

<detail>
CRITICAL: This must happen AFTER switching to main, not before
CRITICAL: Always pull even if the user doesn't explicitly request it
CRITICAL: This ensures main is always up-to-date with remote

Keeping main synchronized prevents creating branches from outdated code.
This is essential for maintaining a clean git history and avoiding merge conflicts.
</detail>