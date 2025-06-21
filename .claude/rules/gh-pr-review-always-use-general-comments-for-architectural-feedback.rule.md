---
applies_to:
  - file_patterns: []
  - contexts: ["gh", "github", "pr", "review", "architecture", "process_feedback"]
  - actions: ["providing_architectural_feedback", "process_commentary", "system_wide_feedback"]
timing: "before"
summary: "Always use general PR comments for architectural, process, or system-wide feedback that doesn't relate to specific code lines"
version: "1.0.0"
---

# Rule: Always Use General Comments For Architectural Feedback

<purpose>
This rule ensures that feedback about architecture, processes, workflows, and system-wide concerns is posted as general PR comments rather than line-specific comments, providing appropriate context and scope for high-level feedback.
</purpose>

<instructions>
When providing feedback that is NOT tied to specific code lines, use general PR comments:

1. **Identify non-line-specific feedback types**:
   - Overall architectural concerns
   - Process and workflow suggestions
   - System-wide design decisions
   - Cross-cutting concerns affecting multiple files
   - General PR structure or approach feedback

2. **Use general PR comment command**:
   ```bash
   gh pr comment {number} --body "Your architectural or process feedback here"
   ```

3. **Ensure feedback scope matches comment type**:
   - General comments for broad, conceptual feedback
   - System-wide concerns that span multiple files
   - Process improvements and workflow suggestions
   - Strategic technical decisions

4. **Reserve line-specific comments for code issues**:
   - Never use general comments for specific line issues
   - Keep architectural feedback separate from implementation details
   - Maintain clear separation of concern levels

**Architectural and process feedback belongs in general PR comments.**
</instructions>

<general_feedback_types>
**What qualifies as general PR feedback:**

**Architectural Concerns:**
- Overall system design approach
- Module organization and separation of concerns
- Design pattern usage and consistency
- System scalability and maintainability considerations
- Technology choice evaluation

**Process and Workflow:**
- Testing strategy and coverage approach
- Documentation completeness
- CI/CD pipeline considerations
- Deployment strategy impact
- Code review process improvements

**Cross-Cutting Concerns:**
- Security model implementation
- Error handling strategy
- Logging and monitoring approach
- Performance optimization strategy
- Configuration management

**PR Structure:**
- Commit organization and clarity
- PR scope and size considerations
- Breaking changes impact
- Migration path suggestions
- Release planning feedback
</general_feedback_types>

<command_usage_examples>
**Correct general comment posting:**

```bash
# For architectural feedback
gh pr comment 123 --body "Architectural concern: The new service layer bypasses the existing authentication middleware. Consider integrating with the current auth system to maintain consistent security across all services."

# For process feedback  
gh pr comment 456 --body "Testing approach: This feature adds significant complexity but lacks integration tests. Consider adding end-to-end tests to verify the complete workflow before merging."

# For system-wide design
gh pr comment 789 --body "Design pattern consistency: The new components use a different state management approach than existing modules. For maintainability, consider aligning with the established Redux pattern or documenting the rationale for the new approach."
```
</command_usage_examples>

<examples>
<correct>
Providing architectural feedback:
```bash
# Overall system design concern
gh pr comment 123 --body "Architecture Review: This PR introduces direct database access in the presentation layer, bypassing the established repository pattern. This could lead to tight coupling and make testing more difficult. Consider routing database operations through the existing service layer to maintain separation of concerns."
```

Process improvement suggestion:
```bash
# Workflow and process feedback
gh pr comment 456 --body "Process Suggestion: This feature modifies core authentication logic but doesn't include migration scripts for existing user sessions. Consider adding a migration strategy or backward compatibility approach to prevent user session invalidation during deployment."
```

Cross-cutting concern feedback:
```bash
# System-wide security consideration
gh pr comment 789 --body "Security Consideration: The new API endpoints don't follow the established rate limiting pattern used throughout the application. For consistency and security, consider applying the same rate limiting middleware to these endpoints."
```
</correct>

<incorrect>
Using line-specific comments for architectural feedback:
```bash
# ❌ WRONG - architectural concern attached to specific line
gh api repos/owner/repo/pulls/123/comments \
  --field body="This breaks the overall system architecture" \
  --field path="src/service.js" \
  --field line="45"
# Should be general PR comment instead
```

Mixed specific and general feedback:
```bash
# ❌ WRONG - mixing line-specific and architectural concerns
gh pr comment 456 --body "Line 32 has a SQL injection issue, and also the overall architecture doesn't follow our patterns"
# Should split into line-specific comment for SQL issue and general comment for architecture
```

Vague general comments for specific issues:
```bash
# ❌ WRONG - using general comment for specific code issue
gh pr comment 789 --body "There are security issues in the auth file"
# Should identify specific lines and use line-specific comments
```
</incorrect>
</examples>

<feedback_categorization>
**How to categorize feedback for proper comment type:**

**Use General PR Comments For:**
- Feedback affecting multiple files or components
- Strategic decisions about technology or approach
- Process, workflow, and methodology concerns
- System-wide patterns and consistency issues
- Documentation and testing strategy
- Deployment and operational considerations

**Use Line-Specific Comments For:**
- Issues with specific code implementations
- Bugs, vulnerabilities, or logic errors in particular lines
- Code style violations in specific locations
- Performance issues in particular functions
- Specific syntax or implementation problems

**Decision Framework:**
```
IF feedback_relates_to_specific_lines:
    USE line-specific comment via GitHub API
ELSE IF feedback_is_architectural_or_process:
    USE general PR comment via gh pr comment
ELSE:
    EVALUATE scope and choose appropriate comment type
```
</feedback_categorization>

<integration>
This rule works with:
- `gh-pr-review-always-use-line-specific-comments-for-code-issues.rule.md` for proper separation
- `gh-pr-review-always-fetch-pr-details-first.rule.md` for context understanding
- `gh-auth-always-switch-to-claude-hughes-before-commands.rule.md` for authentication

This rule ensures:
- Proper feedback categorization and placement
- Clear separation between code and architectural concerns
- Appropriate scope matching for different feedback types
- Better organization of review feedback for developers
</integration>

<validation>
General comment usage complete when:
- [ ] Feedback type identified as architectural/process/system-wide
- [ ] Confirmed feedback doesn't relate to specific code lines
- [ ] General PR comment command used (gh pr comment)
- [ ] Feedback scope matches comment type appropriately
- [ ] Clear separation maintained from line-specific issues
- [ ] Architectural or process feedback properly conveyed
- [ ] Appropriate level of detail for general feedback provided
</validation>