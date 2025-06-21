---
applies_to:
  - file_patterns: []
  - contexts: ["workflow", "execution", "git", "safety"]
  - actions: ["after_plan_approval", "before_file_operations"]
timing: "before"
summary: "Always verify correct git branch immediately after plan approval and before any file operations"
version: "1.0.0"
---

# Rule: Always Verify Branch Before File Operations

<purpose>
This rule acts as a safety checkpoint that triggers immediately after plan approval to ensure proper git branch is set up before any file operations begin, serving as a fail-safe to catch any git workflow violations before they occur.
</purpose>

<instructions>
IMMEDIATELY after plan approval (when user approves plan mode), you MUST:

1. **Run Branch Check**: Execute `git branch --show-current` as the FIRST action
2. **Verify Not on Main**: If on main/master branch, STOP all file operations
3. **Create Branch if Needed**: If on main, create appropriate branch before proceeding
4. **Confirm Branch**: Verify successful branch switch before any file operations
5. **Document Branch**: Note the branch name being used for the work

This check MUST happen before ANY file creation, editing, or deletion operations.
</instructions>

<execution_flow>
**Mandatory execution sequence after plan approval:**

```bash
# 1. FIRST COMMAND after plan approval (no exceptions)
git branch --show-current

# 2. Evaluate result
if [branch is main/master]:
    # STOP - Do not proceed with file operations
    # Create branch based on planned work
    git checkout -b [appropriate-branch-name]
    
    # Verify switch successful
    git branch --show-current
    
# 3. Only now proceed with planned file operations
```

**This sequence is NON-NEGOTIABLE and has NO EXCEPTIONS**
</execution_flow>

<trigger_conditions>
**This rule triggers when ALL of these are true:**

1. Plan mode has just been approved by user
2. The approved plan includes file operations
3. Execution is about to begin
4. No explicit user instruction to work on main

**This rule does NOT trigger when:**
- Plan contains no file operations
- User explicitly requested working on main
- Only running read-only commands
- Already on a feature branch from previous work
</trigger_conditions>

<checkpoint_algorithm>
```
AFTER plan_approved:
    IF plan_contains_file_operations:
        current_branch = execute("git branch --show-current")
        
        IF current_branch in ["main", "master"]:
            PRINT "ERROR: On main branch. Creating feature branch first..."
            
            # Extract branch name from plan or generate from context
            branch_name = derive_branch_name_from_plan()
            
            execute("git checkout -b " + branch_name)
            new_branch = execute("git branch --show-current")
            
            IF new_branch == branch_name:
                PRINT "✓ Switched to " + branch_name
                PROCEED with file operations
            ELSE:
                STOP "Failed to create branch"
        ELSE:
            PRINT "✓ On branch: " + current_branch
            PROCEED with file operations
    ELSE:
        PROCEED with non-file operations
```
</checkpoint_algorithm>

<enforcement_strength>
**This is a CRITICAL SAFETY RULE:**

- **Priority**: HIGHEST - Executes before any other post-plan actions
- **Skipability**: NONE - Cannot be skipped or deferred
- **Failure Mode**: BLOCKING - Stops all execution if branch check fails
- **Recovery**: REQUIRED - Must create branch before continuing

**Violation Consequences:**
- Immediate stop of all file operations
- Force branch creation before proceeding
- Log the near-miss violation
- Continue only after proper branch setup
</enforcement_strength>

<examples>
<correct>
After plan approval for creating rules:
```bash
# First action after plan approval
$ git branch --show-current
main

# Detected main branch - creating required branch
$ git checkout -b rules/validation-improvements
Switched to a new branch 'rules/validation-improvements'

# Verify switch successful
$ git branch --show-current  
rules/validation-improvements

# ✓ Safe to proceed with file operations
# Now creating rule files...
```

Already on feature branch:
```bash
# First action after plan approval
$ git branch --show-current
feature/user-authentication

# ✓ Already on feature branch
# Proceeding with planned file operations...
```
</correct>

<incorrect>
Skipping the check:
```bash
# ❌ WRONG - Starting file operations without branch check
# Plan approved, immediately creating files...
touch new-file.js  # VIOLATION!
```

Ignoring main branch detection:
```bash
$ git branch --show-current
main
# ❌ WRONG - Proceeding anyway
echo "content" > file.txt  # VIOLATION!
```
</incorrect>
</examples>

<integration_with_other_rules>
**This rule complements:**

1. **git-branching-always-create-branch-before-file-modifications**
   - This rule enforces it at execution time
   - Acts as runtime enforcement of the branching rule

2. **workflow-planning-always-include-git-steps-in-plan**
   - This rule verifies the plan was followed
   - Catches cases where plan was incomplete

3. **git-workflow-always-commit-after-completing-batch-work**
   - This rule ensures work starts on correct branch
   - Makes subsequent commit rule applicable

**Execution order:**
1. Plan approved → THIS RULE TRIGGERS
2. Branch verified/created → File operations begin
3. Work completed → Commit rule triggers
4. Commit done → Push rule triggers
</integration_with_other_rules>

<error_recovery>
**If branch check is accidentally skipped:**

1. **Stop immediately** when violation detected
2. **Stash any changes** made on wrong branch
3. **Create correct branch**
4. **Apply stashed changes**
5. **Continue with proper workflow**

**Recovery commands:**
```bash
# If files created on main by mistake
git stash push -m "Emergency stash - wrong branch"
git checkout -b [correct-branch-name]
git stash pop
# Continue properly
```
</error_recovery>

<validation>
**Successful checkpoint execution verified by:**
- [ ] `git branch --show-current` was first command after plan approval
- [ ] Branch was checked before ANY file operations
- [ ] If on main, branch was created before proceeding
- [ ] Branch creation used appropriate naming convention
- [ ] File operations only began after branch confirmation
- [ ] No files were created/edited while on main branch
</validation>