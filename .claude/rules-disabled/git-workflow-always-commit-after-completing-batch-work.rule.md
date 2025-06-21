---
applies_to:
  - file_patterns: []
  - contexts: ["git", "workflow", "task_completion"]
  - actions: ["after_completing_user_request", "after_task_completion"]
timing: "after"
summary: "Automatically add and commit all edited files after completing any user request or logical task"
version: "2.0.0"
---

# Rule: Always Commit After Completing User Requests or Tasks

<purpose>
This rule ensures that completed work is properly saved to git history after finishing any user request or logical task, preventing loss of work and maintaining a clean development workflow with clear commit boundaries.
</purpose>

<instructions>
After completing ANY user request or logical task that involves file changes, you MUST:

1. RUN `git status` to see all modified and untracked files
2. RUN `git diff` to review all changes that will be committed
3. ADD all relevant files using `git add` for each modified file
4. CREATE a commit with an appropriate message following commit message rules
5. RUN `git status` again to confirm the commit was successful

This applies when:
- You have completed ANY user request that resulted in file changes
- You have finished a logical task or subtask
- You have implemented a feature, fix, or enhancement
- You have completed any coherent unit of work
- The user has not explicitly asked you NOT to commit

Examples of when to commit:
- After creating one or more new files for a user request
- After editing files to implement a requested feature
- After fixing a bug the user reported
- After completing each distinct task in a multi-part request
- After refactoring code as requested
- After updating documentation or configuration
</instructions>

<commit_triggers>
You MUST commit when:
- Any user request is complete (even small ones)
- A logical task or subtask is finished
- Files have been changed for a coherent purpose
- A feature, fix, or enhancement is implemented
- Documentation or configuration is updated
- Any work unit is complete and could stand alone

The key principle: If you've made file changes to accomplish something specific, commit it.
</commit_triggers>

<exclusions>
Do NOT auto-commit when:
- User explicitly says not to commit
- Work is incomplete or partially done
- There are failing tests (run tests first if available)
- Only exploratory or temporary changes were made
- User is still actively iterating on changes
</exclusions>

<examples>
<correct>
After implementing a new feature:
```bash
git status
git diff
git add src/components/UserProfile.tsx
git add src/types/User.ts
git add tests/UserProfile.test.tsx
git commit -m "Add user profile display component

Implements user profile view with avatar, name, and bio display.
Includes responsive design and comprehensive test coverage.
Addresses user request for profile functionality."
git status
```

After fixing a bug:
```bash
git status
git diff
git add src/utils/dateFormatter.ts
git add tests/dateFormatter.test.ts
git commit -m "Fix date formatting for non-English locales

Resolves issue where dates displayed incorrectly in French and 
German locales due to hardcoded English month names."
git status
```
</correct>

<incorrect>
Skipping commit after completing work:
- Making changes but not committing when work is done
- Adding files but forgetting to commit
- Committing without reviewing changes first

Committing incomplete work:
- Committing when only halfway through a feature
- Committing broken or failing code
- Committing when user is still iterating
</incorrect>
</examples>

<validation>
- Git status MUST be checked before and after commit
- Git diff MUST be reviewed to understand changes
- All relevant modified files MUST be added
- Commit message MUST follow commit message rules
- Commit MUST only happen when work is complete
- NEVER commit when user explicitly declines
</validation>