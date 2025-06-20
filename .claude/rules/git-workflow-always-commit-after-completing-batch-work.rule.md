---
applies_to:
  - file_patterns: []
  - contexts: ["git", "workflow", "batch_completion"]
  - actions: ["after_batch_work"]
timing: "after"
summary: "Automatically add and commit all edited files after completing a batch of work"
version: "1.0.0"
---

# Rule: Always Commit After Completing Batch Work

<purpose>
This rule ensures that completed work is properly saved to git history after finishing a coherent batch of changes, preventing loss of work and maintaining a clean development workflow with logical commit boundaries.
</purpose>

<instructions>
After completing a batch of related work (such as implementing a feature, fixing a bug, or completing a user request), you MUST:

1. RUN `git status` to see all modified and untracked files
2. RUN `git diff` to review all changes that will be committed
3. ADD all relevant files using `git add` for each modified file
4. CREATE a commit with an appropriate message following commit message rules
5. RUN `git status` again to confirm the commit was successful

This applies when:
- You have completed a user's request that involved multiple file changes
- You have finished implementing a feature or fix
- You have completed a logical unit of work that stands alone
- The user has not explicitly asked you NOT to commit
</instructions>

<batch_work_indicators>
Work is considered "batch work" when:
- Multiple files have been edited for a single purpose
- A feature implementation is complete
- A bug fix is complete
- A refactoring task is complete
- User's request has been fully addressed
- All related changes form a logical unit
</batch_work_indicators>

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