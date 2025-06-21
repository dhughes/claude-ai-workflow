---
applies_to:
  - file_patterns: ["*.js", "*.ts", "*.py", "*.java", "*.cpp", "*.c", "*.cs", "*.go", "*.rs"]
  - contexts: ["gh", "github", "pr", "review", "performance", "optimization", "code_analysis"]
  - actions: ["analyzing_performance", "reviewing_algorithms", "checking_efficiency"]
timing: "before"
summary: "Always analyze code changes for performance issues including inefficient algorithms, memory leaks, unnecessary database queries, and optimization opportunities"
version: "1.0.0"
---

# Rule: Analyze Performance Issues In Code Changes

<purpose>
This rule ensures comprehensive performance analysis of code changes to identify efficiency problems, including inefficient algorithms, memory leaks, unnecessary database queries, and missed optimization opportunities that could impact system performance.
</purpose>

<instructions>
When reviewing code changes, systematically analyze for performance issues:

1. **Search for performance anti-patterns**:
   ```bash
   # Inefficient loops and algorithms
   Grep pattern="for.*for.*for" include="*.js,*.ts,*.py"
   Grep pattern="\.map.*\.filter.*\.reduce" include="*.js,*.ts"
   
   # Database query issues
   Grep pattern="for.*await.*query\|for.*query" include="*.js,*.ts,*.py"
   Grep pattern="SELECT.*\*.*FROM" include="*.js,*.ts,*.py"
   
   # Memory management issues
   Grep pattern="new.*\[.*\].*length\|Array.*fill" include="*.js,*.ts"
   Grep pattern="setInterval\|setTimeout.*0" include="*.js,*.ts"
   ```

2. **Analyze algorithmic complexity**:
   - Identify O(n²) or higher complexity algorithms
   - Check for unnecessary nested iterations
   - Verify efficient data structure usage
   - Examine sorting and searching implementations

3. **Identify resource management issues**:
   - Memory leaks from unclosed resources
   - Excessive memory allocation patterns
   - Missing cleanup in event listeners
   - Inefficient string concatenation

4. **Post performance optimization feedback**:
   - Use line-specific comments for each performance issue
   - Explain complexity impact and suggest improvements
   - Provide more efficient algorithm alternatives
   - Quantify potential performance gains when possible

**Focus on changes that could significantly impact system performance.**
</instructions>

<performance_anti_patterns>
**Common performance issues to detect:**

**Inefficient Algorithms:**
```javascript
// INEFFICIENT: O(n²) nested loops
for (let i = 0; i < items.length; i++) {
    for (let j = 0; j < items.length; j++) {
        if (items[i].id === items[j].relatedId) { } // Use Map/Set instead
    }
}

// INEFFICIENT: Repeated array operations
items.map(item => transform(item))
     .filter(item => item.isValid)
     .map(item => item.value); // Combine operations

// EFFICIENT: Single pass with reduce
items.reduce((acc, item) => {
    const transformed = transform(item);
    if (transformed.isValid) acc.push(transformed.value);
    return acc;
}, []);
```

**Database Query Issues:**
```javascript
// INEFFICIENT: N+1 query problem
for (const user of users) {
    const posts = await db.query('SELECT * FROM posts WHERE user_id = ?', [user.id]);
}

// EFFICIENT: Single query with JOIN or batch loading
const posts = await db.query('SELECT * FROM posts WHERE user_id IN (?)', [userIds]);

// INEFFICIENT: SELECT *
const user = await db.query('SELECT * FROM users WHERE id = ?', [id]);

// EFFICIENT: Select only needed fields
const user = await db.query('SELECT name, email FROM users WHERE id = ?', [id]);
```

**Memory Management Issues:**
```javascript
// MEMORY LEAK: Event listeners not removed
element.addEventListener('click', handler);
// Missing: element.removeEventListener('click', handler);

// MEMORY LEAK: Unclosed intervals
setInterval(() => { }, 1000); // Should store reference for clearInterval

// INEFFICIENT: String concatenation in loops
let result = '';
for (const item of items) {
    result += item.toString(); // Use array.join() instead
}
```
</performance_anti_patterns>

<analysis_process>
**Step-by-step performance analysis:**

1. **Algorithm complexity scanning**:
   ```bash
   # Look for nested loops
   Grep pattern="for.*\{[^}]*for.*\{" include="*.js,*.py"
   
   # Find array method chaining
   Grep pattern="\.map.*\.(filter|map|reduce)" include="*.js,*.ts"
   
   # Search for recursive functions
   Grep pattern="function.*\{.*function_name\(" include="*.js,*.py"
   ```

2. **Database operation analysis**:
   ```bash
   # Find queries in loops
   Grep pattern="for.*query\|while.*query" include="*.js,*.py"
   
   # Look for SELECT * patterns
   Grep pattern="SELECT.*\*" include="*.js,*.py,*.sql"
   
   # Check for missing indexes hints
   Grep pattern="WHERE.*=.*req\.|ORDER BY" include="*.js,*.py"
   ```

3. **Memory usage examination**:
   ```bash
   # Find large object creation
   Grep pattern="new Array\(.*[0-9]{4,}\)\|Array.*fill" include="*.js,*.ts"
   
   # Look for potential leaks
   Grep pattern="addEventListener.*\{" include="*.js,*.ts"
   Grep pattern="setInterval\|setTimeout" include="*.js,*.ts"
   ```

4. **Resource cleanup verification**:
   ```bash
   # Check for proper cleanup
   Grep pattern="removeEventListener\|clearInterval\|clearTimeout" include="*.js,*.ts"
   Grep pattern="close\(\)\|cleanup\(\)\|dispose\(\)" include="*.js,*.py"
   ```
</analysis_process>

<examples>
<correct>
Identifying N+1 query problem:
```bash
# Search for database queries in loops
Grep pattern="for.*await.*query" include="*.js"

# Examine the specific code
Read file_path="services/user-service.js" offset="45" limit="10"

# Code shows: for (const user of users) { const posts = await db.query(...) }
# Post performance feedback:
gh api repos/owner/repo/pulls/123/comments \
  --field body="Performance Issue - N+1 Query Problem: This loop executes a database query for each user, resulting in N+1 queries for N users. Use a single query with JOIN or batch loading: const posts = await db.query('SELECT * FROM posts WHERE user_id IN (?)', [userIds]);" \
  --field path="services/user-service.js" \
  --field line="47"
```

Identifying inefficient algorithm:
```bash
# Look for nested loops
Grep pattern="for.*for" include="*.js"

# Examine the code
Read file_path="utils/matcher.js" offset="23" limit="15"

# Code shows O(n²) algorithm for finding matches
gh api repos/owner/repo/pulls/456/comments \
  --field body="Performance Issue - O(n²) Algorithm: Nested loops create quadratic time complexity. For large datasets, this will be slow. Use a Map for O(n) solution: const idMap = new Map(); items.forEach(item => idMap.set(item.id, item)); then lookup with idMap.get(relatedId);" \
  --field path="utils/matcher.js" \
  --field line="28"
```

Identifying memory leak:
```bash
# Search for event listeners without cleanup
Grep pattern="addEventListener" include="*.js"

# Check if removeEventListener exists
Grep pattern="removeEventListener" include="*.js"

# Found addEventListener but no cleanup
gh api repos/owner/repo/pulls/789/comments \
  --field body="Memory Leak Risk: Event listener added but no corresponding removeEventListener found. This can cause memory leaks if component is destroyed. Add cleanup: useEffect(() => { element.addEventListener('click', handler); return () => element.removeEventListener('click', handler); }, []);" \
  --field path="components/interactive.js" \
  --field line="34"
```
</correct>

<incorrect>
Missing performance analysis:
```bash
# ❌ WRONG - reviewing code without performance focus
# Only checking functionality, missing efficiency problems
# Should systematically check for algorithms, queries, memory usage
```

Superficial pattern detection:
```bash
# ❌ WRONG - finding patterns but not analyzing impact
grep "for.*for" file.js  # Found nested loops but didn't assess complexity
# Should examine actual algorithm and suggest improvements
```

Vague performance feedback:
```bash
# ❌ WRONG - generic performance warning
"This might be slow"
# Should identify specific issues with complexity analysis and solutions
```
</incorrect>
</examples>

<advanced_performance_analysis>
**Advanced performance considerations:**

**Async/Await Patterns:**
```bash
# Check for sequential vs parallel execution
Grep pattern="await.*await" include="*.js,*.ts"
Grep pattern="Promise\.all\|Promise\.allSettled" include="*.js,*.ts"
# Verify appropriate async patterns
```

**Caching Opportunities:**
```bash
# Look for repeated expensive operations
Grep pattern="JSON\.parse\|JSON\.stringify" include="*.js,*.ts"
Grep pattern="sort\(\)\|filter\(\).*length" include="*.js,*.ts"
# Check for caching potential
```

**Bundle Size Impact:**
```bash
# Look for large imports
Grep pattern="import.*\*.*from\|require.*\*" include="*.js,*.ts"
Grep pattern="import.*{.*,.*,.*,.*}" include="*.js,*.ts"
# Check for tree-shaking opportunities
```

**Rendering Performance:**
```bash
# React-specific performance issues
Grep pattern="useEffect.*\[\]\|useState.*new" include="*.jsx,*.tsx"
Grep pattern="render.*map.*=>" include="*.jsx,*.tsx"
# Check for rendering optimizations
```
</advanced_performance_analysis>

<integration>
This rule works with:
- `gh-pr-review-always-verify-line-content-before-commenting.rule.md` for accuracy
- `gh-pr-review-always-use-line-specific-comments-for-code-issues.rule.md` for proper feedback
- All other PR analysis rules for comprehensive performance review

This rule identifies:
- Performance bottlenecks before they impact users
- Scalability issues in algorithms and database queries
- Memory leaks and resource management problems
- Optimization opportunities for better efficiency
</integration>

<validation>
Performance analysis complete when:
- [ ] Algorithm complexity assessed for all changed functions
- [ ] Database query patterns examined for efficiency
- [ ] Memory management and resource cleanup verified
- [ ] Loop and iteration patterns optimized
- [ ] Async/await patterns reviewed for parallelization
- [ ] Specific line-specific performance feedback posted
- [ ] Optimization suggestions provided with complexity analysis
</validation>