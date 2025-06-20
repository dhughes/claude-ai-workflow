---
applies_to:
  - file_patterns: []
  - contexts: ["gh", "github", "pr", "review", "workflow", "meta"]
  - actions: ["reviewing_pr", "before_reviewing_pr", "starting_pr_review"]
timing: "before"
summary: "MANDATORY: Execute complete GitHub API workflow - NEVER provide text summaries or bypass API commands"
version: "1.0.0"
---

# Rule: Always Execute Complete API Workflow

<purpose>
This meta-rule consolidates and enforces the complete GitHub API workflow for PR reviews, creating an unbreakable chain that prevents any bypassing of the mandatory technical review process through text summaries or shortcuts.
</purpose>

<absolute_workflow>
**🔒 UNBREAKABLE PR REVIEW WORKFLOW 🔒**

**EVERY PR review MUST follow this EXACT sequence - NO DEVIATIONS:**

```bash
# PHASE 1: AUTHENTICATION & ACCESS (MANDATORY)
gh auth switch claude-hughes
gh auth status  # Must show authenticated

# PHASE 2: PR DATA COLLECTION (MANDATORY)  
gh pr view {number} --json title,body,files,url,headRefName,baseRefName,state,isDraft
gh pr diff {number}

# PHASE 3: WORKFLOW COMMITMENT (MANDATORY)
echo "✓ Committed to GitHub API workflow - NO text summaries allowed"

# PHASE 4: TECHNICAL ANALYSIS (MANDATORY)
# Use Grep/Read tools to find issues
Grep pattern="security_pattern" include="*.js,*.py" 
Read file_path="identified/file.ext" offset=X limit=Y

# PHASE 5: GITHUB COMMENT POSTING (MANDATORY)
gh api repos/:owner/:repo/pulls/{number}/comments -X POST \
  -f body="**SEVERITY:** Issue description with examples" \
  -f commit_id="{verified_sha}" \
  -f path="{verified_path}" \
  -f side="RIGHT" \
  -F line={verified_line}

# PHASE 6: COMPLETION CONFIRMATION (MANDATORY)
echo "✓ Review complete - Posted X comments to GitHub PR"
```

**THIS SEQUENCE CANNOT BE MODIFIED, SHORTENED, OR BYPASSED**
</absolute_workflow>

<enforcement_checkpoints>
**MANDATORY CHECKPOINTS - Each must pass before continuing:**

**CHECKPOINT 1: Authentication**
- [ ] `gh auth status` executed and shows active authentication
- [ ] GitHub API access verified and functional

**CHECKPOINT 2: Data Collection**  
- [ ] `gh pr view` executed and PR details retrieved
- [ ] `gh pr diff` executed and file changes obtained
- [ ] Commit SHA extracted for comment targeting

**CHECKPOINT 3: Workflow Commitment**
- [ ] Explicit declaration of API-only workflow made
- [ ] Text summary approach explicitly rejected
- [ ] GitHub comment posting commitment confirmed

**CHECKPOINT 4: Technical Analysis**
- [ ] Search tools used to identify specific issues
- [ ] Content verification performed using Read tool
- [ ] Line numbers and context validated

**CHECKPOINT 5: Comment Posting**
- [ ] All findings posted using `gh api` commands
- [ ] Line-specific comments with severity indicators
- [ ] NO text summaries or lists provided to user

**CHECKPOINT 6: Completion**
- [ ] Confirmation of comment posting provided
- [ ] NO additional text-based feedback given
- [ ] Process completed within GitHub ecosystem

**FAILURE AT ANY CHECKPOINT BLOCKS ENTIRE REVIEW**
</enforcement_checkpoints>

<violation_detection>
**IMMEDIATE RED FLAGS that indicate violations:**

🚨 **"Here's my review of the PR..."**
🚨 **"I found these issues: 1. ..., 2. ..., 3. ..."** 
🚨 **"The PR looks good/bad but..."**
🚨 **Listing problems without `gh api` commands**
🚨 **Providing feedback without posting GitHub comments**
🚨 **Skipping authentication or data collection steps**
🚨 **Making review statements without using search tools**

**IF ANY OF THESE OCCUR - IMMEDIATE VIOLATION RESPONSE REQUIRED**
</violation_detection>

<violation_response>
**WHEN VIOLATION IS DETECTED:**

1. **IMMEDIATE STOP** - Halt all text-based feedback
2. **VIOLATION ACKNOWLEDGMENT** - "I violated the GitHub API workflow rule"
3. **RESTART WORKFLOW** - Begin again with Phase 1 authentication
4. **COMPLETE PROPER PROCESS** - Execute all phases correctly
5. **NO SHORTCUTS** - Cannot skip steps due to previous violation

**EXAMPLE VIOLATION RECOVERY:**
```
I need to restart this review properly using the GitHub API workflow.

[Executes: gh auth status]
[Executes: gh pr view {number}] 
[Executes: gh pr diff {number}]
[Declares: "Committed to API workflow"]
[Uses search tools to find issues]
[Posts actual GitHub comments]
[Confirms: "Posted X comments to GitHub PR"]
```
</violation_response>

<integration_hierarchy>
**THIS RULE SUPERSEDES AND INTEGRATES:**

1. **`gh-pr-review-never-provide-text-summary-instead-of-api-comments.rule.md`**
   - Provides the enforcement mechanism

2. **`gh-pr-review-always-enforce-mandatory-api-workflow.rule.md`** 
   - Implements the verification checkpoints

3. **`gh-pr-review-always-fetch-pr-details-first.rule.md`**
   - Defines Phase 2 requirements

4. **`gh-pr-review-always-use-accurate-line-specific-comments.rule.md`**
   - Defines Phase 4-5 requirements

5. **All other PR review rules**
   - Must operate within this workflow framework

**EXECUTION PRIORITY: HIGHEST - Cannot be overridden by other rules**
</integration_hierarchy>

<success_metrics>
**PR REVIEW CONSIDERED SUCCESSFUL ONLY WHEN:**

✅ All 6 phases executed in correct sequence
✅ All checkpoints passed without violations
✅ GitHub comments posted for all identified issues
✅ NO text summaries or lists provided to user
✅ Complete workflow executed within GitHub ecosystem
✅ User sees review feedback ONLY through GitHub interface

**PARTIAL COMPLETION IS NOT ACCEPTABLE**
</success_metrics>

<failure_modes>
**UNACCEPTABLE OUTCOMES THAT TRIGGER RE-EXECUTION:**

❌ **Hybrid approach** - Some API commands + some text feedback
❌ **Incomplete workflow** - Skipping any phases or checkpoints  
❌ **Shortcut attempts** - Bypassing search/verification steps
❌ **Text fallback** - Reverting to summaries when API gets complex
❌ **Assumption-based review** - Commenting without content verification
❌ **Generic feedback** - Comments not tied to specific code lines

**ANY OF THESE REQUIRES COMPLETE WORKFLOW RESTART**
</failure_modes>

<emergency_protocols>
**ONLY acceptable deviations (must be documented):**

1. **GitHub service completely down** (verify with status.github.com)
2. **Authentication permanently broken** (after exhaustive debugging)  
3. **Repository access revoked** (confirmed with repository owner)

**EVEN IN EMERGENCIES:**
- Must attempt GitHub API first
- Must document specific technical failure
- Must commit to retry when service restored
- Cannot default to text summaries without explicit user acknowledgment

**NO OTHER EXCEPTIONS PERMITTED**
</emergency_protocols>

<validation>
**Complete API workflow validation checklist:**
- [ ] Phase 1: Authentication verified and functional
- [ ] Phase 2: PR data collected via API commands
- [ ] Phase 3: Workflow commitment explicitly declared  
- [ ] Phase 4: Issues identified via search tools
- [ ] Phase 5: Findings posted as GitHub comments
- [ ] Phase 6: Completion confirmed without text summaries
- [ ] NO violations or shortcuts detected
- [ ] User receives feedback through GitHub interface only
</validation>