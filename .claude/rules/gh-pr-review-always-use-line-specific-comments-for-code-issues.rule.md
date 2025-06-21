---
applies_to:
  - file_patterns: []
  - contexts: ["gh", "github", "pr", "review", "comments", "code_feedback"]
  - actions: ["posting_code_feedback", "commenting_on_code", "providing_line_feedback"]
timing: "before"
summary: "Always use line-specific comments via GitHub API for code-related issues rather than general PR comments"
version: "1.0.0"
---

# Rule: Always Use Line-Specific Comments For Code Issues

<purpose>
This rule ensures that feedback related to specific lines of code is posted as line-specific review comments attached to the exact code location, rather than as general PR comments, providing precise context and better developer experience.
</purpose>

<instructions>
When providing feedback about specific code, you MUST use line-specific comments:

1. **Identify if feedback is code-specific**:
   - Issues with specific lines, functions, or code blocks
   - Logic errors in particular code sections
   - Security vulnerabilities in specific code
   - Performance issues in particular implementations
   - Style violations in specific lines

2. **Use GitHub API for line-specific comments**:
   ```bash
   gh api repos/:owner/:repo/pulls/{number}/comments \
     --method POST \
     --field body="Your detailed feedback here" \
     --field commit_sha="latest_commit_sha" \
     --field path="relative/file/path" \
     --field line="{line_number}"
   ```

3. **Never use general PR comments for code-specific issues**:
   - Do NOT use `gh pr comment` for line-specific feedback
   - Reserve general comments for architectural/process feedback
   - Ensure precision in feedback location

4. **Verify exact positioning**:
   - Confirm line numbers are accurate
   - Ensure file paths are correct
   - Validate commit SHA matches current PR state

**Line-specific feedback MUST be attached to the specific code location.**
</instructions>

<code_specific_feedback_types>
**What qualifies as code-specific feedback:**

**Logic Issues:**
- Off-by-one errors in loops
- Incorrect conditional logic
- Unreachable code blocks
- Algorithm implementation problems

**Security Issues:**
- SQL injection vulnerabilities
- XSS attack vectors
- Authentication bypass attempts
- Data exposure risks

**Performance Issues:**
- Inefficient algorithms in specific functions
- Memory leaks in particular code sections
- Unnecessary database queries
- Resource management problems

**Style/Maintainability:**
- Naming convention violations
- Code complexity in specific functions
- Missing error handling
- Documentation gaps for specific methods
</code_specific_feedback_types>

<api_usage_examples>
**Correct line-specific comment posting:**

```bash
# For security issue in auth.js line 45
gh api repos/owner/repo/pulls/123/comments \
  --method POST \
  --field body="Security issue: This authentication check can be bypassed by passing null. Consider using strict equality (===) instead of loose equality (==)." \
  --field commit_sha="abc123def456" \
  --field path="src/auth.js" \
  --field line="45"
```

```bash
# For performance issue in database.js line 78
gh api repos/owner/repo/pulls/123/comments \
  --method POST \
  --field body="Performance concern: This query runs inside a loop and could cause N+1 problem. Consider batching queries or using joins." \
  --field commit_sha="abc123def456" \
  --field path="src/database.js" \
  --field line="78"
```
</api_usage_examples>

<examples>
<correct>
Reviewing code with security issue:
```bash
# Found SQL injection vulnerability in user.js line 32
# CORRECT: Use line-specific comment
gh api repos/owner/repo/pulls/123/comments \
  --method POST \
  --field body="SQL Injection Risk: User input is directly concatenated into query. Use parameterized queries instead: SELECT * FROM users WHERE id = ?" \
  --field commit_sha="latest_sha" \
  --field path="models/user.js" \
  --field line="32"
```

Providing logic error feedback:
```bash
# Found off-by-one error in loop condition
# CORRECT: Attach to specific line
gh api repos/owner/repo/pulls/456/comments \
  --method POST \
  --field body="Off-by-one error: Loop condition should be 'i < array.length' not 'i <= array.length' to avoid accessing undefined index." \
  --field commit_sha="def789ghi012" \
  --field path="utils/processor.js" \
  --field line="67"
```
</correct>

<incorrect>
Using general PR comments for code-specific feedback:
```bash
# ❌ WRONG - general comment for specific code issue
gh pr comment 123 --body "There's a SQL injection issue in user.js line 32"
# Should be line-specific comment instead
```

Vague location in general comment:
```bash
# ❌ WRONG - imprecise feedback location
gh pr comment 456 --body "The loop in processor.js has an off-by-one error somewhere"
# Should identify exact line and attach comment there
```

Mixed feedback types in single comment:
```bash
# ❌ WRONG - combining specific and general feedback
gh pr comment 789 --body "Line 45 has security issue, and overall architecture needs improvement"
# Split into line-specific and general comments
```
</incorrect>
</examples>

<verification_requirements>
**Before posting line-specific comments:**

1. **Verify file path accuracy**:
   - Use exact relative path from repository root
   - Confirm file exists in PR changes
   - Check path format matches GitHub expectations

2. **Confirm line number precision**:
   - Count lines accurately from file start
   - Account for any line number changes in PR
   - Verify line contains the code being referenced

3. **Validate commit SHA**:
   - Use latest commit SHA from PR
   - Ensure SHA exists and is accessible
   - Confirm commit contains the referenced code

4. **Test API call format**:
   - Verify all required fields are present
   - Check field values are properly formatted
   - Ensure authentication is working
</verification_requirements>

<integration>
This rule works with:
- `gh-pr-review-always-verify-line-content-before-commenting.rule.md` for accuracy
- `gh-pr-review-always-use-general-comments-for-architectural-feedback.rule.md` for proper separation
- `gh-auth-always-switch-to-claude-hughes-before-commands.rule.md` for authentication

This rule ensures:
- Precise feedback location for developers
- Clear separation between code and process feedback
- Better developer experience with contextual comments
- Improved code review quality and actionability
</integration>

<validation>
Line-specific comment posting complete when:
- [ ] Code-specific feedback identified and categorized
- [ ] File path and line number verified for accuracy
- [ ] Latest commit SHA obtained and validated
- [ ] GitHub API call properly formatted with all required fields
- [ ] Comment posted successfully to specific code location
- [ ] Feedback is actionable and precisely located
- [ ] No code-specific feedback posted as general PR comments
</validation>