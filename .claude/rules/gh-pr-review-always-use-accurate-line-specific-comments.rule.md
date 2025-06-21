---
applies_to:
  - file_patterns: []
  - contexts: ["gh", "github", "pr", "review", "comments"]
  - actions: ["reviewing_pr"]
timing: "during"
summary: "Choose appropriate comment type - line-specific for code issues, general for overarching feedback"
version: "1.0.0"
---

# Rule: Always Choose Appropriate Comment Type

<purpose>
This rule ensures that feedback is placed using the most appropriate GitHub comment type - line-specific comments for code-related issues and general PR comments for overarching feedback - with mandatory content verification for line-specific comments.
</purpose>

<instructions>
For ALL technical code feedback, you MUST:

1. **Use Line-Specific Comments**: Never use general PR comments for code-specific issues
2. **Verify Target Content**: Always search and verify line content before commenting
3. **Follow Content-First Workflow**: Search → Verify → Read Context → Comment

**MANDATORY WORKFLOW:**
```bash
# STEP 1: Search for the specific content you want to comment on
Grep pattern="your_target_content" path="target/file.ext"

# STEP 2: Verify line numbers and read context  
Read file_path="target/file.ext" offset=[found_line - 3] limit=7

# STEP 3: Confirm content matches your comment intent
# STEP 4: Post comment with verified line numbers
gh api repos/:owner/:repo/pulls/{number}/comments -X POST \
  -f body="{verified_feedback}" \
  -f commit_id="{sha}" \
  -f path="{verified_filename}" \
  -f side="RIGHT" \
  -F line={verified_line_number}
```
</instructions>

<when_to_use_line_specific>
**ALWAYS use line-specific comments for:**
- Logic errors in specific code
- Security vulnerabilities  
- Performance issues
- Maintainability problems
- Missing error handling
- Code style violations
- Refactoring suggestions

**NEVER use general PR comments for:**
- Issues tied to specific lines of code
- Code that can be pointed to directly
- Technical implementation feedback

**USE general PR comments ONLY for:**
- Overall PR structure/organization
- Process-related feedback
- Summary of review findings
- Approval/rejection decisions
</when_to_use_line_specific>

<content_verification>
**Before posting ANY line-specific comment:**

1. **Search for Target Content**:
   ```bash
   # Find exact code/text you want to comment on
   Grep pattern="specific_pattern" include="*.ext" path="."
   ```

2. **Verify Location**:
   ```bash
   # Read around the found location
   Read file_path="found/file.ext" offset=[line - 5] limit=10
   ```

3. **Content Verification Checklist**:
   - [ ] Target line(s) contain the content I'm discussing
   - [ ] Surrounding context makes my comment relevant
   - [ ] This is the correct instance (if multiple matches)
   - [ ] Comment directly relates to what's on these lines

**NEVER guess line numbers or post without content verification!**
</content_verification>

<api_syntax>
**GitHub API comment syntax:**

**Single-line comment:**
```bash
gh api repos/:owner/:repo/pulls/{number}/comments -X POST \
  -f body="{comment_text}" \
  -f commit_id="{commit_sha}" \
  -f path="{file_path}" \
  -f side="RIGHT" \
  -F line={line_number}
```

**Multi-line comment:**
```bash
gh api repos/:owner/:repo/pulls/{number}/comments -X POST \
  -f body="{comment_text}" \
  -f commit_id="{commit_sha}" \
  -f path="{file_path}" \
  -f side="RIGHT" \
  -F start_line={start_line} \
  -F line={end_line}
```

**Comment on deleted code:**
```bash
gh api repos/:owner/:repo/pulls/{number}/comments -X POST \
  -f body="{comment_text}" \
  -f commit_id="{commit_sha}" \
  -f path="{file_path}" \
  -f side="LEFT" \
  -F line={original_line_number}
```

**Required parameters:**
- `body`: Comment text (use `-f` flag)
- `commit_id`: Commit SHA (use `-f` flag) 
- `path`: File path relative to repo root (use `-f` flag)
- `side`: "RIGHT" for new/modified lines, "LEFT" for deleted lines (use `-f` flag)
- `line`: Line number (use `-F` flag for integer)
</api_syntax>

<search_strategies>
**How to find content for different issue types:**

**Code Logic Issues:**
```bash
Grep pattern="function_name\|variable_name" include="*.js,*.py"
Grep pattern="if.*condition" include="*.java"
```

**Security Issues:**
```bash
Grep pattern="eval\(" include="*.js"
Grep pattern="SELECT.*\+.*WHERE" include="*.py,*.sql"
Grep pattern="innerHTML.*=" include="*.js"
```

**Performance Issues:**
```bash  
Grep pattern="for.*in.*for\|forEach.*forEach" include="*.js"
Grep pattern="\.find\(" include="*.js"
Grep pattern="O\(n" include="*.py,*.js"
```

**Style/Documentation Issues:**
```bash
Grep pattern="TODO\|FIXME" include="*"
Grep pattern="function.*\{" include="*.js"
```
</search_strategies>

<examples>
<correct>
Proper verification and commenting workflow:
```bash
# 1. Search for performance issue
Grep pattern="users\.find" path="src/order-service.js"
# Found: Line 47: const user = users.find(u => u.id === order.userId);

# 2. Verify context
Read file_path="src/order-service.js" offset=44 limit=7
# Confirmed: Lines 45-52 show nested loop with inefficient user lookup

# 3. Post verified comment
gh api repos/:owner/:repo/pulls/123/comments -X POST \
  -f body="**SUGGESTION:** Performance Issue - O(n²) lookup could be optimized to O(n)

Nested loop searches through all users for each order, creating quadratic complexity.

Current code:
\`\`\`javascript
orders.forEach(order => {
  const user = users.find(u => u.id === order.userId);
  order.userName = user.name;
});
\`\`\`

Suggested optimization:
\`\`\`javascript  
const userMap = new Map(users.map(u => [u.id, u]));
orders.forEach(order => {
  const user = userMap.get(order.userId);
  order.userName = user?.name;
});
\`\`\`

Impact: With 1000 orders and 1000 users, reduces from 1M operations to 2000." \
  -f commit_id="abc123..." \
  -f path="src/order-service.js" \
  -f side="RIGHT" \
  -F line=47
```
</correct>

<incorrect>
Posting without verification:
```bash
# ❌ WRONG - guessing line numbers
gh api repos/:owner/:repo/pulls/123/comments -X POST \
  -f body="This algorithm is inefficient" \
  -f commit_id="abc123..." \
  -f path="src/file.js" \
  -f side="RIGHT" \
  -F line=50  # Never verified what's on line 50!
```

Using general PR comment for code issue:
```bash
# ❌ WRONG - should be line-specific
gh pr comment 123 --body "The loop in file.js line 50 is inefficient"
```

Commenting without context verification:
```bash
# ❌ WRONG - found content but didn't verify context
Grep pattern="algorithm" path="file.md"
# Found on line 80, immediately commented on line 80
# But line 80 was in a documentation example, not actual implementation
```
</incorrect>
</examples>

<error_handling>
**Common GitHub API errors and solutions:**

**"Invalid request" (HTTP 422):**
- Missing required parameters (commit_id, line, etc.)
- Wrong parameter types (use -F for integers, -f for strings)
- Line number doesn't exist in the diff

**"No subschema matched":**
- Invalid side parameter (must be "RIGHT" or "LEFT")
- Missing positioning information

**Rate limiting (HTTP 403):**
- Too many API calls in short period
- Solution: Add delays between comments

**Authentication failure (HTTP 401):**
- Invalid GitHub token
- Solution: Check `gh auth status` and re-authenticate

**Validation before posting:**
```bash
# Verify commit SHA
gh api repos/:owner/:repo/pulls/{number} --jq '.head.sha'

# Verify file exists in PR
gh api repos/:owner/:repo/pulls/{number}/files --jq '.[].filename' | grep "target-file"
```
</error_handling>

<quality_assurance>
**Before posting any comment, verify:**

1. **Content Accuracy**: Target line contains what I'm commenting about
2. **Contextual Relevance**: Surrounding lines make my comment appropriate here  
3. **Specificity**: Commenting on the right instance if multiple similar lines exist
4. **Reader Experience**: Someone reading this will understand why it's placed here
5. **API Accuracy**: Line numbers, file paths, and parameters are all verified

**If uncertain about any of these, re-search and re-verify before posting.**
</quality_assurance>

<integration>
This rule replaces and consolidates:
- `gh-pr-review-always-use-line-specific-comments.rule.md`
- `gh-pr-review-always-verify-line-content-before-commenting.rule.md`

All other PR review rules should follow this rule's workflow when posting feedback.
</integration>

<validation>
Accurate line-specific commenting achieved when:
- [ ] All code feedback uses line-specific comments (not general PR comments)
- [ ] Target content was located using search tools
- [ ] Line numbers were verified by reading the file
- [ ] Surrounding context was checked for relevance
- [ ] Comment content directly relates to target lines
- [ ] GitHub API parameters are all verified correct
- [ ] Comments enhance rather than confuse the review
</validation>