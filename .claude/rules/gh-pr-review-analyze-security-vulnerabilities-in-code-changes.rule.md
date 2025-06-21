---
applies_to:
  - file_patterns: ["*.js", "*.ts", "*.py", "*.java", "*.php", "*.rb", "*.cs", "*.go"]
  - contexts: ["gh", "github", "pr", "review", "security", "vulnerabilities", "code_analysis"]
  - actions: ["analyzing_security_risks", "reviewing_auth_code", "checking_input_validation"]
timing: "before"
summary: "Always analyze code changes for security vulnerabilities including SQL injection, XSS, authentication bypasses, and data exposure risks"
version: "1.0.0"
---

# Rule: Analyze Security Vulnerabilities In Code Changes

<purpose>
This rule ensures comprehensive security analysis of code changes to identify vulnerabilities that could compromise system security, including SQL injection, XSS attacks, authentication bypasses, and sensitive data exposure.
</purpose>

<instructions>
When reviewing code changes, systematically analyze for security vulnerabilities:

1. **Search for injection vulnerability patterns**:
   ```bash
   # SQL injection patterns
   Grep pattern="SELECT.*\+.*req\.|INSERT.*\+.*req\.|UPDATE.*\+.*req\." include="*.js,*.ts,*.py"
   Grep pattern="query.*=.*[\"'].*\+.*[\"']" include="*.js,*.ts,*.py"
   
   # XSS vulnerability patterns  
   Grep pattern="innerHTML.*=.*req\.|innerHTML.*\+.*req\." include="*.js,*.ts"
   Grep pattern="document\.write.*req\.|eval.*req\." include="*.js,*.ts"
   
   # Command injection patterns
   Grep pattern="exec.*req\.|system.*req\.|spawn.*req\." include="*.js,*.ts,*.py"
   ```

2. **Analyze authentication and authorization**:
   - Verify proper authentication checks
   - Check for authorization bypass opportunities
   - Examine session management security
   - Validate token handling and storage

3. **Identify data exposure risks**:
   - Sensitive data in logs or error messages
   - Unencrypted data transmission
   - Information disclosure through APIs
   - Debug information leakage

4. **Post critical security feedback**:
   - Use line-specific comments for each vulnerability
   - Explain attack vectors and potential impact
   - Provide secure coding alternatives
   - Prioritize security fixes appropriately

**Security vulnerabilities require immediate attention and detailed remediation guidance.**
</instructions>

<vulnerability_patterns>
**Critical security vulnerability patterns:**

**SQL Injection:**
```javascript
// VULNERABLE: Direct string concatenation
const query = "SELECT * FROM users WHERE id = " + req.params.id;

// VULNERABLE: Template literals with user input
const query = `SELECT * FROM users WHERE name = '${req.body.name}'`;

// SECURE: Parameterized queries
const query = "SELECT * FROM users WHERE id = ?";
db.query(query, [req.params.id]);
```

**Cross-Site Scripting (XSS):**
```javascript
// VULNERABLE: Direct HTML injection
element.innerHTML = req.body.comment;

// VULNERABLE: Unescaped user input
document.write("<div>" + userInput + "</div>");

// SECURE: Proper escaping/sanitization  
element.textContent = req.body.comment;
```

**Authentication Bypasses:**
```javascript
// VULNERABLE: Weak authentication check
if (req.headers.authorization) { // Missing validation
    // Grant access
}

// VULNERABLE: Client-side only validation
if (user.role === 'admin') { // Can be manipulated
    // Admin functionality
}

// SECURE: Server-side validation
if (await validateToken(req.headers.authorization)) {
    // Verified access
}
```

**Data Exposure:**
```javascript
// VULNERABLE: Logging sensitive data
console.log("User login:", req.body); // May contain passwords

// VULNERABLE: Exposing internal errors
res.status(500).json({ error: error.message }); // Stack traces

// SECURE: Sanitized logging
console.log("User login attempt:", { username: req.body.username });
```
</vulnerability_patterns>

<security_analysis_process>
**Systematic security analysis steps:**

1. **Input validation scanning**:
   ```bash
   # Find user input entry points
   Grep pattern="req\.body\.|req\.params\.|req\.query\." include="*.js"
   Grep pattern="request\.form\.|request\.args\." include="*.py"
   
   # Check for validation
   Grep pattern="validate.*req\.|sanitize.*req\." include="*.js,*.py"
   ```

2. **Authentication mechanism review**:
   ```bash
   # Look for auth patterns
   Grep pattern="authenticate\|authorize\|login\|token" include="*.js,*.py"
   Grep pattern="session\|cookie\|jwt" include="*.js,*.py"
   ```

3. **Data flow analysis**:
   ```bash
   # Trace sensitive data handling
   Grep pattern="password\|secret\|key\|token" include="*.js,*.py"
   Grep pattern="encrypt\|decrypt\|hash" include="*.js,*.py"
   ```

4. **Output encoding verification**:
   ```bash
   # Check for proper output handling
   Grep pattern="innerHTML\|document\.write\|eval" include="*.js"
   Grep pattern="render_template\|safe\|escape" include="*.py"
   ```
</security_analysis_process>

<examples>
<correct>
Identifying SQL injection vulnerability:
```bash
# Search for SQL concatenation patterns
Grep pattern="SELECT.*\+.*req\." include="*.js"

# Examine the specific code
Read file_path="models/user.js" offset="45" limit="8"

# Code shows: const query = "SELECT * FROM users WHERE id = " + req.params.id;
# Post critical security feedback:
gh api repos/owner/repo/pulls/123/comments \
  --field body="CRITICAL SECURITY ISSUE - SQL Injection: User input is directly concatenated into SQL query. This allows attackers to execute arbitrary SQL commands. Use parameterized queries instead: 'SELECT * FROM users WHERE id = ?' with parameters [req.params.id]" \
  --field path="models/user.js" \
  --field line="47"
```

Identifying XSS vulnerability:
```bash
# Search for innerHTML with user input
Grep pattern="innerHTML.*req\." include="*.js"

# Examine the code
Read file_path="views/comments.js" offset="23" limit="5"

# Code shows: element.innerHTML = req.body.comment;
# Post security warning:
gh api repos/owner/repo/pulls/456/comments \
  --field body="XSS Vulnerability: Setting innerHTML with user input allows script injection. Use textContent for plain text or properly sanitize HTML: element.textContent = req.body.comment; or use a sanitization library like DOMPurify." \
  --field path="views/comments.js" \
  --field line="25"
```

Identifying authentication bypass:
```bash
# Look for weak auth patterns
Grep pattern="if.*role.*==.*admin" include="*.js"

# Examine auth logic
Read file_path="middleware/auth.js" offset="34" limit="10"

# Code shows client-side role check without server verification
gh api repos/owner/repo/pulls/789/comments \
  --field body="Authentication Bypass Risk: Role check appears to rely on client-provided data. Verify user roles server-side using verified session/token data: const userRole = await getUserRoleFromSession(req.session.userId);" \
  --field path="middleware/auth.js" \
  --field line="38"
```
</correct>

<incorrect>
Missing security analysis:
```bash
# ❌ WRONG - reviewing code without security focus
# Only checking for style issues, missing vulnerability patterns
# Should systematically scan for injection, auth, and data exposure
```

Superficial security scanning:
```bash
# ❌ WRONG - finding patterns but not analyzing impact
grep "SELECT" file.js  # Found SQL but didn't check for injection
# Should examine actual query construction and input handling
```

Vague security feedback:
```bash
# ❌ WRONG - generic security warning
"This might have security issues"
# Should identify specific vulnerabilities with attack vectors
```
</incorrect>
</examples>

<advanced_security_analysis>
**Advanced security considerations:**

**Authentication Token Security:**
```bash
# Check for secure token handling
Grep pattern="jwt\.sign\|jwt\.verify" include="*.js"
Grep pattern="localStorage\|sessionStorage.*token" include="*.js"
# Verify proper token storage and validation
```

**Encryption and Hashing:**
```bash
# Look for weak crypto practices
Grep pattern="md5\|sha1\|base64.*password" include="*.js,*.py"
Grep pattern="crypto\.createHash.*md5" include="*.js"
# Check for strong hashing algorithms (bcrypt, scrypt, Argon2)
```

**API Security:**
```bash
# Check for rate limiting and CORS
Grep pattern="cors\|rateLimit\|helmet" include="*.js"
Grep pattern="@app\.route.*methods" include="*.py"
# Verify proper API security measures
```

**File Upload Security:**
```bash
# Look for file upload vulnerabilities
Grep pattern="multer\|upload\|file.*req\." include="*.js"
Grep pattern="save.*req\.files" include="*.js,*.py"
# Check for file type validation and safe storage
```
</advanced_security_analysis>

<severity_classification>
**Security issue severity levels:**

**CRITICAL - Immediate Fix Required:**
- SQL injection vulnerabilities
- Remote code execution risks
- Authentication bypasses
- Sensitive data exposure

**HIGH - Fix Before Merge:**
- XSS vulnerabilities
- Weak authentication mechanisms
- Improper access controls
- Cryptographic weaknesses

**MEDIUM - Address Soon:**
- Information disclosure
- Session management issues
- Input validation gaps
- Error handling improvements

**LOW - Future Enhancement:**
- Security header improvements
- Logging and monitoring gaps
- Documentation security notes
</severity_classification>

<integration>
This rule works with:
- `gh-pr-review-always-verify-line-content-before-commenting.rule.md` for accuracy
- `gh-pr-review-always-use-line-specific-comments-for-code-issues.rule.md` for precise feedback
- All other PR analysis rules for comprehensive security review

This rule prevents:
- Security vulnerabilities from reaching production
- Data breaches and unauthorized access
- Injection attacks and code execution
- Authentication and authorization bypasses
</integration>

<validation>
Security vulnerability analysis complete when:
- [ ] Injection vulnerability patterns searched across all code files
- [ ] Authentication and authorization mechanisms reviewed
- [ ] Data exposure and information leakage risks identified
- [ ] Input validation and output encoding verified
- [ ] Cryptographic implementations examined
- [ ] Specific line-specific security feedback posted for each issue
- [ ] Severity levels assigned and remediation guidance provided
</validation>