---
timing: "before"
applies_to:
  - file_patterns: []
  - contexts: ["git", "commit", "messages", "quality"]
  - actions: ["committing", "git_commit"]
action: "Write clear, descriptive commit messages following best practices"
---

<purpose>
This rule ensures all commit messages are well-written, descriptive, and follow established best practices for clarity and maintainability, inspired by https://cbea.ms/git-commit/ guidelines.
</purpose>

<condition>
When creating a git commit message
</condition>

<instructions>
1. STRUCTURE the commit message with:
   - Subject line (50 chars or less)
   - Blank line
   - Body (wrap at 72 chars) if needed
2. WRITE subject line that:
   - Uses imperative mood ("Add feature" not "Added feature")
   - Capitalizes first letter
   - Doesn't end with period
   - Summarizes the change clearly
3. INCLUDE body when necessary to:
   - Explain what and why (not how)
   - Reference issues or tickets
   - Describe breaking changes
4. AVOID:
   - Vague messages like "fix bug" or "update code"
   - Explaining how the code works
   - Including file names unless critical
</instructions>

<detail>
CRITICAL: Commit messages document the project's evolution
CRITICAL: Focus on the intent and impact of changes
CRITICAL: Use present tense, imperative mood

Good examples:
- "Add user authentication via OAuth2"
- "Fix memory leak in image processing pipeline"
- "Refactor API client to use async/await"

Bad examples:
- "Fixed stuff"
- "Updated files"
- "Changes"

The commit message should complete: "If applied, this commit will..."
</detail>