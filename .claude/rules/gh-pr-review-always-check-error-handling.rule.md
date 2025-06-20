---
applies_to:
  - file_patterns: []
  - contexts: ["gh", "github", "pr", "review", "errors"]
  - actions: ["reviewing_pr"]
timing: "during"
summary: "Verify proper error handling and edge case coverage in code changes"
version: "1.0.0"
---

# Rule: Always Check Error Handling

<purpose>
This rule ensures that code changes properly handle error conditions, edge cases, and unexpected scenarios to prevent runtime failures and provide good user experience through appropriate error handling and recovery mechanisms.
</purpose>

<instructions>
Review code changes for error handling adequacy:

1. **Exception Handling**: Verify that:
   - Try-catch blocks are used appropriately
   - Specific exceptions are caught rather than generic ones
   - Error messages are meaningful and actionable
   - Resources are properly cleaned up in finally blocks

2. **Input Validation**: Check that:
   - Function parameters are validated
   - Null/undefined values are handled
   - Type checking is performed where necessary
   - Range and format validation exists

3. **External Dependencies**: Ensure that:
   - Network calls have timeout and retry logic
   - Database operations handle connection failures
   - File operations handle missing files or permissions
   - API calls handle various response codes

4. **Error Propagation**: Verify that:
   - Errors are propagated appropriately up the call stack
   - Error context is preserved and enhanced
   - Logging provides sufficient debugging information
   - User-facing errors are appropriately sanitized
</instructions>

<error_patterns>
**Common error handling issues:**

**Missing Error Handling:**
```javascript
// Problematic - no error handling
async function fetchUserData(userId) {
    const response = await fetch(`/api/users/${userId}`);
    const userData = await response.json();
    return userData.profile;
}

// Better - with error handling
async function fetchUserData(userId) {
    try {
        const response = await fetch(`/api/users/${userId}`);
        if (!response.ok) {
            throw new Error(`Failed to fetch user: ${response.status}`);
        }
        const userData = await response.json();
        if (!userData || !userData.profile) {
            throw new Error('Invalid user data structure');
        }
        return userData.profile;
    } catch (error) {
        console.error(`Error fetching user ${userId}:`, error);
        throw new Error('Unable to load user profile');
    }
}
```

**Generic Exception Catching:**
```python
# Problematic - too broad
try:
    result = complex_operation()
    save_to_database(result)
    send_notification(result)
except Exception as e:
    print(f"Something went wrong: {e}")
    return None

# Better - specific error handling
try:
    result = complex_operation()
except ValidationError as e:
    logger.error(f"Validation failed: {e}")
    raise BadRequestError("Invalid input data")
except DatabaseError as e:
    logger.error(f"Database operation failed: {e}")
    raise ServiceUnavailableError("Database temporarily unavailable")
except Exception as e:
    logger.error(f"Unexpected error in complex_operation: {e}")
    raise InternalServerError("Operation failed unexpectedly")
```

**Missing Input Validation:**
```java
// Problematic - no validation
public User createUser(String email, String password, int age) {
    User user = new User();
    user.setEmail(email.toLowerCase());
    user.setPassword(hashPassword(password));
    user.setAge(age);
    return userRepository.save(user);
}

// Better - with validation
public User createUser(String email, String password, int age) {
    if (email == null || email.trim().isEmpty()) {
        throw new IllegalArgumentException("Email cannot be null or empty");
    }
    if (!isValidEmailFormat(email)) {
        throw new IllegalArgumentException("Invalid email format");
    }
    if (password == null || password.length() < 8) {
        throw new IllegalArgumentException("Password must be at least 8 characters");
    }
    if (age < 0 || age > 150) {
        throw new IllegalArgumentException("Age must be between 0 and 150");
    }
    
    User user = new User();
    user.setEmail(email.toLowerCase());
    user.setPassword(hashPassword(password));
    user.setAge(age);
    return userRepository.save(user);
}
```

**Resource Cleanup Issues:**
```python
# Problematic - file not closed on error
def process_file(filename):
    file = open(filename, 'r')
    data = file.read()
    result = transform_data(data)  # Could throw exception
    file.close()  # Never reached if transform_data throws
    return result

# Better - using context manager
def process_file(filename):
    try:
        with open(filename, 'r') as file:
            data = file.read()
            return transform_data(data)
    except FileNotFoundError:
        raise ProcessingError(f"File not found: {filename}")
    except PermissionError:
        raise ProcessingError(f"Permission denied: {filename}")
    except Exception as e:
        raise ProcessingError(f"Error processing file {filename}: {str(e)}")
```
</error_patterns>

<validation_areas>
**Key areas to check for error handling:**

**Network Operations:**
- Timeout handling
- Connection failures
- Invalid response formats
- HTTP error status codes
- Retry logic with backoff

**Database Operations:**
- Connection pool exhaustion
- Query timeouts
- Constraint violations
- Transaction rollback
- Deadlock handling

**File System Operations:**
- File not found
- Permission denied
- Disk space full
- Concurrent access issues
- Path traversal security

**User Input:**
- Null or empty values
- Type mismatches
- Range validation
- Format validation
- Injection attacks
</validation_areas>

<comment_strategy>
**When commenting on error handling:**

1. **Identify the risk**: What could go wrong without proper error handling
2. **Explain the impact**: How the error would affect users or system
3. **Suggest specific handling**: Provide concrete error handling approach
4. **Consider error types**: Different errors may need different handling

**Severity guidelines:**
- **Blocking**: Missing error handling for external dependencies or user input
- **Suggestion**: Improvements to existing error handling or edge cases
- **Nitpick**: Better error messages or logging improvements

**Comment template:**
```bash
gh api repos/:owner/:repo/pulls/{number}/comments -X POST \
  -f body="Error handling gap: [specific scenario not handled]. Risk: [what could fail]. Impact: [user/system effect]. Suggested fix: [specific error handling approach]" \
  -f commit_id="{sha}" \
  -f path="{filename}" \
  -f side="RIGHT" \
  -F line={line_number}
```
</comment_strategy>

<specific_scenarios>
**Common error scenarios to check:**

**Async Operations:**
- Promise rejections
- Timeout errors
- Network connectivity issues
- Rate limiting responses

**Data Processing:**
- Malformed input data
- Type conversion errors
- Arithmetic errors (division by zero)
- Buffer overflows

**External Services:**
- Service unavailability
- Authentication failures
- Rate limit exceeded
- Invalid API responses

**System Resources:**
- Memory allocation failures
- Disk space exhaustion
- File handle limits
- Thread pool exhaustion

**Business Logic:**
- Invalid state transitions
- Constraint violations
- Workflow interruptions
- Race conditions
</specific_scenarios>

<examples>
<correct>
Identifying missing async error handling:
```bash
# Code finds: const data = await api.fetchData(); without try-catch

gh api repos/:owner/:repo/pulls/45/comments -X POST \
  -f body="Error handling gap: Async API call has no error handling for network failures or invalid responses. Risk: Unhandled promise rejection could crash the application. Impact: Users would see generic error or app crash. Suggested fix: Wrap in try-catch block and handle specific error types (network timeout, 404, 500, etc.) with appropriate user messages." \
  -f commit_id="a1b2c3..." \
  -f path="data_service.js" \
  -f side="RIGHT" \
  -F line=23
```

Identifying missing input validation:
```bash
# Code finds function that doesn't validate required parameters

gh api repos/:owner/:repo/pulls/45/comments -X POST \
  -f body="Error handling gap: Function processes email parameter without null/format validation. Risk: Runtime errors if email is null/undefined or malformed. Impact: Function crashes instead of providing helpful error message. Suggested fix: Add validation - if (!email || !isValidEmail(email)) throw new Error('Valid email required') before processing." \
  -f commit_id="a1b2c3..." \
  -f path="user_service.py" \
  -f side="RIGHT" \
  -F line=67
```
</correct>

<incorrect>
Vague error handling comment:
```bash
# ❌ WRONG - not specific about what error handling is missing
gh api repos/:owner/:repo/pulls/45/comments -X POST \
  -f body="This needs error handling" \
  -f commit_id="a1b2c3..." \
  -f path="data_service.js" \
  -f side="RIGHT" \
  -F line=23
```
</incorrect>
</examples>

<error_handling_patterns>
**Best practices to look for:**

**Fail Fast:**
- Validate inputs early
- Check preconditions before processing
- Return early on invalid states
- Use guard clauses

**Graceful Degradation:**
- Fallback mechanisms for external services
- Default values for missing configuration
- Alternative workflows when primary fails
- Progressive feature degradation

**Error Recovery:**
- Retry logic with exponential backoff
- Circuit breaker patterns
- Automatic failover
- Transaction rollback

**Error Communication:**
- Structured error objects
- Error codes for programmatic handling
- User-friendly error messages
- Detailed logging for debugging
</error_handling_patterns>

<validation_checklist>
**Error handling review complete when verified:**
- [ ] All external calls have error handling
- [ ] Input parameters are validated
- [ ] Null/undefined values are handled
- [ ] Resources are properly cleaned up
- [ ] Specific exceptions are caught (not generic)
- [ ] Error messages are meaningful
- [ ] Logging provides debugging context
- [ ] User-facing errors are sanitized
- [ ] Async operations handle rejections
- [ ] Database operations handle failures
- [ ] File operations handle missing files
- [ ] Network operations have timeouts
</validation_checklist>

<integration>
This rule works with:
- Context from `gh-pr-review-always-fetch-pr-details-first.rule.md`
- Complements `gh-pr-review-always-comment-on-logic-issues.rule.md`
- Supports `gh-pr-review-always-verify-test-coverage.rule.md`
- Informs `gh-pr-review-always-comment-on-security-vulnerabilities.rule.md`
</integration>