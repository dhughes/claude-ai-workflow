---
applies_to:
  - file_patterns: []
  - contexts: ["gh", "github", "pr", "review", "security"]
  - actions: ["reviewing_pr"]
timing: "during"
summary: "Detect and flag security issues in code changes"
version: "1.0.0"
---

# Rule: Always Comment on Security Vulnerabilities

<purpose>
This rule ensures that potential security vulnerabilities are identified and flagged in PR changes, including input validation issues, authentication problems, data exposure risks, and other security concerns.
</purpose>

<instructions>
Analyze each changed file for security vulnerabilities:

1. **Input Validation**: Check for:
   - Unvalidated user input
   - Missing sanitization of data
   - SQL injection possibilities
   - XSS (Cross-Site Scripting) vulnerabilities
   - Command injection risks

2. **Authentication & Authorization**: Look for:
   - Missing authentication checks
   - Weak password handling
   - Session management issues
   - Privilege escalation possibilities
   - JWT token vulnerabilities

3. **Data Exposure**: Identify:
   - Sensitive data in logs or responses
   - Hardcoded secrets or credentials
   - Information disclosure in error messages
   - Insecure data transmission
   - Missing encryption for sensitive data

4. **Configuration Security**: Check for:
   - Insecure default configurations
   - Missing security headers
   - Exposed debug information
   - Insecure file permissions
   - Missing rate limiting
</instructions>

<vulnerability_patterns>
**Critical security patterns to identify:**

**SQL Injection:**
```javascript
// Vulnerable:
const query = `SELECT * FROM users WHERE id = ${userId}`;
// Safe:
const query = 'SELECT * FROM users WHERE id = ?';
db.query(query, [userId]);
```

**XSS Vulnerabilities:**
```javascript
// Vulnerable:
document.innerHTML = userInput;
// Safe:
document.textContent = userInput;
```

**Hardcoded Secrets:**
```python
# Vulnerable:
API_KEY = "sk-1234567890abcdef"
DATABASE_PASSWORD = "password123"
# Safe:
API_KEY = os.environ.get('API_KEY')
```

**Authentication Issues:**
```javascript
// Vulnerable:
if (user.role === 'admin') { /* admin actions */ }
// Safe:
if (isAuthenticated(user) && hasPermission(user, 'admin')) { /* admin actions */ }
```

**Path Traversal:**
```python
# Vulnerable:
filename = request.GET['file']
with open(f'/uploads/{filename}', 'r') as f:
# Safe:
filename = secure_filename(request.GET['file'])
filepath = safe_join('/uploads', filename)
```
</vulnerability_patterns>

<severity_classification>
**Security issue severities:**

**Critical (Blocking):**
- SQL injection vulnerabilities
- Remote code execution possibilities
- Authentication bypass
- Hardcoded production secrets
- Data exposure of PII/sensitive information

**High (Blocking):**
- XSS vulnerabilities
- Authorization flaws
- Insecure cryptographic implementations
- Session management issues
- File upload vulnerabilities

**Medium (Suggestion):**
- Missing input validation
- Weak password policies
- Information disclosure in errors
- Missing security headers
- Insecure default configurations

**Low (Nitpick):**
- Missing rate limiting
- Weak randomness usage
- Debug information exposure
- Missing security documentation
</severity_classification>

<comment_guidelines>
**When commenting on security issues:**

1. **Describe the vulnerability**: Explain what the security issue is
2. **Explain the risk**: What could an attacker do with this vulnerability
3. **Provide secure alternative**: Show how to fix the issue properly
4. **Reference security standards**: Mention OWASP, CWE, or other relevant standards

**Comment template:**
```bash
gh api repos/:owner/:repo/pulls/{number}/comments -X POST \
  -f body="Security vulnerability: [Type] - [Risk description]. Recommended fix: [secure alternative]. Reference: [OWASP/CWE link if applicable]" \
  -f commit_id="{sha}" \
  -f path="{filename}" \
  -f side="RIGHT" \
  -F line={line_number}
```
</comment_guidelines>

<specific_checks>
**Language-specific security checks:**

**JavaScript/Node.js:**
- `eval()` usage with user input
- `innerHTML` with unsanitized data
- Missing CSRF protection
- Insecure cookie settings
- Prototype pollution vulnerabilities

**Python:**
- `exec()` or `eval()` with user input
- Pickle deserialization of untrusted data
- Missing input validation in Flask/Django
- SQL injection in raw queries
- Path traversal in file operations

**Java:**
- Deserialization of untrusted data
- SQL injection in JDBC
- XXE (XML External Entity) vulnerabilities
- Missing input validation
- Insecure random number generation

**General (All Languages):**
- Hardcoded credentials
- Weak cryptographic algorithms
- Missing authentication
- Insufficient logging
- Insecure data transmission
</specific_checks>

<examples>
<correct>
Identifying SQL injection:
```bash
# Code finds: query = f"SELECT * FROM users WHERE name = '{username}'"

gh api repos/:owner/:repo/pulls/45/comments -X POST \
  -f body="Security vulnerability: SQL Injection - Direct string interpolation with user input allows attackers to execute arbitrary SQL commands. Use parameterized queries instead: cursor.execute('SELECT * FROM users WHERE name = %s', (username,)). Reference: OWASP A03:2021 Injection" \
  -f commit_id="a1b2c3..." \
  -f path="user_service.py" \
  -f side="RIGHT" \
  -F line=45
```

Identifying hardcoded secret:
```bash
# Code finds: JWT_SECRET = "super_secret_key_123"

gh api repos/:owner/:repo/pulls/45/comments -X POST \
  -f body="Security vulnerability: Hardcoded Secret - JWT secret key is hardcoded and visible in source code. Move to environment variable: JWT_SECRET = os.environ.get('JWT_SECRET'). This prevents secret exposure in version control." \
  -f commit_id="a1b2c3..." \
  -f path="auth.py" \
  -f side="RIGHT" \
  -F line=12
```
</correct>

<incorrect>
Generic security comment:
```bash
# ❌ WRONG - not specific about the vulnerability or fix
gh api repos/:owner/:repo/pulls/45/comments -X POST \
  -f body="This looks insecure" \
  -f commit_id="a1b2c3..." \
  -f path="auth.py" \
  -f side="RIGHT" \
  -F line=12
```
</incorrect>
</examples>

<security_resources>
**Reference these standards when commenting:**
- OWASP Top 10: https://owasp.org/www-project-top-ten/
- CWE (Common Weakness Enumeration): https://cwe.mitre.org/
- SANS Top 25: https://www.sans.org/top25-software-errors/
- Language-specific security guides (e.g., Node.js Security Best Practices)
</security_resources>

<validation_checklist>
**Security review complete when checked:**
- [ ] All user inputs are validated and sanitized
- [ ] No hardcoded secrets or credentials
- [ ] Authentication and authorization properly implemented
- [ ] No SQL injection or XSS vulnerabilities
- [ ] Sensitive data is properly protected
- [ ] Error messages don't leak information
- [ ] Security headers are present where needed
- [ ] File operations are secure
- [ ] Cryptographic implementations are secure
- [ ] Rate limiting is considered where appropriate
</validation_checklist>

<integration>
This rule works with:
- Context from `gh-pr-review-always-fetch-pr-details-first.rule.md`
- Complements `gh-pr-review-always-check-error-handling.rule.md`
- Should be prioritized as blocking issues in most cases
</integration>