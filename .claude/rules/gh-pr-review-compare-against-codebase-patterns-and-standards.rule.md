---
applies_to:
  - file_patterns: ["*.js", "*.ts", "*.py", "*.java", "*.cpp", "*.c", "*.cs", "*.go", "*.rs"]
  - contexts: ["gh", "github", "pr", "review", "consistency", "patterns", "standards"]
  - actions: ["comparing_against_patterns", "checking_consistency", "verifying_standards"]
timing: "before"
summary: "Always compare code changes against existing codebase patterns, naming conventions, architectural standards, and coding style consistency"
version: "1.0.0"
---

# Rule: Compare Against Codebase Patterns And Standards

<purpose>
This rule ensures code changes maintain consistency with established codebase patterns, naming conventions, architectural standards, and coding styles to preserve code coherence and team productivity.
</purpose>

<instructions>
When reviewing code changes, compare against existing patterns:

1. **Analyze existing codebase patterns**:
   ```bash
   # Study similar functionality patterns
   Grep pattern="function.*Service|class.*Service" include="*.js,*.ts"
   Grep pattern="export.*Controller|class.*Controller" include="*.js,*.ts"
   
   # Check naming conventions
   Grep pattern="const [A-Z][A-Z_]*" include="*.js,*.ts"  # Constants
   Grep pattern="function [a-z][a-zA-Z]*" include="*.js,*.ts"  # Functions
   ```

2. **Verify architectural consistency**:
   ```bash
   # Check import/export patterns
   Grep pattern="import.*from.*\.\." include="*.js,*.ts"
   Grep pattern="require\(.*\)" include="*.js"
   
   # Examine error handling patterns
   Grep pattern="throw new.*Error" include="*.js,*.ts,*.py"
   ```

3. **Compare coding styles**:
   ```bash
   # Check formatting and style patterns
   Grep pattern="if.*\{" include="*.js,*.ts"  # Brace style
   Grep pattern="function.*\(.*\).*\{" include="*.js,*.ts"  # Function style
   ```

4. **Post consistency feedback**:
   - Use line-specific comments for pattern deviations
   - Suggest alignment with existing conventions
   - Reference similar implementations in codebase
   - Recommend architectural consistency improvements

**New code should follow established patterns and conventions.**
</instructions>

<pattern_consistency_checks>
**Key consistency areas to verify:**

**Naming Conventions:**
```javascript
// EXISTING PATTERN in codebase:
const USER_ROLES = { ADMIN: 'admin', USER: 'user' };
function getUserByEmail(email) { }
class UserService { }

// INCONSISTENT - Different naming style:
+const user_types = { admin: 'admin', user: 'user' };  // snake_case vs UPPER_CASE
+function get_user_by_email(email) { }  // snake_case vs camelCase
+class userservice { }  // lowercase vs PascalCase

// CONSISTENT - Follows existing patterns:
+const USER_TYPES = { ADMIN: 'admin', USER: 'user' };
+function getUserByEmail(email) { }
+class UserService { }
```

**Architectural Patterns:**
```javascript
// EXISTING PATTERN - Service layer with dependency injection:
class UserService {
    constructor(userRepository, emailService) {
        this.userRepository = userRepository;
        this.emailService = emailService;
    }
}

// INCONSISTENT - Direct database access:
+class OrderService {
+    async createOrder(orderData) {
+        return await db.orders.create(orderData);  // Bypasses repository pattern
+    }
+}

// CONSISTENT - Follows repository pattern:
+class OrderService {
+    constructor(orderRepository, inventoryService) {
+        this.orderRepository = orderRepository;
+        this.inventoryService = inventoryService;
+    }
+}
```

**Error Handling Patterns:**
```javascript
// EXISTING PATTERN - Custom error classes:
class ValidationError extends Error {
    constructor(message, field) {
        super(message);
        this.name = 'ValidationError';
        this.field = field;
    }
}

// INCONSISTENT - Generic errors:
+throw new Error('Invalid email');  // Should use ValidationError

// CONSISTENT - Follows error pattern:
+throw new ValidationError('Invalid email format', 'email');
```
</pattern_consistency_checks>

<analysis_process>
**Step-by-step consistency analysis:**

1. **Sample existing patterns**:
   ```bash
   # Study 3-5 similar files for patterns
   Read file_path="src/services/user-service.js"
   Read file_path="src/services/order-service.js"
   Read file_path="src/services/payment-service.js"
   ```

2. **Compare new code against patterns**:
   ```bash
   # Check if new code follows discovered patterns
   # Compare naming, structure, imports, exports
   ```

3. **Identify deviations**:
   - Note inconsistent naming conventions
   - Find architectural pattern violations
   - Spot style inconsistencies
   - Document missing standard practices

4. **Generate consistency feedback**:
   - Reference specific existing examples
   - Suggest alignment with established patterns
   - Explain benefits of consistency
</analysis_process>

<examples>
<correct>
Identifying naming inconsistency:
```bash
# Study existing naming patterns
Grep pattern="const [A-Z][A-Z_]*" include="src/constants/*.js"
# Found: const API_ENDPOINTS, const USER_ROLES, const ERROR_CODES

# Check new code
Read file_path="src/constants/settings.js" offset="10" limit="5"
# Found: const api_endpoints = { ... }

# Post consistency feedback:
gh api repos/owner/repo/pulls/123/comments \
  --field body="Naming Convention Inconsistency: Use UPPER_CASE for constants to match existing codebase patterns. Change 'api_endpoints' to 'API_ENDPOINTS' to align with constants like USER_ROLES and ERROR_CODES in other files." \
  --field path="src/constants/settings.js" \
  --field line="12"
```

Identifying architectural inconsistency:
```bash
# Study service layer patterns
Grep pattern="class.*Service" include="src/services/*.js"
Read file_path="src/services/user-service.js"
# Found: Constructor injection pattern with repository

# Check new service
Read file_path="src/services/notification-service.js"
# Found: Direct database access

gh pr comment 456 --body "Architectural Inconsistency: The new NotificationService directly accesses the database, but existing services (UserService, OrderService) follow the repository pattern with dependency injection. Please refactor to use NotificationRepository for data access to maintain architectural consistency."
```
</correct>

<incorrect>
Ignoring existing patterns:
```bash
# ❌ WRONG - not checking existing codebase
# Should study similar files before reviewing
```

Superficial pattern checking:
```bash
# ❌ WRONG - only checking syntax, not patterns
# Should analyze naming, architecture, and style consistency
```

Vague consistency feedback:
```bash
# ❌ WRONG - generic consistency comment
"This doesn't match our patterns"
# Should reference specific examples and suggest fixes
```
</incorrect>
</examples>

<integration>
This rule works with:
- `gh-pr-review-always-verify-line-content-before-commenting.rule.md` for accuracy
- All other analysis rules to ensure comprehensive pattern checking

This rule ensures:
- Codebase consistency and maintainability
- Team productivity through familiar patterns
- Reduced cognitive load for developers
- Architectural integrity across changes
</integration>

<validation>
Pattern consistency analysis complete when:
- [ ] Existing codebase patterns studied and documented
- [ ] New code compared against established conventions
- [ ] Naming convention consistency verified
- [ ] Architectural pattern adherence confirmed
- [ ] Coding style alignment checked
- [ ] Specific pattern deviation feedback posted
- [ ] References to existing examples provided
</validation>