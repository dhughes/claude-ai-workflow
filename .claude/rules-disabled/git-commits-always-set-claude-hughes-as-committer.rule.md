---
applies_to:
  - file_patterns: []
  - contexts: ["git", "commits", "identity", "committer"]
  - actions: ["before_commit"]
timing: "before"
summary: "Always set git committer identity to Claude Hughes before any commit operations"
version: "1.0.0"
---

# Rule: Always Set Claude Hughes as Committer

<purpose>
This rule ensures that git commits show Claude Hughes as both the author and committer, providing consistent identity attribution in GitHub and git history by setting the proper git configuration before committing.
</purpose>

<instructions>
Before EVERY git commit operation, you MUST:

1. **Set git committer identity**: Configure git user.name and user.email to Claude Hughes
2. **Use consistent commit command**: Continue using --author flag for completeness
3. **Verify identity**: Ensure both author and committer will show as Claude Hughes

Commands to run before each commit:
```bash
git config user.name "Claude Hughes"
git config user.email "doug+ai@doughughes.net"
```

Then commit with author flag as usual:
```bash
git commit --author="Claude Hughes <doug+ai@doughughes.net>" -m "commit message"
```

This ensures both the committer (from git config) and author (from --author flag) are set to Claude Hughes.
</instructions>

<identity_configuration>
**Required git configuration:**
- **Name**: "Claude Hughes"
- **Email**: "doug+ai@doughughes.net"
- **Scope**: Repository-local (not global to avoid affecting other projects)

**Commands to execute:**
```bash
# Set repository-local git identity before commits
git config user.name "Claude Hughes"
git config user.email "doug+ai@doughughes.net"

# Then commit with author flag for consistency
git commit --author="Claude Hughes <doug+ai@doughughes.net>" -m "message"
```
</identity_configuration>

<commit_workflow>
**Complete commit workflow:**

1. **Configure identity**: Set git config for committer
2. **Stage files**: Add files with `git add`
3. **Create commit**: Use commit command with author flag
4. **Verify identity**: Both author and committer should be Claude Hughes

**Before each commit:**
```bash
git config user.name "Claude Hughes"
git config user.email "doug+ai@doughughes.net"
git add [files]
git commit --author="Claude Hughes <doug+ai@doughughes.net>" -m "message"
```
</commit_workflow>

<github_display>
**Expected GitHub display:**
- **Author**: Claude Hughes (from --author flag)
- **Committer**: Claude Hughes (from git config)
- **GitHub user**: claude-hughes (based on SSH key association)

This ensures consistent attribution across all git interfaces and GitHub displays.
</github_display>

<examples>
<correct>
Proper commit sequence:
```bash
git config user.name "Claude Hughes"
git config user.email "doug+ai@doughughes.net"
git add src/component.tsx
git commit --author="Claude Hughes <doug+ai@doughughes.net>" -m "Add new component"
# Result: Both author and committer show as Claude Hughes
```

After configuration, subsequent commits:
```bash
# Config persists for repository
git add tests/component.test.tsx
git commit --author="Claude Hughes <doug+ai@doughughes.net>" -m "Add component tests"
# Result: Consistent Claude Hughes attribution
```
</correct>

<incorrect>
Committing without setting git config:
```bash
# Missing git config setup
git commit --author="Claude Hughes <doug+ai@doughughes.net>" -m "Add feature"
# Result: Author=Claude Hughes, Committer=dhughes (inconsistent)
```

Setting global config instead of local:
```bash
git config --global user.name "Claude Hughes"  # Affects all repos
git commit --author="Claude Hughes <doug+ai@doughughes.net>" -m "Add feature"
# Problem: Changes global git config for all projects
```
</incorrect>
</examples>

<verification>
**Check git configuration:**
```bash
git config user.name     # Should return: Claude Hughes
git config user.email    # Should return: doug+ai@doughughes.net
```

**Check recent commit attribution:**
```bash
git log --format="%an <%ae> | %cn <%ce>" -1
# Should show: Claude Hughes <doug+ai@doughughes.net> | Claude Hughes <doug+ai@doughughes.net>
```
</verification>

<persistence>
**Git config persistence:**
- Configuration is set per repository (not global)
- Persists for all subsequent commits in this repository
- Does not affect other git repositories on the system
- Should be set once per repository, but rule ensures it's always current

**Why set before each commit:**
- Ensures configuration is always correct
- Handles cases where repository is freshly cloned
- Provides consistency across different environments
- Low overhead to verify/set configuration
</persistence>

<troubleshooting>
**If attribution still shows incorrectly:**

1. **Check current config:**
   ```bash
   git config --list | grep user
   ```

2. **Verify SSH key association:**
   - Ensure SSH key is associated with claude-hughes GitHub account
   - Check authentication with `gh auth status`

3. **Confirm commit details:**
   ```bash
   git show --format=fuller HEAD
   ```

4. **Re-set configuration if needed:**
   ```bash
   git config user.name "Claude Hughes"
   git config user.email "doug+ai@doughughes.net"
   ```
</troubleshooting>