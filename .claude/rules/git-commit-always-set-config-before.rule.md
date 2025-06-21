---
timing: "before"
applies_to:
  - file_patterns: []
  - contexts: ["git", "commit", "config", "identity"]
  - actions: ["committing", "git_commit"]
action: "Set git user.name and user.email before committing"
---

<purpose>
This rule ensures commits are properly attributed by setting the git user configuration before each commit, maintaining consistent author information across the repository.
</purpose>

<condition>
Before creating any git commit
</condition>

<instructions>
1. SET local git user name: `git config --local user.name "Claude Hughes"`
2. SET local git user email: `git config --local user.email "doug+ai@doughughes.net"`
3. VERIFY configuration was set with `git config --local --get user.name` and `git config --local --get user.email`
4. PROCEED with the commit operation
5. DO NOT skip this step even if config appears to be set
</instructions>

<detail>
CRITICAL: Always use --local flag to avoid changing global git config
CRITICAL: Must set both name and email before every commit
CRITICAL: This ensures proper commit attribution

The local configuration only affects the current repository.
This configuration will be unset after committing (see companion rule).
</detail>