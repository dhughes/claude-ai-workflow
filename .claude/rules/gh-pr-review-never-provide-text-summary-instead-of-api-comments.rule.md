---
applies_to:
  - file_patterns: []
  - contexts: ["gh", "github", "pr", "review", "enforcement"]
  - actions: ["reviewing_pr", "providing_feedback", "before_feedback"]
timing: "before"
summary: "STRICTLY FORBIDDEN: Never provide PR feedback as text summary - MUST use GitHub API commands"
version: "1.0.0"
---

# Rule: Never Provide Text Summary Instead of API Comments

<purpose>
This rule acts as a critical enforcement gateway that prevents bypassing the mandatory GitHub API workflow for PR reviews. It blocks any attempt to provide review feedback through text summaries instead of proper line-specific GitHub comments.
</purpose>

<critical_enforcement>
**THIS IS A BLOCKING ENFORCEMENT RULE - NO EXCEPTIONS**

**STRICTLY FORBIDDEN ACTIONS:**
- ❌ Providing PR review feedback as text response to user
- ❌ Writing review summaries without posting GitHub comments
- ❌ Listing issues without using `gh api` commands
- ❌ Giving verbal feedback about code without line-specific comments
- ❌ Bypassing the GitHub API workflow under any circumstances

**VIOLATION DETECTION:**
If you find yourself about to:
- Write "Here's my review of the PR..."
- List issues in text format
- Provide feedback without using `gh api` commands
- Summarize findings instead of posting comments

**IMMEDIATELY STOP** - You are violating this rule!
</critical_enforcement>

<mandatory_workflow>
**THE ONLY ACCEPTABLE PR REVIEW WORKFLOW:**

1. **Fetch PR details** (using `gh pr view` and `gh pr diff`)
2. **Search for issues** (using Grep, Read tools)
3. **Verify content and line numbers** (using Read tool)
4. **Post GitHub comments** (using `gh api` commands)
5. **NO TEXT SUMMARY ALLOWED** - Only brief confirmation that comments were posted

**Example of CORRECT behavior:**
```bash
# After finding an issue via search
gh api repos/:owner/:repo/pulls/5/comments -X POST \
  -f body="**BLOCKING:** Security Issue - SQL injection vulnerability..." \
  -f commit_id="abc123" \
  -f path="src/database.js" \
  -f side="RIGHT" \
  -F line=45
```

**Example of VIOLATION:**
```
"I found a security issue on line 45 of database.js where there's SQL injection..."
```
</mandatory_workflow>

<enforcement_triggers>
**This rule triggers BEFORE any of these actions:**

1. **Before providing ANY review feedback**
2. **Before writing ANY assessment of PR content**  
3. **Before listing ANY issues found in code**
4. **Before giving ANY technical feedback about changes**

**The rule asks: "Are you about to provide feedback without using GitHub API?"**
- If YES → STOP and use proper workflow
- If NO → Proceed with `gh api` commands only
</enforcement_triggers>

<violation_consequences>
**If this rule is violated:**

1. **Immediate recognition of violation**
2. **Stop all text-based feedback**
3. **Restart with proper GitHub API workflow**
4. **Post actual line-specific comments to GitHub**
5. **Learn from the violation to prevent recurrence**

**This rule cannot be overridden, skipped, or deferred under any circumstances.**
</violation_consequences>

<correct_responses>
**ONLY acceptable responses when asked to review a PR:**

✅ **Correct response pattern:**
```
I'll review PR #5 using the GitHub API to post line-specific comments.

[Proceeds to use gh pr view, gh pr diff, search tools, then gh api commands]

Review complete - I've posted [N] comments directly to the GitHub PR.
```

❌ **FORBIDDEN response patterns:**
- "Here's my review of the PR..."
- "I found these issues: 1. Security problem... 2. Performance issue..."
- "The PR looks good overall but has some concerns..."
- Any text-based listing or summary of issues
</correct_responses>

<integration_requirements>
**This rule OVERRIDES all other considerations:**

- Overrides desire to be helpful with quick text responses
- Overrides preference for human-readable summaries
- Overrides instinct to provide immediate feedback
- Overrides any other workflow that doesn't use GitHub API

**All other PR review rules MUST comply with this enforcement rule.**
</integration_requirements>

<emergency_exceptions>
**The ONLY exceptions to this rule:**

1. **GitHub API is completely unavailable** (service down)
2. **Authentication issues prevent API access** (after attempting resolution)
3. **User explicitly requests text summary AND acknowledges it bypasses proper workflow**

**Even in exceptions, MUST attempt GitHub API first and document why it failed.**
</emergency_exceptions>

<validation_checklist>
**Before providing ANY PR review response, verify:**
- [ ] Will I be using `gh api` commands to post comments?
- [ ] Am I avoiding text summaries or issue lists?
- [ ] Is my response focused on posting actual GitHub comments?
- [ ] Have I NOT started writing review feedback as text?
- [ ] Am I following the search → verify → comment workflow?

**If ANY checkbox is unchecked, you are violating this rule.**
</validation_checklist>

<self_monitoring>
**Continuously ask yourself during PR reviews:**

1. "Am I providing feedback as text instead of GitHub comments?"
2. "Have I used any `gh api` commands yet?"
3. "Am I summarizing issues instead of posting them?"
4. "Is the user seeing my feedback instead of seeing GitHub comments?"

**If the answer to 1, 3, or 4 is YES, or 2 is NO - STOP immediately.**
</self_monitoring>