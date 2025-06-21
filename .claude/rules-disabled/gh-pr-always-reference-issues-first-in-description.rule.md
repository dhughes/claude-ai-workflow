---
applies_to:
  - file_patterns: []
  - contexts: ["gh", "github", "pr", "issues"]
  - actions: ["creating_pr_with_associated_issue"]
timing: "before"
summary: "Always reference associated GitHub issues first in PR descriptions using closing keywords"
version: "1.0.0"
---

# Rule: Always Reference Issues First in PR Description

<purpose>
This rule ensures that when a pull request is associated with a GitHub issue, the issue is properly referenced at the beginning of the PR description using appropriate closing keywords to enable automatic issue closure.
</purpose>

<instructions>
When creating a PR that has an associated GitHub issue, you MUST:

1. PLACE the issue reference at the very beginning of the PR description
2. USE appropriate closing keywords followed by the issue number
3. FORMAT as: `KEYWORD #ISSUE-NUMBER`

Closing keywords (case-insensitive):
- `close`, `closes`, `closed`
- `fix`, `fixes`, `fixed`  
- `resolve`, `resolves`, `resolved`

This applies when:
- PR addresses a specific GitHub issue
- PR should automatically close the issue when merged
- Issue is in the same repository as the PR
</instructions>

<keyword_usage>
Choose appropriate keywords based on context:
- **Fixes**: For bug fixes (e.g., `Fixes #123`)
- **Resolves**: For feature requests or enhancements (e.g., `Resolves #456`)
- **Closes**: General purpose or neutral context (e.g., `Closes #789`)

All keywords automatically close the linked issue when the PR is merged into the default branch.
</keyword_usage>

<formatting_rules>
1. **Placement**: Issue reference must be the FIRST line of PR description
2. **Format**: `KEYWORD #NUMBER` (space before #, no space after)
3. **Case**: Keywords can be lowercase, uppercase, or mixed case
4. **Multiple issues**: Use separate lines for each issue
</formatting_rules>

<examples>
<correct>
Single issue reference:
```
Fixes #123

## Purpose
This PR implements user authentication...
```

Multiple issues:
```
Resolves #456
Fixes #789

## Purpose
This PR addresses multiple authentication issues...
```

Different keywords:
```
Closes #101

## Purpose
General enhancement to improve performance...
```
</correct>

<incorrect>
Issue reference not first:
```
## Purpose
This PR fixes the login bug.

Fixes #123  # Should be first
```

Wrong format:
```
Fixes: #123  # Colon not required
Fix #123     # Should be "Fixes"
Fixes#123    # Missing space before #
```

No keyword:
```
#123

## Purpose
...  # Missing closing keyword
```
</incorrect>
</examples>

<cross_repository_references>
For issues in different repositories, use full format:
```
Fixes owner/repository#123

## Purpose
...
```

Example:
```
Resolves dhughes/other-repo#456

## Purpose
...
```
</cross_repository_references>

<validation>
When creating PRs with associated issues:
- [ ] Issue reference is the first line of PR description
- [ ] Uses appropriate closing keyword (fixes/resolves/closes)
- [ ] Follows correct format: `KEYWORD #NUMBER`
- [ ] Issue number is correct and exists
- [ ] No syntax errors in the reference
- [ ] Multiple issues each have their own line and keyword
</validation>

<automatic_behavior>
When PR with proper issue reference is merged:
- Referenced issue will be automatically closed
- PR will be listed as the closing PR on the issue
- Issue timeline will show the connection
- Both PR and issue will be linked in GitHub interface
</automatic_behavior>