---
applies_to:
  - file_patterns: []
  - contexts: ["gh", "github", "pr", "review", "analysis"]
  - actions: ["reviewing_pr", "analyzing_pr", "before_pr_review"]
timing: "before"
summary: "Always fetch comprehensive PR details using gh pr view and gh pr diff before starting any code analysis"
version: "1.0.0"
---

# Rule: Always Fetch PR Details First

<purpose>
This rule ensures that before performing any code analysis or review of a GitHub Pull Request, all necessary PR details are fetched using GitHub CLI commands to provide complete context for informed review decisions.
</purpose>

<instructions>
Before analyzing or reviewing ANY Pull Request, you MUST fetch comprehensive details:

1. **Fetch PR metadata and content**:
   ```bash
   gh pr view {number} --json title,body,files,reviews,comments
   ```

2. **Fetch PR diff for code changes**:
   ```bash
   gh pr diff {number}
   ```

3. **Parse and understand fetched information**:
   - Review PR title and description for context
   - Understand the scope of file changes
   - Review existing comments and feedback
   - Note any previous review decisions

4. **Block analysis until complete**:
   - Do not proceed with code analysis until all PR details are loaded
   - Ensure you have full context before making any review comments
   - Verify you understand the PR's purpose and scope

**This data fetching is MANDATORY before any review activity.**
</instructions>

<required_commands>
**Minimum required commands before PR review:**

```bash
# Essential PR details
gh pr view {pr_number} --json title,body,files,reviews,comments

# Code changes analysis  
gh pr diff {pr_number}
```

**Optional additional commands for complex PRs:**

```bash
# Detailed file changes
gh pr view {pr_number} --json additions,deletions,changedFiles

# Specific file content
gh pr diff {pr_number} --name-only
```
</required_commands>

<examples>
<correct>
Before reviewing PR #123:
```bash
# REQUIRED: Fetch PR details first
gh pr view 123 --json title,body,files,reviews,comments
gh pr diff 123

# Parse the information:
# - Title: "Add user authentication system" 
# - Files changed: auth.js, login.js, user-model.js
# - 2 previous reviews with feedback on security

# NOW ready to proceed with code analysis
# Review files with context of PR purpose and previous feedback
```

Before analyzing code changes:
```bash
# REQUIRED: Get complete picture first
gh pr view 456 --json title,body,files,reviews,comments
gh pr diff 456

# Understand scope before diving into code:
# - This is a bug fix for memory leak issue
# - Changes are isolated to memory management module
# - Previous reviewer noted concern about edge cases

# NOW can provide targeted analysis focused on memory management
```
</correct>

<incorrect>
Starting code analysis without context:
```bash
# ❌ WRONG - analyzing code without PR context
# Reading files directly without understanding PR scope
# Could miss important context about why changes were made
```

Partial information gathering:
```bash
# ❌ WRONG - only getting diff without metadata
gh pr diff 123
# Missing: purpose, previous reviews, discussion context
```

Assuming PR purpose without verification:
```bash
# ❌ WRONG - proceeding based on assumptions
# "This looks like a feature addition..."
# Must verify actual PR purpose via gh pr view
```
</incorrect>
</examples>

<information_parsing>
**What to extract from PR details:**

**From `gh pr view` JSON:**
- **title**: Understanding of main change purpose
- **body**: Detailed explanation, requirements, context
- **files**: Complete list of changed files for scope understanding
- **reviews**: Previous review decisions and feedback
- **comments**: Discussion context and clarifications

**From `gh pr diff`:**
- **Code changes**: Actual modifications for detailed analysis
- **Change patterns**: Additions, deletions, modifications
- **File context**: Understanding changes within file structure
- **Change complexity**: Scope and impact assessment
</information_parsing>

<blocking_mechanism>
**This rule BLOCKS analysis until information is gathered:**

```
IF attempting_pr_review:
    IF NOT pr_details_fetched:
        EXECUTE "gh pr view {number} --json title,body,files,reviews,comments"
        EXECUTE "gh pr diff {number}"
        PARSE pr_context and change_scope
        IF fetch_failed:
            STOP "Cannot review without PR context"
    PROCEED with informed code analysis
```

**NO PR ANALYSIS IS PERMITTED WITHOUT COMPLETE CONTEXT**
</blocking_mechanism>

<integration>
This rule works with:
- `gh-auth-always-switch-to-claude-hughes-before-commands.rule.md` for proper authentication
- All PR review analysis rules to provide necessary context
- PR comment rules to ensure informed feedback

This rule enables:
- Contextual code analysis based on PR purpose
- Informed review decisions considering previous feedback
- Appropriate scope of review based on change complexity
</integration>

<validation>
PR details fetching complete when:
- [ ] gh pr view command executed with JSON output
- [ ] gh pr diff command executed for code changes
- [ ] PR title and purpose understood
- [ ] Scope of file changes identified
- [ ] Previous reviews and comments reviewed
- [ ] Ready to proceed with informed code analysis
- [ ] All context necessary for quality review available
</validation>