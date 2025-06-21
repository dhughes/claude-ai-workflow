---
applies_to:
  - file_patterns: []
  - contexts: ["gh", "github", "pr", "feedback", "communication", "follow_up"]
  - actions: ["replying_to_feedback", "acknowledging_implementations", "communicating_changes"]
timing: "after"
summary: "Always reply to each comment where changes were implemented, explaining specifically what was changed in response to the reviewer's feedback"
version: "1.0.0"
---

# Rule: Always Reply To Implemented Changes

<purpose>
This rule ensures clear communication and feedback closure by requiring specific replies to each comment where changes were implemented, demonstrating responsiveness and helping reviewers understand exactly how their feedback was addressed.
</purpose>

<instructions>
After implementing changes, reply to each relevant comment:

1. **Identify comments that resulted in implementations**:
   - Review all feedback that led to code changes
   - Map commits back to specific reviewer comments
   - Include both line-specific and general feedback

2. **Reply to each implemented change**:
   - Reference the specific commit(s) that address the feedback
   - Explain exactly what was changed
   - Acknowledge the reviewer's contribution
   - Provide context for the implementation approach

3. **Use appropriate reply mechanisms**:
   ```bash
   # For line-specific review comments:
   gh api repos/:owner/:repo/pulls/{number}/comments/{comment_id}/replies \
     --field body="Implementation details and commit reference"
   
   # For general PR comments:
   gh pr comment {number} --body "Response referencing the original comment"
   ```

4. **Ensure complete coverage**:
   - Reply to every comment that resulted in changes
   - Don't leave implemented feedback unacknowledged
   - Provide clear closure for reviewer concerns

**Every implemented change deserves acknowledgment and explanation.**
</instructions>

<reply_structure>
**Structure for implementation replies:**

**For Security/Logic Fixes:**
```
✅ Fixed in commit {sha}: {brief description}

{Explanation of what was changed and how it addresses the concern}

{Any additional context or decisions made during implementation}
```

**For Performance Improvements:**
```
✅ Optimized in commit {sha}: {brief description}

{Details of the performance improvement implemented}

{Metrics or expected impact if available}
```

**For Architecture/Design Changes:**
```
✅ Refactored in commit {sha}: {brief description}

{Explanation of the architectural change}

{Rationale for the specific approach taken}
```

**For Test/Documentation Additions:**
```
✅ Added in commit {sha}: {brief description}

{Details of what tests/documentation were added}

{Coverage or completeness information}
```
</reply_structure>

<examples>
<correct>
Replying to security feedback implementation:
```bash
# Original comment: "Line 32 has SQL injection vulnerability - use parameterized queries"

# After implementing fix in commit abc123:
gh api repos/owner/repo/pulls/123/comments/456/replies \
  --field body="✅ Fixed in commit abc123: Replace string concatenation with parameterized queries

Changed from:
\`const query = \"SELECT * FROM users WHERE id = \" + userId\`

To:
\`const query = \"SELECT * FROM users WHERE id = ?\"; const params = [userId]\`

This eliminates the SQL injection vulnerability by properly parameterizing the query. Thanks for catching this critical security issue!"
```

Replying to performance feedback implementation:
```bash
# Original comment: "This loop creates N+1 query problem - consider batch loading"

# After implementing optimization in commit def456:
gh api repos/owner/repo/pulls/123/comments/789/replies \
  --field body="✅ Optimized in commit def456: Implement batch loading to eliminate N+1 queries

Replaced individual queries in loop with:
- Single batch query to fetch all related entities
- Map-based lookup for O(1) access during processing
- Reduced database calls from O(n) to O(1)

This should significantly improve performance for large datasets. Great suggestion!"
```

Replying to test coverage feedback:
```bash
# Original comment: "Missing tests for edge cases in this function"

# After adding tests in commit ghi789:
gh api repos/owner/repo/pulls/123/comments/012/replies \
  --field body="✅ Added in commit ghi789: Comprehensive test coverage for edge cases

Added tests covering:
- Null input handling
- Empty array processing
- Maximum boundary values
- Error condition scenarios

Test coverage for this function is now 100%. Thanks for pointing out the gaps!"
```
</correct>

<incorrect>
Vague implementation acknowledgment:
```bash
# ❌ WRONG - generic response without specifics
"Thanks, I fixed it"
# Should explain exactly what was changed and reference commits
```

Missing commit references:
```bash
# ❌ WRONG - no way to verify the fix
"I've addressed the SQL injection issue"
# Should reference specific commit that contains the fix
```

Lumping multiple changes together:
```bash
# ❌ WRONG - one reply for multiple distinct feedback items
"I've fixed all the issues you mentioned"
# Should reply individually to each comment that was addressed
```
</incorrect>
</examples>

<reply_mapping_process>
**Process for mapping implementations to feedback:**

1. **Review commit history**:
   ```bash
   git log --oneline -10
   # Identify commits that address feedback
   ```

2. **Match commits to feedback comments**:
   ```
   Commit abc123: "Fix SQL injection" -> Maps to security comment on line 32
   Commit def456: "Add caching layer" -> Maps to performance comment on line 67
   Commit ghi789: "Add edge case tests" -> Maps to test coverage comment
   ```

3. **Reply to each mapped comment**:
   - Use specific commit SHA in reply
   - Explain the implementation approach
   - Acknowledge the reviewer's insight

4. **Verify complete coverage**:
   - Ensure no implemented changes are left unacknowledged
   - Check that all actionable feedback received replies
   - Confirm reviewers can see the connection between feedback and implementation
</reply_mapping_process>

<communication_best_practices>
**Best practices for implementation replies:**

**Be Specific:**
- Reference exact commit SHAs
- Quote relevant code changes
- Explain the implementation approach
- Provide before/after comparisons when helpful

**Be Grateful:**
- Thank reviewers for valuable feedback
- Acknowledge learning opportunities
- Recognize time spent on thorough review
- Show appreciation for expertise shared

**Be Educational:**
- Explain reasoning behind implementation choices
- Share relevant technical details
- Provide context for decisions made
- Help reviewers understand the solution

**Be Complete:**
- Address every aspect of the original feedback
- Don't leave questions unanswered
- Provide follow-up information if needed
- Ensure clear closure on the concern
</communication_best_practices>

<integration>
This rule works with:
- `gh-pr-feedback-always-implement-changes-before-replying.rule.md` for proper sequencing
- `gh-pr-feedback-always-reply-to-review-comments-not-general-comments.rule.md` for proper reply location
- All feedback analysis rules for understanding what was implemented

This rule ensures:
- Clear communication of implemented changes
- Proper acknowledgment of reviewer contributions
- Traceable connection between feedback and implementation
- Professional closure of feedback loops
</integration>

<validation>
Implementation reply completion when:
- [ ] All commits mapped to relevant feedback comments
- [ ] Individual replies posted to each implemented change
- [ ] Specific commit references included in each reply
- [ ] Implementation approach explained clearly
- [ ] Reviewer contributions acknowledged appropriately
- [ ] Complete coverage of all implemented feedback
- [ ] Clear closure provided for addressed concerns
</validation>