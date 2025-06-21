---
applies_to:
  - file_patterns: ["*.js", "*.ts", "*.py", "*.java", "*.cs", "*.go", "*.rs"]
  - contexts: ["gh", "github", "pr", "review", "error_handling", "validation", "exceptions"]
  - actions: ["reviewing_error_handling", "checking_input_validation", "verifying_exception_management"]
timing: "before"
summary: "Always verify proper error handling, input validation, exception management, and resource cleanup in code changes"
version: "1.0.0"
---

# Rule: Verify Error Handling And Input Validation

<purpose>
This rule ensures code changes include proper error handling, comprehensive input validation, appropriate exception management, and reliable resource cleanup to prevent runtime failures and security vulnerabilities.
</purpose>

<instructions>
When reviewing code changes, systematically verify error handling:

1. **Check for input validation patterns**:
   ```bash
   # Missing validation checks
   Grep pattern="req\.(body|params|query)" include="*.js,*.ts"
   Grep pattern="request\.(form|args|json)" include="*.py"
   
   # Look for validation libraries
   Grep pattern="validate|joi|yup|schema" include="*.js,*.ts,*.py"
   ```

2. **Verify exception handling**:
   ```bash
   # Try-catch patterns
   Grep pattern="try.*\{" include="*.js,*.ts,*.py,*.java"
   Grep pattern="catch.*\{|except.*:" include="*.js,*.ts,*.py,*.java"
   
   # Error propagation
   Grep pattern="throw.*Error|raise.*Error" include="*.js,*.ts,*.py"
   ```

3. **Examine resource cleanup**:
   ```bash
   # Resource management
   Grep pattern="finally.*\{|finally:" include="*.js,*.ts,*.py,*.java"
   Grep pattern="close\(\)|dispose\(\)|cleanup\(\)" include="*.js,*.ts,*.py"
   ```

4. **Post specific feedback for gaps**:
   - Use line-specific comments for missing error handling
   - Explain potential failure scenarios
   - Suggest appropriate validation and cleanup patterns
   - Recommend defensive programming practices

**Robust error handling prevents production failures and security issues.**
</instructions>

<error_handling_patterns>
**Critical error handling patterns to verify:**

**Input Validation:**
```javascript
// MISSING: No input validation
function updateUser(req, res) {
    const user = await User.findById(req.params.id); // What if id is invalid?
    user.email = req.body.email; // What if email is malformed?
}

// PROPER: Comprehensive validation
function updateUser(req, res) {
    const { error, value } = userSchema.validate(req.body);
    if (error) return res.status(400).json({ error: error.details });
    
    if (!req.params.id || !mongoose.isValidObjectId(req.params.id)) {
        return res.status(400).json({ error: 'Invalid user ID' });
    }
}
```

**Exception Management:**
```javascript
// MISSING: No error handling
async function processData(data) {
    const result = await externalAPI.call(data); // Could throw
    return JSON.parse(result); // Could throw
}

// PROPER: Comprehensive error handling
async function processData(data) {
    try {
        const result = await externalAPI.call(data);
        return JSON.parse(result);
    } catch (error) {
        logger.error('Data processing failed:', error);
        throw new ProcessingError('Failed to process data', { cause: error });
    }
}
```

**Resource Cleanup:**
```javascript
// MISSING: Resource leak potential
function processFile(filepath) {
    const file = fs.openSync(filepath, 'r');
    const data = fs.readFileSync(file); // What if this throws?
    return processData(data);
} // File handle never closed

// PROPER: Guaranteed cleanup
function processFile(filepath) {
    let file;
    try {
        file = fs.openSync(filepath, 'r');
        const data = fs.readFileSync(file);
        return processData(data);
    } catch (error) {
        throw new FileProcessingError('Failed to process file', { cause: error });
    } finally {
        if (file) fs.closeSync(file);
    }
}
```
</error_handling_patterns>

<validation>
Error handling verification complete when:
- [ ] Input validation patterns checked for all user inputs
- [ ] Exception handling verified for all potential failure points
- [ ] Resource cleanup patterns confirmed for all acquired resources
- [ ] Error propagation and logging appropriately implemented
- [ ] Specific feedback posted for missing error handling
- [ ] Defensive programming practices recommended
</validation>