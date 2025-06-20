---
applies_to:
  - file_patterns: []
  - contexts: ["gh", "github", "pr", "merge", "approval"]
  - actions: ["before_merging_pr"]
timing: "before"
summary: "Always verify both human approval and GitHub status before merging any PR"
version: "1.0.0"
---

# Rule: Always Verify Approval Before Merge

<purpose>
This rule ensures that pull requests are only merged when there is clear confirmation of approval from both the human user and GitHub's approval system, preventing accidental or unauthorized merges.
</purpose>

<instructions>
Before merging any pull request, you MUST verify BOTH conditions:

1. **Human Approval**: The human has explicitly stated the PR is approved
2. **GitHub Status**: GitHub shows the PR as approved in its system

Verification steps:
1. CHECK that human has clearly stated "approved" or "merge this PR"
2. RUN `gh pr status [PR-number]` to check GitHub approval status
3. CONFIRM both approvals exist before proceeding with merge
4. ONLY merge when both conditions are satisfied

If either condition is missing, do NOT merge.
</instructions>

<approval_verification>
**Human Approval Indicators:**
- "This PR is approved"
- "Please merge this PR"
- "Approved, go ahead and merge"
- "LGTM, merge it"

**GitHub Status Check:**
Use `gh pr status [PR-number]` to verify:
- PR shows as "approved" in status
- All required checks are passing
- No blocking reviews or requests for changes

**Both Must Be Present:**
- Human approval alone is NOT sufficient
- GitHub approval alone is NOT sufficient
- Both are required for merge authorization
</approval_verification>

<examples>
<correct>
Human says "PR #1 is approved" AND gh pr status shows approved:
```bash
gh pr status 1
# Output shows: ✓ Approved by reviewers
# Safe to proceed with merge
```

Human says "Please merge the authentication PR" AND GitHub shows approval:
```bash
gh pr status 1
# Output shows: ✓ All checks passed, ✓ Approved
# Safe to proceed with merge
```
</correct>

<incorrect>
Only human approval:
```
Human: "This PR looks good, merge it"
# Missing: GitHub approval verification
# Action: Do NOT merge, check GitHub status first
```

Only GitHub approval:
```bash
gh pr status 1
# Output: ✓ Approved
# Missing: Explicit human approval statement
# Action: Do NOT merge, wait for human approval
```

Unclear human statement:
```
Human: "The code looks fine"
# Not explicit approval
# Action: Do NOT merge, ask for clear approval
```
</incorrect>
</examples>

<verification_commands>
Check PR status:
```bash
gh pr status [PR-number]
```

Check specific PR details:
```bash
gh pr view [PR-number]
```

List all PRs with status:
```bash
gh pr list --state open
```
</verification_commands>

<validation>
Before any PR merge, verify:
- [ ] Human has explicitly stated PR is approved
- [ ] GitHub status check shows PR as approved
- [ ] All required CI checks are passing
- [ ] No outstanding review requests or changes requested
- [ ] Both approval conditions are clearly satisfied
- [ ] PR number/identity is clear and unambiguous
</validation>

<failure_actions>
If verification fails:
- Missing human approval → Wait for explicit approval statement
- Missing GitHub approval → Do not merge, check what's blocking
- Unclear approval status → Ask for clarification
- Failed checks → Wait for checks to pass before merge consideration
</failure_actions>