---
applies_to:
  - file_patterns: []
  - contexts: ["workflow", "planning", "git"]
  - actions: ["creating_plan_with_file_operations"]
timing: "before"
summary: "Always include explicit git workflow steps in plans that involve file operations"
version: "1.0.0"
---

# Rule: Always Include Git Steps in Plan

<purpose>
This rule ensures that any plan involving file creation or modification explicitly includes git branching, committing, and pushing steps, making the git workflow visible and reviewable during the plan approval phase to prevent violations of git workflow rules.
</purpose>

<instructions>
When creating a plan that involves ANY file operations (create, edit, delete), you MUST:

1. **Include Git Branching Step**: Explicitly state that you will create a branch before file operations
2. **Name the Branch**: Include the specific branch name following naming conventions
3. **List File Operations**: Clearly enumerate what files will be created/modified
4. **Include Commit Step**: State that changes will be committed with a descriptive message
5. **Include Push Step**: Mention pushing the branch to remote
6. **Order Correctly**: Ensure git steps are in the right sequence

The plan MUST make these git operations explicit and visible for user review.
</instructions>

<plan_structure>
**Required structure for plans with file operations:**

```
## Plan: [Description]

### 1. Git Setup
- Check current branch
- Create branch: `[category]/[descriptive-name]`
- Switch to new branch

### 2. File Operations
- Create/Edit: [list specific files]
- [Detailed file operation steps]

### 3. Git Finalization  
- Stage all changes
- Commit with message: "[descriptive commit message]"
- Push branch to remote
- [Optional: Create PR]

### 4. [Other non-file steps if applicable]
```
</plan_structure>

<required_elements>
**Every plan with file operations MUST include:**

1. **Branch Creation**:
   - Explicit `git checkout -b [branch-name]` command
   - Branch name following conventions (feature/, fix/, docs/, etc.)
   - Statement that this happens BEFORE file operations

2. **File Operation List**:
   - Specific files to be created/modified
   - Clear separation between git setup and file operations

3. **Commit Information**:
   - Statement that changes will be committed
   - Draft commit message or description
   - Mention of --author flag for attribution

4. **Push Statement**:
   - Explicit mention of pushing to remote
   - Setting upstream if new branch
</required_elements>

<examples>
<correct>
Plan with proper git workflow:
```
## Plan: Add PR Review Rules

### 1. Git Setup
- Check current branch with `git branch --show-current`
- Create branch: `git checkout -b rules/pr-review-workflow`
- Confirm on new branch before proceeding

### 2. Create Rule Files
- Create 12 rule files in .claude/rules/:
  - gh-pr-review-always-fetch-pr-details-first.rule.md
  - gh-pr-review-always-check-against-project-patterns.rule.md
  - [... list all files ...]

### 3. Git Finalization
- Stage all new rule files: `git add .claude/rules/gh-pr-review-*.rule.md`
- Commit with message: "Add comprehensive AI-focused PR review rules"
- Push branch: `git push -u origin rules/pr-review-workflow`
- Create PR for review
```
</correct>

<incorrect>
Plan missing git steps:
```
## Plan: Add PR Review Rules

I'll create 12 rule files for PR reviews:
- Rule 1: Fetch PR details
- Rule 2: Check patterns
[... rest of plan without git operations ...]
```

Plan with git steps out of order:
```
## Plan: Add Features

1. Create new feature files
2. Test the features
3. Create a branch  // ❌ WRONG - branch must come first
4. Commit changes
```
</incorrect>
</examples>

<integration_checks>
**Before presenting any plan, verify:**

1. **Does plan involve file operations?**
   - Creating new files → YES, need git steps
   - Editing existing files → YES, need git steps  
   - Only reading/analyzing → NO, git steps not required
   - Only running commands → NO, git steps not required

2. **Are git steps complete?**
   - [ ] Branch creation listed FIRST
   - [ ] Branch name provided and follows conventions
   - [ ] File operations listed AFTER branch creation
   - [ ] Commit step included
   - [ ] Push step included

3. **Is sequence correct?**
   - Branch → Files → Commit → Push
   - No file operations before branching
   - No commits on main branch
</integration_checks>

<enforcement>
**This rule is enforced by:**

1. **Making violations visible**: Users see if git steps are missing during plan review
2. **Enabling user intervention**: Users can reject plans missing git workflow
3. **Creating accountability**: Plans document intended git operations
4. **Preventing surprise violations**: No hidden file operations without git workflow

**If you present a plan with file operations but no git steps:**
- User should reject the plan
- You must revise to include proper git workflow
- This prevents downstream rule violations
</enforcement>

<special_cases>
**Git steps NOT required when:**
- Plan only involves reading files
- Plan only runs non-modifying commands
- User explicitly requests working on main
- User has pre-selected a specific branch
- Plan is for investigation/analysis only

**Git steps ALWAYS required when:**
- Creating new files (any type)
- Editing existing files
- Deleting files
- Moving or renaming files
- Any operation that changes repository state
</special_cases>

<validation>
**Plan is complete when it includes:**
- [ ] Explicit branch creation before file operations
- [ ] Specific branch name following conventions
- [ ] Clear list of files to be created/modified
- [ ] Commit step with descriptive message
- [ ] Push step to remote repository
- [ ] Correct operation sequence
- [ ] No file operations on main branch
</validation>