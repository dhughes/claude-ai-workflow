---
applies_to:
  - file_patterns: []
  - contexts: ["gh", "github", "pr", "approach"]
  - actions: ["writing_pr_approach_section"]
timing: "before"
summary: "Always describe HOW changes were implemented in Approach section - strategies and technical decisions"
version: "1.0.0"
---

# Rule: Always Describe Implementation Strategy in Approach Section

<purpose>
This rule ensures that the Approach section of PR descriptions focuses exclusively on the "HOW" - explaining the technical strategies, implementation decisions, and methods used to achieve the goals stated in the Purpose section.
</purpose>

<instructions>
When writing the Approach section of a PR description, you MUST:

1. FOCUS on HOW the changes were implemented
2. EXPLAIN technical strategies and decisions made
3. DESCRIBE the solution approach and methodology
4. INCLUDE key implementation details and architectural choices
5. ANSWER: "What solution approach was taken?" and "How was this implemented?"

The Approach section should help reviewers understand:
- Technical decisions and rationale
- Implementation strategy and patterns used
- Key components or changes made
- Architecture or design approaches
- Libraries, tools, or frameworks chosen
</instructions>

<content_guidelines>
**Include in Approach:**
- Technical implementation strategies
- Architectural decisions and patterns
- Key components or modules created/modified
- Libraries, frameworks, or tools used
- Design patterns or methodologies applied
- Data structures or algorithms chosen
- Integration approaches
- Error handling strategies
- Performance considerations

**Exclude from Approach:**
- Business motivation (belongs in Purpose)
- User stories or requirements
- Problem context or background
- Why the change was needed
- Future plans or roadmap items
</content_guidelines>

<examples>
<correct>
Good Approach sections:
```markdown
## Approach
Implemented JWT-based authentication using the jsonwebtoken library. Added middleware for route protection that validates tokens on protected endpoints. Used bcrypt for secure password hashing with salt rounds of 12. Created login/logout endpoints with proper error handling and session management. Token expiration set to 24 hours with secure httpOnly cookies.
```

```markdown
## Approach
Replaced hardcoded English month names with the Intl.DateTimeFormat API for proper localization. Added locale detection from user browser preferences with fallback to system default. Implemented a utility function that handles edge cases for different calendar systems and formats dates consistently across all components.
```

```markdown
## Approach
Added CSS custom properties for theme variables and created a ThemeProvider context in React. Implemented toggle functionality using localStorage for persistence. Updated all existing components to use theme variables instead of hardcoded colors. Added smooth transitions between themes using CSS transitions.
```
</correct>

<incorrect>
Poor Approach sections (too focused on why):
```markdown
## Approach
This change is needed because users requested better security and want to protect their data.
# Wrong - this explains WHY, not HOW
```

```markdown
## Approach
International users are having problems with dates so we need to fix this bug.
# Wrong - problem context belongs in Purpose
```

Too vague:
```markdown
## Approach
Made some changes to the authentication system.
# Wrong - not specific about implementation details
```

Too detailed (belongs in code comments):
```markdown
## Approach
Changed line 42 in auth.js to use bcrypt.hash() with await keyword, then modified the user model schema to include password field with type String and required true, then updated the login route handler to compare passwords using bcrypt.compare()...
# Wrong - too granular, should be higher level
```
</incorrect>
</examples>

<approach_patterns>
Use these patterns for clear Approach sections:

**Strategy Pattern:**
"Implemented [solution] using [technology/pattern]. [Key decision] to [achieve specific goal]."

**Component Pattern:**
"Added [component/module] that handles [functionality]. Used [technology] for [specific aspect]. Integrated with [existing system]."

**Technical Decision Pattern:**
"Chose [technology/approach] over [alternative] because [technical rationale]. Implemented [key features] with [specific methods]."

**Architecture Pattern:**
"Structured the solution using [pattern/architecture]. Created [components] that [responsibilities]. Connected via [integration method]."
</approach_patterns>

<implementation_levels>
Focus on the right level of detail:

**Good Level (High-level technical):**
- Key architectural decisions
- Major components and their interactions
- Technology choices and rationale
- Important patterns or algorithms
- Integration strategies

**Too High Level:**
- Vague statements without specifics
- Just restating the purpose
- No technical content

**Too Low Level:**
- Line-by-line code changes
- Variable names and exact syntax
- Minor implementation details
- Information better suited for code comments
</implementation_levels>

<validation>
Before finalizing Approach section, verify it:
- [ ] Explains HOW changes were implemented
- [ ] Describes technical strategies and decisions
- [ ] Includes key implementation details
- [ ] Avoids business motivation (Purpose content)
- [ ] Is specific about methods and technologies
- [ ] Helps reviewers understand technical approach
- [ ] Provides appropriate level of detail
- [ ] Focuses on solution methods, not problems
</validation>