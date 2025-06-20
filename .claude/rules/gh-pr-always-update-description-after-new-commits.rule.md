---
applies_to:
  - file_patterns: []
  - contexts: ["gh", "github", "pr", "push", "updates"]
  - actions: ["after_push_to_branch_with_open_pr"]
timing: "after"
summary: "Always update PR description when pushing new work to branch with open PR, if changes warrant it"
version: "1.0.0"
---

# Rule: Always Update PR Description After New Commits

<purpose>
This rule ensures that pull request descriptions remain accurate and comprehensive when new commits are pushed to a branch with an open PR, keeping reviewers informed about additional work and changes to the scope or approach.
</purpose>

<instructions>
After pushing commits to a branch that has an open pull request, you MUST:

1. **Check if PR exists**: Use `gh pr list` or `gh pr view` to confirm there's an open PR for the current branch
2. **Analyze new commits**: Review what work was added since the last PR description update
3. **Evaluate description sufficiency**: Determine if current description covers the new work adequately
4. **Update if needed**: If new work changes scope, approach, or adds significant functionality, update the PR description
5. **Leave unchanged if sufficient**: If existing description already covers the new work, no update needed

This applies when:
- New commits are pushed to a branch with an open PR
- The new work substantially changes or expands the PR scope
- The existing description doesn't adequately reflect the current state of work
</instructions>

<evaluation_criteria>
**Update PR description when new commits include:**
- New features or functionality not mentioned in original description
- Significant changes to the implementation approach
- Additional bug fixes beyond the original scope
- New files or components not covered in the original description
- Changes that affect the verification steps or testing approach
- Work that addresses additional requirements or edge cases

**Leave description unchanged when new commits are:**
- Minor fixes or improvements already implied by the original description
- Refactoring that doesn't change the external behavior
- Code cleanup or formatting changes
- Small bug fixes that are part of the expected implementation
- Test additions that were already mentioned in verification steps
- Documentation updates for features already described
</evaluation_criteria>

<workflow_steps>
After pushing to branch with open PR:

1. **Check for open PR**: `gh pr view` (no arguments uses current branch)
2. **Review new commits**: `git log --oneline [last-described-commit]..HEAD`
3. **Assess current description**: Read existing PR description
4. **Determine if update needed**: Apply evaluation criteria
5. **Update if warranted**: `gh pr edit --body "updated description"`
6. **Skip if sufficient**: Continue with normal workflow
</workflow_steps>

<update_approaches>
**For significant additions:**
- Add new sections to Purpose or Approach sections
- Update verification steps if new testing is required
- Mention new files or components in Approach section
- Add any new open questions or considerations

**For scope changes:**
- Update Purpose section to reflect expanded scope
- Revise Approach section with new implementation details
- Update verification steps with additional testing requirements
- Note any changes to timeline or complexity

**For approach changes:**
- Revise Approach section with new technical decisions
- Update any affected verification steps
- Note reasons for approach changes in Additional Notes
- Update any relevant open questions
</update_approaches>

<examples>
<update_warranted>
Original PR: "Add user authentication"
New commits: Added OAuth integration, password reset functionality
Action: Update description to include OAuth and password reset features

Original PR: "Fix date formatting bug"
New commits: Also fixed timezone handling and added comprehensive date tests  
Action: Update description to reflect expanded bug fix scope

Original PR: "Refactor user service"
New commits: Changed from REST to GraphQL API approach
Action: Update Approach section to explain GraphQL decision
</update_warranted>

<update_not_needed>
Original PR: "Add user profile component with avatar and bio"
New commits: Fixed CSS spacing, added hover effects
Action: No update needed - improvements are implied by original description

Original PR: "Implement search functionality with filters"
New commits: Added unit tests for search filters
Action: No update needed - testing was mentioned in verification steps

Original PR: "Fix login validation errors"
New commits: Improved error messages, added input sanitization
Action: No update needed - improvements are part of expected fix scope
</update_not_needed>
</examples>

<commands>
**Check for open PR on current branch:**
```bash
gh pr view
```

**Check PR status across branches:**
```bash
gh pr list --state open
```

**Review recent commits:**
```bash
git log --oneline -10
git log --oneline [last-update]..HEAD
```

**Update PR description:**
```bash
gh pr edit --body "updated description content"
```

**Update PR description interactively:**
```bash
gh pr edit
```
</commands>

<validation>
Before and after PR description updates, verify:
- [ ] Open PR exists for the current branch
- [ ] New commits have been analyzed for scope/approach changes
- [ ] Current description has been evaluated for adequacy
- [ ] Update decision follows the evaluation criteria
- [ ] If updated, new description accurately reflects all current work
- [ ] If not updated, existing description still covers new commits appropriately
</validation>

<description_update_format>
When updating descriptions, maintain the standard 5-section format:
- **Purpose**: Update if scope has expanded or changed
- **Approach**: Update if implementation strategy has changed  
- **Additional Notes**: Add notes about new decisions or changes
- **Open Questions**: Update or add new questions if applicable
- **Verification Steps**: Add new steps for additional functionality

Preserve existing content that remains accurate and only modify sections that need updates.
</description_update_format>

<exceptions>
Do NOT update PR descriptions when:
- No open PR exists for the current branch
- New commits are purely cosmetic (formatting, comments)
- Changes are minor fixes clearly implied by original description
- User explicitly requests to keep current description
- PR is in draft state and user is still actively developing
- Description was recently updated and still accurately reflects all work
</exceptions>