---
applies_to:
  - file_patterns: []
  - contexts: ["gh", "github", "pr", "feedback", "review_comments", "line_comments"]
  - actions: ["responding_to_review_feedback", "addressing_line_comments", "handling_code_review"]
timing: "before"
summary: "Always read all review comments (line-specific code comments) via .claude/scripts/pr-file-comments.sh before responding to feedback"
version: "1.0.0"
---

# Rule: Always Read Review Comments Via Script

<purpose>
This rule ensures comprehensive understanding of all line-specific code review comments before responding to feedback by requiring systematic reading of review comments using the dedicated script to understand code-specific feedback and context.
</purpose>

<instructions>
Before responding to ANY code review feedback, read all review comments:

1. **Execute the PR file comments script**:
   ```bash
   .claude/scripts/pr-file-comments.sh {pr_number}
   ```

2. **Parse review comment structure**:
   - File-specific comments grouped by file
   - Line-specific feedback with code context
   - Review thread conversations and replies
   - Comment resolution status

3. **Understand code-specific feedback**:
   - Identify specific code issues and suggestions
   - Note line-level concerns and recommendations
   - Track comment threads and discussion evolution
   - Understand reviewer intent and concerns

4. **Block response until complete analysis**:
   - Do not respond to code feedback without full review context
   - Ensure understanding of all line-specific comments
   - Verify awareness of reviewer concerns and suggestions
   - Consider all code-related feedback before responding

**Line-specific feedback requires thorough understanding before response.**
</instructions>

<review_comment_analysis>
**How to analyze review comments systematically:**

1. **Execute script and parse output**:
   ```bash
   .claude/scripts/pr-file-comments.sh 123
   
   # Expected output format:
   # File: src/user-service.js
   #   Line 45: [Reviewer] Security concern: SQL injection risk
   #   Line 67: [Reviewer] Performance: N+1 query problem
   # File: src/auth-middleware.js
   #   Line 23: [Reviewer] Logic error: missing null check
   ```

2. **Categorize comments by type**:
   - **Security concerns**: Vulnerabilities and security issues
   - **Performance issues**: Efficiency and optimization feedback
   - **Logic errors**: Bugs and correctness problems  
   - **Style feedback**: Naming, formatting, conventions
   - **Architecture suggestions**: Design and structure improvements

3. **Track comment status**:
   - **Unresolved**: New comments requiring response
   - **Addressed**: Issues that have been fixed
   - **Acknowledged**: Feedback noted but not implemented
   - **Disputed**: Areas needing further discussion

4. **Map comments to files and context**:
   - Understand which files have feedback
   - Note line-specific context for each comment
   - Track relationships between related comments
   - Identify patterns in reviewer concerns
</review_comment_analysis>

<examples>
<correct>
Reading review comments before responding:
```bash
# Step 1: Execute script to get all review comments
.claude/scripts/pr-file-comments.sh 123

# Output analysis:
# File: src/payment.js
#   Line 32: [Alice] SQL injection: Use parameterized queries
#   Line 45: [Bob] Performance: Cache this calculation
# File: src/user.js  
#   Line 12: [Alice] Logic: Handle null user case
#   Line 28: [Charlie] Style: Use consistent naming

# Step 2: Understand feedback scope
# - 4 total comments across 2 files
# - Security issue needs immediate fix (Line 32)
# - Performance optimization suggestion (Line 45)
# - Logic bug requiring null check (Line 12)
# - Style consistency improvement (Line 28)

# NOW respond with targeted fixes:
# "I'll address the SQL injection on line 32 first, then handle the null check..."
```

Understanding comment context:
```bash
# Read all review comments with context
.claude/scripts/pr-file-comments.sh 456

# Analysis reveals:
# - Multiple security concerns from Alice
# - Performance feedback from Bob
# - Style suggestions from Charlie
# - Some comments reference each other

# Response acknowledges comprehensive understanding:
# "Based on the review feedback, I'll prioritize Alice's security concerns,
#  implement Bob's performance suggestions, and address Charlie's style points..."
```
</correct>

<incorrect>
Skipping review comment analysis:
```bash
# ❌ WRONG - responding without reading review comments
# "I'll make the changes"
# Should read specific line comments to understand what changes are needed
```

Using wrong command for review comments:
```bash
# ❌ WRONG - using general PR view for line-specific comments
gh pr view 123
# Should use .claude/scripts/pr-file-comments.sh for review comments
```

Partial comment reading:
```bash
# ❌ WRONG - only reading comments for one file
# Should read all review comments across all files in the PR
```
</incorrect>
</examples>

<script_output_interpretation>
**How to interpret pr-file-comments.sh output:**

**File Organization:**
```
File: path/to/file.js
  Line X: [Reviewer] Comment text
  Line Y: [Reviewer] Comment text
```

**Comment Types to Recognize:**
- **Critical issues**: Security, logic errors requiring immediate fix
- **Suggestions**: Performance, style, architecture improvements
- **Questions**: Clarification requests about implementation
- **Acknowledgments**: Positive feedback or approval notes

**Priority Assessment:**
1. **Security issues**: Address immediately
2. **Logic errors**: Fix before merge
3. **Performance concerns**: Evaluate and implement
4. **Style feedback**: Address for consistency
5. **Questions**: Respond with explanations

**Response Planning:**
- Group related comments for efficient fixes
- Plan implementation order by priority
- Prepare explanations for disputed items
- Identify which comments need code changes vs responses
</script_output_interpretation>

<integration>
This rule works with:
- `gh-pr-feedback-always-read-issue-comments-before-responding.rule.md` for complete feedback context
- `gh-pr-feedback-always-filter-for-new-unaddressed-feedback.rule.md` for focused responses
- All other feedback response rules for comprehensive review handling

This rule ensures:
- Complete understanding of line-specific code feedback
- Proper prioritization of code review comments
- Targeted responses to specific reviewer concerns
- Efficient handling of code-related feedback
</integration>

<validation>
Review comment reading complete when:
- [ ] pr-file-comments.sh script executed for target PR
- [ ] All line-specific review comments parsed and understood
- [ ] Comments categorized by type and priority
- [ ] File-specific feedback mapped to code context
- [ ] Reviewer concerns and suggestions comprehended
- [ ] Response strategy planned based on comment analysis
- [ ] Ready to address code feedback with full understanding
</validation>