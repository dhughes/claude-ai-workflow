---
applies_to:
  - file_patterns: []
  - contexts: ["git", "commits", "attribution", "identity"]
  - actions: ["before_commit"]
timing: "before"
summary: "Always use --author flag with Claude Hughes format and role-based attribution"
version: "1.1.0"
---

# Rule: Always Use Claude Hughes Attribution for Git Commits

<purpose>
This rule ensures all git commits use the --author flag with the exact Claude Hughes attribution format, providing clear AI identification in git history with role-based attribution when applicable.
</purpose>

<instructions>
When creating any git commit, you MUST:

1. ALWAYS use the --author flag with the git commit command
2. NEVER commit without proper author attribution  
3. USE this exact author format:

**With Role (if AI has an assigned role):**
```
"Claude Hughes ([Role]) <doug+ai@doughughes.net>"
```

**Without Role (default):**
```
"Claude Hughes <doug+ai@doughughes.net>"
```

Where [Role] is replaced with the specific role assigned to the AI assistant, such as:
- Architect
- Developer  
- DevOps Engineer
- Data Analyst
- Code Reviewer
- QA Engineer
- Technical Writer
- etc.

The complete git commit command format:
```bash
git commit --author="[Author String]" -m "[Commit Message]"
```
</instructions>

<format_rules>
1. ALWAYS include the --author flag in git commit commands
2. ALWAYS use "Claude Hughes" as the name (never "Claude" alone)
3. ALWAYS use angle brackets around the email: <doug+ai@doughughes.net>
4. ALWAYS use parentheses around the role: (Role)
5. PLACE the role between the name and email
6. USE proper capitalization for roles (title case)
7. NEVER modify the email address
8. NEVER use quotes inside the author string itself
9. NEVER commit without proper author attribution
</format_rules>

<role_examples>
Common role attributions:
- `"Claude Hughes (Architect) <doug+ai@doughughes.net>"`
- `"Claude Hughes (Developer) <doug+ai@doughughes.net>"`
- `"Claude Hughes (DevOps Engineer) <doug+ai@doughughes.net>"`
- `"Claude Hughes (Data Analyst) <doug+ai@doughughes.net>"`
- `"Claude Hughes (Code Reviewer) <doug+ai@doughughes.net>"`
- `"Claude Hughes (QA Engineer) <doug+ai@doughughes.net>"`
- `"Claude Hughes (Technical Writer) <doug+ai@doughughes.net>"`
- `"Claude Hughes (Security Analyst) <doug+ai@doughughes.net>"`
</role_examples>

<examples>
<correct>
Basic attribution (no role):
```bash
git commit --author="Claude Hughes <doug+ai@doughughes.net>" -m "Fix login validation bug"
```

With Developer role:
```bash
git commit --author="Claude Hughes (Developer) <doug+ai@doughughes.net>" -m "Implement user registration API"
```

With Architect role:
```bash
git commit --author="Claude Hughes (Architect) <doug+ai@doughughes.net>" -m "Design microservice communication patterns"
```

With Technical Writer role:
```bash
git commit --author="Claude Hughes (Technical Writer) <doug+ai@doughughes.net>" -m "Update API documentation with examples"
```

Complex commit with role:
```bash
git commit --author="Claude Hughes (DevOps Engineer) <doug+ai@doughughes.net>" -m "$(cat <<'EOF'
Configure CI/CD pipeline for automated deployments

Added GitHub Actions workflow with:
- Automated testing on pull requests
- Docker image building and pushing
- Staging and production deployment stages
- Security scanning and compliance checks
EOF
)"
```
</correct>

<incorrect>
Wrong name format:
```bash
git commit --author="Claude <doug+ai@doughughes.net>" -m "Fix bug"
# Should be "Claude Hughes"
```

Wrong email:
```bash
git commit --author="Claude Hughes <claude@anthropic.com>" -m "Add feature"
# Should be doug+ai@doughughes.net
```

Wrong role format:
```bash
git commit --author="Claude Hughes - Developer <doug+ai@doughughes.net>" -m "Add API"
# Should use parentheses: (Developer)
```

Missing role parentheses:
```bash
git commit --author="Claude Hughes Developer <doug+ai@doughughes.net>" -m "Code review"
# Should be: (Developer)
```

Wrong capitalization:
```bash
git commit --author="Claude Hughes (developer) <doug+ai@doughughes.net>" -m "Build feature"
# Should be: (Developer)
```

Wrong email brackets:
```bash
git commit --author="Claude Hughes (Architect) doug+ai@doughughes.net" -m "Design system"
# Missing angle brackets around email
```
</incorrect>
</examples>

<role_determination>
To determine if a role should be included:
1. CHECK if the AI has been explicitly assigned a role in the conversation
2. LOOK for role-specific tasks or contexts being performed
3. USE the most specific role that applies to the current work
4. DEFAULT to no role if none is clearly assigned or applicable

Common role indicators:
- Architecture/design work → Architect
- Writing code/implementation → Developer
- Infrastructure/deployment → DevOps Engineer
- Testing/quality assurance → QA Engineer
- Documentation work → Technical Writer
- Security-focused tasks → Security Analyst
</role_determination>

<validation>
Before executing any git commit command, verify:
- [ ] The --author flag is present
- [ ] Uses exactly "Claude Hughes" as the name
- [ ] Email is exactly "doug+ai@doughughes.net"
- [ ] Email is wrapped in angle brackets < >
- [ ] Role (if present) is in parentheses ( )
- [ ] Role (if present) uses proper title case
- [ ] Entire author string is wrapped in double quotes
- [ ] No extra spaces or formatting issues
- [ ] Never committing without author attribution
</validation>