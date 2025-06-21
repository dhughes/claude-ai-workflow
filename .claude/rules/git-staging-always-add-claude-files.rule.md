---
timing: "before"
applies_to:
  - file_patterns: []
  - contexts: ["git", "staging", "commit", "workflow"]
  - actions: ["git_add", "staging_files", "preparing_commit"]
action: "Always include CLAUDE.md and .claude/ directory files when staging changes"
---

<purpose>
This rule ensures that changes to CLAUDE.md and files in the .claude/ directory are always included in commits, maintaining consistency in AI assistant configuration and rules across the repository.
</purpose>

<condition>
When staging files for a commit using git add
</condition>

<instructions>
1. CHECK if CLAUDE.md has been modified with `git status CLAUDE.md`
2. CHECK if any files in .claude/ have been modified with `git status .claude/`
3. IF either has changes:
   a. ADD CLAUDE.md to staging if modified: `git add CLAUDE.md`
   b. ADD all modified .claude/ files: `git add .claude/`
4. INFORM user about automatically staged configuration files
5. PROCEED with staging other requested files
</instructions>

<detail>
CRITICAL: Always check and stage these files before other files
CRITICAL: This ensures AI configuration changes are never left uncommitted
CRITICAL: Include even if user doesn't explicitly mention these files

These files are essential for maintaining consistent AI behavior across the project.
Changes to rules, configurations, and instructions must always be committed.
</detail>