---
applies_to:
  - file_patterns: []
  - contexts: ["gh", "github", "pr", "feedback", "review_comments", "reply_location"]
  - actions: ["replying_to_review_comments", "responding_to_line_feedback", "commenting_on_code"]
timing: "before"
summary: "Always reply to review comments (line-specific code comments) using review comment replies, not general PR comments"
version: "1.0.0"
---

# Rule: Always Reply To Review Comments Not General Comments

<purpose>
This rule ensures proper contextual communication by requiring replies to line-specific review comments to be posted as review comment replies rather than general PR comments, maintaining the connection between feedback and specific code locations.
</purpose>

<instructions>
When responding to line-specific review comments, use review comment replies:

1. **Identify comment type**:
   - **Review comments**: Line-specific feedback attached to code
   - **Issue comments**: General PR discussion and feedback

2. **Use appropriate reply mechanism**:
   ```bash
   # For review comments (line-specific):
   gh api repos/:owner/:repo/pulls/{number}/comments/{comment_id}/replies \
     --method POST \
     --field body="Your response to the line-specific feedback"
   
   # NOT for review comments:
   gh pr comment {number} --body="Response" # This creates general PR comment
   ```

3. **Maintain code context**:
   - Keep replies attached to specific lines of code
   - Preserve the relationship between feedback and implementation
   - Ensure reviewers can see responses in context

4. **Verify proper reply location**:
   - Confirm replies appear as threaded responses to review comments
   - Ensure they don't appear as separate general comments
   - Check that code context is preserved

**Review comment replies maintain essential code context.**
</instructions>

<comment_type_identification>
**How to distinguish comment types:**

**Review Comments (Line-Specific):**
- Attached to specific lines of code
- Visible in the "Files changed" tab
- Have file path and line number context
- Appear inline with code diff
- Retrieved via `.claude/scripts/pr-file-comments.sh`

**Issue Comments (General):**
- Posted to overall PR conversation
- Visible in the main PR discussion
- Not tied to specific code lines
- Appear in chronological order
- Retrieved via `gh pr view {number}`

**Examples:**
```
Review Comment: "Line 32: This function needs error handling"
-> Reply with review comment API

Issue Comment: "Overall architecture looks good, ready to merge"
-> Reply with general PR comment
```
</comment_type_identification>

<api_usage_examples>
**Correct API usage for review comment replies:**

```bash
# Step 1: Get review comment ID from script output
.claude/scripts/pr-file-comments.sh 123
# Output shows comment IDs for each line-specific comment

# Step 2: Reply to specific review comment
gh api repos/owner/repo/pulls/123/comments/456789/replies \
  --method POST \
  --field body="✅ Fixed in commit abc123: Added proper error handling

The function now includes:
- Input validation for null parameters
- Try-catch block for exception handling  
- Appropriate error responses

Thanks for catching this!"

# Step 3: Verify reply appears in correct location
# Reply should appear threaded under the original review comment
```
</api_usage_examples>

<examples>
<correct>
Replying to line-specific security feedback:
```bash
# Original review comment on line 32: "SQL injection vulnerability here"
# Comment ID: 789012 (from pr-file-comments.sh output)

# CORRECT: Reply to review comment
gh api repos/owner/repo/pulls/123/comments/789012/replies \
  --method POST \
  --field body="✅ Fixed in commit def456: Implemented parameterized queries

Changed from string concatenation to prepared statements:
- Added parameter validation
- Used query placeholders  
- Eliminated injection vector

The security vulnerability is now resolved."

# Result: Reply appears threaded under the line 32 comment
```

Replying to line-specific performance feedback:
```bash
# Original review comment on line 67: "This loop is inefficient, O(n²) complexity"
# Comment ID: 345678

# CORRECT: Reply to review comment with implementation details
gh api repos/owner/repo/pulls/456/comments/345678/replies \
  --method POST \
  --field body="✅ Optimized in commit ghi789: Reduced complexity to O(n)

Implementation changes:
- Replaced nested loops with Map lookup
- Pre-compute values in single pass
- Eliminated redundant iterations

Performance improved significantly for large datasets."

# Result: Reply contextually attached to the specific line of code
```
</correct>

<incorrect>
Using general PR comments for line-specific feedback:
```bash
# ❌ WRONG - responding to line-specific comment with general PR comment
gh pr comment 123 --body "I fixed the SQL injection on line 32"
# Should use review comment reply API to maintain code context
```

Losing code context:
```bash
# ❌ WRONG - generic response without line context
gh pr comment 456 --body "I've addressed all the performance issues"
# Should reply to each specific line comment individually
```

Mixing reply types:
```bash
# ❌ WRONG - using general comments for some line-specific feedback
# Inconsistent reply patterns confuse reviewers
# Should consistently use review comment replies for all line-specific feedback
```
</incorrect>
</examples>

<workflow_integration>
**Integration with feedback workflow:**

1. **Read review comments via script**:
   ```bash
   .claude/scripts/pr-file-comments.sh {number}
   # Outputs review comments with IDs
   ```

2. **Implement changes for line-specific feedback**:
   ```bash
   # Make code changes, commit, push
   ```

3. **Reply to each review comment**:
   ```bash
   # Use review comment reply API for each line-specific item
   gh api repos/:owner/:repo/pulls/{number}/comments/{comment_id}/replies
   ```

4. **Use general PR comments only for**:
   - Overall architecture feedback
   - Process and workflow discussions
   - Summary responses covering multiple changes
   - Non-code-specific communication
</workflow_integration>

<context_preservation>
**Why review comment replies are essential:**

**Maintains Code Context:**
- Reviewers see responses inline with code
- Discussion stays attached to relevant lines
- Future readers understand feedback context
- Code review history is preserved

**Improves Communication:**
- Clear connection between feedback and response
- Easier to track resolution of specific issues
- Reduces confusion about which code is discussed
- Enables focused follow-up discussions

**Enhances Review Quality:**
- Encourages specific, actionable feedback
- Makes it easier to verify fixes
- Supports collaborative code improvement
- Creates better documentation of decisions
</context_preservation>

<integration>
This rule works with:
- `gh-pr-feedback-always-read-review-comments-via-script.rule.md` for getting comment IDs
- `gh-pr-feedback-always-reply-to-implemented-changes.rule.md` for comprehensive responses
- `gh-pr-review-always-use-line-specific-comments-for-code-issues.rule.md` for consistency

This rule ensures:
- Proper contextual communication
- Preserved relationship between feedback and code
- Professional code review interactions
- Clear audit trail for code discussions
</integration>

<validation>
Review comment reply completion when:
- [ ] Review comment types identified correctly
- [ ] Review comment IDs obtained from script output
- [ ] Review comment reply API used for all line-specific responses
- [ ] General PR comments used only for non-code-specific communication
- [ ] All replies appear in correct contextual location
- [ ] Code context preserved for all line-specific discussions
- [ ] Consistent reply patterns maintained throughout PR
</validation>