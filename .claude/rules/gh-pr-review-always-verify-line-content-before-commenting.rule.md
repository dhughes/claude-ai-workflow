---
applies_to:
  - file_patterns: []
  - contexts: ["gh", "github", "pr", "review", "accuracy"]
  - actions: ["reviewing_pr"]
timing: "before"
summary: "Always verify that target line content matches the comment before posting line-specific feedback"
version: "1.0.0"
---

# Rule: Always Verify Line Content Before Commenting

<purpose>
This rule prevents contextually misplaced comments by requiring reviewers to verify that the target line(s) actually contain the content being discussed before posting line-specific feedback.
</purpose>

<instructions>
Before posting ANY line-specific comment, you MUST:

1. **Search for Target Content**: Use Grep or Read tools to locate the exact content you want to comment on
2. **Verify Line Numbers**: Confirm the line numbers from the search match your intended target
3. **Read Context**: Read 3-5 lines above and below the target to ensure contextual relevance
4. **Match Comment to Content**: Ensure your comment directly relates to what's actually on those lines
5. **Double-Check Before Posting**: Re-verify line numbers in the GitHub API call

**NEVER guess line numbers or post comments without content verification.**
</instructions>

<verification_process>
**Mandatory verification sequence:**

```bash
# 1. Search for the specific content you want to comment on
Grep pattern="your_target_content" path="path/to/file"

# 2. Read the file around the target area
Read file_path="path/to/file" offset=[target_line - 5] limit=10

# 3. Verify the content matches your intended comment
# 4. Note the exact line number(s) 
# 5. ONLY THEN post the comment with verified line numbers
```

**Content verification checklist:**
- [ ] Located exact text/code being discussed
- [ ] Confirmed line numbers are correct
- [ ] Read surrounding context (±3-5 lines)
- [ ] Comment content matches target lines
- [ ] Line numbers in API call are verified correct
</verification_process>

<common_mistakes>
**Mistakes that lead to misplaced comments:**

1. **Estimating Line Numbers**: Guessing where content might be
2. **Skipping Verification**: Posting without reading the target lines
3. **Wrong Section**: Commenting on headers instead of actual content
4. **Off-by-One Errors**: Missing the target by a few lines
5. **Multi-line Confusion**: Commenting on wrong part of multi-line blocks

**Example of misplaced comment:**
```
Comment: "This algorithm is inefficient"
Target line 45: "# End of configuration section"
Actual algorithm: Lines 78-85
```

This happens when the reviewer found algorithmic content but didn't verify the line numbers.
</common_mistakes>

<search_strategies>
**How to find the right lines to comment on:**

**For Code Issues:**
```bash
# Search for function names, variable names, or unique code patterns
Grep pattern="function calculateTotal" include="*.js"
Grep pattern="class UserService" include="*.py"
```

**For Security Issues:**
```bash
# Search for potential vulnerabilities
Grep pattern="eval\(" include="*.js"
Grep pattern="SELECT.*WHERE.*=" include="*.sql,*.py"
```

**For Performance Issues:**
```bash
# Search for loops, algorithms, or performance patterns
Grep pattern="for.*in.*for" include="*.js,*.py"  # Nested loops
Grep pattern="\.find\(" include="*.js"  # Potentially inefficient searches
```

**For Documentation Issues:**
```bash
# Search for specific text or missing documentation patterns
Grep pattern="TODO" include="*.md"
Grep pattern="function.*\{" include="*.js"  # Functions that might need docs
```
</search_strategies>

<accurate_targeting>
**Steps for accurate line targeting:**

1. **Search Phase**:
   ```bash
   # Find the content you want to comment on
   Grep pattern="your_specific_content" path="target/file"
   ```

2. **Verification Phase**:
   ```bash
   # Read the area around your target
   Read file_path="target/file" offset=[found_line - 3] limit=7
   ```

3. **Context Check**:
   - Does this line contain what I want to comment on?
   - Do surrounding lines provide appropriate context?
   - Is this the best place for this feedback?

4. **Comment Placement**:
   ```bash
   # Only after verification, post the comment
   gh api repos/:owner/:repo/pulls/X/comments -X POST \
     -f body="[verified comment content]" \
     -f commit_id="[sha]" \
     -f path="[verified path]" \
     -f side="RIGHT" \
     -F line=[verified_line_number]
   ```
</accurate_targeting>

<examples>
<correct>
Proper verification process:
```bash
# 1. Search for the specific issue
Grep pattern="repos/:owner/:repo" path=".claude/rules/gh-pr-review-always-categorize-comment-severity.rule.md"
# Found on lines 135, 156, 172, etc.

# 2. Read the context around line 135
Read file_path=".claude/rules/gh-pr-review-always-categorize-comment-severity.rule.md" offset=130 limit=10
# Verify line 135 contains: gh api repos/:owner/:repo/pulls/45/comments -X POST \

# 3. Confirm this is the right place for security comment about API examples
# 4. Post comment on the verified line
gh api repos/:owner/:repo/pulls/5/comments -X POST \
  -f body="**BLOCKING:** Security issue with API examples..." \
  -f commit_id="sha..." \
  -f path=".claude/rules/gh-pr-review-always-categorize-comment-severity.rule.md" \
  -f side="RIGHT" \
  -F line=135
```
</correct>

<incorrect>
Posting without verification:
```bash
# ❌ WRONG - guessing line numbers
gh api repos/:owner/:repo/pulls/5/comments -X POST \
  -f body="Algorithm pseudocode needs improvement" \
  -f commit_id="sha..." \
  -f path="workflow-file.md" \
  -f side="RIGHT" \
  -F line=62  # Never verified what's on line 62!
```

Missing context check:
```bash
# ❌ WRONG - found content but didn't check context
Grep pattern="AFTER plan_approved" path="file.md"
# Found on line 80, immediately posted comment on line 80
# But line 80 might be in a code example, not the main algorithm section
```
</incorrect>
</examples>

<quality_assurance>
**Before posting any comment, ask yourself:**

1. **Content Match**: Does the line I'm targeting actually contain what I'm commenting about?
2. **Context Appropriateness**: Do the surrounding lines make my comment relevant here?
3. **Specificity**: Am I commenting on the right instance if there are multiple similar lines?
4. **Reader Experience**: Will someone reading this comment understand why it's placed here?

**If you answer "no" or "unsure" to any of these, search again and re-verify your target.**
</quality_assurance>

<integration>
This rule must be applied by:
- All other PR review rules before posting line-specific comments
- Works as a prerequisite for `gh-pr-review-always-use-line-specific-comments.rule.md`
- Enhances the accuracy of `gh-pr-review-always-provide-concrete-examples.rule.md`
- Prevents wasted time from contextually irrelevant feedback
</integration>

<validation>
Comment targeting is accurate when:
- [ ] Target content was found using search tools
- [ ] Line numbers were verified by reading the file
- [ ] Surrounding context was checked for relevance
- [ ] Comment content directly relates to target lines
- [ ] GitHub API call uses verified line numbers
- [ ] Comment placement enhances rather than confuses the review
</validation>