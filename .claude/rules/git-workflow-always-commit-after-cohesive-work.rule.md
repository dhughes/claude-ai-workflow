---
timing: "after"
applies_to:
  - file_patterns: ["*"]
  - contexts: ["git", "workflow", "commit", "productivity"]
  - actions: ["completing_task", "finishing_feature", "fixing_bug"]
action: "Commit changes after completing a cohesive set of work"
---

<purpose>
This rule ensures work is regularly committed in logical, atomic units after completing cohesive tasks, maintaining a clean git history and preventing loss of work.
</purpose>

<condition>
After completing a cohesive unit of work such as implementing a feature, fixing a bug, or finishing a refactor
</condition>

<instructions>
1. ASSESS if the completed work forms a logical, cohesive unit
2. CHECK for uncommitted changes with `git status`
3. IF changes exist and work is complete:
   a. REVIEW changes with `git diff`
   b. STAGE appropriate files with `git add`
   c. CREATE descriptive commit following commit message rules
   d. PUSH to remote following push rules
4. AVOID combining unrelated changes in a single commit
5. ENSURE each commit represents one logical change
</instructions>

<detail>
CRITICAL: Commit frequently but meaningfully
CRITICAL: Each commit should be able to stand alone
CRITICAL: Don't wait too long between commits

Cohesive work includes:
- A complete feature or sub-feature
- A bug fix and its tests
- A refactoring of a specific component
- Documentation updates for a feature
- Configuration changes for a specific purpose

Benefits:
- Easier code review
- Better git history
- Simpler debugging with git bisect
- Reduced risk of losing work
- Clear project evolution
</detail>