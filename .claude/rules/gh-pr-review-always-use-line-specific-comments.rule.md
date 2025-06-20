---
applies_to:
  - file_patterns: []
  - contexts: ["gh", "github", "pr", "review", "comments"]
  - actions: ["reviewing_pr"]
timing: "during"
summary: "Place technical feedback on specific lines using GitHub API instead of general PR comments"
version: "1.0.0"
---

# Rule: Always Use Line-Specific Comments

<purpose>
This rule ensures that technical feedback is placed directly on the relevant code lines using GitHub's line-specific comment API, making feedback more contextual and actionable rather than using general PR-level comments.
</purpose>

<instructions>
When providing code review feedback, ALWAYS use line-specific comments:

**CRITICAL: Before posting any comment, you MUST verify the target line content using search/read tools. Never guess line numbers!**

1. **Individual Line Comments**: For single-line issues:
   ```bash
   gh api repos/:owner/:repo/pulls/{number}/comments -X POST \
     -f body="{feedback}" \
     -f commit_id="{sha}" \
     -f path="{filename}" \
     -f side="RIGHT" \
     -F line={line_number}
   ```

2. **Multi-Line Comments**: For issues spanning multiple lines:
   ```bash
   gh api repos/:owner/:repo/pulls/{number}/comments -X POST \
     -f body="{feedback}" \
     -f commit_id="{sha}" \
     -f path="{filename}" \
     -f side="RIGHT" \
     -F start_line={start} \
     -F line={end}
   ```

3. **Comments on Deleted Code**: For issues with removed code:
   ```bash
   gh api repos/:owner/:repo/pulls/{number}/comments -X POST \
     -f body="{feedback}" \
     -f commit_id="{sha}" \
     -f path="{filename}" \
     -f side="LEFT" \
     -F line={original_line_number}
   ```

4. **NEVER use general PR comments** for specific code issues - always tie feedback to exact lines.

**Line Content Verification Workflow:**
```bash
# STEP 1: Search for the content you want to comment on
Grep pattern="specific_content_pattern" path="target/file.ext"

# STEP 2: Verify the line numbers and read context
Read file_path="target/file.ext" offset=[found_line - 3] limit=7

# STEP 3: Confirm the content matches your comment intent
# STEP 4: ONLY THEN post the comment with verified line numbers
```
</instructions>

<api_parameters>
**Required parameters for line comments:**

**Basic Parameters:**
- `body`: The comment text (use `-f` flag)
- `commit_id`: The commit SHA (use `-f` flag)
- `path`: The file path relative to repo root (use `-f` flag)
- `side`: "RIGHT" for new/modified lines, "LEFT" for original/deleted lines (use `-f` flag)
- `line`: The line number for single-line comments (use `-F` flag for integer)

**Multi-line Parameters:**
- `start_line`: Starting line number (use `-F` flag for integer)
- `line`: Ending line number (use `-F` flag for integer)
- Both must be on the same `side`

**Getting Required Values:**
```bash
# Get commit SHA
COMMIT_SHA=$(gh api repos/:owner/:repo/pulls/{number} --jq '.head.sha')

# Get file paths and line numbers from files API
gh api repos/:owner/:repo/pulls/{number}/files --jq '.[].filename'
```
</api_parameters>

<when_to_use_each_type>
**Line-specific comments for:**
- Logic errors in specific code
- Security vulnerabilities
- Performance issues
- Maintainability problems
- Missing error handling
- Code style violations
- Refactoring suggestions

**Multi-line comments for:**
- Issues spanning multiple related lines
- Function or method-level problems
- Code blocks that work together
- Complex logic that needs overall feedback

**Comments on deleted code for:**
- Explaining why deletion is good/bad
- Noting important functionality being removed
- Suggesting alternatives to deleted code
- Pointing out missing error handling that was removed
</when_to_use_each_type>

<comment_targeting>
**How to target comments accurately:**

**For Added Lines (side="RIGHT"):**
- Use the new line numbers as they appear in the diff
- These are lines marked with `+` in the patch
- Line numbers count from 1 in the new file version

**For Deleted Lines (side="LEFT"):**
- Use the original line numbers from before the change
- These are lines marked with `-` in the patch
- Line numbers count from 1 in the original file version

**For Modified Lines:**
- Comment on the RIGHT side (new version) for most cases
- Comment on LEFT side only if discussing what was removed
- Use multi-line spans to cover before/after of modifications

**Example Line Mapping:**
```
@@ -10,7 +10,8 @@
     function oldCode() {
-        return "old implementation";  // LEFT side, line 11
+        return "new implementation";  // RIGHT side, line 11
+        console.log("added line");    // RIGHT side, line 12
     }
```
</comment_targeting>

<examples>
<correct>
Single-line comment on performance issue:
```bash
# Commenting on inefficient loop at line 45
gh api repos/:owner/:repo/pulls/123/comments -X POST \
  -f body="Performance issue: O(n²) nested loop creates 1M operations with 1000 items. Consider using Map lookup for O(n) complexity." \
  -f commit_id="a1b2c3d4..." \
  -f path="src/user-service.js" \
  -f side="RIGHT" \
  -F line=45
```

Multi-line comment on function with multiple issues:
```bash
# Commenting on function spanning lines 23-35
gh api repos/:owner/:repo/pulls/123/comments -X POST \
  -f body="Maintainability issues: Function mixes validation, transformation, and persistence. Consider extracting validateInput(), transformData(), and saveRecord() methods." \
  -f commit_id="a1b2c3d4..." \
  -f path="src/data-processor.py" \
  -f side="RIGHT" \
  -F start_line=23 \
  -F line=35
```

Comment on deleted code:
```bash
# Commenting on removed error handling at original line 28
gh api repos/:owner/:repo/pulls/123/comments -X POST \
  -f body="Removed error handling: This try-catch block handled database connection failures. Consider adding equivalent error handling in the new implementation." \
  -f commit_id="a1b2c3d4..." \
  -f path="src/database.py" \
  -f side="LEFT" \
  -F line=28
```
</correct>

<incorrect>
Using general PR comment for specific code issue:
```bash
# ❌ WRONG - should be line-specific comment instead
gh pr comment 123 --body "The loop in user-service.js is inefficient"
```

Wrong side parameter:
```bash
# ❌ WRONG - using LEFT side for new code
gh api repos/:owner/:repo/pulls/123/comments -X POST \
  -f body="New code comment" \
  -f commit_id="a1b2c3d4..." \
  -f path="src/file.js" \
  -f side="LEFT" \  # Should be "RIGHT" for new code
  -F line=45
```

Missing commit_id parameter:
```bash
# ❌ WRONG - missing required commit_id
gh api repos/:owner/:repo/pulls/123/comments -X POST \
  -f body="Comment text" \
  -f path="src/file.js" \
  -f side="RIGHT" \
  -F line=45
```
</incorrect>
</examples>

<error_handling>
**Common API errors and solutions:**

**"Invalid request" error:**
- Check that all required parameters are present
- Verify commit_id is correct SHA
- Ensure line number exists in the diff
- Confirm path matches exact filename

**"No subschema matched" error:**
- Missing required parameters (commit_id, line, etc.)
- Wrong parameter types (use -F for integers, -f for strings)
- Invalid side value (must be "RIGHT" or "LEFT")

**"Line not found" error:**
- Line number doesn't exist in the diff
- Wrong side for the line (LEFT vs RIGHT)
- Commit SHA doesn't match the PR head

**Validation before commenting:**
```bash
# Verify commit SHA
gh api repos/:owner/:repo/pulls/{number} --jq '.head.sha'

# Verify file exists in changes
gh api repos/:owner/:repo/pulls/{number}/files --jq '.[].filename' | grep "{filename}"

# Check line numbers in patch
gh api repos/:owner/:repo/pulls/{number}/files --jq '.[] | select(.filename=="{filename}") | .patch'
```
</error_handling>

<workflow_integration>
**Integration with review workflow:**

1. **Gather PR details first** (from fetch-pr-details rule)
2. **For each file change identified:**
   - Analyze the code for issues
   - Determine exact line numbers from patch data
   - Create line-specific comments for each issue
   - Use appropriate single-line or multi-line format

3. **Never fallback to general comments** for code-specific issues
4. **Use general PR comments only for:**
   - Overall PR structure feedback
   - Process-related comments
   - Summary of review findings
   - Approval or rejection decisions
</workflow_integration>

<validation_checklist>
**Before posting line-specific comments:**
- [ ] Commit SHA is correct for the PR
- [ ] File path exactly matches the changed file
- [ ] Line number exists in the diff
- [ ] Side parameter is correct (RIGHT for new, LEFT for old)
- [ ] Comment body is specific and actionable
- [ ] Multi-line ranges are valid (start < end, same side)
- [ ] Comment addresses code on those specific lines
- [ ] Alternative: verified general PR comment is NOT appropriate
</validation_checklist>

<integration>
This rule must be applied by:
- All other code review rules when posting feedback
- Works after `gh-pr-review-always-fetch-pr-details-first.rule.md` to get commit SHA
- Provides the mechanism for `gh-pr-review-always-provide-concrete-examples.rule.md`
- Required for `gh-pr-review-always-categorize-comment-severity.rule.md`
</integration>