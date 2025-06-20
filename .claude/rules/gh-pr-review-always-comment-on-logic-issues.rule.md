---
applies_to:
  - file_patterns: []
  - contexts: ["gh", "github", "pr", "review", "logic"]
  - actions: ["reviewing_pr"]
timing: "during"
summary: "Identify and comment on logic errors, potential bugs, and edge cases"
version: "1.0.0"
---

# Rule: Always Comment on Logic Issues

<purpose>
This rule ensures thorough analysis of code logic to identify potential bugs, logical errors, edge cases, and algorithmic issues that could cause runtime problems or incorrect behavior.
</purpose>

<instructions>
For each changed file, analyze the code logic for these issues:

1. **Logic Errors**: Look for:
   - Incorrect conditional logic (wrong operators, missing conditions)
   - Off-by-one errors in loops and array access
   - Incorrect boolean logic or operator precedence
   - Unreachable code or dead code paths

2. **Edge Case Handling**: Check for:
   - Null/undefined/empty value handling
   - Boundary conditions (min/max values, empty arrays)
   - Unexpected input types or formats
   - Race conditions in async code

3. **Algorithmic Issues**: Identify:
   - Infinite loops or excessive recursion
   - Incorrect algorithm implementation
   - Missing break statements or early returns
   - Incorrect data structure usage

4. **State Management Problems**: Look for:
   - Inconsistent state updates
   - Missing state validation
   - Concurrent access issues
   - Memory leaks or resource cleanup
</instructions>

<analysis_focus>
**Critical areas to examine:**

**Conditional Logic:**
```javascript
// Look for issues like:
if (user.age >= 18 && user.age <= 65) // Missing edge case for exactly 65?
if (items.length > 0 && items[0]) // What if items[0] is falsy but exists?
if (status = "active") // Assignment instead of comparison
```

**Loop Logic:**
```python
# Check for off-by-one errors:
for i in range(len(array)): 
    if array[i+1]: # Will fail on last iteration
        
# Infinite loop potential:
while condition:
    # Missing condition modification
```

**Async/Promise Handling:**
```javascript
// Missing error handling:
async function fetchData() {
    const result = await api.getData(); // What if this throws?
    return result.data; // What if result is null?
}
```

**Resource Management:**
```python
# Missing cleanup:
def process_file(filename):
    file = open(filename) # Should use with statement
    return file.read() # File never closed
```
</analysis_focus>

<comment_strategy>
**When commenting on logic issues:**

1. **Identify the specific problem**: Point to the exact line or block with the issue
2. **Explain the potential consequence**: What could go wrong at runtime
3. **Suggest a fix**: Provide concrete code improvement
4. **Mark severity appropriately**: 
   - **Blocking**: Will cause bugs or failures
   - **Suggestion**: Could cause issues in edge cases
   - **Nitpick**: Minor logic improvements

**Comment format:**
```bash
gh api repos/:owner/:repo/pulls/{number}/comments -X POST \
  -f body="Logic issue: This condition will fail when X is Y because Z. Consider: [suggested fix]" \
  -f commit_id="{sha}" \
  -f path="{filename}" \
  -f side="RIGHT" \
  -F line={line_number}
```
</comment_strategy>

<specific_patterns>
**Common logic issues to catch:**

**Array/List Operations:**
- Index out of bounds access
- Modifying collection while iterating
- Assuming non-empty collections
- Incorrect sorting or filtering logic

**String Operations:**
- Null/empty string handling
- Incorrect substring operations
- Missing string validation
- Case sensitivity issues

**Numeric Operations:**
- Division by zero possibilities
- Integer overflow/underflow
- Floating point precision issues
- Incorrect type conversions

**Function Logic:**
- Missing return statements in all code paths
- Incorrect parameter validation
- Side effects in pure functions
- Recursive functions without base cases

**Error Scenarios:**
- Unhandled exceptions
- Missing input validation
- Incorrect error propagation
- Resource leaks on error paths
</specific_patterns>

<examples>
<correct>
Identifying off-by-one error:
```bash
# Code review finds:
# for (let i = 0; i <= items.length; i++) { items[i].process(); }

gh api repos/:owner/:repo/pulls/45/comments -X POST \
  -f body="Logic error: Loop condition 'i <= items.length' will cause index out of bounds on the last iteration. Should be 'i < items.length' to avoid accessing items[items.length] which is undefined." \
  -f commit_id="a1b2c3..." \
  -f path="processor.js" \
  -f side="RIGHT" \
  -F line=23
```

Finding missing null check:
```bash
# Code review finds:
# const userName = user.profile.name.toLowerCase();

gh api repos/:owner/:repo/pulls/45/comments -X POST \
  -f body="Potential null reference: This will throw if user.profile or user.profile.name is null/undefined. Consider: user.profile?.name?.toLowerCase() || 'anonymous'" \
  -f commit_id="a1b2c3..." \
  -f path="user-service.js" \
  -f side="RIGHT" \
  -F line=67
```
</correct>

<incorrect>
Vague logic comment:
```bash
# ❌ WRONG - not specific about the issue
gh api repos/:owner/:repo/pulls/45/comments -X POST \
  -f body="This logic looks wrong" \
  -f commit_id="a1b2c3..." \
  -f path="processor.js" \
  -f side="RIGHT" \
  -F line=23
```
</incorrect>
</examples>

<validation_checklist>
**Before finalizing logic review:**
- [ ] Traced through each conditional branch
- [ ] Checked loop boundaries and termination conditions
- [ ] Verified null/undefined handling
- [ ] Examined async operation error handling
- [ ] Looked for resource cleanup requirements
- [ ] Identified any unreachable code
- [ ] Checked for potential race conditions
- [ ] Verified algorithm correctness
</validation_checklist>

<integration>
This rule works with:
- Information from `gh-pr-review-always-fetch-pr-details-first.rule.md`
- Complements `gh-pr-review-always-check-error-handling.rule.md`
- Provides input for `gh-pr-review-always-verify-test-coverage.rule.md`
</integration>