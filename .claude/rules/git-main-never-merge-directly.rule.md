---
applies_to:
  - file_patterns: []
  - contexts: ["git", "main", "merge", "workflow"]
  - actions: ["before_merge"]
timing: "before"
summary: "STRICTLY FORBIDDEN: Never merge directly to main branch - main can only be updated via PR merges"
version: "1.1.0"
---

# Rule: Never Merge Directly to Main Branch

<purpose>
This rule strictly prohibits any direct merge operations to the main branch, enforcing that main can ONLY be updated through the proper pull request merge workflow via GitHub, ensuring all changes go through code review and approval processes.
</purpose>

<instructions>
You are ABSOLUTELY FORBIDDEN from performing direct merges to main branch:

1. **NEVER run `git merge` while on main branch**
2. **NEVER merge branches directly into main using git commands**
3. **NEVER perform any direct merge operations that target main**
4. **Main branch MUST only receive updates through approved PR merges via GitHub**

🚨 **ZERO TOLERANCE POLICY** - This rule has NO EXCEPTIONS WHATSOEVER for direct merges

**When this rule applies, simply REFUSE and STOP:**
- Do NOT research alternatives
- Do NOT offer to create PRs
- Do NOT check branch status
- Do NOT analyze commits
- Simply state: "I cannot merge directly to main branch. Main can only be updated via GitHub PR merges."
</instructions>

<forbidden_merge_actions>
**ABSOLUTELY FORBIDDEN:**
```bash
# Being on main and merging other branches
git checkout main
git merge feature/some-branch  # ❌ FORBIDDEN

# Any form of direct merge to main
git merge --no-ff feature/branch  # ❌ FORBIDDEN (while on main)
git merge --squash feature/branch  # ❌ FORBIDDEN (while on main)

# Fast-forward merges to main
git merge feature/hotfix  # ❌ FORBIDDEN (while on main)
```

**REQUIRED WORKFLOW:**
```bash
# Correct workflow - use GitHub PR merges only
gh pr merge [PR-number] --squash  # ✅ GitHub PR merge
# OR through GitHub web interface
# Main is updated automatically by GitHub after PR merge
```
</forbidden_merge_actions>

<enforcement>
**STRICT ENFORCEMENT:**
- NO exceptions for "hotfixes"
- NO exceptions for "urgent changes" 
- NO exceptions for "small updates"
- NO exceptions for "emergency fixes"
- NO exceptions for configuration changes
- NO exceptions for documentation updates
- NO exceptions for ANY reason whatsoever

**VIOLATION CONSEQUENCES:**
If you attempt to merge directly to main:
1. STOP immediately
2. State: "I cannot merge directly to main branch. Main can only be updated via GitHub PR merges."
3. Do NOT provide additional help or alternatives
4. Do NOT research the situation further
5. Simply refuse and end the interaction
</enforcement>

<response_template>
When a direct merge to main is requested, use this EXACT response:

"I cannot merge directly to main branch. Main can only be updated via GitHub PR merges."

**Do NOT add:**
- Explanations of why
- Offers to help create PRs
- Branch analysis or commit checking
- Alternative suggestions
- Research into current state

**Just refuse and stop.**
</response_template>

<prevention_checks>
Before ANY merge operation, verify:
- [ ] Current branch is NOT main (`git branch --show-current`)
- [ ] Not attempting to merge anything into main
- [ ] Using GitHub PR merge workflow instead
- [ ] Following proper code review process
</prevention_checks>

<examples>
<correct>
When user requests direct merge to main:
```
User: "Merge the current branch to main"
Claude: "I cannot merge directly to main branch. Main can only be updated via GitHub PR merges."
# STOP - no additional help offered
```

Proper update workflow for main (when appropriate):
```bash
# Work is done on feature branch
git checkout feature/auth-system
git commit -m "Add authentication"
git push -u origin feature/auth-system

# Create PR and get approval
gh pr create --title "Add authentication system"
# Wait for approval...

# Merge via GitHub PR (only way to update main)
gh pr merge 1 --squash
```
</correct>

<incorrect>
Being too helpful after refusing:
```
User: "Merge the current branch to main"
Claude: "I cannot merge directly to main branch. According to the rules..."
# ❌ WRONG - provides long explanation
# ❌ WRONG - checks branch status
# ❌ WRONG - offers to create PR
# ❌ WRONG - analyzes commits
```

Direct merge operations:
```bash
git checkout main
git merge feature/new-api  # ❌ VIOLATION - direct merge to main
git merge --ff-only hotfix/bug  # ❌ VIOLATION - still direct merge
git merge --squash feature/ui  # ❌ VIOLATION - direct merge operation
```
</incorrect>
</examples>

<violation_detection>
**Red flags that indicate violations:**
- `git branch --show-current` shows "main" before merge command
- Any `git merge` command executed while on main branch
- Attempting to merge branches directly into main
- Bypassing PR workflow for "urgent" changes

**Immediate actions upon detection:**
1. ABORT the merge operation immediately
2. Return to feature branch workflow
3. Create proper PR for the changes
4. Never complete the forbidden merge
</violation_detection>

<proper_workflow>
**Only acceptable way to update main:**

1. **Work on feature branch**: Make changes on dedicated branch
2. **Push feature branch**: `git push -u origin feature/branch-name`
3. **Create PR**: `gh pr create` with proper description
4. **Get approval**: Wait for human and GitHub approval
5. **Merge via GitHub**: `gh pr merge [PR-number] --squash`
6. **Main updated automatically**: GitHub handles the main branch update

**Key principle:** Main branch is READ-ONLY for direct operations
</proper_workflow>

<emergency_procedures>
Even in critical emergencies:
- NO direct merges to main
- CREATE hotfix branch immediately
- PUSH to hotfix branch
- CREATE emergency PR with "URGENT" label
- GET expedited approval if available
- MERGE via GitHub PR process
- NEVER bypass the PR workflow

Emergency example:
```bash
git checkout -b hotfix/security-critical
git commit -m "Fix critical vulnerability"
git push -u origin hotfix/security-critical
gh pr create --title "URGENT: Critical security fix"
# Get emergency approval...
gh pr merge [PR-number] --squash
```
</emergency_procedures>

<integration_with_existing_rules>
This rule works with:
- `git-main-never-commit-directly.rule.md` - Prevents commits
- `git-main-never-push-directly.rule.md` - Prevents pushes  
- `gh-pr-always-verify-approval-before-merge.rule.md` - Ensures proper PR merges
- `gh-pr-always-use-squash-merge.rule.md` - Enforces squash merge for PRs

**Complete main branch protection:**
- No direct commits (existing rule)
- No direct pushes (existing rule)
- No direct merges (this rule)
- Only PR merges allowed (GitHub workflow)
</integration_with_existing_rules>

<validation>
Before any operation that might affect main, verify:
- [ ] Not attempting direct merge to main
- [ ] Using proper PR workflow instead
- [ ] Main branch remains protected from direct modifications
- [ ] All changes go through code review process
- [ ] Following GitHub PR merge procedures
</validation>