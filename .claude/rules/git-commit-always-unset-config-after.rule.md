---
timing: "after"
applies_to:
  - file_patterns: []
  - contexts: ["git", "commit", "config", "cleanup"]
  - actions: ["committing", "git_commit"]
action: "Unset git user.name and user.email after committing"
---

<purpose>
This rule cleans up the temporary git user configuration after commits, ensuring the local repository doesn't retain persistent user settings that might affect other operations or users.
</purpose>

<condition>
After successfully creating a git commit
</condition>

<instructions>
1. UNSET local git user name: `git config --local --unset user.name`
2. UNSET local git user email: `git config --local --unset user.email`
3. VERIFY configuration was removed with `git config --local --get user.name` (should show no output)
4. IF unset commands fail due to missing config, continue without error
5. INFORM user that temporary git config has been cleaned up
</instructions>

<detail>
CRITICAL: Only unset --local configuration, never global
CRITICAL: This cleanup happens after EVERY commit
CRITICAL: Ignore errors if config was already unset

This ensures:
- No persistent local configuration remains
- Each commit cycle is independent
- No interference with other git operations
- Clean state for next commit operation
</detail>