---
applies_to:
  - file_patterns: []
  - contexts: ["gh", "github", "pr", "review"]
  - actions: ["reviewing_pr"]
timing: "before"
summary: "MANDATORY: Always fetch PR description, files, and context before starting review - NO EXCEPTIONS"
version: "1.1.0"
---

# Rule: Always Fetch PR Details First

<purpose>
This rule ensures that before conducting any PR review, all necessary context is gathered including the PR description, changed files, commit history, and diff information to provide comprehensive and informed feedback.
</purpose>

<instructions>
**🚨 MANDATORY EXECUTION - NO BYPASSING ALLOWED 🚨**

Before reviewing any PR, you MUST gather this information in sequence:

1. **Fetch PR metadata**: Use `gh api repos/:owner/:repo/pulls/{number}` to get:
   - PR title and description
   - Author information
   - Target and source branches
   - PR status and labels

2. **Get changed files**: Use `gh api repos/:owner/:repo/pulls/{number}/files` to get:
   - List of all modified files
   - Addition/deletion counts
   - File status (added, modified, deleted, renamed)
   - Raw diff content

3. **Analyze PR scope**: Review the description to understand:
   - Purpose and motivation for changes
   - Expected behavior changes
   - Any special testing or deployment considerations
   - Related issues or dependencies

**THIS CONTEXT GATHERING IS STRICTLY MANDATORY - NEVER SKIP OR BYPASS**

❌ **STRICTLY FORBIDDEN:** Starting review without gathering full context
❌ **STRICTLY FORBIDDEN:** Making assumptions about PR content
❌ **STRICTLY FORBIDDEN:** Proceeding to comments without API data
❌ **STRICTLY FORBIDDEN:** Providing any feedback before data collection

✅ **REQUIRED:** Complete information gathering before ANY review activity
</instructions>

<context_requirements>
**Essential information to collect:**
- PR description and purpose
- Complete list of changed files with diffs
- Commit SHA for accurate line referencing
- Any linked issues or related PRs
- Branch context (feature branch → main, etc.)

**Use this information to:**
- Understand the scope and intent of changes
- Identify files that need detailed review
- Plan which areas require line-specific comments
- Ensure review feedback aligns with PR objectives
</context_requirements>

<api_commands>
**Required commands before review:**

```bash
# Get PR details
gh api repos/:owner/:repo/pulls/{number}

# Get changed files and diffs
gh api repos/:owner/:repo/pulls/{number}/files

# Get commit SHA for comment targeting
gh api repos/:owner/:repo/pulls/{number} --jq '.head.sha'
```

**Parse the response to extract:**
- `title` and `body` from PR details
- `filename`, `status`, `patch` from files
- `sha` for comment commit targeting
</api_commands>

<examples>
<correct>
Starting PR #45 review:
```bash
# Step 1: Get PR details
gh api repos/:owner/:repo/pulls/45

# Step 2: Get file changes
gh api repos/:owner/:repo/pulls/45/files

# Step 3: Get commit SHA
gh api repos/:owner/:repo/pulls/45 --jq '.head.sha'
# Returns: "a1b2c3d4..."

# Now ready to review with full context
```
</correct>

<incorrect>
Starting review without context:
```bash
# ❌ WRONG - jumping straight to comments without understanding changes
gh api repos/:owner/:repo/pulls/45/comments -X POST -f body="Looks good"
```
</incorrect>
</examples>

<integration>
This rule must complete successfully before applying any other PR review rules. The gathered information becomes input for:
- `gh-pr-review-always-check-against-project-patterns.rule.md`
- `gh-pr-review-always-comment-on-logic-issues.rule.md`
- All other review-specific rules
</integration>

<validation>
Before proceeding with review, verify you have:
- [ ] PR title, description, and metadata
- [ ] Complete list of changed files
- [ ] Diff content for each changed file
- [ ] Commit SHA for comment targeting
- [ ] Understanding of PR purpose and scope
</validation>