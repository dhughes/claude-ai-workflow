---
applies_to:
  - file_patterns: []
  - contexts: ["gh", "github", "pr", "review", "maintainability"]
  - actions: ["reviewing_pr"]
timing: "during"
summary: "Flag complex code, poor naming, lack of documentation, and maintainability issues"
version: "1.0.0"
---

# Rule: Always Comment on Maintainability Problems

<purpose>
This rule ensures that code maintainability issues are identified and addressed, including complex code that's hard to understand, poor naming conventions, missing documentation, and structural problems that will make future changes difficult.
</purpose>

<instructions>
Review code changes for maintainability issues:

1. **Code Complexity**: Look for:
   - Functions that are too long or do too many things
   - Deeply nested code structures
   - Complex conditional logic
   - High cyclomatic complexity

2. **Naming and Clarity**: Check for:
   - Unclear or misleading variable/function names
   - Inconsistent naming conventions
   - Magic numbers or strings without explanation
   - Abbreviated names that are hard to understand

3. **Documentation**: Identify missing:
   - Function/method documentation
   - Complex algorithm explanations
   - API usage examples
   - Configuration documentation

4. **Code Organization**: Look for:
   - Large classes or modules
   - Mixed concerns in single functions
   - Tight coupling between components
   - Violation of single responsibility principle
</instructions>

<complexity_indicators>
**Signs of excessive complexity:**

**Function Length:**
```javascript
// Too long - hard to understand and test
function processUserData(userData) {
    // 50+ lines of mixed validation, transformation, 
    // database operations, and business logic
}

// Better - broken into focused functions
function processUserData(userData) {
    const validatedData = validateUserData(userData);
    const transformedData = transformUserData(validatedData);
    return saveUserData(transformedData);
}
```

**Deep Nesting:**
```python
# Too deeply nested - hard to follow
if user:
    if user.is_active:
        if user.has_permission:
            if feature_enabled:
                if quota_available:
                    # actual logic buried deep
                    
# Better - early returns
if not user or not user.is_active:
    return error_response("Invalid user")
if not user.has_permission:
    return error_response("No permission")
if not feature_enabled or not quota_available:
    return error_response("Feature unavailable")
# actual logic at top level
```

**Complex Conditionals:**
```java
// Hard to understand
if ((user.getAge() >= 18 && user.getAge() <= 65) && 
    (user.getCountry().equals("US") || user.getCountry().equals("CA")) &&
    user.getAccountType() != AccountType.SUSPENDED && 
    user.getLastLoginDate().isAfter(thirtyDaysAgo)) {
    // logic
}

// Better - extracted to meaningful methods
if (isEligibleUser(user) && isRecentlyActive(user)) {
    // logic
}
```
</complexity_indicators>

<naming_issues>
**Poor naming patterns to flag:**

**Unclear Names:**
```javascript
// Poor naming
function calc(d, r, t) { return d * r * t; }
const x = getUserData();
let flag = true;

// Clear naming
function calculateDistance(duration, rate, time) { return duration * rate * time; }
const currentUser = getUserData();
let isUserValid = true;
```

**Misleading Names:**
```python
# Misleading - doesn't actually get all users
def get_all_users():
    return User.objects.filter(is_active=True).limit(10)

# Clear about what it does
def get_active_users_sample(limit=10):
    return User.objects.filter(is_active=True).limit(limit)
```

**Magic Values:**
```java
// Magic numbers
if (user.getAge() > 65) { return "senior"; }
if (attempts >= 3) { lockAccount(); }

// Named constants
private static final int SENIOR_AGE_THRESHOLD = 65;
private static final int MAX_LOGIN_ATTEMPTS = 3;

if (user.getAge() > SENIOR_AGE_THRESHOLD) { return "senior"; }
if (attempts >= MAX_LOGIN_ATTEMPTS) { lockAccount(); }
```
</naming_issues>

<documentation_gaps>
**Missing documentation to identify:**

**Complex Algorithms:**
```python
# Needs explanation
def transform_data(data):
    # Complex mathematical transformation without explanation
    result = []
    for i, item in enumerate(data):
        if i % 2 == 0:
            result.append(item * 0.7 + sum(data[max(0, i-2):i+3]) / 5)
    return result
```

**Public APIs:**
```javascript
// Missing parameter and return documentation
function processPayment(amount, currency, options) {
    // Implementation without explaining parameters or return value
}
```

**Configuration:**
```yaml
# Missing explanation of what these values do
timeout: 5000
retry_count: 3
batch_size: 50
```
</documentation_gaps>

<comment_guidelines>
**When commenting on maintainability issues:**

1. **Identify the specific problem**: Point to what makes the code hard to maintain
2. **Explain the impact**: How this affects future development
3. **Suggest improvements**: Provide concrete refactoring suggestions
4. **Consider the scope**: Is this a small fix or larger refactoring?

**Comment template:**
```bash
gh api repos/:owner/:repo/pulls/{number}/comments -X POST \
  -f body="Maintainability issue: [specific problem]. Impact: [how it affects maintenance]. Suggested improvement: [concrete suggestion]" \
  -f commit_id="{sha}" \
  -f path="{filename}" \
  -f side="RIGHT" \
  -F line={line_number}
```
</comment_guidelines>

<severity_classification>
**Maintainability issue severities:**

**High (Suggestion):**
- Functions over 50 lines doing multiple things
- Complex nested conditionals (3+ levels)
- Misleading function/variable names
- Missing documentation for public APIs

**Medium (Suggestion):**
- Functions over 20 lines with single responsibility
- Magic numbers/strings without constants
- Inconsistent naming within a module
- Missing comments for complex logic

**Low (Nitpick):**
- Minor naming improvements
- Additional documentation that would be helpful
- Small organizational improvements
- Style consistency issues
</severity_classification>

<examples>
<correct>
Identifying overly complex function:
```bash
# Code finds 60-line function doing validation, transformation, and saving

gh api repos/:owner/:repo/pulls/45/comments -X POST \
  -f body="Maintainability issue: This function is 60 lines and handles validation, transformation, and database operations. Impact: Hard to test, debug, and modify individual concerns. Suggested improvement: Extract into separate functions: validateUserInput(), transformUserData(), and saveUserToDatabase()" \
  -f commit_id="a1b2c3..." \
  -f path="user_service.py" \
  -f side="RIGHT" \
  -F start_line=45 \
  -F line=105
```

Identifying poor naming:
```bash
# Code finds: def calc(x, y, z): return x * y + z * 0.1

gh api repos/:owner/:repo/pulls/45/comments -X POST \
  -f body="Maintainability issue: Function name 'calc' and parameters 'x, y, z' don't explain what calculation is being performed. Impact: Other developers won't understand the purpose without reading implementation. Suggested improvement: def calculateTotalWithTax(price, quantity, taxRate): return price * quantity + taxRate * 0.1" \
  -f commit_id="a1b2c3..." \
  -f path="billing.py" \
  -f side="RIGHT" \
  -F line=23
```
</correct>

<incorrect>
Vague maintainability comment:
```bash
# ❌ WRONG - not specific about the issue or solution
gh api repos/:owner/:repo/pulls/45/comments -X POST \
  -f body="This code is hard to read" \
  -f commit_id="a1b2c3..." \
  -f path="user_service.py" \
  -f side="RIGHT" \
  -F line=45
```
</incorrect>
</examples>

<specific_checks>
**Maintainability checklist:**

**Function Design:**
- Single responsibility principle adherence
- Appropriate function length (generally <30 lines)
- Clear input/output contracts
- Minimal side effects

**Variable Management:**
- Descriptive variable names
- Appropriate scope and lifetime
- Immutability where possible
- Avoiding global state

**Code Structure:**
- Logical organization and grouping
- Consistent indentation and formatting
- Appropriate abstraction levels
- Clear separation of concerns

**Dependencies:**
- Minimal coupling between modules
- Clear dependency directions
- Avoiding circular dependencies
- Interface-based design where appropriate
</specific_checks>

<validation_checklist>
**Maintainability review complete when checked:**
- [ ] All functions have clear, single responsibilities
- [ ] Variable and function names are descriptive
- [ ] Complex logic has explanatory comments
- [ ] No magic numbers or strings without constants
- [ ] Nesting depth is reasonable (typically <4 levels)
- [ ] Function length is manageable (typically <30 lines)
- [ ] Code organization follows logical patterns
- [ ] Public interfaces have documentation
- [ ] Dependencies are minimal and clear
</validation_checklist>

<integration>
This rule works with:
- Context from `gh-pr-review-always-check-against-project-patterns.rule.md`
- Informs `gh-pr-review-always-suggest-refactoring-opportunities.rule.md`
- Complements `gh-pr-review-always-verify-test-coverage.rule.md`
</integration>