---
applies_to:
  - file_patterns: []
  - contexts: ["gh", "github", "pr", "pull_requests"]
  - actions: ["creating_pr"]
timing: "before"
summary: "Always use gh command for creating pull requests, never other methods"
version: "1.0.0"
---

# Rule: Always Use GH Command for PR Creation

<purpose>
This rule ensures that all pull request creation is done through the GitHub CLI (gh command) rather than other methods, maintaining consistency and leveraging proper GitHub integration.
</purpose>

<instructions>
When creating pull requests, you MUST:

1. ALWAYS use the `gh pr create` command
2. NEVER use other methods such as:
   - Manual creation through GitHub web interface
   - Direct API calls
   - Other CLI tools
   - Git push with manual PR creation

The standard command format:
```bash
gh pr create --title "[PR Title]" --body "[PR Description]"
```
</instructions>

<rationale>
Using gh CLI for PR creation provides:
- Consistent command-line workflow
- Proper authentication handling
- Integration with other gh commands
- Standardized PR creation process
- Better automation capabilities
- Reduced context switching to web interface
</rationale>

<command_options>
Common gh pr create options:
- `--title` or `-t`: PR title
- `--body` or `-b`: PR description
- `--draft` or `-d`: Create as draft PR
- `--reviewer` or `-r`: Add reviewers
- `--assignee` or `-a`: Assign the PR
- `--label` or `-l`: Add labels
- `--base` or `-B`: Target branch (default: main)
- `--head` or `-H`: Source branch (default: current)
</command_options>

<examples>
<correct>
Basic PR creation:
```bash
gh pr create --title "Add user authentication" --body "Implements login and logout functionality"
```

PR with additional options:
```bash
gh pr create \
  --title "Fix validation bug" \
  --body "Resolves issue with email validation" \
  --draft \
  --label "bug"
```

Using file for description:
```bash
gh pr create --title "Feature implementation" --body-file pr-description.md
```
</correct>

<incorrect>
Using other methods:
```bash
# Wrong - manual web interface creation
# Opening GitHub.com to create PR manually

# Wrong - direct API calls
curl -X POST https://api.github.com/repos/...

# Wrong - expecting git push to auto-create PR
git push origin feature-branch  # Without using gh pr create
```
</incorrect>
</examples>

<integration>
This rule works with:
- gh-auth-always-switch-to-claude-hughes-before-commands.rule.md (auth switching)
- gh-pr-always-use-standard-description-format.rule.md (description formatting)
- Other gh PR rules for complete workflow
</integration>

<validation>
When creating PRs, verify:
- [ ] Using gh pr create command
- [ ] Not using alternative PR creation methods
- [ ] Command includes required title and body
- [ ] Authentication switched to claude-hughes first
- [ ] Command executed successfully
</validation>