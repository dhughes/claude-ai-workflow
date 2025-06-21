---
applies_to:
  - file_patterns: []
  - contexts: ["gh", "github", "pr", "purpose"]
  - actions: ["writing_pr_purpose_section"]
timing: "before"
summary: "Always describe WHY changes were made in Purpose section - motivation and goals, not implementation details"
version: "1.0.0"
---

# Rule: Always Describe Motivation and Goals in Purpose Section

<purpose>
This rule ensures that the Purpose section of PR descriptions focuses exclusively on the "WHY" - explaining the motivation, business value, and goals behind the changes rather than implementation details.
</purpose>

<instructions>
When writing the Purpose section of a PR description, you MUST:

1. FOCUS on WHY the changes were made
2. EXPLAIN the motivation and business goals
3. DESCRIBE the problem being solved or value being added
4. AVOID implementation details (those go in Approach section)
5. ANSWER: "What problem does this solve?" and "Why is this important?"

The Purpose section should help reviewers understand:
- The business or technical need driving the change
- The value or benefit this provides
- The problem context or user impact
</instructions>

<content_guidelines>
**Include in Purpose:**
- Business requirements or user needs
- Problems being solved
- Goals and objectives
- User impact or value
- Context about why this change is needed now
- Reference to related issues or requirements

**Exclude from Purpose:**
- Implementation details (save for Approach)
- Technical decisions or strategies
- Code changes or file modifications
- Tool choices or library selections
- Step-by-step implementation plans
</content_guidelines>

<examples>
<correct>
Good Purpose sections:
```markdown
## Purpose
Implement user authentication to provide secure access to the application. Users currently cannot protect their data or maintain sessions, creating security risks and poor user experience. This change enables user registration, login, and session management as requested in our security audit.
```

```markdown
## Purpose
Fix date formatting bug that displays incorrect dates for non-English users. The current implementation hardcodes English month names, causing confusion for international users and failing accessibility requirements. This impacts 40% of our user base.
```

```markdown
## Purpose
Add dark mode toggle to reduce eye strain for users during night usage. User feedback indicates this is the most requested feature, and accessibility guidelines recommend providing theme options for better user experience.
```
</correct>

<incorrect>
Poor Purpose sections (too focused on implementation):
```markdown
## Purpose
Add JWT authentication using bcrypt for password hashing and middleware for route protection.
# Wrong - this describes HOW, not WHY
```

```markdown
## Purpose
Replace hardcoded strings with Intl.DateTimeFormat API and add locale detection from user preferences.
# Wrong - implementation details belong in Approach
```

```markdown
## Purpose
Create new CSS variables for theme switching and update all components to use dynamic styles.
# Wrong - technical implementation, not business purpose
```

Too vague:
```markdown
## Purpose
Improve the application.
# Wrong - not specific about what problem is being solved
```
</incorrect>
</examples>

<purpose_patterns>
Use these patterns for clear Purpose sections:

**Problem-Solution Pattern:**
"[Problem description]. This change [solves X] by [high-level benefit]."

**User Need Pattern:**
"Users need [capability] to [achieve goal]. Currently [limitation exists], causing [negative impact]."

**Business Value Pattern:**
"This implements [business requirement] to [achieve business goal]. The change provides [value/benefit] for [stakeholder]."

**Issue Reference Pattern:**
"Addresses [issue/requirement] by providing [solution capability]. This resolves [specific problem] that affects [impact scope]."
</purpose_patterns>

<context_information>
Good Purpose sections often include:
- **User impact**: Who benefits and how
- **Problem scope**: How many users or systems affected
- **Business context**: Why this matters to the organization
- **Timing context**: Why this change is needed now
- **Reference context**: Links to issues, requirements, or discussions
</context_information>

<validation>
Before finalizing Purpose section, verify it:
- [ ] Explains WHY changes were made
- [ ] Describes business/user motivation
- [ ] Avoids implementation details
- [ ] Provides clear problem context
- [ ] States goals and expected value
- [ ] Helps reviewers understand importance
- [ ] Is specific rather than vague
- [ ] Focuses on outcomes, not methods
</validation>