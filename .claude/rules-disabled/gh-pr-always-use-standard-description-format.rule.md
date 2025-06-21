---
applies_to:
  - file_patterns: []
  - contexts: ["gh", "github", "pr", "description"]
  - actions: ["creating_pr_description"]
timing: "before"
summary: "Always use standard 5-section format for PR descriptions: Purpose, Approach, Additional Notes, Open Questions, Verification Steps"
version: "1.0.0"
---

# Rule: Always Use Standard Description Format for PRs

<purpose>
This rule ensures that all pull request descriptions follow a consistent, comprehensive format with standardized sections that provide reviewers with all necessary information for effective code review.
</purpose>

<instructions>
When creating PR descriptions, you MUST use this exact 5-section format in order:

1. **Purpose** (required)
2. **Approach** (required)  
3. **Additional Notes** (optional)
4. **Open Questions** (optional)
5. **Verification Steps** (optional)

Each section must:
- Use the exact section names as markdown headers (##)
- Appear in the specified order
- Include Purpose and Approach sections (never skip these)
- Include optional sections only when relevant
</instructions>

<section_format>
Standard template:
```markdown
[Issue reference if applicable]

## Purpose
[WHY these changes were made - motivation and goals]

## Approach  
[HOW the changes were implemented - strategies and decisions]

## Additional Notes
[Optional: Any relevant context, considerations, or clarifications]

## Open Questions
[Optional: Questions that may block or affect this PR]

## Verification Steps
[Optional: Manual steps humans need to perform to validate the work]
```
</section_format>

<section_definitions>
**Purpose (Required):**
- Describes WHY the changes were made
- Explains motivation, goals, and business value
- Answers: "What problem does this solve?"

**Approach (Required):**
- Describes HOW the changes were implemented
- Explains technical strategies and decisions made
- Answers: "What solution approach was taken?"

**Additional Notes (Optional):**
- Any relevant context or considerations
- Design decisions and trade-offs
- Future improvements or limitations
- Use AI discretion for inclusion

**Open Questions (Optional):**
- Questions relevant to the PR that need answers
- Potential blockers or concerns
- Items requiring input from reviewers
- May prevent PR completion until resolved

**Verification Steps (Optional):**
- Manual validation steps for humans
- Only include if AI cannot verify the work
- Examples: mobile app testing, UI interaction, external integrations
- Skip if all verification can be automated
</section_definitions>

<examples>
<correct>
Complete PR description:
```markdown
Fixes #123

## Purpose
Implement user authentication to allow secure access to the application. This addresses the security requirement for user login and session management.

## Approach
Added JWT-based authentication with login/logout endpoints. Implemented middleware for route protection and session validation. Used bcrypt for password hashing and secure token generation.

## Additional Notes
Token expiration is set to 24 hours. Future enhancement could include refresh token functionality for better user experience.

## Open Questions
Should we implement password reset functionality in this PR or create a separate issue?

## Verification Steps
1. Open the app on mobile device
2. Test login flow with valid credentials
3. Verify session persists across app restarts
4. Test logout functionality
```

Minimal required sections:
```markdown
Resolves #456

## Purpose
Fix date formatting bug that displays incorrect dates in non-English locales.

## Approach
Replaced hardcoded English month names with Intl.DateTimeFormat API for proper localization support.
```
</correct>

<incorrect>
Missing required sections:
```markdown
Fixes #123

This PR adds authentication.
# Missing Purpose and Approach sections
```

Wrong section names:
```markdown
## Why
This fixes the bug...

## How  
I changed the code...
# Should be "Purpose" and "Approach"
```

Wrong order:
```markdown
## Approach
Implementation details...

## Purpose  
Why this was needed...
# Purpose should come first
```

Inappropriate optional sections:
```markdown
## Purpose
Add new feature...

## Approach
Implementation details...

## Verification Steps
Run unit tests
# Wrong - unit tests are automated, not manual verification
```
</incorrect>
</examples>

<integration>
This rule works with:
- gh-pr-always-reference-issues-first-in-description.rule.md (issue references)
- gh-pr-purpose-always-describe-motivation-and-goals.rule.md (Purpose content)
- gh-pr-approach-always-describe-implementation-strategy.rule.md (Approach content)
</integration>

<validation>
Before creating PR, verify description has:
- [ ] Issue reference first (if applicable)
- [ ] ## Purpose section with motivation and goals
- [ ] ## Approach section with implementation details
- [ ] Optional sections only when relevant and valuable
- [ ] Sections in correct order
- [ ] Proper markdown formatting for headers
- [ ] Content is clear and comprehensive
</validation>