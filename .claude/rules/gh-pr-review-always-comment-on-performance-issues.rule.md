---
applies_to:
  - file_patterns: []
  - contexts: ["gh", "github", "pr", "review", "performance"]
  - actions: ["reviewing_pr"]
timing: "during"
summary: "Identify performance bottlenecks, inefficient algorithms, and optimization opportunities"
version: "1.0.0"
---

# Rule: Always Comment on Performance Issues

<purpose>
This rule ensures that performance problems, inefficient algorithms, resource waste, and optimization opportunities are identified and addressed in PR changes to maintain system performance and scalability.
</purpose>

<instructions>
Analyze code changes for performance issues:

1. **Algorithmic Efficiency**: Look for:
   - O(n²) or worse algorithms where better solutions exist
   - Unnecessary nested loops
   - Inefficient sorting or searching
   - Redundant computations

2. **Resource Usage**: Check for:
   - Memory leaks or excessive memory allocation
   - Unnecessary object creation in loops
   - Missing resource cleanup
   - Inefficient data structures

3. **I/O Operations**: Identify:
   - N+1 query problems
   - Synchronous operations that could be async
   - Missing caching opportunities
   - Inefficient file or network operations

4. **Database Performance**: Look for:
   - Missing database indexes
   - Inefficient queries
   - Loading unnecessary data
   - Missing query optimization
</instructions>

<performance_patterns>
**Common performance anti-patterns:**

**Inefficient Loops:**
```javascript
// Inefficient O(n²):
for (let i = 0; i < users.length; i++) {
    for (let j = 0; j < users.length; j++) {
        if (users[i].id === users[j].friendId) { /* ... */ }
    }
}
// Better O(n):
const userMap = new Map(users.map(u => [u.id, u]));
users.forEach(user => {
    const friend = userMap.get(user.friendId);
    /* ... */
});
```

**N+1 Query Problem:**
```python
# Inefficient:
for post in posts:
    author = db.query(f"SELECT * FROM users WHERE id = {post.author_id}")
# Better:
author_ids = [post.author_id for post in posts]
authors = db.query(f"SELECT * FROM users WHERE id IN ({','.join(author_ids)})")
```

**Unnecessary Object Creation:**
```java
// Inefficient:
for (int i = 0; i < 1000; i++) {
    String result = new String("Hello " + i); // Unnecessary String() constructor
    list.add(result);
}
// Better:
for (int i = 0; i < 1000; i++) {
    String result = "Hello " + i; // String literal pooling
    list.add(result);
}
```

**Missing Caching:**
```python
# Inefficient - recalculates every time:
def calculate_user_score(user_id):
    # Expensive calculation
    return complex_calculation(user_id)

# Better - with caching:
@lru_cache(maxsize=128)
def calculate_user_score(user_id):
    return complex_calculation(user_id)
```
</performance_patterns>

<severity_guidelines>
**Performance issue severity:**

**Critical (Blocking):**
- Exponential time complexity (O(2^n))
- Memory leaks that will cause crashes
- Infinite loops or excessive recursion
- Database queries that will timeout

**High (Suggestion):**
- O(n²) algorithms where O(n log n) exists
- N+1 query problems
- Large memory allocations in loops
- Missing indexes on queried columns

**Medium (Suggestion):**
- Inefficient data structure usage
- Missing caching for expensive operations
- Synchronous I/O that could be async
- Unnecessary object allocations

**Low (Nitpick):**
- Minor algorithmic improvements
- Micro-optimizations
- String concatenation inefficiencies
- Small memory optimizations
</severity_guidelines>

<comment_strategy>
**When commenting on performance issues:**

1. **Identify the problem**: Explain what makes the code inefficient
2. **Quantify the impact**: Estimate time/space complexity or real-world impact
3. **Suggest improvements**: Provide specific optimization techniques
4. **Consider trade-offs**: Mention any complexity vs. performance trade-offs

**Comment template:**
```bash
gh api repos/:owner/:repo/pulls/{number}/comments -X POST \
  -f body="Performance issue: [Problem description]. Current complexity: [O(n)]. Impact: [real-world effect]. Suggested optimization: [specific improvement]" \
  -f commit_id="{sha}" \
  -f path="{filename}" \
  -f side="RIGHT" \
  -F line={line_number}
```
</comment_strategy>

<specific_areas>
**Key performance areas to review:**

**Database Operations:**
- Query efficiency and indexing
- Connection pooling usage
- Transaction management
- Bulk operations vs. individual queries

**Memory Management:**
- Object lifecycle and garbage collection
- Large data structure handling
- Stream processing vs. loading all data
- Memory-efficient algorithms

**Async/Concurrency:**
- Proper async/await usage
- Thread pool efficiency
- Race condition avoidance
- Parallel processing opportunities

**Caching:**
- Appropriate cache levels (memory, disk, CDN)
- Cache invalidation strategies
- Cache hit ratio optimization
- Avoiding cache stampede

**Data Structures:**
- Appropriate collection types
- Search and retrieval efficiency
- Insert/delete performance
- Memory overhead considerations
</specific_areas>

<examples>
<correct>
Identifying O(n²) algorithm:
```bash
# Code finds nested loop searching:
# for user in users:
#     for friend in users:
#         if friend.id == user.best_friend_id:

gh api repos/:owner/:repo/pulls/45/comments -X POST \
  -f body="Performance issue: Nested loop creates O(n²) complexity for friend lookup. With 1000 users, this becomes 1M operations. Suggested optimization: Create a dictionary lookup: friend_map = {u.id: u for u in users}, then friend = friend_map.get(user.best_friend_id)" \
  -f commit_id="a1b2c3..." \
  -f path="user_service.py" \
  -f side="RIGHT" \
  -F start_line=23 \
  -F line=26
```

Identifying N+1 query:
```bash
# Code finds: for order in orders: customer = db.get_customer(order.customer_id)

gh api repos/:owner/:repo/pulls/45/comments -X POST \
  -f body="Performance issue: N+1 query problem - executing one query per order to fetch customers. With 100 orders, this creates 101 database queries. Suggested fix: Fetch all customers in one query: customer_ids = [o.customer_id for o in orders]; customers = db.get_customers_by_ids(customer_ids)" \
  -f commit_id="a1b2c3..." \
  -f path="order_service.py" \
  -f side="RIGHT" \
  -F line=78
```
</correct>

<incorrect>
Vague performance comment:
```bash
# ❌ WRONG - no specific problem or solution
gh api repos/:owner/:repo/pulls/45/comments -X POST \
  -f body="This might be slow" \
  -f commit_id="a1b2c3..." \
  -f path="user_service.py" \
  -f side="RIGHT" \
  -F line=23
```
</incorrect>
</examples>

<measurement_considerations>
**When suggesting optimizations, consider:**

**Measurable Impact:**
- Will this affect response times?
- How many users/requests will benefit?
- What's the memory/CPU savings?
- Is this a hot path in the application?

**Implementation Cost:**
- How complex is the optimization?
- Does it introduce new dependencies?
- Will it affect code readability?
- Are there maintenance implications?

**Premature Optimization:**
- Is this actually a bottleneck?
- Do we have performance data?
- Is the code likely to change soon?
- Would profiling be more appropriate?
</measurement_considerations>

<validation_checklist>
**Performance review complete when checked:**
- [ ] Analyzed algorithm complexity for all new code
- [ ] Reviewed database query efficiency
- [ ] Checked for memory leaks or excessive allocations
- [ ] Identified caching opportunities
- [ ] Verified async operations are used appropriately
- [ ] Looked for N+1 query patterns
- [ ] Assessed data structure choices
- [ ] Considered scalability with larger datasets
- [ ] Evaluated I/O operation efficiency
</validation_checklist>

<integration>
This rule works with:
- Context from `gh-pr-review-always-fetch-pr-details-first.rule.md`
- May inform `gh-pr-review-always-suggest-refactoring-opportunities.rule.md`
- Complements `gh-pr-review-always-verify-test-coverage.rule.md` for performance tests
</integration>