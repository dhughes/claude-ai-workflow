---
timing: "before"
applies_to:
  - file_patterns: []
  - contexts: ["git", "branch", "commit", "safety"]
  - actions: ["committing", "git_commit"]
action: "Prevent direct commits to main branch"
---

<purpose>
This rule prevents accidental commits directly to the main branch, enforcing a branch-based workflow where all changes must be made on feature branches before being merged through pull requests.
</purpose>

<condition>
When attempting to commit code while on the main branch
</condition>

<instructions>
1. CHECK current branch with `git branch --show-current`
2. IF on main branch, STOP the commit operation
3. INFORM the user that commits to main are not allowed
4. SUGGEST creating a new feature branch first
5. DO NOT proceed with the commit
</instructions>

<detail>
CRITICAL: This rule has no exceptions - commits must never be made directly to main
CRITICAL: Always verify the current branch before any commit operation
CRITICAL: This applies to both regular commits and amend operations

The main branch should only receive changes through pull request merges performed on GitHub.
Direct commits to main bypass code review and CI/CD processes.
</detail>