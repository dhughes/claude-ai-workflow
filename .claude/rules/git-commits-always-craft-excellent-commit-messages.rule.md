---
applies_to:
  - file_patterns: []
  - contexts: ["git", "commits", "messaging"]
  - actions: ["before_commit"]
timing: "before"
summary: "Create excellent commit messages using chat context, git changes, and best practices"
version: "1.0.0"
---

# Rule: Always Craft Excellent Commit Messages

<purpose>
This rule ensures all git commits have well-crafted messages that clearly communicate the purpose, context, and reasoning behind changes, following industry best practices and leveraging available context for maximum clarity.
</purpose>

<instructions>
Before creating any git commit, you MUST:

1. ANALYZE the chat context to understand:
   - What the user requested
   - Why the changes were needed
   - What problem is being solved

2. REVIEW git changes by running:
   - `git diff` to see all modifications
   - `git log --oneline -5` to see recent commit styles
   - `git diff [base-branch]...HEAD` if working on a feature branch

3. CRAFT the commit message following these rules:
   - Subject line: 50 characters or less
   - Capitalize the subject line
   - Use imperative mood ("Add feature" not "Added feature")
   - No period at end of subject line
   - Blank line between subject and body
   - Body wrapped at 72 characters
   - Explain "what" and "why", not "how"

4. VALIDATE the subject line completes: "If applied, this commit will _____"

5. INCLUDE in the body:
   - Context from the conversation
   - Reason for the change
   - Any side effects or considerations
   - Reference to user requests when applicable
</instructions>

<message_structure>
Subject Line Rules:
- Maximum 50 characters
- Start with capital letter
- Use imperative mood
- No trailing period
- Be specific and descriptive

Body Guidelines:
- Separate from subject with blank line
- Wrap at 72 characters per line
- Explain the context and reasoning
- Reference the user's request when relevant
- Mention any important considerations
- Use bullet points for multiple items
</message_structure>

<context_integration>
Use chat context to enhance commit messages:
- Reference the user's original request
- Explain the business logic or user need
- Mention constraints or requirements discussed
- Note any decisions made during implementation
- Include rationale for chosen approach
</context_integration>

<examples>
<correct>
When user asked to "add dark mode toggle":
```
Add dark mode toggle to application settings

Implements user-requested dark mode functionality with:
- Toggle switch in settings page
- CSS-in-JS theme switching
- Local storage persistence
- Updated component theming throughout app

Addresses user need for eye-strain reduction during night usage.
```

When fixing a bug user reported:
```
Fix date formatting for non-English locales

Resolves user-reported issue where dates displayed incorrectly 
in French and German locales. Problem was caused by hardcoded 
English month names in dateFormatter utility.

- Replace hardcoded strings with Intl.DateTimeFormat
- Add locale detection from user preferences
- Include comprehensive test coverage for multiple locales
```

When implementing a feature request:
```
Implement user profile editing functionality

User requested ability to update profile information including
avatar, bio, and contact details. Implementation includes:

- Profile edit form with validation
- Image upload for avatar changes  
- Real-time preview of changes
- Optimistic UI updates with error handling

Maintains existing profile display while adding edit capabilities.
```
</correct>

<incorrect>
Too vague:
```
Update files
```

Wrong mood:
```
Updated the user profile component
```

Too long subject:
```
Add user profile editing functionality with image upload and validation
```

No context or reasoning:
```
Fix bug

Changed the date function.
```

Missing blank line:
```
Add dark mode toggle
Implements dark mode functionality for the app.
```
</incorrect>
</examples>

<validation_checklist>
Before committing, verify:
- [ ] Subject line ≤ 50 characters
- [ ] Subject line capitalized
- [ ] Subject line uses imperative mood
- [ ] No period at end of subject line
- [ ] Blank line separates subject and body
- [ ] Body lines wrapped at 72 characters
- [ ] Message explains "what" and "why"
- [ ] Context from chat conversation included
- [ ] Subject completes "If applied, this commit will..."
- [ ] Message would be helpful to future developers
</validation_checklist>

<commit_message_templates>
For new features:
```
[Verb] [feature description]

[User context and reasoning]
[Implementation details]
[Any important considerations]
```

For bug fixes:
```
Fix [specific issue description]

[Problem explanation and context]
[Root cause if relevant]
[Solution approach]
```

For refactoring:
```
Refactor [component/area] for [reason]

[Why refactoring was needed]
[What was changed]
[Benefits of new approach]
```
</commit_message_templates>