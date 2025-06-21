---
timing: "before"
applies_to:
  - file_patterns: []
  - contexts: ["git", "branch", "push", "safety"]
  - actions: ["pushing", "git_push"]
action: "Prevent pushing to remote main branch"
---

<purpose>
This rule prevents pushing changes directly to the remote main branch, enforcing that all changes to main must go through pull requests with proper review processes.
</purpose>

<condition>
When attempting to push while on the main branch or pushing to origin/main
</condition>

<instructions>
1. CHECK current branch with `git branch --show-current`
2. IF on main branch or push target is main, STOP the push operation
3. INFORM the user that pushing to main is not allowed
4. SUGGEST pushing to a feature branch instead
5. DO NOT proceed with the push to main
</instructions>

<detail>
CRITICAL: This rule prevents both `git push` from main branch and `git push origin main`
CRITICAL: No direct pushes to main are allowed under any circumstances
CRITICAL: This includes force pushes and push with lease operations

All changes to the main branch should happen through pull request merges on GitHub.
This ensures code review, CI/CD checks, and proper change tracking.
</detail>