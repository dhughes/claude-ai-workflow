---
applies_to:
  - file_patterns: ["*.js", "*.ts", "*.py", "*.java", "*.cs", "*.go", "*.rs"]
  - contexts: ["gh", "github", "pr", "review", "testing", "coverage", "quality_assurance"]
  - actions: ["reviewing_test_coverage", "analyzing_test_completeness", "checking_test_quality"]
timing: "before"
summary: "Always ensure appropriate test coverage exists for new and changed functionality in code changes"
version: "1.0.0"
---

# Rule: Ensure Appropriate Test Coverage

<purpose>
This rule ensures that all new and modified functionality includes appropriate test coverage, preventing regressions and maintaining code quality through comprehensive testing strategies.
</purpose>

<instructions>
When reviewing code changes, verify test coverage:

1. **Identify new functionality requiring tests**:
   ```bash
   # Find new functions and methods
   Grep pattern="^\+.*function|^\+.*def |^\+.*class" include="*.js,*.ts,*.py"
   
   # Look for corresponding test files
   Glob pattern="**/*test*.js" 
   Glob pattern="**/*spec*.js"
   Glob pattern="**/test_*.py"
   ```

2. **Verify test file existence and completeness**:
   ```bash
   # Check if test files exist for changed modules
   # For src/user-service.js, look for:
   # - src/user-service.test.js
   # - tests/user-service.test.js  
   # - __tests__/user-service.test.js
   ```

3. **Analyze test quality and coverage**:
   - Check for unit tests covering new functions
   - Verify integration tests for API endpoints
   - Ensure edge cases and error conditions are tested
   - Validate test assertions are meaningful

4. **Post test coverage feedback**:
   - Use general PR comments for missing test strategy
   - Suggest specific test cases for uncovered scenarios
   - Recommend appropriate test types (unit, integration, e2e)
   - Request test additions before merge approval

**New functionality should not be merged without appropriate tests.**
</instructions>

<test_coverage_requirements>
**What requires test coverage:**

**New Functions/Methods:**
```javascript
// NEW FUNCTION - Requires unit tests
+function calculateTax(amount, rate) {
+    if (amount <= 0) throw new Error('Amount must be positive');
+    return amount * rate;
+}

// Required tests:
// - Normal calculation: calculateTax(100, 0.1) === 10
// - Zero amount: expect(() => calculateTax(0, 0.1)).toThrow()
// - Negative amount: expect(() => calculateTax(-10, 0.1)).toThrow()
// - Edge case: calculateTax(0.01, 0.999)
```

**New API Endpoints:**
```javascript
// NEW ENDPOINT - Requires integration tests
+app.post('/api/users', async (req, res) => {
+    const user = await createUser(req.body);
+    res.status(201).json(user);
+});

// Required tests:
// - Successful user creation: POST /api/users with valid data
// - Validation errors: POST /api/users with invalid data
// - Authentication required: POST /api/users without auth
// - Duplicate user handling: POST /api/users with existing email
```

**Modified Business Logic:**
```javascript
// MODIFIED LOGIC - Requires updated tests
 function processPayment(order) {
-    return order.total * 1.1; // Old tax calculation
+    const tax = calculateTax(order.total, order.taxRate);
+    return order.total + tax; // New tax calculation
 }

// Required test updates:
// - Update existing processPayment tests
// - Add tests for new tax calculation integration
// - Test various tax rates and edge cases
```
</test_coverage_requirements>

<test_analysis_process>
**Step-by-step test coverage analysis:**

1. **Map changes to test requirements**:
   ```bash
   # Identify changed files
   gh pr diff {number} --name-only
   
   # For each changed file, check for test file
   # src/services/payment.js -> look for:
   Glob pattern="**/payment*.test.js"
   Glob pattern="**/payment*.spec.js"
   ```

2. **Analyze test completeness**:
   ```bash
   # Read test files to verify coverage
   Read file_path="tests/payment.test.js"
   
   # Check if new functions are tested
   Grep pattern="describe.*calculateTax|test.*calculateTax" include="*.test.js"
   ```

3. **Assess test quality**:
   - Verify test assertions are specific and meaningful
   - Check for edge case coverage
   - Ensure error conditions are tested
   - Validate test isolation and independence

4. **Generate coverage feedback**:
   - List untested new functions
   - Suggest missing test scenarios
   - Recommend test structure improvements
</test_analysis_process>

<examples>
<correct>
Verifying test coverage for new function:
```bash
# Found new function in payment service
Grep pattern="^\+.*function.*calculateTax" include="*.js"

# Check for corresponding tests
Grep pattern="calculateTax" include="*.test.js,*.spec.js"

# No tests found - post feedback:
gh pr comment 123 --body "Test Coverage Missing: The new calculateTax function requires unit tests. Please add tests covering: 1) Normal calculation scenarios 2) Edge cases (zero, negative amounts) 3) Error conditions 4) Boundary values. Consider adding tests in tests/payment.test.js"
```

Checking API endpoint test coverage:
```bash
# Found new API endpoint
Grep pattern="^\+.*app\.(get|post|put|delete)" include="*.js"

# Look for integration tests
Grep pattern="/api/users" include="*.test.js,*.spec.js"

# Post integration test request:
gh pr comment 456 --body "Integration Tests Needed: New POST /api/users endpoint requires integration tests covering: 1) Successful user creation with valid data 2) Validation error responses 3) Authentication/authorization checks 4) Duplicate handling. Please add tests to tests/integration/users.test.js"
```
</correct>

<incorrect>
Approving without checking tests:
```bash
# ❌ WRONG - approving PR without test verification
# Should always check for test coverage of new functionality
```

Superficial test checking:
```bash
# ❌ WRONG - only checking if test files exist
# Should verify tests actually cover the new functionality
```

Vague test feedback:
```bash
# ❌ WRONG - generic test request
"Add some tests"
# Should specify what needs testing and suggest test scenarios
```
</incorrect>
</examples>

<integration>
This rule works with:
- `gh-pr-review-always-use-general-comments-for-architectural-feedback.rule.md` for test strategy feedback
- All other analysis rules to ensure changes are properly tested

This rule ensures:
- New functionality is properly tested before merge
- Test coverage gaps are identified and addressed
- Code quality maintained through comprehensive testing
- Regression prevention through adequate test suites
</integration>

<validation>
Test coverage analysis complete when:
- [ ] All new functions and methods checked for corresponding tests
- [ ] API endpoints verified for integration test coverage
- [ ] Modified logic confirmed to have updated tests
- [ ] Test quality and completeness assessed
- [ ] Missing test coverage identified and documented
- [ ] Specific test recommendations provided
- [ ] Test coverage feedback posted before approval
</validation>