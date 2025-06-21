---
timing: "before"
applies_to:
  - file_patterns: ["*"]
  - contexts: ["git", "branch", "files", "safety"]
  - actions: ["creating", "editing", "deleting", "writing", "modifying"]
action: "Prevent file modifications while on main branch"
---

<purpose>
This rule prevents any file modifications while on the main branch, ensuring all development work happens on feature branches to maintain main branch stability.
</purpose>

<condition>
When attempting to create, edit, delete, or modify any file while on the main branch
</condition>

<instructions>
1. CHECK current branch with `git branch --show-current`
2. IF on main branch, STOP the file operation
3. INFORM the user that file modifications on main are not allowed
4. SUGGEST creating a new feature branch first
5. DO NOT proceed with the file modification
</instructions>

<detail>
CRITICAL: This rule applies to ALL file operations including creates, edits, and deletes
CRITICAL: No exceptions - all development must happen on feature branches
CRITICAL: This includes modifications to any files, even documentation or config files

The main branch should remain stable and only receive tested changes through pull requests.
All development work, regardless of size or scope, must happen on feature branches.
</detail>