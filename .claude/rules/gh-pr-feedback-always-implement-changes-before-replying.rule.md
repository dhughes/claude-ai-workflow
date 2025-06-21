---
applies_to:
  - file_patterns: []
  - contexts: ["gh", "github", "pr", "feedback", "implementation", "workflow"]
  - actions: ["implementing_feedback_changes", "committing_fixes", "responding_to_feedback"]
timing: "before"
summary: "Always make all agreed-upon code changes, commit them with descriptive messages, and push updates before replying to any feedback comments"
version: "1.0.0"
---

# Rule: Always Implement Changes Before Replying

<purpose>
This rule ensures that feedback implementation precedes communication by requiring all agreed-upon code changes to be completed, committed, and pushed before posting any replies to feedback comments, demonstrating responsiveness through action rather than promises.
</purpose>

<instructions>
Before replying to ANY feedback, complete all implementation work:

1. **Implement all decided changes**:
   - Fix security vulnerabilities and logic errors
   - Address performance issues and optimization suggestions
   - Make requested architectural improvements
   - Add missing tests and documentation

2. **Commit changes with descriptive messages**:
   ```bash
   # Use descriptive commit messages referencing feedback
   git add .
   git commit -m "Fix SQL injection vulnerability in user authentication (addresses review feedback)"
   git commit -m "Add error handling for edge cases (addresses reviewer concerns)"
   git commit -m "Optimize database queries to prevent N+1 problem (performance improvement)"
   ```

3. **Push all commits to update PR**:
   ```bash
   git push origin feature-branch-name
   ```

4. **Verify changes are visible in PR**:
   ```bash
   # Confirm commits appear in PR
   gh pr view {number}
   ```

5. **Only then reply to feedback**:
   - Reply to comments explaining what was implemented
   - Reference specific commits that address concerns
   - Provide explanations for defended positions

**Actions speak louder than words - implement first, explain after.**
</instructions>

<implementation_workflow>
**Step-by-step implementation workflow:**

1. **Group changes by type and file**:
   ```bash
   # Organize implementation work:
   # Security fixes: auth.js line 32, user.js line 45
   # Performance: payment.js line 67, order.js line 23
   # Tests: add test-user.js, update test-payment.js
   ```

2. **Implement changes systematically**:
   ```bash
   # Make code changes
   Edit file_path="src/auth.js" old_string="query = 'SELECT * FROM users WHERE id = ' + userId" new_string="query = 'SELECT * FROM users WHERE id = ?'; params = [userId]"
   
   # Add tests
   Write file_path="tests/auth.test.js" content="test cases for security fixes"
   
   # Update documentation
   Edit file_path="README.md" old_string="old usage" new_string="updated usage examples"
   ```

3. **Commit in logical groups**:
   ```bash
   # Commit security fixes together
   git add src/auth.js src/user.js
   git commit -m "Fix SQL injection vulnerabilities in authentication and user modules
   
   - Replace string concatenation with parameterized queries
   - Add input validation for user IDs
   - Addresses security concerns raised in PR review"
   
   # Commit performance improvements
   git add src/payment.js src/order.js
   git commit -m "Optimize database queries to improve performance
   
   - Implement query batching to prevent N+1 problems
   - Add caching layer for frequently accessed data
   - Addresses performance feedback from review"
   
   # Commit tests and documentation
   git add tests/ README.md
   git commit -m "Add comprehensive tests and update documentation
   
   - Add unit tests for security fixes
   - Update integration tests for performance changes
   - Refresh README with updated usage examples"
   ```

4. **Push and verify**:
   ```bash
   git push origin feature-branch
   
   # Verify commits appear in PR
   gh pr view {number} --json commits
   ```
</implementation_workflow>

<examples>
<correct>
Proper implementation-first workflow:
```bash
# Step 1: Implement all agreed-upon changes
# Fix security issue
Edit file_path="src/auth.js" old_string="WHERE id = " + req.params.id" new_string="WHERE id = ?" 

# Add performance optimization
Edit file_path="src/cache.js" old_string="// TODO: implement caching" new_string="const cache = new Map(); // Cache implementation"

# Add missing tests
Write file_path="tests/auth.test.js" content="comprehensive test suite"

# Step 2: Commit with descriptive messages
git add src/auth.js
git commit -m "Fix SQL injection in authentication module (addresses security review)"

git add src/cache.js tests/auth.test.js
git commit -m "Add caching and comprehensive tests (addresses performance and coverage feedback)"

# Step 3: Push updates
git push origin feature-auth-improvements

# Step 4: NOW reply to feedback with references to commits
gh api repos/owner/repo/pulls/123/comments/456/replies \
  --field body="Fixed the SQL injection vulnerability in commit abc123. The authentication module now uses parameterized queries as suggested."
```

Demonstrating completed work:
```bash
# All implementation completed first:
# - Security fixes: 3 commits
# - Performance improvements: 2 commits  
# - Test additions: 1 commit
# - Documentation updates: 1 commit

# All changes pushed and visible in PR

# NOW provide comprehensive response:
gh pr comment 123 --body "I've addressed all the feedback:

✅ Security vulnerabilities fixed (commits abc123, def456)
✅ Performance optimizations implemented (commits ghi789, jkl012)
✅ Test coverage added (commit mno345)
✅ Documentation updated (commit pqr678)

All changes are now visible in the PR. Please review the implementations."
```
</correct>

<incorrect>
Replying before implementing:
```bash
# ❌ WRONG - promising changes without implementing
gh pr comment 123 --body "I'll fix the SQL injection issue and add the tests"
# Should implement the fixes first, then reference the completed work
```

Partial implementation:
```bash
# ❌ WRONG - implementing some changes but not others
# Fixed security issues but ignored performance feedback
# Should complete all agreed-upon changes before replying
```

Vague implementation references:
```bash
# ❌ WRONG - replying without specific commit references
"I've made the requested changes"
# Should reference specific commits and what was changed
```
</incorrect>
</examples>

<commit_message_guidelines>
**Guidelines for implementation commit messages:**

**Security Fixes:**
```
Fix SQL injection vulnerability in user authentication

- Replace string concatenation with parameterized queries
- Add input validation for user IDs and email addresses
- Implement proper escaping for dynamic query components
- Addresses critical security concern raised in PR review
```

**Performance Improvements:**
```
Optimize database queries to prevent N+1 problems

- Implement batch loading for related entities
- Add query result caching with TTL
- Reduce database round trips from O(n) to O(1)
- Addresses performance feedback from code review
```

**Test Coverage:**
```
Add comprehensive test coverage for authentication module

- Add unit tests for all public methods
- Include edge case and error condition tests
- Add integration tests for full auth workflow
- Achieves 95% code coverage as requested in review
```

**Documentation Updates:**
```
Update API documentation with security best practices

- Add examples of secure authentication patterns
- Document new error handling approaches
- Include performance optimization guidelines
- Addresses documentation gaps identified in review
```
</commit_message_guidelines>

<integration>
This rule works with:
- Previous feedback evaluation and decision rules for knowing what to implement
- Subsequent reply rules for communicating completed work
- Git workflow rules for proper commit and push practices

This rule ensures:
- Tangible progress before communication
- Clear demonstration of responsiveness to feedback
- Proper tracking of changes through commit history
- Efficient review cycles through action-first approach
</integration>

<validation>
Implementation before reply complete when:
- [ ] All agreed-upon code changes implemented
- [ ] Security vulnerabilities and logic errors fixed
- [ ] Performance improvements and optimizations completed
- [ ] Missing tests and documentation added
- [ ] Changes committed with descriptive messages
- [ ] All commits pushed and visible in PR
- [ ] Ready to reply with references to completed work
</validation>