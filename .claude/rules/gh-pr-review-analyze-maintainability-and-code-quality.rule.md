---
applies_to:
  - file_patterns: ["*.js", "*.ts", "*.py", "*.java", "*.cpp", "*.c", "*.cs", "*.go", "*.rs"]
  - contexts: ["gh", "github", "pr", "review", "maintainability", "code_quality", "complexity"]
  - actions: ["analyzing_maintainability", "reviewing_code_complexity", "checking_naming_conventions"]
timing: "before"
summary: "Always analyze code changes for maintainability issues including complexity, naming conventions, documentation gaps, and code organization problems"
version: "1.0.0"
---

# Rule: Analyze Maintainability And Code Quality

<purpose>
This rule ensures code changes maintain high quality standards by identifying complexity issues, poor naming conventions, missing documentation, and organizational problems that could hinder long-term maintainability.
</purpose>

<instructions>
When reviewing code changes, analyze maintainability factors:

1. **Check for complexity indicators**:
   ```bash
   # Long functions and files
   Grep pattern="function.*\{[^}]{200,}" include="*.js,*.ts"
   Grep pattern="def.*:[^}]{200,}" include="*.py"
   
   # Deep nesting
   Grep pattern="if.*if.*if.*if" include="*.js,*.ts,*.py"
   
   # Large parameter lists
   Grep pattern="function.*\(.*,.*,.*,.*,.*\)" include="*.js,*.ts"
   ```

2. **Verify naming conventions**:
   ```bash
   # Poor naming patterns
   Grep pattern="function [a-z]{1,2}\(|var [a-z]{1,2} =" include="*.js,*.ts"
   Grep pattern="def [a-z]{1,2}\(" include="*.py"
   
   # Inconsistent naming
   Grep pattern="camelCase.*snake_case|snake_case.*camelCase" include="*.js,*.ts"
   ```

3. **Assess documentation coverage**:
   ```bash
   # Missing function documentation
   Grep pattern="function [^/]*\{|def [^#]*:" include="*.js,*.ts,*.py"
   
   # TODO/FIXME comments
   Grep pattern="TODO|FIXME|HACK|XXX" include="*.js,*.ts,*.py"
   ```

4. **Post maintainability feedback**:
   - Use line-specific comments for complexity issues
   - Suggest refactoring opportunities
   - Recommend better naming and documentation
   - Identify code organization improvements

**Focus on changes that impact long-term code maintainability.**
</instructions>

<maintainability_issues>
**Key maintainability problems to identify:**

**Excessive Complexity:**
```javascript
// COMPLEX: Too many responsibilities
function processUserData(user, options, callbacks, config, state) {
    if (user && user.id && options && options.validate) {
        if (config.allowUpdates) {
            if (state.isActive) {
                // 50+ lines of nested logic
            }
        }
    }
}

// MAINTAINABLE: Single responsibility
function validateUser(user) { /* validation logic */ }
function updateUserIfAllowed(user, config) { /* update logic */ }
function processActiveUser(user) { /* processing logic */ }
```

**Poor Naming:**
```javascript
// POOR: Unclear names
function f(d, t) {
    const x = d.filter(i => i.t > t);
    return x.map(i => i.v);
}

// CLEAR: Descriptive names
function getActiveUserValues(users, thresholdTime) {
    const activeUsers = users.filter(user => user.lastActive > thresholdTime);
    return activeUsers.map(user => user.value);
}
```

**Missing Documentation:**
```javascript
// UNDOCUMENTED: Purpose unclear
function transform(data, config) {
    return data.reduce((acc, item) => {
        const key = config.keyExtractor(item);
        acc[key] = config.transformer(item);
        return acc;
    }, {});
}

// DOCUMENTED: Clear purpose and usage
/**
 * Transforms an array into an object using configurable key extraction and transformation
 * @param {Array} data - Source array to transform
 * @param {Object} config - Configuration object
 * @param {Function} config.keyExtractor - Function to extract key from each item
 * @param {Function} config.transformer - Function to transform each item value
 * @returns {Object} Transformed object with extracted keys and transformed values
 */
function transformArrayToObject(data, config) { /* ... */ }
```
</maintainability_issues>

<validation>
Maintainability analysis complete when:
- [ ] Function and class complexity assessed
- [ ] Naming conventions verified across all changes
- [ ] Documentation coverage evaluated
- [ ] Code organization and structure reviewed
- [ ] Refactoring opportunities identified
- [ ] Specific maintainability feedback posted
</validation>