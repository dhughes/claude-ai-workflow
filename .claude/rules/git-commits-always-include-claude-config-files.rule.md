---
applies_to:
  - file_patterns: []
  - contexts: ["git", "commits", "claude_config"]
  - actions: ["before_commit"]
timing: "before"
summary: "Always include CLAUDE.md and .claude/settings.local.json changes in commits"
version: "1.0.0"
---

# Rule: Always Include Claude Configuration Files in Commits

<purpose>
This rule ensures that changes to Claude Code configuration files (CLAUDE.md and .claude/settings.local.json) are always included in commits, maintaining consistency between code changes and the Claude configuration that governs how those changes should be made.
</purpose>

<instructions>
Before creating any git commit, you MUST:

1. CHECK if CLAUDE.md has been modified:
   - Run `git status` and look for CLAUDE.md in modified files
   - If modified, ALWAYS add it to the commit with `git add CLAUDE.md`

2. CHECK if .claude/settings.local.json has been modified:
   - Run `git status` and look for .claude/settings.local.json in modified files  
   - If modified, ALWAYS add it to the commit with `git add .claude/settings.local.json`

3. NEVER commit code changes without including related Claude configuration changes

4. ALWAYS include these files even if they seem unrelated to the main changes

This applies because:
- CLAUDE.md contains project instructions that affect all future work
- settings.local.json contains Claude Code configuration
- These files provide context for why code changes were made
- Future Claude sessions need the updated configuration
- Configuration and code should stay in sync
</instructions>

<rationale>
Claude configuration files are critical infrastructure:
- CLAUDE.md guides all future Claude Code interactions
- settings.local.json controls Claude Code behavior
- Changes to these files often drive or explain code changes
- Keeping them in sync prevents configuration drift
- Other developers need to see configuration context
</rationale>

<file_descriptions>
<claude_md>
File: CLAUDE.md
Purpose: Primary instruction file for Claude Code
Contains: Project overview, rules system instructions, coding guidelines
Why include: Changes affect all future Claude interactions and code decisions
</claude_md>

<settings_local_json>
File: .claude/settings.local.json  
Purpose: Local Claude Code configuration settings
Contains: Tool preferences, model settings, workflow configurations
Why include: Changes affect Claude Code behavior and capabilities
</settings_local_json>
</file_descriptions>

<examples>
<correct>
Including configuration files in commit:
```bash
git status
# See that CLAUDE.md and main.py are modified
git add main.py
git add CLAUDE.md
git commit -m "Add user authentication system

Implements login/logout functionality as requested by user.
Updated CLAUDE.md with new authentication guidelines."
```

Including settings in commit:
```bash
git status  
# See that .claude/settings.local.json and src/api.ts are modified
git add src/api.ts
git add .claude/settings.local.json
git commit -m "Configure API client with retry logic

Added exponential backoff for failed requests.
Updated Claude settings to prefer async patterns."
```

Both files modified:
```bash
git status
# See CLAUDE.md, .claude/settings.local.json, and src/components/ modified
git add src/components/
git add CLAUDE.md
git add .claude/settings.local.json
git commit -m "Refactor component architecture

Simplified component hierarchy for better maintainability.
Updated Claude configuration with new component guidelines."
```
</correct>

<incorrect>
Forgetting to include CLAUDE.md:
```bash
git add src/main.py
git commit -m "Add new feature"
# Missing: git add CLAUDE.md (even though it was modified)
```

Forgetting to include settings:
```bash
git add src/api.ts
git commit -m "Update API client"  
# Missing: git add .claude/settings.local.json (even though it was modified)
```

Not checking for changes:
```bash
git add src/
git commit -m "Various updates"
# Missing: checking git status for Claude config file changes
```
</incorrect>
</examples>

<validation_steps>
Before every commit, verify:
1. [ ] Run `git status` to see all modified files
2. [ ] Check if CLAUDE.md appears in modified files
3. [ ] If CLAUDE.md modified, run `git add CLAUDE.md`
4. [ ] Check if .claude/settings.local.json appears in modified files
5. [ ] If settings.local.json modified, run `git add .claude/settings.local.json`
6. [ ] Proceed with normal commit process
7. [ ] Include context about configuration changes in commit message
</validation_steps>

<commit_message_guidance>
When including Claude configuration files:
- Mention configuration updates in the commit message
- Explain how the configuration relates to code changes
- Note any new guidelines or behavioral changes
- Reference configuration updates in the body text

Example:
```
Implement new validation system

Added form validation with custom error messages.
Updated CLAUDE.md with validation coding standards
and Claude settings to prefer validation libraries.
```
</commit_message_guidance>