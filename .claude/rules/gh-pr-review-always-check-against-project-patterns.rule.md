---
applies_to:
  - file_patterns: []
  - contexts: ["gh", "github", "pr", "review", "patterns"]
  - actions: ["reviewing_pr"]
timing: "before"
summary: "Compare PR changes against existing codebase patterns and conventions"
version: "1.0.0"
---

# Rule: Always Check Against Project Patterns

<purpose>
This rule ensures that PR changes are evaluated against existing codebase patterns, naming conventions, architectural decisions, and coding standards to maintain consistency and identify deviations that may need attention.
</purpose>

<instructions>
After gathering PR details, analyze the changed files against project patterns:

1. **Examine similar existing files**: For each changed file, find similar files in the codebase to understand:
   - Naming conventions
   - Code structure patterns
   - Import/dependency patterns
   - Error handling approaches

2. **Check architectural consistency**: Verify changes align with:
   - Existing directory structure
   - Module organization patterns
   - Design patterns in use
   - Data flow conventions

3. **Validate against project standards**: Look for:
   - Consistent code formatting
   - Documentation patterns
   - Testing conventions
   - Configuration approaches

4. **Identify pattern deviations**: Flag cases where changes:
   - Introduce new patterns without justification
   - Break existing conventions
   - Use different approaches than similar code
   - Miss opportunities to follow established patterns
</instructions>

<pattern_analysis>
**Areas to examine:**

**File Organization:**
- Directory structure consistency
- File naming conventions
- Module grouping logic

**Code Structure:**
- Function/method organization
- Class design patterns
- Import statement conventions
- Error handling patterns

**Naming Conventions:**
- Variable naming styles
- Function/method naming
- Constant naming patterns
- Type/interface naming

**Documentation Patterns:**
- Comment styles and placement
- Documentation string formats
- README and config patterns
</pattern_analysis>

<search_strategy>
**Use these tools to understand patterns:**

```bash
# Find similar files by name pattern
Glob pattern="**/*{similar_name}*"

# Search for similar code patterns
Grep pattern="class.*{ClassName}" include="*.js,*.ts"

# Find existing implementations
Grep pattern="function.*{functionType}" include="*.py"
```

**Look for:**
- Files with similar responsibilities
- Existing implementations of similar features
- Configuration files and their patterns
- Test files and their structure
</search_strategy>

<comment_guidelines>
**When patterns are inconsistent, comment with:**

1. **Reference to existing pattern**: Point to similar code that follows the established pattern
2. **Specific deviation**: Explain exactly what differs from the pattern
3. **Suggested alignment**: Provide concrete steps to match existing conventions
4. **Rationale**: Explain why consistency matters for this pattern

**Comment severity:**
- **Blocking**: Breaks critical architectural patterns
- **Suggestion**: Minor deviations that could be improved
- **Nitpick**: Style preferences that don't affect functionality
</comment_guidelines>

<examples>
<correct>
Finding pattern deviation:
```bash
# PR changes authentication in user.js
# Search for existing auth patterns
Grep pattern="authenticate.*user" include="*.js"
# Find: auth/service.js, admin/auth.js both use AuthService class

# Comment on line where new auth code deviates:
gh api repos/:owner/:repo/pulls/45/comments -X POST \
  -f body="This authentication approach differs from the established pattern used in auth/service.js:23 and admin/auth.js:45. Consider using the AuthService class for consistency." \
  -f commit_id="a1b2c3..." \
  -f path="user.js" \
  -f side="RIGHT" \
  -F line=67
```
</correct>

<incorrect>
Generic pattern comment:
```bash
# ❌ WRONG - vague comment without specific reference
gh api repos/:owner/:repo/pulls/45/comments -X POST \
  -f body="This doesn't follow our patterns" \
  -f commit_id="a1b2c3..." \
  -f path="user.js" \
  -f side="RIGHT" \
  -F line=67
```
</incorrect>
</examples>

<specific_patterns_to_check>
**Common pattern areas:**

**Error Handling:**
- Exception types and handling strategies
- Error message formats and logging
- Retry and fallback patterns

**Configuration:**
- Environment variable usage
- Config file structures
- Default value patterns

**Testing:**
- Test file naming and organization
- Assertion patterns and styles
- Mock and fixture patterns

**API Design:**
- Request/response patterns
- Validation approaches
- Authentication/authorization patterns

**Database/Storage:**
- Query patterns and organization
- Migration file structures
- Schema design conventions
</specific_patterns_to_check>

<integration>
This rule works after `gh-pr-review-always-fetch-pr-details-first.rule.md` and provides context for:
- `gh-pr-review-always-comment-on-maintainability-problems.rule.md`
- `gh-pr-review-always-suggest-refactoring-opportunities.rule.md`
- Other technical analysis rules
</integration>

<validation>
Pattern analysis complete when you have:
- [ ] Identified similar files and their patterns
- [ ] Found any deviations from established conventions
- [ ] Located examples of correct patterns to reference
- [ ] Determined severity of any pattern violations
- [ ] Prepared specific, actionable feedback with examples
</validation>