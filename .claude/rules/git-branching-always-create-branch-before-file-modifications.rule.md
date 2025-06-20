---
applies_to:
  - file_patterns: []
  - contexts: ["git", "branching", "workflow"]
  - actions: ["before_creating_files", "before_editing_files"]
timing: "before"
summary: "MANDATORY: Create new git branch before ANY file modifications on main - NEVER skip this step"
version: "2.0.0"
---

# Rule: Always Create Branch Before File Modifications

<purpose>
This rule MANDATORILY ensures that all file creation and editing work is done on feature branches rather than directly on the main branch, maintaining clean git history and enabling proper code review workflows. This rule CANNOT be skipped or ignored under any circumstances.
</purpose>

<instructions>
Before creating OR editing any files, you MUST:

1. CHECK the current git branch with `git branch --show-current`
2. IF on main branch (or master), IMMEDIATELY create a new branch:
   - Generate a descriptive branch name based on the work being done
   - Use kebab-case naming convention
   - Include context about the changes being made
3. SWITCH to the new branch before making any file modifications
4. NEVER create or edit files directly on the main branch

⚠️ CRITICAL: This rule is MANDATORY and has NO EXCEPTIONS. If you start creating or editing files on main branch, you are VIOLATING this rule and must STOP IMMEDIATELY.</instructions>

Branch naming format: `[category]/[descriptive-name]`

Categories:
- `feature/` - New functionality or capabilities
- `fix/` - Bug fixes or corrections
- `refactor/` - Code restructuring without behavior changes
- `docs/` - Documentation updates
- `config/` - Configuration or settings changes
- `rules/` - Rule system modifications
- `chore/` - Maintenance tasks, dependencies, tooling
</instructions>

<branch_naming_examples>
Based on work context:
- Adding new authentication: `feature/user-authentication`
- Fixing login bug: `fix/login-validation-error`
- Updating API docs: `docs/api-endpoint-documentation`
- Refactoring components: `refactor/component-architecture`
- Adding new rules: `rules/git-workflow-automation`
- Updating dependencies: `chore/dependency-updates`
- Configuration changes: `config/build-optimization`
</branch_naming_examples>

<workflow_steps>
1. Check current branch: `git branch --show-current`
2. If on main/master:
   a. Analyze the upcoming work to determine category and description
   b. Create branch: `git checkout -b [category]/[descriptive-name]`
   c. Confirm switch: `git branch --show-current`
3. Proceed with file creation/editing
4. Follow normal commit and push workflows
</workflow_steps>

<examples>
<correct>
Before creating new authentication files:
```bash
git branch --show-current  # Shows: main
git checkout -b feature/user-authentication
git branch --show-current  # Shows: feature/user-authentication
# Now safe to create/edit files
```

Before fixing a bug:
```bash
git branch --show-current  # Shows: main  
git checkout -b fix/date-formatting-locale-issue
# Now safe to edit files
```

Before adding new rules:
```bash
git branch --show-current  # Shows: main
git checkout -b rules/celebration-ascii-borders
# Now safe to create rule files
```

Already on feature branch:
```bash
git branch --show-current  # Shows: feature/api-endpoints
# Already on feature branch, safe to proceed with file changes
```
</correct>

<incorrect>
Creating files directly on main:
```bash
git branch --show-current  # Shows: main
# Immediately starts editing files without creating branch
```

Using poor branch names:
```bash
git checkout -b temp
git checkout -b fix
git checkout -b branch1
# Names are too vague or non-descriptive
```

Wrong branch naming format:
```bash
git checkout -b Fix_Login_Bug  # Should use kebab-case
git checkout -b featureUserAuth  # Should use category/description format
```
</incorrect>
</examples>

<branch_name_generation>
To generate appropriate branch names:

1. IDENTIFY the work category:
   - New functionality → feature/
   - Bug fix → fix/
   - Documentation → docs/
   - Refactoring → refactor/
   - Configuration → config/
   - Rules changes → rules/
   - Maintenance → chore/

2. CREATE descriptive name from:
   - User's request context
   - Type of files being modified
   - Specific problem being solved
   - Feature being implemented

3. FORMAT as kebab-case (lowercase with hyphens)

4. KEEP reasonably concise but descriptive
</branch_name_generation>

<exclusions>
Do NOT create branches when:
- Already on a feature branch (not main/master)
- User explicitly requests working on main
- Only reading files (no modifications)
- Running commands that don't modify files
- User has explicitly checked out a specific branch for the work
</exclusions>

<validation>
Before any file creation or editing, verify:
- [ ] Current branch has been checked with `git branch --show-current`
- [ ] If on main/master, new branch has been created BEFORE any file changes
- [ ] Branch name follows category/description format
- [ ] Branch name is descriptive of the work being done
- [ ] Successfully switched to the new branch
- [ ] Ready to proceed with file modifications

🚨 VIOLATION DETECTION: If you find yourself creating or editing files while on main branch, you have VIOLATED this rule. STOP immediately and create the branch before continuing.
</validation>

<enforcement>
This rule is STRICTLY ENFORCED:
- NO exceptions for "quick fixes" or "small changes"
- NO exceptions for "it's just one file"
- NO exceptions for urgent work
- NO exceptions for rule files or any other file types
- ALWAYS create branches, even for minor modifications
- If caught violating this rule, immediately stop and correct the violation
</enforcement>