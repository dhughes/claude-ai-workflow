---
applies_to:
  - file_patterns: []
  - contexts: ["gh", "github", "pr", "merge", "safety"]
  - actions: ["considering_pr_merge"]
timing: "before"
summary: "Never merge PRs without explicit clear approval - stop and ask when approval is unclear"
version: "1.0.0"
---

# Rule: Never Merge Without Clear Approval

<purpose>
This rule provides a safety mechanism to prevent unauthorized or accidental PR merges by requiring explicit, unambiguous approval before any merge operation, and mandating clarification requests when approval status is unclear.
</purpose>

<instructions>
When considering merging any pull request, you MUST:

1. NEVER merge if approval is unclear, ambiguous, or missing
2. STOP immediately if approval status is uncertain
3. ASK for explicit clarification when approval is not clear
4. WAIT for unambiguous approval before proceeding
5. REQUIRE both human approval and GitHub approval to be crystal clear

If there is ANY doubt about approval status, do NOT merge.
</instructions>

<clear_approval_criteria>
**Clear Approval Requires:**
- Explicit human statement of approval
- Unambiguous language from the user
- GitHub system showing approved status
- No outstanding review comments or change requests
- Clear identification of which PR to merge

**Examples of Clear Approval:**
- "This PR is approved, please merge it"
- "PR #1 looks good, go ahead and merge"
- "Approved! Please squash and merge"
- "LGTM, merge this PR"
</clear_approval_criteria>

<unclear_approval_scenarios>
**NEVER merge when approval is:**
- Implicit or assumed
- Vague or non-specific
- Missing human confirmation
- Missing GitHub approval
- Ambiguous about which PR
- Conditional ("merge if X")
- Outdated or withdrawn

**Examples requiring clarification:**
- "The code looks good" (not explicit approval)
- "Seems fine to me" (vague, not clear approval)  
- "You can merge it" (implicit, not explicit)
- "Merge when ready" (conditional, unclear timing)
- "Approved" without PR identification
</unclear_approval_scenarios>

<examples>
<correct>
Clear approval scenario:
```
Human: "PR #1 is approved and GitHub shows it's ready. Please merge it."
GitHub Status: ✓ Approved, ✓ All checks passed
Action: Safe to merge PR #1
```

Requesting clarification for unclear approval:
```
Human: "That looks fine"
Action: "Could you please explicitly approve the PR for merging? I need clear confirmation that you want me to merge this pull request."
```
</correct>

<incorrect>
Merging with unclear approval:
```
Human: "The code seems okay"
Action: Merging anyway
# Wrong - not explicit approval
```

Assuming approval:
```
Human: "Good work on the PR"
Action: Interpreting as approval and merging
# Wrong - not explicit merge authorization
```

Merging without GitHub approval:
```
Human: "Please merge PR #1"
GitHub Status: ⚠ Pending reviews
Action: Merging anyway
# Wrong - GitHub approval missing
```
</incorrect>
</examples>

<clarification_requests>
When approval is unclear, use these clarification patterns:

**For vague statements:**
"I need explicit approval to merge this PR. Could you please confirm that you want me to merge [PR identification]?"

**For missing PR identification:**
"You mentioned approval, but could you specify which PR you'd like me to merge? Please provide the PR number or clear identification."

**For conditional approval:**
"You mentioned merging 'when ready' - could you confirm that the PR is ready now and should be merged?"

**For GitHub status issues:**
"You've approved the PR, but GitHub shows [status issue]. Should I wait for GitHub approval or is there something that needs to be resolved first?"
</clarification_requests>

<safety_checks>
Before any merge, verify:
- [ ] Human has used explicit approval language
- [ ] PR to merge is clearly identified
- [ ] GitHub shows approved status
- [ ] No ambiguity in the approval statement
- [ ] No outstanding conditions or requirements
- [ ] Approval is current (not outdated)
- [ ] No conflicting signals about merge readiness
</safety_checks>

<enforcement>
This rule is STRICTLY ENFORCED:
- NO exceptions for "obvious" approval
- NO interpreting implied consent as approval
- NO merging based on positive comments alone
- NO assuming approval from code review feedback
- ALWAYS require explicit merge authorization
- ALWAYS clarify when there's any doubt
</enforcement>

<escalation>
When in doubt:
1. STOP the merge process immediately
2. ASK for specific clarification
3. WAIT for unambiguous response
4. DO NOT proceed until approval is crystal clear
5. DOCUMENT the clarification if needed
</escalation>