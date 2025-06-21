---
applies_to:
  - file_patterns: []
  - contexts: ["gh", "github", "pr", "feedback", "filtering", "prioritization"]
  - actions: ["filtering_feedback", "prioritizing_responses", "focusing_on_new_feedback"]
timing: "before"
summary: "Always filter comments to focus only on new, unaddressed feedback that hasn't been resolved or acknowledged already"
version: "1.0.0"
---

# Rule: Always Filter For New Unaddressed Feedback

<purpose>
This rule ensures efficient use of time and focused responses by filtering PR feedback to identify only new, unaddressed comments that require action or response, avoiding duplicate work on already resolved issues.
</purpose>

<instructions>
After reading all PR feedback, filter for actionable items:

1. **Categorize all feedback by status**:
   - **New/Unaddressed**: Requires response or action
   - **Resolved**: Already fixed in code changes
   - **Acknowledged**: Noted but explicitly not being implemented
   - **Disputed**: Under discussion, no consensus yet

2. **Identify new feedback requiring action**:
   ```bash
   # Look for recent comments since last response
   # Check timestamps and identify unresolved items
   # Cross-reference with any fixes already implemented
   ```

3. **Prioritize unaddressed feedback**:
   - **Critical issues**: Security, logic errors, blockers
   - **Important suggestions**: Performance, architecture improvements
   - **Minor feedback**: Style, documentation, preferences
   - **Questions**: Clarification requests needing responses

4. **Focus response efforts**:
   - Address only unresolved feedback
   - Skip items already handled or acknowledged
   - Avoid rehashing previously settled discussions
   - Concentrate on moving the PR forward

**Efficient feedback handling focuses on unresolved items only.**
</instructions>

<feedback_filtering_process>
**Step-by-step feedback filtering:**

1. **Collect all feedback sources**:
   ```bash
   # General PR comments (from previous rule)
   gh pr view {number} --json comments
   
   # Line-specific review comments (from previous rule)
   .claude/scripts/pr-file-comments.sh {number}
   ```

2. **Cross-reference with recent changes**:
   ```bash
   # Check recent commits to see what was already addressed
   git log --oneline -5
   
   # Compare feedback timestamps with commit timestamps
   ```

3. **Filter by resolution status**:
   ```
   FOR each comment:
     IF comment_date < last_commit_addressing_issue:
       status = "resolved"
     ELSE IF comment contains acknowledgment/explanation:
       status = "acknowledged" 
     ELSE IF comment is question with response:
       status = "answered"
     ELSE:
       status = "new/unaddressed"
   ```

4. **Create actionable items list**:
   - List only unaddressed feedback
   - Group by file/area for efficiency
   - Prioritize by importance and impact
   - Plan response strategy
</feedback_filtering_process>

<examples>
<correct>
Filtering feedback effectively:
```bash
# Step 1: Collected all feedback
# General comments: 8 total
# Review comments: 12 line-specific comments

# Step 2: Analysis reveals status:
# - Comment 1: "Fix SQL injection on line 32" - RESOLVED (fixed in commit abc123)
# - Comment 2: "Add error handling" - RESOLVED (fixed in commit def456)
# - Comment 3: "Performance concern about loop" - UNADDRESSED (still needs fix)
# - Comment 4: "Consider using async/await" - ACKNOWLEDGED (explained why sync is needed)
# - Comment 5: "Missing tests for edge case" - UNADDRESSED (tests needed)
# - Comment 6: "Naming convention inconsistent" - UNADDRESSED (needs fix)

# Step 3: Focus on unaddressed items only:
# Priority 1: Performance concern (line 45)
# Priority 2: Missing tests for edge case
# Priority 3: Naming convention fix

# Response plan: Address these 3 items, skip the 3 already resolved/acknowledged
```

Efficient filtering example:
```bash
# After reading all feedback, identified:
# Total comments: 15
# Already resolved: 8 (fixed in recent commits)
# Acknowledged/explained: 3 (no action needed)
# New unaddressed: 4 (need attention)

# Focus response on the 4 unaddressed items:
# 1. Security issue in auth.js line 23
# 2. Performance optimization suggestion
# 3. Test coverage gap
# 4. Documentation clarity question

# Skip the 11 items already handled to avoid duplicate work
```
</correct>

<incorrect>
Addressing already resolved feedback:
```bash
# ❌ WRONG - responding to feedback that was already fixed
# "I'll fix the SQL injection issue" 
# Should check if it was already fixed in recent commits
```

Rehashing settled discussions:
```bash
# ❌ WRONG - reopening decided issues
# "Let me reconsider the async approach"
# Should check if this was already discussed and decided
```

Ignoring prioritization:
```bash
# ❌ WRONG - addressing minor items before critical ones
# Fixing style issues while security vulnerabilities remain
# Should prioritize critical feedback first
```
</incorrect>
</examples>

<filtering_criteria>
**Criteria for filtering feedback:**

**SKIP - Already Resolved:**
- Code issues fixed in recent commits
- Problems addressed by code changes
- Suggestions implemented in latest push
- Questions answered in previous responses

**SKIP - Acknowledged/Decided:**
- Design decisions explained and accepted
- Trade-offs discussed and justified
- Alternative approaches considered and rejected
- Scope limitations acknowledged

**ADDRESS - New/Unaddressed:**
- Recent feedback not yet handled
- Code issues not yet fixed
- Questions without responses
- Suggestions not yet considered
- Critical issues requiring immediate attention

**ADDRESS - Disputed/Unclear:**
- Disagreements needing resolution
- Ambiguous feedback requiring clarification
- Conflicting suggestions from multiple reviewers
- Items needing further discussion
</filtering_criteria>

<priority_framework>
**Priority framework for unaddressed feedback:**

**Priority 1 - Critical (Address Immediately):**
- Security vulnerabilities
- Logic errors causing bugs
- Breaking changes or compatibility issues
- Merge blockers identified by reviewers

**Priority 2 - Important (Address Before Merge):**
- Performance issues with significant impact
- Architecture concerns affecting maintainability
- Missing test coverage for critical paths
- Documentation gaps for public APIs

**Priority 3 - Minor (Address If Time Permits):**
- Style and formatting suggestions
- Naming convention improvements
- Code organization optimizations
- Non-critical documentation improvements

**Priority 4 - Questions/Discussion:**
- Clarification requests
- Design alternative discussions
- Future improvement suggestions
- Learning or educational questions
</priority_framework>

<integration>
This rule works with:
- `gh-pr-feedback-always-read-issue-comments-before-responding.rule.md` for complete feedback collection
- `gh-pr-feedback-always-read-review-comments-via-script.rule.md` for line-specific feedback
- All subsequent response rules for efficient feedback handling

This rule ensures:
- Efficient use of time on unresolved issues
- Focused progress toward PR completion
- Avoidance of duplicate work on resolved items
- Proper prioritization of feedback importance
</integration>

<validation>
Feedback filtering complete when:
- [ ] All feedback collected from both general and review comments
- [ ] Each comment categorized by resolution status
- [ ] Already resolved/acknowledged items identified and excluded
- [ ] New unaddressed feedback prioritized by importance
- [ ] Actionable items list created with clear priorities
- [ ] Response strategy focused on unresolved items only
- [ ] Ready to efficiently address remaining feedback
</validation>