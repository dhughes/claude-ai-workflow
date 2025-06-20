---
applies_to:
  - file_patterns: []
  - contexts: ["gh", "github", "pr", "review", "severity"]
  - actions: ["reviewing_pr"]
timing: "during"
summary: "Mark comments as blocking vs. suggestion vs. nitpick to clarify priority"
version: "1.0.0"
---

# Rule: Always Categorize Comment Severity

<purpose>
This rule ensures that every review comment is clearly categorized by severity level (blocking, suggestion, or nitpick) to help developers understand which issues must be addressed before merging versus which are optional improvements.
</purpose>

<instructions>
Every review comment MUST start with a severity indicator:

1. **Blocking Issues**: Must be fixed before merge
   - Start comment with "**BLOCKING:**"
   - Use for: Security vulnerabilities, logic errors, breaking changes
   - Prevent merge until resolved

2. **Suggestion Issues**: Should be addressed but not merge-blocking
   - Start comment with "**SUGGESTION:**"
   - Use for: Performance improvements, maintainability issues, missing tests
   - Can be addressed in follow-up if time-constrained

3. **Nitpick Issues**: Minor improvements, style preferences
   - Start comment with "**NITPICK:**"
   - Use for: Style consistency, minor naming improvements, documentation
   - Optional, can be ignored if not valuable

4. **Follow standard format**: `**SEVERITY:** [Issue type] - [Description]`
</instructions>

<severity_definitions>
**Blocking Issues (Must Fix):**
- Security vulnerabilities
- Logic errors that cause incorrect behavior
- Breaking API changes without proper migration
- Memory leaks or resource exhaustion
- Data corruption possibilities
- Authentication/authorization bypasses
- Critical performance regressions
- Missing error handling for external dependencies

**Suggestion Issues (Should Fix):**
- Performance optimizations (non-critical)
- Maintainability improvements
- Missing unit tests for new functionality
- Code organization improvements
- Better error messages
- Refactoring opportunities
- Missing documentation for public APIs
- Input validation improvements

**Nitpick Issues (Nice to Have):**
- Code style consistency
- Variable naming improvements
- Comment formatting
- Minor code organization
- Preference-based suggestions
- Documentation typos
- Non-critical logging improvements
- Aesthetic code improvements
</severity_definitions>

<comment_format>
**Standard comment format:**

```
**SEVERITY:** [Issue Category] - [Brief Description]

[Detailed explanation of the issue]

[Code examples or specific suggestions]

[Additional context or references]
```

**Examples of proper formatting:**

```
**BLOCKING:** Security Vulnerability - SQL injection risk from string concatenation

Direct string interpolation allows SQL injection attacks...
[code examples]
Reference: OWASP A03:2021 Injection
```

```
**SUGGESTION:** Performance Issue - O(n²) algorithm could be optimized to O(n)

Nested loop creates quadratic complexity...
[code examples]
Impact: With 1000 items, this becomes 1M operations vs 1000
```

```
**NITPICK:** Code Style - Inconsistent variable naming convention

Variable uses camelCase while others use snake_case...
[code examples]
Consider following project's camelCase convention
```
</comment_format>

<severity_guidelines>
**How to determine severity:**

**Ask these questions:**
1. **Will this cause runtime failures?** → BLOCKING
2. **Will this cause incorrect behavior?** → BLOCKING  
3. **Is this a security risk?** → BLOCKING
4. **Will this significantly impact performance?** → BLOCKING or SUGGESTION
5. **Will this make code harder to maintain?** → SUGGESTION
6. **Is this a style/preference issue?** → NITPICK

**Error type mapping:**
- **Runtime errors**: BLOCKING
- **Logic errors**: BLOCKING
- **Security issues**: BLOCKING
- **Performance problems**: SUGGESTION (unless critical)
- **Maintainability issues**: SUGGESTION
- **Style issues**: NITPICK
- **Documentation gaps**: SUGGESTION or NITPICK
- **Test coverage**: SUGGESTION
</severity_guidelines>

<examples>
<correct>
Blocking security issue:
```bash
gh api repos/:owner/:repo/pulls/45/comments -X POST \
  -f body="**BLOCKING:** Security Vulnerability - Hardcoded API key exposes production credentials

Hardcoded API key is visible in source control and could be accessed by anyone with repository access.

Current code:
\`\`\`python
API_KEY = \"sk-1234567890abcdef\"
\`\`\`

Required fix:
\`\`\`python
API_KEY = os.environ.get('API_KEY')
if not API_KEY:
    raise ValueError('API_KEY environment variable required')
\`\`\`

This must be fixed before merge to prevent credential exposure." \
  -f commit_id="a1b2c3..." \
  -f path="config.py" \
  -f side="RIGHT" \
  -F line=12
```

Suggestion for performance:
```bash
gh api repos/:owner/:repo/pulls/45/comments -X POST \
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

Impact: With 1000 orders and 1000 users, this reduces from 1M operations to 2000." \
  -f commit_id="a1b2c3..." \
  -f path="order_service.js" \
  -f side="RIGHT" \
  -F start_line=45 \
  -F line=52
```

Nitpick for naming:
```bash
gh api repos/:owner/:repo/pulls/45/comments -X POST \
  -f body="**NITPICK:** Code Style - Variable name could be more descriptive

Variable 'data' is generic and doesn't indicate what type of data it contains.

Current code:
\`\`\`python
data = fetch_user_info(user_id)
\`\`\`

Suggested improvement:
\`\`\`python
user_profile = fetch_user_info(user_id)
\`\`\`

This makes the code more self-documenting." \
  -f commit_id="a1b2c3..." \
  -f path="user_service.py" \
  -f side="RIGHT" \
  -F line=23
```
</correct>

<incorrect>
Missing severity indicator:
```bash
# ❌ WRONG - no severity classification
gh api repos/:owner/:repo/pulls/45/comments -X POST \
  -f body="This has a security issue with SQL injection" \
  -f commit_id="a1b2c3..." \
  -f path="config.py" \
  -f side="RIGHT" \
  -F line=12
```

Wrong severity classification:
```bash
# ❌ WRONG - security issue marked as nitpick
gh api repos/:owner/:repo/pulls/45/comments -X POST \
  -f body="**NITPICK:** SQL injection vulnerability..." \
  -f commit_id="a1b2c3..." \
  -f path="database.py" \
  -f side="RIGHT" \
  -F line=45
```
</incorrect>
</examples>

<escalation_rules>
**When to escalate severity:**

**Nitpick → Suggestion:**
- Style issue affects code readability significantly
- Documentation gap affects public API usage
- Naming inconsistency causes confusion

**Suggestion → Blocking:**
- Performance issue affects critical user flows
- Maintainability issue makes code very fragile
- Missing tests for security-critical functionality

**Context considerations:**
- **Production impact**: Issues affecting live users should be higher severity
- **Frequency of execution**: Code that runs frequently deserves more attention
- **Team expertise**: Complex issues may need more guidance
- **Technical debt**: Accumulated issues may warrant higher priority
</escalation_rules>

<merge_decision_support>
**How severity affects merge decisions:**

**Blocking Issues Present:**
- PR should not be merged until all blocking issues resolved
- May require additional review after fixes
- Security issues always block merge

**Only Suggestions/Nitpicks:**
- PR can be merged with plan to address suggestions
- Create follow-up issues for suggestions if not addressed
- Nitpicks can be addressed opportunistically

**Mixed Severities:**
- Address all blocking issues first
- Evaluate time constraints for suggestions
- Document any deferred suggestions as technical debt
</merge_decision_support>

<validation_checklist>
**Before posting any comment, verify:**
- [ ] Comment starts with appropriate severity marker
- [ ] Severity matches the actual impact of the issue
- [ ] Issue category is correctly identified
- [ ] Explanation justifies the severity level
- [ ] Blocking issues are truly merge-blocking
- [ ] Suggestions provide clear value
- [ ] Nitpicks are genuinely minor improvements
- [ ] Comment includes concrete examples
- [ ] Severity is consistent with similar issues in the review
</validation_checklist>

<integration>
This rule must be applied by:
- All other PR review rules when posting feedback
- Works with `gh-pr-review-always-use-line-specific-comments.rule.md`
- Enhances `gh-pr-review-always-provide-concrete-examples.rule.md`
- Provides framework for prioritizing all technical feedback
</integration>