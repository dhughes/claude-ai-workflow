---
applies_to:
  - file_patterns: []
  - contexts: ["git", "main", "push", "workflow"]
  - actions: ["before_push"]
timing: "before"
summary: "STRICTLY FORBIDDEN: Never push updates directly to main branch"
version: "1.0.0"
---

# Rule: Never Push Directly to Main Branch

<purpose>
This rule STRICTLY FORBIDS any direct pushes to the main branch, enforcing that ALL pushes to main must go through the proper pull request merge workflow rather than direct push operations.
</purpose>

<instructions>
You are ABSOLUTELY FORBIDDEN from pushing directly to main branch:

1. **NEVER run `git push` while on main branch**
2. **NEVER push commits directly to origin/main**
3. **ALWAYS push to feature branches only**
4. **Main branch MUST only receive updates through approved PR merges**

🚨 **ZERO TOLERANCE POLICY** - This rule has NO EXCEPTIONS WHATSOEVER for pushes
</instructions>

<forbidden_push_actions>
**ABSOLUTELY FORBIDDEN:**
```bash
# Pushing to main directly
git push origin main  # ❌ FORBIDDEN

# Being on main and pushing
git checkout main
git push  # ❌ FORBIDDEN

# Any form of direct main branch pushes
git push --force origin main  # ❌ FORBIDDEN
```

**REQUIRED WORKFLOW:**
```bash
# Correct workflow
git checkout feature/new-feature
git push -u origin feature/new-feature  # ✅ Push to feature branch
```
</forbidden_push_actions>

<enforcement>
**STRICT ENFORCEMENT:**
- NO exceptions for "quick deployments"
- NO exceptions for "hotfixes" 
- NO exceptions for "urgent updates"
- NO exceptions for "small changes"
- NO exceptions for configuration changes
- NO exceptions for documentation updates
- NO exceptions for ANY reason whatsoever

**VIOLATION CONSEQUENCES:**
If you attempt to push to main:
1. STOP immediately
2. Acknowledge the violation
3. Switch to feature branch
4. Follow proper workflow
5. Never repeat the violation
</enforcement>

<prevention_checks>
Before ANY push, verify:
- [ ] Current branch is NOT main (`git branch --show-current`)
- [ ] Pushing to feature branch, not main
- [ ] Not using `git push origin main`
- [ ] Following proper workflow
</prevention_checks>

<examples>
<correct>
Proper push workflow:
```bash
git branch --show-current  # Shows: feature/auth-system
git push -u origin feature/auth-system
```

Pushing feature branch:
```bash
git checkout fix/login-bug
git push origin fix/login-bug
```
</correct>

<incorrect>
Direct push to main:
```bash
git push origin main  # ❌ VIOLATION - pushing to main
```

Push while on main:
```bash
git branch --show-current  # Shows: main
git push  # ❌ VIOLATION - pushing from main branch
```

Force push to main:
```bash
git push --force origin main  # ❌ VIOLATION - force pushing to main
```
</incorrect>
</examples>

<violation_detection>
**Red flags that indicate violations:**
- `git branch --show-current` shows "main" before push
- Commands targeting "origin/main" directly in push
- Any `git push` command executed while on main branch

**Immediate actions upon detection:**
1. ABORT the push operation immediately
2. Switch to appropriate feature branch
3. Restart with proper workflow
4. Never complete the forbidden push
</violation_detection>

<emergency_procedures>
Even in emergencies:
- NO direct pushes to main
- PUSH to hotfix branch for urgent fixes
- FOLLOW expedited PR process
- GET emergency approval if needed
- NEVER bypass the push workflow

Emergency workflow:
```bash
git checkout -b hotfix/critical-security-fix
git push -u origin hotfix/critical-security-fix
```
</emergency_procedures>