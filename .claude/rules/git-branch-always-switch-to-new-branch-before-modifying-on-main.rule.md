---
timing: "before"
applies_to:
  - file_patterns: ["*"]
  - contexts: ["git", "branch", "workflow", "automation"]
  - actions: ["creating", "editing", "deleting", "writing", "modifying"]
action: "Automatically create and switch to new feature branch when attempting file modifications on main"
---

<purpose>
This rule automatically creates and switches to a new feature branch when file modifications are attempted on the main branch, ensuring development work never happens directly on main while maintaining workflow efficiency.
</purpose>

<condition>
When attempting to create, edit, delete, or modify any file while on the main branch
</condition>

<instructions>
1. CHECK current branch with `git branch --show-current`
2. IF on main branch:
   a. DERIVE branch name from the current task or modification purpose
   b. CREATE new branch with `git checkout -b <branch-name>`
   c. Use naming pattern: feature/<task-description> or fix/<issue-description>
   d. INFORM user about automatic branch creation
3. PROCEED with file modification on the new branch
4. TRACK the branch creation in the workflow
</instructions>

<detail>
CRITICAL: Branch name should be descriptive and follow kebab-case convention
CRITICAL: Automatically handle the branch creation without requiring user intervention
CRITICAL: Ensure the branch name reflects the work being done

Branch naming examples:
- feature/add-user-authentication
- fix/resolve-memory-leak
- refactor/improve-api-structure
- docs/update-readme

This rule works in conjunction with the file modification prevention rule to provide a seamless workflow.
</detail>