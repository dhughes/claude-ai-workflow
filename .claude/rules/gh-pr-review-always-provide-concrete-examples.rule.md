---
applies_to:
  - file_patterns: []
  - contexts: ["gh", "github", "pr", "review", "examples"]
  - actions: ["reviewing_pr"]
timing: "during"
summary: "Include code snippets or specific suggestions in review comments"
version: "1.0.0"
---

# Rule: Always Provide Concrete Examples

<purpose>
This rule ensures that review comments include specific, actionable examples such as code snippets, exact suggestions, or concrete alternatives rather than vague feedback, making it easier for developers to understand and implement the suggested changes.
</purpose>

<instructions>
Every review comment MUST include concrete examples:

1. **Code Snippets**: When suggesting improvements, show exactly what the code should look like
2. **Specific Alternatives**: Provide concrete alternative implementations
3. **Exact Fixes**: Give precise solutions rather than general advice
4. **Before/After Examples**: Show the current code issue and the improved version
5. **Configuration Examples**: Provide exact configuration values or settings
6. **Test Examples**: Show specific test cases that should be added

**Format requirements:**
- Use code blocks with appropriate language syntax highlighting
- Provide complete, working examples when possible
- Include inline comments explaining the changes
- Show both problematic code and improved version when relevant
</instructions>

<example_types>
**Types of concrete examples to provide:**

**Code Improvement Examples:**
```javascript
// Current code (problematic):
if (user && user.profile && user.profile.preferences && user.profile.preferences.theme) {
    applyTheme(user.profile.preferences.theme);
}

// Suggested improvement:
const theme = user?.profile?.preferences?.theme;
if (theme) {
    applyTheme(theme);
}
```

**Security Fix Examples:**
```python
# Current code (vulnerable):
query = f"SELECT * FROM users WHERE id = {user_id}"

# Suggested fix:
query = "SELECT * FROM users WHERE id = %s"
cursor.execute(query, (user_id,))
```

**Performance Optimization Examples:**
```java
// Current code (O(n²)):
for (User user : users) {
    for (Role role : roles) {
        if (role.getUserId() == user.getId()) {
            user.addRole(role);
        }
    }
}

// Suggested optimization (O(n)):
Map<Integer, List<Role>> rolesByUserId = roles.stream()
    .collect(Collectors.groupingBy(Role::getUserId));
for (User user : users) {
    List<Role> userRoles = rolesByUserId.get(user.getId());
    if (userRoles != null) {
        user.addRoles(userRoles);
    }
}
```

**Error Handling Examples:**
```javascript
// Current code (missing error handling):
const data = await fetch('/api/data');
const result = data.json();

// Suggested improvement:
try {
    const response = await fetch('/api/data');
    if (!response.ok) {
        throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    }
    const data = await response.json();
    return data;
} catch (error) {
    console.error('Failed to fetch data:', error);
    throw new Error('Unable to load data. Please try again.');
}
```
</example_types>

<comment_structure>
**Structure for concrete examples in comments:**

**Problem + Solution Format:**
```
[Issue description]

Current code:
```language
[problematic code]
```

Suggested improvement:
```language
[improved code]
```

[Explanation of why this is better]
```

**Alternative Approach Format:**
```
[Issue description]

Consider this alternative:
```language
[suggested code]
```

Benefits: [specific benefits of the suggestion]
```

**Configuration Example Format:**
```
[Configuration issue description]

Add this configuration:
```language
[exact configuration]
```

This will [specific outcome/behavior]
```
</comment_structure>

<specific_guidance>
**Guidelines for different types of suggestions:**

**For Logic Issues:**
- Show the exact conditional logic fix
- Include edge cases in the example
- Demonstrate the correct algorithm implementation
- Provide test cases that would catch the issue

**For Performance Issues:**
- Show the more efficient algorithm
- Include complexity analysis (O(n) vs O(n²))
- Provide benchmarking suggestions
- Show memory usage improvements

**For Security Issues:**
- Provide the secure implementation
- Show input validation examples
- Include sanitization code
- Reference security standards (OWASP, etc.)

**For Maintainability Issues:**
- Show the refactored structure
- Provide clearer naming examples
- Include documentation examples
- Demonstrate separation of concerns

**For Missing Tests:**
- Provide specific test cases
- Show test structure and assertions
- Include edge cases to test
- Demonstrate mocking examples
</specific_guidance>

<examples>
<correct>
Logic issue with concrete fix:
```bash
gh api repos/:owner/:repo/pulls/45/comments -X POST \
  -f body="Logic error: Off-by-one error will cause index out of bounds.

Current code:
\`\`\`javascript
for (let i = 0; i <= items.length; i++) {
    processItem(items[i]); // Error: items[items.length] is undefined
}
\`\`\`

Suggested fix:
\`\`\`javascript
for (let i = 0; i < items.length; i++) {
    processItem(items[i]);
}
\`\`\`

This prevents accessing \`items[items.length]\` which is beyond the array bounds." \
  -f commit_id="a1b2c3..." \
  -f path="processor.js" \
  -f side="RIGHT" \
  -F line=23
```

Security issue with exact solution:
```bash
gh api repos/:owner/:repo/pulls/45/comments -X POST \
  -f body="Security vulnerability: SQL injection risk from string concatenation.

Current code:
\`\`\`python
query = f\"SELECT * FROM users WHERE name = '{username}'\"
cursor.execute(query)
\`\`\`

Secure fix:
\`\`\`python
query = \"SELECT * FROM users WHERE name = %s\"
cursor.execute(query, (username,))
\`\`\`

This uses parameterized queries to prevent SQL injection attacks. Reference: OWASP A03:2021 Injection" \
  -f commit_id="a1b2c3..." \
  -f path="user_service.py" \
  -f side="RIGHT" \
  -F line=67
```

Missing tests with specific test cases:
```bash
gh api repos/:owner/:repo/pulls/45/comments -X POST \
  -f body="Test coverage gap: Missing tests for input validation.

Add these test cases:
\`\`\`javascript
describe('validateEmail', () => {
  test('should accept valid email', () => {
    expect(validateEmail('user@example.com')).toBe(true);
  });
  
  test('should reject email without @', () => {
    expect(validateEmail('userexample.com')).toBe(false);
  });
  
  test('should reject empty string', () => {
    expect(validateEmail('')).toBe(false);
  });
  
  test('should reject null/undefined', () => {
    expect(validateEmail(null)).toBe(false);
    expect(validateEmail(undefined)).toBe(false);
  });
});
\`\`\`

These tests cover the main validation scenarios and edge cases." \
  -f commit_id="a1b2c3..." \
  -f path="validators.js" \
  -f side="RIGHT" \
  -F line=45
```
</correct>

<incorrect>
Vague suggestion without examples:
```bash
# ❌ WRONG - no concrete example
gh api repos/:owner/:repo/pulls/45/comments -X POST \
  -f body="This loop could be more efficient" \
  -f commit_id="a1b2c3..." \
  -f path="processor.js" \
  -f side="RIGHT" \
  -F line=23
```

General advice without specific code:
```bash
# ❌ WRONG - no actionable example
gh api repos/:owner/:repo/pulls/45/comments -X POST \
  -f body="Consider using better error handling here" \
  -f commit_id="a1b2c3..." \
  -f path="user_service.py" \
  -f side="RIGHT" \
  -F line=67
```
</incorrect>
</examples>

<code_block_formatting>
**Proper code block formatting in GitHub comments:**

**Single Language Blocks:**
```
```javascript
function example() {
    return "formatted code";
}
```
```

**Diff-style Comparisons:**
```
```diff
- const result = items.filter(i => i.active == true);
+ const result = items.filter(i => i.active === true);
```
```

**Multiple Examples:**
```
Before:
```python
if user != None:
    process(user)
```

After:
```python
if user is not None:
    process(user)
```
```

**Inline Code:**
Use backticks for short inline code: `variable.method()` or `className.property`
</code_block_formatting>

<reference_inclusion>
**Include relevant references:**

**Documentation Links:**
- Language-specific best practices
- Framework documentation
- API documentation
- Style guide references

**Standards References:**
- OWASP security guidelines
- Performance benchmarking standards
- Testing best practices
- Code quality metrics

**Example Reference Formats:**
```
Reference: MDN Web Docs - Array.prototype.forEach()
See: React Testing Library - Common mistakes
OWASP: A03:2021 - Injection
Performance: Big O Notation Guide
```
</reference_inclusion>

<validation_checklist>
**Before posting comments, ensure they include:**
- [ ] Specific code examples showing the issue
- [ ] Concrete suggestions with exact code
- [ ] Proper syntax highlighting in code blocks
- [ ] Clear explanation of why the change is beneficial
- [ ] Complete, working examples when possible
- [ ] Relevant references or documentation links
- [ ] Before/after comparison when appropriate
- [ ] Test cases for testing-related suggestions
- [ ] Configuration examples for setup-related issues
</validation_checklist>

<integration>
This rule enhances:
- All other PR review rules by making their feedback concrete
- Works with `gh-pr-review-always-use-line-specific-comments.rule.md`
- Supports `gh-pr-review-always-categorize-comment-severity.rule.md`
- Makes all technical feedback more actionable and implementable
</integration>