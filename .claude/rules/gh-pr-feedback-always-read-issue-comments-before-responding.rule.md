---
applies_to:
  - file_patterns: []
  - contexts: ["gh", "github", "pr", "feedback", "comments", "response"]
  - actions: ["responding_to_pr_feedback", "addressing_pr_comments", "handling_pr_discussion"]
timing: "before"
summary: "Always read all issue comments (general PR comments) via gh pr view before responding to any PR feedback"
version: "1.0.0"
---

# Rule: Always Read Issue Comments Before Responding

<purpose>
This rule ensures comprehensive understanding of all general PR discussion before responding to feedback by requiring systematic reading of issue comments to understand context, previous decisions, and ongoing conversations.
</purpose>

<instructions>
Before responding to ANY PR feedback, read all issue comments:

1. **Fetch all general PR comments**:
   ```bash
   gh pr view {number} --json comments
   ```

2. **Read and understand comment context**:
   ```bash
   # Alternative: View PR with comments
   gh pr view {number}
   ```

3. **Parse comment information**:
   - Understand conversation flow and context
   - Identify previous decisions and agreements
   - Note any concerns or blockers raised
   - Track feedback that has been addressed vs pending

4. **Block response until complete understanding**:
   - Do not respond to feedback without full context
   - Ensure awareness of all participants' input
   - Verify understanding of PR discussion history
   - Consider all perspectives before crafting responses

**Complete context is essential for appropriate feedback responses.**
</instructions>

<comment_analysis_process>
**How to analyze issue comments systematically:**

1. **Fetch comment data**:
   ```bash
   # Get structured comment data
   gh pr view {pr_number} --json comments,author,createdAt,body
   
   # Or view formatted comments
   gh pr view {pr_number}
   ```

2. **Categorize comments by type**:
   - **Process comments**: Workflow, approval, merge decisions
   - **Architectural feedback**: Design, structure, approach
   - **Clarification requests**: Questions about implementation
   - **Coordination comments**: Timeline, dependencies, assignments

3. **Track comment resolution status**:
   - **Addressed**: Issues that have been resolved
   - **Pending**: Open questions or unresolved concerns
   - **Acknowledged**: Feedback that was noted but not acted upon
   - **Disputed**: Areas of disagreement needing discussion

4. **Understand participant perspectives**:
   - Note each reviewer's main concerns
   - Identify areas of consensus vs disagreement
   - Track evolving decisions through comment history
</comment_analysis_process>

<examples>
<correct>
Reading comments before responding to feedback:
```bash
# Step 1: Fetch all PR comments
gh pr view 123 --json comments

# Parse comment content:
# - Reviewer A: Concerned about performance impact
# - Reviewer B: Suggested using caching layer
# - Author: Agreed to implement caching
# - Reviewer A: Still waiting for performance benchmarks

# Step 2: Understand current state
# - Caching has been implemented (addressed)
# - Performance benchmarks still needed (pending)
# - No disputes, general agreement on approach

# NOW respond with full context:
# "Based on the discussion, I'll provide the requested performance benchmarks.
#  The caching implementation addresses Reviewer B's suggestion..."
```

Understanding conversation flow:
```bash
# Read complete PR discussion
gh pr view 456

# Comment analysis reveals:
# 1. Initial architectural concern raised
# 2. Alternative approaches discussed
# 3. Decision made to refactor
# 4. Refactoring completed
# 5. New concern about test coverage

# Response acknowledges full context:
# "Following the refactoring decision from earlier discussion,
#  I'll address the new test coverage concern by..."
```
</correct>

<incorrect>
Responding without reading comments:
```bash
# ❌ WRONG - jumping straight to response
# "I'll fix that issue"
# Should read all comments first to understand which issue and context
```

Partial comment reading:
```bash
# ❌ WRONG - only reading latest comment
gh pr view 123 | tail -5
# Should read all comments to understand full conversation
```

Ignoring comment context:
```bash
# ❌ WRONG - responding without considering previous discussion
# "Why don't we use approach X?"
# Should read comments to see if approach X was already discussed and rejected
```
</incorrect>
</examples>

<comment_types_to_understand>
**Types of issue comments to analyze:**

**Process and Workflow Comments:**
- Merge approval or blocking decisions
- Timeline and dependency discussions
- Release planning and deployment notes
- CI/CD and testing workflow feedback

**Technical Architecture Comments:**
- Design pattern discussions
- Technology choice debates
- Performance and scalability concerns
- Security and compliance considerations

**Clarification and Questions:**
- Implementation detail questions
- Requirement clarification requests
- Scope and boundary discussions
- Documentation and explanation needs

**Coordination Comments:**
- Task assignments and ownership
- Cross-team dependencies
- Integration planning
- Communication with stakeholders
</comment_types_to_understand>

<integration>
This rule works with:
- `gh-pr-feedback-always-read-review-comments-before-responding.rule.md` for complete feedback understanding
- `gh-pr-feedback-always-filter-for-new-unaddressed-feedback.rule.md` for focused responses
- All other feedback response rules for comprehensive PR interaction

This rule ensures:
- Complete context before responding to feedback
- Appropriate acknowledgment of previous discussions
- Informed decision-making based on full conversation
- Professional and contextual communication
</integration>

<validation>
Issue comment reading complete when:
- [ ] All general PR comments fetched via gh pr view
- [ ] Comment content and context understood
- [ ] Conversation flow and decisions tracked
- [ ] Participant perspectives and concerns noted
- [ ] Previous agreements and resolutions identified
- [ ] Current pending items and blockers understood
- [ ] Ready to respond with full contextual awareness
</validation>