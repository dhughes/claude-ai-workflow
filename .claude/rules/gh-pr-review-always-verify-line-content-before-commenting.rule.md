---
applies_to:
  - file_patterns: []
  - contexts: ["gh", "github", "pr", "review", "verification", "line_comments"]
  - actions: ["before_posting_line_comment", "verifying_code_content", "checking_line_accuracy"]
timing: "before"
summary: "Always use search tools to verify exact line content and context before posting line-specific comments"
version: "1.0.0"
---

# Rule: Always Verify Line Content Before Commenting

<purpose>
This rule ensures accuracy in line-specific code comments by requiring verification of exact line content and surrounding context using search tools before posting any line-specific feedback to prevent incorrect or outdated references.
</purpose>

<instructions>
Before posting ANY line-specific comment, you MUST verify the exact content:

1. **Use search tools to locate and verify code**:
   ```bash
   # Use Grep to find specific code patterns
   Grep pattern="specific_code_pattern" include="*.js"
   
   # Use Read tool to examine exact file content
   Read file_path="path/to/file.js" offset="line_number" limit="5"
   ```

2. **Verify line number accuracy**:
   - Confirm the exact line contains the code being referenced
   - Check surrounding context matches expectations
   - Account for any line number shifts from recent changes

3. **Validate code context**:
   - Understand function/method context around the line
   - Verify the code pattern matches what you're commenting on
   - Ensure the issue actually exists in the current code

4. **Cross-reference with PR diff**:
   - Confirm the line is part of the PR changes
   - Verify the line hasn't been modified since your analysis
   - Ensure comment relevance to the actual changes

**NO LINE-SPECIFIC COMMENTS without verified content accuracy.**
</instructions>

<verification_process>
**Step-by-step verification process:**

1. **Initial code identification**:
   ```bash
   # Find the suspected issue location
   Grep pattern="problematic_code_pattern" include="*.js"
   ```

2. **Exact content verification**:
   ```bash
   # Read specific lines with context
   Read file_path="src/problematic-file.js" offset="42" limit="10"
   ```

3. **Context understanding**:
   ```bash
   # Read broader function context if needed
   Read file_path="src/problematic-file.js" offset="35" limit="20"
   ```

4. **Cross-reference with PR changes**:
   ```bash
   # Verify line is in PR diff
   gh pr diff {number} -- src/problematic-file.js
   ```
</verification_process>

<accuracy_checks>
**What to verify before commenting:**

**Line Content Accuracy:**
- Exact code text matches your analysis
- Variable names and syntax are correct
- Function signatures match your assumptions
- Code patterns exist as described

**Context Accuracy:**
- Surrounding code provides proper context
- Function/method scope is understood correctly
- Variable definitions and usage are clear
- Control flow logic is properly analyzed

**Change Relevance:**
- Line is actually modified in the PR
- Change is substantive, not just formatting
- Issue exists in the new code, not old code
- Comment addresses the actual change impact
</accuracy_checks>

<examples>
<correct>
Before commenting on suspected SQL injection:
```bash
# Step 1: Search for the pattern
Grep pattern="SELECT.*FROM.*WHERE.*\+.*req\." include="*.js"

# Step 2: Read exact content
Read file_path="models/user.js" offset="30" limit="10"

# Step 3: Verify this shows:
# Line 32: const query = "SELECT * FROM users WHERE id = " + req.params.id;

# Step 4: Cross-reference with PR diff
gh pr diff 123 -- models/user.js

# NOW post accurate line-specific comment referencing line 32
gh api repos/owner/repo/pulls/123/comments \
  --field body="SQL Injection Risk: Line concatenates user input directly into query..." \
  --field path="models/user.js" \
  --field line="32"
```

Before commenting on performance issue:
```bash
# Step 1: Find the loop pattern
Grep pattern="for.*in.*await" include="*.js"

# Step 2: Examine exact code
Read file_path="services/processor.js" offset="65" limit="8"

# Step 3: Verify shows:
# Line 67: for (const item of items) {
# Line 68:   const result = await processItem(item);

# Step 4: Confirm it's in PR changes
gh pr diff 456 -- services/processor.js

# NOW post accurate comment about N+1 performance issue
```
</correct>

<incorrect>
Commenting without verification:
```bash
# ❌ WRONG - posting comment based on assumption
gh api repos/owner/repo/pulls/123/comments \
  --field body="SQL injection on line 32" \
  --field path="models/user.js" \
  --field line="32"
# Should verify line 32 actually contains SQL code first
```

Using outdated line references:
```bash
# ❌ WRONG - referencing line numbers from old version
# Comment based on previous code analysis without re-verification
# Line numbers may have changed with new commits
```

Vague pattern matching:
```bash
# ❌ WRONG - assuming code pattern without reading exact content
# "There's probably a SQL injection in user.js somewhere around line 30-35"
# Must verify exact line and content
```
</incorrect>
</examples>

<search_tool_usage>
**How to use search tools effectively:**

**Grep for pattern discovery:**
```bash
# Security patterns
Grep pattern="SELECT.*\+.*req\." include="*.js"
Grep pattern="innerHTML.*=.*req\." include="*.js"

# Performance patterns
Grep pattern="for.*await" include="*.js"  
Grep pattern="\.map.*await" include="*.js"

# Logic patterns
Grep pattern="<=.*\.length" include="*.js"
Grep pattern="if.*=.*null" include="*.js"
```

**Read for exact verification:**
```bash
# Read specific area around suspected issue
Read file_path="target/file.js" offset="suspected_line_minus_5" limit="10"

# Read broader context if needed
Read file_path="target/file.js" offset="function_start" limit="entire_function_length"
```
</search_tool_usage>

<integration>
This rule works with:
- `gh-pr-review-always-use-line-specific-comments-for-code-issues.rule.md` for accuracy
- `gh-pr-review-always-fetch-pr-details-first.rule.md` for context
- All PR analysis rules to ensure accurate feedback

This rule prevents:
- Comments on non-existent code issues
- Incorrect line number references  
- Outdated or irrelevant feedback
- Confusion from inaccurate code references
</integration>

<validation>
Line content verification complete when:
- [ ] Search tools used to locate suspected code pattern
- [ ] Read tool used to examine exact line content
- [ ] Line number and content confirmed accurate
- [ ] Surrounding context understood and verified
- [ ] PR diff cross-referenced to confirm relevance
- [ ] Code issue actually exists as described
- [ ] Ready to post accurate line-specific comment
</validation>