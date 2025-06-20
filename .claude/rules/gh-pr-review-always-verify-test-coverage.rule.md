---
applies_to:
  - file_patterns: []
  - contexts: ["gh", "github", "pr", "review", "testing"]
  - actions: ["reviewing_pr"]
timing: "during"
summary: "Ensure appropriate tests exist for new and changed functionality"
version: "1.0.0"
---

# Rule: Always Verify Test Coverage

<purpose>
This rule ensures that new functionality includes appropriate tests and that changes to existing code maintain or improve test coverage, verifying that the test quality is sufficient for the code complexity and risk level.
</purpose>

<instructions>
For each code change, verify test coverage:

1. **New Functionality**: Check that:
   - New public methods/functions have corresponding tests
   - New classes have test files
   - New API endpoints have integration tests
   - New business logic has unit tests

2. **Modified Code**: Verify that:
   - Existing tests still cover modified functionality
   - Changes in behavior have updated test expectations
   - Edge cases introduced by changes are tested
   - Regression tests exist for bug fixes

3. **Test Quality**: Evaluate that tests:
   - Actually test the intended functionality
   - Cover both happy path and error scenarios
   - Have meaningful assertions
   - Are maintainable and readable

4. **Test Types**: Ensure appropriate mix of:
   - Unit tests for individual components
   - Integration tests for component interactions
   - End-to-end tests for critical user flows
   - Performance tests for critical paths
</instructions>

<coverage_analysis>
**What to look for in test coverage:**

**Missing Tests:**
```python
# New function without tests
def calculate_compound_interest(principal, rate, time, compound_frequency):
    # Complex calculation logic
    return principal * (1 + rate/compound_frequency) ** (compound_frequency * time)

# Should have tests for:
# - Valid inputs with known expected outputs
# - Edge cases (zero values, negative numbers)
# - Boundary conditions (very large/small numbers)
# - Error conditions (invalid inputs)
```

**Inadequate Test Coverage:**
```javascript
// Function with complex logic
function processPayment(amount, paymentMethod, userAccount) {
    if (amount <= 0) throw new Error("Invalid amount");
    if (!paymentMethod) throw new Error("Payment method required");
    
    if (paymentMethod.type === "credit_card") {
        // Credit card processing logic
    } else if (paymentMethod.type === "bank_transfer") {
        // Bank transfer logic  
    } else if (paymentMethod.type === "paypal") {
        // PayPal logic
    }
    
    userAccount.balance -= amount;
    return { success: true, transactionId: generateId() };
}

// Existing test only covers happy path:
test("should process credit card payment", () => {
    const result = processPayment(100, {type: "credit_card"}, {balance: 200});
    expect(result.success).toBe(true);
});

// Missing tests for:
// - Invalid amount (0, negative)
// - Missing payment method
// - Different payment types
// - Insufficient balance scenarios
// - Error handling paths
```

**Poor Test Quality:**
```java
// Test that doesn't actually verify behavior
@Test
public void testCalculateTotal() {
    Order order = new Order();
    order.addItem(new Item("Product", 10.0));
    double total = order.calculateTotal();
    // No assertion - test passes but doesn't verify anything!
}

// Test with weak assertions
@Test
public void testUserValidation() {
    User user = new User("john@example.com", "password123");
    boolean isValid = validator.validate(user);
    assertTrue(isValid); // Doesn't test what makes a user valid
}
```
</coverage_analysis>

<test_identification>
**How to find test files:**

Use project patterns to locate tests:
```bash
# Common test file patterns
Glob pattern="**/*test*.{js,py,java,ts}"
Glob pattern="**/*spec*.{js,ts}"
Glob pattern="**/test_*.py"
Glob pattern="**/tests/**/*.{js,py,java,ts}"

# Look for test directories
LS path="/project/tests"
LS path="/project/src/test"
LS path="/project/__tests__"
```

**Test naming conventions to check:**
- `test_function_name.py` or `function_name_test.py`
- `FunctionName.test.js` or `FunctionName.spec.js`
- `FunctionNameTest.java`
- Test methods: `test_should_do_something()` or `testShouldDoSomething()`
</test_identification>

<comment_guidelines>
**When commenting on test coverage:**

1. **Identify missing tests**: Be specific about what functionality lacks tests
2. **Suggest test scenarios**: Provide concrete examples of test cases needed
3. **Explain risk**: Why these tests are important for this specific code
4. **Consider test type**: Recommend appropriate level of testing

**Severity levels:**
- **Blocking**: Critical functionality without any tests
- **Suggestion**: Missing edge case or error scenario tests
- **Nitpick**: Additional tests that would be helpful but not critical

**Comment template:**
```bash
gh api repos/:owner/:repo/pulls/{number}/comments -X POST \
  -f body="Test coverage gap: [missing tests]. Risk: [what could break]. Suggested tests: [specific test scenarios]. Consider adding tests for: [test cases]" \
  -f commit_id="{sha}" \
  -f path="{filename}" \
  -f side="RIGHT" \
  -F line={line_number}
```
</comment_guidelines>

<test_scenarios>
**Common test scenarios to suggest:**

**Happy Path Tests:**
- Valid inputs with expected outputs
- Normal workflow completion
- Successful operations

**Edge Case Tests:**
- Boundary values (empty, max, min)
- Special characters in strings
- Very large or very small numbers
- Empty collections or null values

**Error Handling Tests:**
- Invalid input parameters
- Network failures or timeouts
- Database connection issues
- Authentication/authorization failures

**Integration Tests:**
- Component interactions
- API endpoint testing
- Database operations
- External service integrations

**Performance Tests:**
- Large data sets
- Concurrent operations
- Memory usage validation
- Response time verification
</test_scenarios>

<examples>
<correct>
Identifying missing tests for new function:
```bash
# New function added without tests:
# def validate_email_format(email): ...

gh api repos/:owner/:repo/pulls/45/comments -X POST \
  -f body="Test coverage gap: New validate_email_format() function has no corresponding tests. Risk: Email validation bugs could allow invalid emails or reject valid ones. Suggested tests: valid emails (user@domain.com), invalid formats (missing @, invalid domain), edge cases (empty string, very long emails, special characters). Consider adding test_validate_email_format.py with these scenarios." \
  -f commit_id="a1b2c3..." \
  -f path="validators.py" \
  -f side="RIGHT" \
  -F line=45
```

Identifying insufficient error handling tests:
```bash
# Function has error handling but tests only cover happy path

gh api repos/:owner/:repo/pulls/45/comments -X POST \
  -f body="Test coverage gap: processPayment() has error handling for invalid amounts and missing payment methods, but existing tests only cover successful payments. Risk: Error handling code paths are untested and could fail silently. Suggested tests: negative amounts, zero amounts, null payment method, insufficient funds. Consider adding error scenario tests to payment_processor_test.js." \
  -f commit_id="a1b2c3..." \
  -f path="payment_processor.js" \
  -f side="RIGHT" \
  -F start_line=23 \
  -F line=45
```
</correct>

<incorrect>
Vague test coverage comment:
```bash
# ❌ WRONG - not specific about what tests are needed
gh api repos/:owner/:repo/pulls/45/comments -X POST \
  -f body="This needs tests" \
  -f commit_id="a1b2c3..." \
  -f path="validators.py" \
  -f side="RIGHT" \
  -F line=45
```
</incorrect>
</examples>

<coverage_metrics>
**When evaluating test coverage, consider:**

**Quantitative Measures:**
- Line coverage percentage
- Branch coverage (all if/else paths)
- Function coverage (all functions called)
- Statement coverage (all statements executed)

**Qualitative Measures:**
- Test readability and maintainability
- Test execution speed
- Test reliability (no flaky tests)
- Test independence (no interdependencies)

**Risk-Based Testing:**
- Critical business logic gets more thorough testing
- Public APIs have comprehensive test coverage
- Error-prone areas get extra attention
- Security-sensitive code requires security tests
</coverage_metrics>

<testing_frameworks>
**Common testing frameworks to recognize:**

**JavaScript/TypeScript:**
- Jest, Mocha, Jasmine
- React Testing Library, Enzyme
- Cypress, Playwright for E2E

**Python:**
- pytest, unittest, nose
- Django TestCase, Flask testing
- Selenium for browser testing

**Java:**
- JUnit, TestNG
- Mockito for mocking
- Spring Test for integration

**General Patterns:**
- Arrange-Act-Assert (AAA) pattern
- Given-When-Then (BDD) pattern
- Test fixtures and setup/teardown
- Mocking and stubbing
</testing_frameworks>

<validation_checklist>
**Test coverage review complete when verified:**
- [ ] All new public methods/functions have tests
- [ ] New classes have corresponding test files
- [ ] Modified code has updated tests
- [ ] Error handling paths are tested
- [ ] Edge cases are covered
- [ ] Integration points are tested
- [ ] Test quality is appropriate for code complexity
- [ ] Tests follow project testing conventions
- [ ] Critical business logic has comprehensive coverage
- [ ] Performance-critical code has performance tests
</validation_checklist>

<integration>
This rule works with:
- Input from `gh-pr-review-always-fetch-pr-details-first.rule.md`
- Complements `gh-pr-review-always-comment-on-logic-issues.rule.md`
- Supports `gh-pr-review-always-check-error-handling.rule.md`
- Can inform suggestions from other review rules
</integration>