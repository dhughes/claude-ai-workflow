---
applies_to:
  - file_patterns: []
  - contexts: ["gh", "github", "pr", "merge", "clarification"]
  - actions: ["handling_ambiguous_merge_request"]
timing: "before"
summary: "Always ask for clarification when merge requests are ambiguous about which PR to merge"
version: "1.0.0"
---

# Rule: Always Request Clarification for Ambiguous Merge Requests

<purpose>
This rule ensures that when users make merge requests that are unclear about which specific pull request should be merged, clarification is always requested to prevent merging the wrong PR or making incorrect assumptions.
</purpose>

<instructions>
When a user requests a PR merge but the request is ambiguous about which PR to merge, you MUST:

1. STOP and do NOT attempt to guess which PR they mean
2. ASK for specific clarification about which PR to merge
3. REQUEST clear PR identification (number, title, or branch name)
4. WAIT for unambiguous identification before proceeding
5. NEVER assume or merge based on incomplete information

Ambiguous scenarios requiring clarification:
- Multiple open PRs exist
- User says "merge the PR" without specifying which one
- User references PR by vague description
- PR identification is unclear or could match multiple PRs
</instructions>

<ambiguous_request_examples>
**Requires clarification:**
- "Please merge the PR" (when multiple PRs exist)
- "Merge the authentication PR" (if multiple auth-related PRs exist)
- "Go ahead and merge it" (unclear which "it")
- "The PR looks good, merge it" (which PR?)
- "Merge the one we discussed" (unclear reference)
- "Please merge my changes" (which changes/PR?)

**Clear requests (no clarification needed):**
- "Please merge PR #1"
- "Merge the GitHub CLI workflow rules PR"
- "Please merge the PR titled 'Add authentication system'"
- "Merge the PR from branch feature/user-login"
</ambiguous_request_examples>

<clarification_patterns>
Use these response patterns for different ambiguous scenarios:

**Multiple PRs exist:**
"I see there are [number] open pull requests. Could you please specify which PR you'd like me to merge? You can reference it by PR number (#1, #2, etc.), title, or branch name."

**Vague description:**
"You mentioned merging '[description]' but I want to make sure I merge the correct PR. Could you please provide the specific PR number or full title?"

**Unclear pronoun reference:**
"When you said 'merge it,' could you clarify which specific PR you're referring to? Please provide the PR number or title."

**No PR identification:**
"You've asked me to merge a PR, but I need to know which specific pull request to merge. Could you provide the PR number, title, or branch name?"
</clarification_patterns>

<identification_methods>
Request clarification using any of these identification methods:

**PR Number:** "Please provide the PR number (e.g., #1, #2)"
**PR Title:** "Please provide the exact PR title"
**Branch Name:** "Please specify the source branch name"
**PR URL:** "You can also provide the GitHub PR URL"

Accept any clear identification method that unambiguously identifies the PR.
</identification_methods>

<examples>
<correct>
Multiple PRs scenario:
```
Human: "Please merge the PR"
Claude: "I see there are 3 open pull requests (#1: GitHub CLI rules, #2: Authentication system, #3: Bug fixes). Could you please specify which PR you'd like me to merge by providing the PR number or title?"
```

Vague description:
```
Human: "Merge the rules PR"
Claude: "I want to make sure I merge the correct PR. Could you specify which rules-related PR you mean? Please provide the PR number or exact title."
```

Ambiguous pronoun:
```
Human: "That looks good, merge it"
Claude: "Could you clarify which specific PR you'd like me to merge? Please provide the PR number, title, or branch name to ensure I merge the correct one."
```
</correct>

<incorrect>
Guessing which PR:
```
Human: "Please merge the PR"
Claude: "I'll merge PR #1 since it seems most recent"
# Wrong - should ask for clarification
```

Making assumptions:
```
Human: "Merge the feature PR"
Claude: "I assume you mean the authentication feature, merging PR #2"
# Wrong - should request specific identification
```

Proceeding with unclear reference:
```
Human: "That one looks good, merge it"
Claude: Merging without asking which "that one"
# Wrong - should clarify the reference
```
</incorrect>
</examples>

<validation>
Before proceeding with any merge, verify:
- [ ] PR to merge is unambiguously identified
- [ ] No assumptions were made about which PR
- [ ] If request was ambiguous, clarification was requested
- [ ] User has provided specific PR identification
- [ ] Only one PR matches the provided identification
- [ ] No confusion about which PR to merge
</validation>

<prevention_strategies>
To minimize ambiguous requests:
- List open PRs when appropriate: "Current open PRs are: #1 (title), #2 (title)"
- Reference PRs by number in communications
- Confirm PR identity before proceeding: "Understood, you want me to merge PR #1 (title)"
- Use clear language in responses about PR actions
</prevention_strategies>

<escalation>
If clarification doesn't resolve ambiguity:
1. List all open PRs with numbers and titles
2. Ask user to choose by number from the list
3. Confirm the selection before proceeding
4. Do not merge until identification is crystal clear
</escalation>