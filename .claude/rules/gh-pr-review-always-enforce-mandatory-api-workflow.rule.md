---
applies_to:
  - file_patterns: []
  - contexts: ["gh", "github", "pr", "review", "workflow", "enforcement"]
  - actions: ["before_reviewing_pr", "starting_pr_review"]
timing: "before"
summary: "MANDATORY: Verify and enforce GitHub API workflow before any PR review begins"
version: "1.0.0"
---

# Rule: Always Enforce Mandatory API Workflow

<purpose>
This rule creates a mandatory checkpoint that verifies proper GitHub API workflow setup before any PR review activities begin, preventing bypasses of the required technical review process.
</purpose>

<mandatory_checkpoint>
**🚨 MANDATORY EXECUTION CHECKPOINT 🚨**

**BEFORE starting ANY PR review, you MUST execute this verification sequence:**

```bash
# STEP 1: Verify GitHub authentication (MANDATORY)
gh auth status

# STEP 2: Fetch PR details (MANDATORY) 
gh pr view {number} --json title,body,files,url,headRefName,baseRefName,state

# STEP 3: Get diff for analysis (MANDATORY)
gh pr diff {number}

# STEP 4: Declare workflow intention (MANDATORY)
echo "Starting PR review using GitHub API workflow - NO text summaries allowed"
```

**THIS SEQUENCE IS NON-NEGOTIABLE AND HAS NO EXCEPTIONS**
</mandatory_checkpoint>

<workflow_verification>
**After initial setup, verify workflow readiness:**

1. **Confirm API access**: `gh auth status` shows active authentication
2. **Confirm PR access**: PR details retrieved successfully  
3. **Confirm diff access**: PR diff shows file changes
4. **Confirm commitment**: Explicit acknowledgment of API-only workflow

**If ANY step fails, STOP and resolve before proceeding.**

**Success criteria:**
- GitHub CLI authenticated and functional
- PR data successfully retrieved
- Diff data available for analysis
- Clear intention to use API workflow declared
</workflow_verification>

<enforcement_algorithm>
```
WHEN user_requests_pr_review:
    IF NOT github_auth_verified:
        EXECUTE "gh auth status"
        IF auth_failed:
            STOP "Must authenticate with GitHub first"
            
    IF NOT pr_details_fetched:
        EXECUTE "gh pr view {number} --json ..."
        IF fetch_failed:
            STOP "Cannot access PR details"
            
    IF NOT diff_retrieved:
        EXECUTE "gh pr diff {number}"
        IF diff_failed:
            STOP "Cannot access PR changes"
            
    IF NOT workflow_declared:
        PRINT "Committing to GitHub API workflow - no text summaries"
        
    # Only now proceed with search and comment workflow
    PROCEED to search for issues using Grep/Read tools
    PROCEED to post findings using gh api commands
    NEVER provide text summaries or lists
```
</enforcement_algorithm>

<violation_prevention>
**This rule prevents these common violations:**

❌ **Starting review without authentication check**
❌ **Proceeding without fetching PR details**
❌ **Attempting review without accessing diff**
❌ **Beginning analysis without workflow commitment**
❌ **Defaulting to text responses instead of API commands**

✅ **Enforces correct sequence:**
1. Verify GitHub access
2. Fetch PR data
3. Commit to API workflow
4. Search for issues
5. Post GitHub comments
6. Confirm completion
</violation_prevention>

<checkpoint_outputs>
**Expected outputs from mandatory checkpoint:**

```bash
# Authentication verification
✓ github.com: Logged in to github.com as claude-hughes

# PR details retrieval  
✓ Retrieved PR #5: "Add comprehensive AI-focused PR review rules"
✓ Files: 15 changed files with 3,850 additions

# Diff access confirmation
✓ Retrieved diff showing 3,850 line changes across rule files

# Workflow commitment
✓ Committed to GitHub API workflow - will post line-specific comments only
```

**If any step shows ❌ or fails, the review CANNOT proceed.**
</checkpoint_outputs>

<integration_with_other_rules>
**This rule enables and enforces:**

1. **`gh-pr-review-never-provide-text-summary-instead-of-api-comments.rule.md`**
   - Provides the pre-check that prevents text summary violations
   
2. **`gh-pr-review-always-fetch-pr-details-first.rule.md`**
   - Ensures this rule's requirements are met first
   
3. **`gh-pr-review-always-use-accurate-line-specific-comments.rule.md`**
   - Prepares the foundation for proper comment posting
   
4. **All other PR review rules**
   - Creates the prerequisite conditions for their execution

**Execution order:**
1. THIS RULE (verify workflow setup)
2. Fetch PR details rule
3. Pattern analysis rules  
4. Technical review rules
5. Comment posting rules
</integration_with_other_rules>

<failure_recovery>
**If checkpoint fails:**

**Authentication Failure:**
```bash
# Resolve authentication
gh auth login
gh auth refresh
# Retry checkpoint
```

**PR Access Failure:**
```bash
# Verify PR exists and number is correct
gh pr list
# Check repository access
gh repo view
# Retry with correct PR number
```

**Diff Access Failure:**
```bash
# Check PR state
gh pr view {number} --json state,mergeable
# Verify PR has changes
gh pr view {number} --json files
# Retry diff retrieval
```

**Must resolve ALL failures before proceeding with review.**
</failure_recovery>

<success_confirmation>
**Checkpoint successful when you can answer YES to all:**

- [ ] GitHub authentication verified and working
- [ ] PR details successfully retrieved and stored
- [ ] PR diff successfully retrieved and available
- [ ] Explicit commitment made to GitHub API workflow
- [ ] Ready to search for issues using tools
- [ ] Ready to post findings using `gh api` commands
- [ ] NO intention to provide text summaries

**Only proceed with review when ALL criteria are met.**
</success_confirmation>

<validation>
**Mandatory workflow enforcement complete when:**
- [ ] `gh auth status` executed and confirmed working
- [ ] `gh pr view` executed and PR details retrieved
- [ ] `gh pr diff` executed and changes available
- [ ] Workflow commitment explicitly declared
- [ ] No text summary patterns detected in planning
- [ ] Ready to proceed with search → verify → comment workflow
- [ ] Clear path established for GitHub API comment posting
</validation>