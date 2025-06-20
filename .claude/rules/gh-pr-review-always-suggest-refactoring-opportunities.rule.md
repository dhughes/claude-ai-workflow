---
applies_to:
  - file_patterns: []
  - contexts: ["gh", "github", "pr", "review", "refactoring"]
  - actions: ["reviewing_pr"]
timing: "during"
summary: "Identify code that could be simplified, restructured, or improved through refactoring"
version: "1.0.0"
---

# Rule: Always Suggest Refactoring Opportunities

<purpose>
This rule identifies opportunities to improve code structure, eliminate duplication, simplify complex logic, and apply design patterns that would make the code more maintainable, readable, and extensible.
</purpose>

<instructions>
Look for refactoring opportunities in code changes:

1. **Code Duplication**: Identify:
   - Repeated logic that could be extracted to functions
   - Similar code patterns that could be generalized
   - Copy-pasted code with minor variations
   - Repeated string literals or magic numbers

2. **Structural Improvements**: Look for:
   - Long parameter lists that could use objects
   - Switch statements that could be polymorphism
   - Nested conditionals that could be flattened
   - Data clumps that should be objects

3. **Design Pattern Opportunities**: Identify where:
   - Strategy pattern could replace conditionals
   - Factory pattern could simplify object creation
   - Observer pattern could decouple components
   - Dependency injection could improve testability

4. **Simplification Opportunities**: Find:
   - Complex expressions that could be broken down
   - Temporary variables that obscure intent
   - Methods that could be more focused
   - Classes that have too many responsibilities
</instructions>

<refactoring_patterns>
**Common refactoring opportunities:**

**Extract Method:**
```javascript
// Before: Long method with multiple concerns
function processOrder(order) {
    // 20 lines of validation logic
    if (!order.customerId || order.items.length === 0) return false;
    // ... more validation
    
    // 15 lines of calculation logic  
    let total = 0;
    for (let item of order.items) {
        total += item.price * item.quantity;
    }
    // ... more calculation
    
    // 10 lines of persistence logic
    database.save(order);
    // ... more persistence
}

// After: Extracted methods
function processOrder(order) {
    if (!validateOrder(order)) return false;
    const total = calculateOrderTotal(order);
    return saveOrder(order, total);
}
```

**Replace Conditional with Polymorphism:**
```python
# Before: Switch on type
def calculate_area(shape):
    if shape.type == "circle":
        return math.pi * shape.radius ** 2
    elif shape.type == "rectangle":
        return shape.width * shape.height
    elif shape.type == "triangle":
        return 0.5 * shape.base * shape.height

# After: Polymorphic approach
class Circle:
    def calculate_area(self):
        return math.pi * self.radius ** 2

class Rectangle:
    def calculate_area(self):
        return self.width * self.height
```

**Introduce Parameter Object:**
```java
// Before: Long parameter list
public void createUser(String firstName, String lastName, String email, 
                      String phone, String address, String city, String zipCode) {
    // implementation
}

// After: Parameter object
public class UserDetails {
    private String firstName, lastName, email, phone, address, city, zipCode;
    // constructors, getters
}

public void createUser(UserDetails userDetails) {
    // implementation
}
```

**Extract Configuration:**
```python
# Before: Magic numbers scattered
def send_email(recipient):
    max_retries = 3
    timeout = 5000
    batch_size = 50
    # implementation with hardcoded values

# After: Configuration object
class EmailConfig:
    MAX_RETRIES = 3
    TIMEOUT_MS = 5000
    BATCH_SIZE = 50

def send_email(recipient, config=EmailConfig()):
    # implementation using config values
```
</refactoring_patterns>

<opportunity_detection>
**How to spot refactoring opportunities:**

**Code Smells:**
- Functions longer than 20-30 lines
- Classes with more than 5-7 public methods
- Parameter lists with more than 3-4 parameters
- Conditional statements with more than 3-4 branches
- Duplicate code blocks (even if slightly different)

**Structural Issues:**
- Feature envy (method using more data from another class)
- Data clumps (same group of parameters passed together)
- Large classes doing too many things
- Comments explaining what code does (vs. why)

**Design Issues:**
- Tight coupling between unrelated modules
- God objects that know too much
- Violation of single responsibility principle
- Hard-coded dependencies
</opportunity_detection>

<comment_strategy>
**When suggesting refactoring:**

1. **Identify the smell**: Name the specific code smell or issue
2. **Explain the benefit**: Why the refactoring would help
3. **Suggest specific technique**: Name the refactoring pattern to apply
4. **Consider effort vs. benefit**: Is this worth doing now?

**Severity guidelines:**
- **Suggestion**: Clear improvement that's worth doing
- **Nitpick**: Minor improvement, nice to have
- **Consider**: Larger refactoring that might be future work

**Comment template:**
```bash
gh api repos/:owner/:repo/pulls/{number}/comments -X POST \
  -f body="Refactoring opportunity: [code smell]. Benefit: [why it helps]. Suggested technique: [specific refactoring]. Consider extracting this to [specific improvement]" \
  -f commit_id="{sha}" \
  -f path="{filename}" \
  -f side="RIGHT" \
  -F line={line_number}
```
</comment_strategy>

<specific_techniques>
**Refactoring techniques to suggest:**

**Method-Level:**
- Extract Method: Break long methods into smaller ones
- Inline Method: Remove unnecessary method indirection
- Rename Method: Make method names more descriptive
- Add Parameter/Remove Parameter: Improve method signatures

**Class-Level:**
- Extract Class: Split classes with multiple responsibilities
- Move Method: Move methods to more appropriate classes
- Replace Data Value with Object: Turn primitives into objects
- Replace Array with Object: Use objects instead of arrays for structure

**Conditional Logic:**
- Decompose Conditional: Extract complex conditions
- Consolidate Conditional Expression: Combine related conditions
- Replace Nested Conditional with Guard Clauses: Use early returns
- Replace Conditional with Polymorphism: Use inheritance/interfaces

**Data Organization:**
- Replace Magic Number with Named Constant: Use meaningful names
- Encapsulate Field: Add getters/setters
- Replace Record with Data Class: Use proper objects
- Replace Type Code with Polymorphism: Use inheritance for types
</specific_techniques>

<examples>
<correct>
Suggesting Extract Method refactoring:
```bash
# Code finds long method mixing validation and calculation

gh api repos/:owner/:repo/pulls/45/comments -X POST \
  -f body="Refactoring opportunity: Long method mixing validation and business logic (lines 23-67). Benefit: Easier to test and understand each concern separately. Suggested technique: Extract Method - consider extracting validateOrderData() (lines 23-35) and calculateShippingCost() (lines 36-55) into separate methods." \
  -f commit_id="a1b2c3..." \
  -f path="order_service.py" \
  -f side="RIGHT" \
  -F start_line=23 \
  -F line=67
```

Suggesting Replace Conditional with Polymorphism:
```bash
# Code finds large switch statement on object type

gh api repos/:owner/:repo/pulls/45/comments -X POST \
  -f body="Refactoring opportunity: Switch statement on payment type (lines 45-78) will need modification every time a new payment type is added. Benefit: More extensible and follows Open/Closed principle. Suggested technique: Replace Conditional with Polymorphism - consider creating PaymentMethod interface with CreditCard, PayPal, BankTransfer implementations." \
  -f commit_id="a1b2c3..." \
  -f path="payment_processor.py" \
  -f side="RIGHT" \
  -F start_line=45 \
  -F line=78
```
</correct>

<incorrect>
Vague refactoring suggestion:
```bash
# ❌ WRONG - not specific about what to refactor or how
gh api repos/:owner/:repo/pulls/45/comments -X POST \
  -f body="This could be refactored" \
  -f commit_id="a1b2c3..." \
  -f path="order_service.py" \
  -f side="RIGHT" \
  -F line=45
```
</incorrect>
</examples>

<timing_considerations>
**When to suggest refactoring:**

**Good Times:**
- Code is being modified anyway (safer to refactor)
- Clear, small refactoring with obvious benefit
- Refactoring enables the current change
- Technical debt is blocking progress

**Consider Carefully:**
- Large refactoring that affects many files
- Code that rarely changes
- Near release deadlines
- When comprehensive tests don't exist

**Future Work:**
- Architectural changes
- Major design pattern implementations
- Large-scale restructuring
- Performance-related refactoring without measurements
</timing_considerations>

<validation_checklist>
**Refactoring review complete when identified:**
- [ ] Code duplication opportunities
- [ ] Long methods that could be broken down
- [ ] Complex conditionals that could be simplified
- [ ] Data clumps that could become objects
- [ ] Magic numbers that need constants
- [ ] Switch statements that could be polymorphism
- [ ] Classes with too many responsibilities
- [ ] Methods with too many parameters
- [ ] Tight coupling that could be reduced
- [ ] Design patterns that would improve structure
</validation_checklist>

<integration>
This rule works with:
- Input from `gh-pr-review-always-comment-on-maintainability-problems.rule.md`
- Context from `gh-pr-review-always-check-against-project-patterns.rule.md`
- May inform suggestions in other review rules
</integration>