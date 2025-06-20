---
applies_to:
  - file_patterns: []
  - contexts: ["gh", "github", "pr", "merge", "approval"]
  - actions: ["before_merging_pr"]
timing: "before"
summary: "Always verify both human approval and GitHub status before merging any PR"
version: "1.1.0"
---

# Rule: Always Verify Approval Before Merge

<purpose>
This rule ensures that pull requests are only merged when there is clear confirmation of approval from both the human user and GitHub's approval system, preventing accidental or unauthorized merges.
</purpose>

<instructions>
Before merging any pull request, you MUST verify BOTH conditions:

1. **Human Approval**: The human has explicitly stated the PR is approved
2. **GitHub Status**: GitHub shows the PR as approved in its system

**MANDATORY Verification steps:**
1. CHECK that human has clearly stated "approved" or "merge this PR"
2. **ALWAYS RUN** `gh pr view [PR-number]` to check GitHub approval status
3. **LOOK FOR** explicit approval indicators in the output (reviewers section showing "Approved")
4. **CONFIRM both approvals exist** before proceeding with merge
5. **REFUSE TO MERGE** if either condition is missing

**CRITICAL:** Running `gh pr view` is MANDATORY, not optional. You MUST see GitHub approval confirmation, not just human approval.
</instructions>

<approval_verification>
**Human Approval Indicators:**
- "This PR is approved"
- "Please merge this PR"
- "Approved, go ahead and merge"
- "LGTM, merge it"

**GitHub Status Check (MANDATORY):**
You MUST run `gh pr view [PR-number]` and verify:
- **Reviewers section shows "Approved"** (e.g., "dhughes (Approved)")
- All required checks are passing
- No blocking reviews or requests for changes
- No "Changes requested" status

**Both Must Be Present - NO EXCEPTIONS:**
- Human approval alone is NOT sufficient
- GitHub approval alone is NOT sufficient  
- Both are required for merge authorization
- **If you skip GitHub verification, you are violating this rule**
</approval_verification>

<examples>
<correct>
Human says "PR #1 is approved" AND gh pr view shows approved:
```bash
gh pr view 1
# Output shows: reviewers: dhughes (Approved)
# BOTH conditions met - safe to proceed with merge
```

Human says "Please merge the authentication PR" AND GitHub shows approval:
```bash
gh pr view 1
# Output shows: reviewers: alice (Approved), bob (Approved)
# BOTH conditions met - safe to proceed with merge
```
</correct>

<incorrect>
Only human approval (RULE VIOLATION):
```
Human: "This PR looks good, merge it"
# Missing: GitHub approval verification with gh pr view
# Action: REFUSE to merge, must run gh pr view first
# Violation: Skipped mandatory GitHub verification step
```

Human approval but no GitHub approval:
```bash
Human: "your PR is approved!"
gh pr view 3
# Output shows: reviewers: (no approvals listed)
# Action: Do NOT merge, GitHub shows no approval
# Required: Wait for actual GitHub approval
```

Only GitHub approval:
```bash
gh pr view 1
# Output shows: reviewers: alice (Approved)
# Missing: Explicit human approval statement
# Action: Do NOT merge, wait for human approval
```

Unclear human statement:
```
Human: "The code looks fine"
# Not explicit approval
# Action: Do NOT merge, ask for clear approval
```

**CRITICAL VIOLATION EXAMPLE:**
```bash
Human: "your PR is approved!"
# Claude merges without running gh pr view
# This is a VIOLATION - must always check GitHub status
```
</incorrect>
</examples>

<verification_commands>
Check specific PR details and approval status:
```bash
gh pr view [PR-number]
```

Check general PR status (no PR number argument):
```bash
gh pr status
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

**RULE VIOLATION CONSEQUENCES:**
If you merge without running `gh pr view` to verify GitHub approval:
1. You have VIOLATED this rule
2. Acknowledge the violation immediately
3. Explain what should have been done differently
4. Commit to following the rule correctly in the future
</failure_actions>

<enforcement>
**MANDATORY REQUIREMENTS:**
- Running `gh pr view [PR-number]` is NOT optional
- You MUST see "reviewers: [username] (Approved)" in the output
- Human approval alone is NEVER sufficient for merge
- This rule has NO EXCEPTIONS

**VIOLATION DETECTION:**
You have violated this rule if you:
- Merge a PR based only on human approval
- Skip running `gh pr view` before merge
- Merge when GitHub shows no approvals
- Ignore the reviewers section in `gh pr view` output

**COMPLIANCE CHECK:**
Before every merge, ask yourself:
- Did I run `gh pr view [PR-number]`?
- Did I see explicit approval in the reviewers section?
- Did I have both human AND GitHub approval?
</enforcement>