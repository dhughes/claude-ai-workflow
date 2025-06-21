---
applies_to:
  - file_patterns: ["*.js", "*.ts", "*.py", "*.java", "*.cpp", "*.c", "*.cs", "*.go", "*.rs"]
  - contexts: ["gh", "github", "pr", "review", "logic", "algorithms", "code_analysis"]
  - actions: ["analyzing_code_logic", "reviewing_algorithms", "checking_conditionals"]
timing: "before"
summary: "Always analyze code changes for logic errors including off-by-one errors, incorrect conditionals, algorithmic issues, and unreachable code"
version: "1.0.0"
---

# Rule: Analyze Logic Errors In Code Changes

<purpose>
This rule ensures comprehensive analysis of code changes to identify logic errors that could cause runtime bugs, including off-by-one errors, incorrect conditionals, flawed algorithms, and unreachable code sections.
</purpose>

<instructions>
When reviewing code changes, systematically analyze for logic errors:

1. **Search for common logic error patterns**:
   ```bash
   # Off-by-one errors
   Grep pattern="<=.*\.length" include="*.js,*.ts,*.py"
   Grep pattern="<.*\.length.*\+" include="*.js,*.ts,*.py"
   
   # Incorrect conditionals
   Grep pattern="if.*=.*(?!==)" include="*.js,*.ts,*.py"
   Grep pattern="if.*null.*==" include="*.js,*.ts,*.py"
   
   # Loop logic issues
   Grep pattern="for.*--.*i\+\+" include="*.js,*.ts,*.py"
   ```

2. **Analyze algorithmic correctness**:
   - Verify loop termination conditions
   - Check array/list boundary handling
   - Validate recursive function base cases
   - Examine sorting and searching logic

3. **Identify unreachable code**:
   - Code after return statements
   - Conditions that can never be true
   - Dead branches in conditional logic
   - Unused function parameters or variables

4. **Post specific feedback for identified issues**:
   - Use line-specific comments for each logic error
   - Explain the potential impact and suggest fixes
   - Provide examples of correct implementation

**Focus on logic that could cause runtime failures or unexpected behavior.**
</instructions>

<logic_error_patterns>
**Common logic error patterns to detect:**

**Off-by-One Errors:**
```javascript
// WRONG: Array index out of bounds
for (let i = 0; i <= array.length; i++) { }  // Should be <, not <=

// WRONG: Missing last element
for (let i = 0; i < array.length - 1; i++) { } // Should be array.length

// WRONG: String slicing
str.substring(0, str.length + 1) // Beyond string bounds
```

**Incorrect Conditionals:**
```javascript
// WRONG: Assignment instead of comparison
if (user.role = 'admin') { } // Should be == or ===

// WRONG: Null/undefined confusion
if (value == null) { } // May not catch undefined correctly

// WRONG: Type coercion issues
if (count == "0") { } // May have unintended type conversion
```

**Algorithmic Issues:**
```javascript
// WRONG: Infinite loop potential
while (i < 10) { 
    // Missing i++ increment
}

// WRONG: Incorrect recursive base case
function factorial(n) {
    if (n <= 0) return 1; // Should handle n === 1 case differently
    return n * factorial(n - 1);
}
```

**Unreachable Code:**
```javascript
// WRONG: Code after return
function example() {
    return true;
    console.log("This will never execute"); // Unreachable
}

// WRONG: Impossible condition
if (value > 10 && value < 5) { // Can never be true
    // Unreachable code
}
```
</logic_error_patterns>

<analysis_process>
**Step-by-step logic analysis:**

1. **Initial pattern scanning**:
   ```bash
   # Scan for boundary condition issues
   Grep pattern="\.length.*[+\-].*1" include="*.js"
   Grep pattern="<=.*\.length" include="*.js"
   
   # Look for assignment in conditionals
   Grep pattern="if.*[^!=]==?[^=]" include="*.js"
   
   # Find potential infinite loops
   Grep pattern="while.*\{[^}]*\}" include="*.js"
   ```

2. **Detailed code examination**:
   ```bash
   # Read specific functions with suspected issues
   Read file_path="suspected-file.js" offset="function_start" limit="function_length"
   ```

3. **Logic flow analysis**:
   - Trace execution paths through conditionals
   - Verify loop initialization, condition, and increment
   - Check function return paths and edge cases
   - Validate error handling and boundary conditions

4. **Impact assessment**:
   - Determine potential runtime consequences
   - Assess data corruption or security risks
   - Evaluate user experience impact
</analysis_process>

<examples>
<correct>
Identifying off-by-one error:
```bash
# Found suspicious loop pattern
Grep pattern="<=.*\.length" include="*.js"

# Examine the specific code
Read file_path="utils/processor.js" offset="45" limit="10"

# Code shows: for (let i = 0; i <= items.length; i++)
# Post line-specific comment:
gh api repos/owner/repo/pulls/123/comments \
  --field body="Off-by-one error: Loop condition 'i <= items.length' will access items[items.length] which is undefined. Change to 'i < items.length' to fix the boundary issue." \
  --field path="utils/processor.js" \
  --field line="47"
```

Identifying incorrect conditional:
```bash
# Search for assignment in conditionals
Grep pattern="if.*=.*[^=]" include="*.js"

# Examine suspicious code
Read file_path="auth/validator.js" offset="32" limit="5"

# Code shows: if (user.role = 'admin')
# Post feedback:
gh api repos/owner/repo/pulls/456/comments \
  --field body="Assignment instead of comparison: 'user.role = \"admin\"' assigns value instead of comparing. Use '===' for strict equality: 'if (user.role === \"admin\")'" \
  --field path="auth/validator.js" \
  --field line="34"
```

Identifying unreachable code:
```bash
# Look for return statements followed by code
Grep pattern="return.*;.*console\|return.*;.*throw" include="*.js"

# Examine the function
Read file_path="services/api.js" offset="78" limit="15"

# Found code after return statement
gh api repos/owner/repo/pulls/789/comments \
  --field body="Unreachable code: The console.log statement after 'return result;' will never execute. Either move the logging before the return or remove it if not needed." \
  --field path="services/api.js" \
  --field line="85"
```
</correct>

<incorrect>
Missing logic analysis:
```bash
# ❌ WRONG - reviewing code without checking for logic errors
# Only looking at style issues, missing algorithmic problems
# Should systematically check for off-by-one, conditionals, etc.
```

Superficial pattern detection:
```bash
# ❌ WRONG - finding patterns but not analyzing logic
grep "if.*=" file.js  # Found pattern but didn't examine context
# Should read actual code and verify the logic issue exists
```

Generic feedback without specifics:
```bash
# ❌ WRONG - vague logic error comment
"There might be logic errors in this function"
# Should identify specific issues with precise line references
```
</incorrect>
</examples>

<advanced_analysis>
**Advanced logic error detection:**

**Recursive Function Issues:**
```bash
# Look for recursive calls without base cases
Grep pattern="function.*\{.*function_name.*\(" include="*.js"
# Verify base case handling and termination conditions
```

**Async Logic Errors:**
```bash
# Find async/await misuse
Grep pattern="for.*await.*forEach\|map.*await" include="*.js"
# Check for sequential vs parallel execution issues
```

**State Management Logic:**
```bash
# Look for state mutation issues
Grep pattern="state\..*=.*\|setState.*state\." include="*.js"
# Verify immutability and state consistency
```

**Error Handling Logic:**
```bash
# Find try/catch with logic issues
Grep pattern="try.*\{.*\}.*catch.*\{.*\}" include="*.js"
# Check for proper error propagation and handling
```
</advanced_analysis>

<integration>
This rule works with:
- `gh-pr-review-always-verify-line-content-before-commenting.rule.md` for accuracy
- `gh-pr-review-always-use-line-specific-comments-for-code-issues.rule.md` for proper feedback
- All other PR analysis rules for comprehensive review

This rule identifies:
- Runtime bugs before they reach production
- Potential data corruption issues
- Performance problems from algorithmic errors
- Security vulnerabilities from logic flaws
</integration>

<validation>
Logic error analysis complete when:
- [ ] Common logic error patterns searched across changed files
- [ ] Loop boundaries and conditions verified
- [ ] Conditional logic accuracy confirmed
- [ ] Unreachable code sections identified
- [ ] Algorithmic correctness validated
- [ ] Specific line-specific feedback posted for each issue found
- [ ] Impact and fix suggestions provided for all logic errors
</validation>