---
applies_to:
  - file_patterns: []
  - contexts: ["git", "main", "commits", "workflow"]
  - actions: ["before_commit"]
timing: "before"
summary: "STRICTLY FORBIDDEN: Never commit code directly to main branch"
version: "1.0.0"
---

# Rule: Never Commit Directly to Main Branch

<purpose>
This rule STRICTLY FORBIDS any direct commits to the main branch, enforcing that ALL commits must be made on feature branches as part of the proper pull request workflow for code review and approval.
</purpose>

<instructions>
You are ABSOLUTELY FORBIDDEN from committing directly to main branch:

1. **NEVER run `git commit` while on main branch**
2. **NEVER create commits that target main branch directly**
3. **ALWAYS commit on feature branches only**
4. **Main branch MUST only receive commits through approved PR merges**

🚨 **ZERO TOLERANCE POLICY** - This rule has NO EXCEPTIONS WHATSOEVER for commits
</instructions>

<forbidden_commit_actions>
**ABSOLUTELY FORBIDDEN:**
```bash
# Being on main and committing
git checkout main
git commit -m "Any commit message"  # ❌ FORBIDDEN

# Any form of direct main branch commits
git commit -am "Quick fix"  # ❌ FORBIDDEN (while on main)
```

**REQUIRED WORKFLOW:**
```bash
# Correct workflow
git checkout -b feature/new-feature  # ✅ Create feature branch
git commit -m "Add new feature"      # ✅ Commit to feature branch
```
</forbidden_commit_actions>

<enforcement>
**STRICT ENFORCEMENT:**
- NO exceptions for "quick fixes"
- NO exceptions for "tiny changes" 
- NO exceptions for "urgent fixes"
- NO exceptions for "just one line"
- NO exceptions for configuration changes
- NO exceptions for documentation updates
- NO exceptions for ANY reason whatsoever

**VIOLATION CONSEQUENCES:**
If you attempt to commit to main:
1. STOP immediately
2. Acknowledge the violation
3. Switch to feature branch
4. Follow proper workflow
5. Never repeat the violation
</enforcement>

<prevention_checks>
Before ANY commit, verify:
- [ ] Current branch is NOT main (`git branch --show-current`)
- [ ] Working on a feature branch
- [ ] Changes will not directly affect main branch
- [ ] Following proper feature branch workflow
</prevention_checks>

<examples>
<correct>
Proper commit workflow:
```bash
git branch --show-current  # Shows: feature/auth-system
git add src/auth.js
git commit -m "Add authentication system"
```

Working on feature branch:
```bash
git checkout -b fix/login-bug
git add src/login.js  
git commit -m "Fix login validation bug"
```
</correct>

<incorrect>
Direct commit to main:
```bash
git branch --show-current  # Shows: main
git commit -m "Quick fix"  # ❌ VIOLATION - committing to main
```

Any direct main branch commit operation:
```bash
git checkout main
git commit -am "Update config"  # ❌ VIOLATION - direct commit to main
```
</incorrect>
</examples>

<violation_detection>
**Red flags that indicate violations:**
- `git branch --show-current` shows "main" before commit
- Any `git commit` command executed while on main branch
- File modifications committed directly to main

**Immediate actions upon detection:**
1. ABORT the commit operation immediately
2. Switch to appropriate feature branch
3. Restart with proper workflow
4. Never complete the forbidden commit
</violation_detection>

<emergency_procedures>
Even in emergencies:
- NO direct commits to main
- CREATE hotfix branch for urgent fixes
- FOLLOW expedited PR process
- GET emergency approval if needed
- NEVER bypass the commit workflow

Emergency workflow:
```bash
git checkout -b hotfix/critical-security-fix
git commit -m "Fix critical security vulnerability" 
```
</emergency_procedures>