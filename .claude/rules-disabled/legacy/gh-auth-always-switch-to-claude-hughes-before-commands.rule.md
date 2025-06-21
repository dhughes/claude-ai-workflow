---
applies_to:
  - file_patterns: []
  - contexts: ["gh", "github", "authentication"]
  - actions: ["before_gh_command"]
timing: "before"
summary: "Always switch to claude-hughes auth before running any gh commands"
version: "1.0.0"
---

# Rule: Always Switch to Claude-Hughes Auth Before GH Commands

<purpose>
This rule ensures that all GitHub CLI commands are executed with the correct authentication context (claude-hughes) rather than any other authenticated user, maintaining consistent identity for all GitHub operations.
</purpose>

<instructions>
Before running ANY gh command, you MUST:

1. SWITCH to the claude-hughes authentication context:
   ```bash
   gh auth switch -u claude-hughes
   ```

2. VERIFY the switch was successful (optional but recommended)

3. PROCEED with the intended gh command

This applies to ALL gh commands including:
- `gh pr create`
- `gh pr list`  
- `gh issue create`
- `gh repo clone`
- Any other gh subcommands
</instructions>

<rationale>
Multiple authenticated users exist in the gh CLI:
- `me` (original user)
- `claude-hughes` (AI user)

All AI operations should be performed as `claude-hughes` to:
- Maintain consistent attribution
- Ensure proper permissions and access
- Keep AI work clearly identified in GitHub
- Prevent accidental operations under wrong identity
</rationale>

<examples>
<correct>
Before creating a PR:
```bash
gh auth switch -u claude-hughes
gh pr create --title "Add new feature" --body "Implementation details..."
```

Before listing PRs:
```bash
gh auth switch -u claude-hughes
gh pr list
```

Before any gh operation:
```bash
gh auth switch -u claude-hughes
gh issue create --title "Bug report" --body "Description..."
```
</correct>

<incorrect>
Running gh commands without auth switch:
```bash
gh pr create --title "Add feature"  # Wrong - no auth switch
```

Using wrong user:
```bash
gh auth switch -u me  # Wrong user
gh pr create --title "Add feature"
```

Skipping auth switch:
```bash
# Assuming current auth is correct without checking
gh pr list
```
</incorrect>
</examples>

<validation>
Before any gh command execution:
- [ ] Authentication switch command executed
- [ ] Used correct username: claude-hughes
- [ ] Switch completed without errors
- [ ] Ready to proceed with gh command
</validation>

<error_handling>
If auth switch fails:
1. Check if claude-hughes user is properly configured
2. Verify gh CLI is installed and working
3. Check network connectivity
4. Do not proceed with gh commands until auth switch succeeds
</error_handling>