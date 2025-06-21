---
timing: "after"
applies_to:
  - file_patterns: []
  - contexts: ["git", "push", "workflow", "sync"]
  - actions: ["committing", "git_commit"]
action: "Push to upstream branch after committing, creating upstream if needed"
---

<purpose>
This rule ensures commits are immediately pushed to the remote repository after creation, maintaining synchronization between local and remote branches and enabling collaboration.
</purpose>

<condition>
After successfully creating a git commit on any branch except main
</condition>

<instructions>
1. CHECK if current branch has upstream tracking: `git rev-parse --abbrev-ref @{upstream} 2>/dev/null`
2. IF no upstream exists:
   a. PUSH with upstream creation: `git push -u origin <current-branch>`
   b. INFORM user about new upstream branch creation
3. IF upstream exists:
   a. PUSH to existing upstream: `git push`
   b. INFORM user about successful push
4. HANDLE any push errors (e.g., need to pull first)
5. ENSURE remote is synchronized before proceeding
</instructions>

<detail>
CRITICAL: Always push after committing to keep remote synchronized
CRITICAL: Use -u flag only when creating new upstream tracking
CRITICAL: This rule applies to all branches except main (which has separate protection)

Benefits:
- Immediate backup of work to remote
- Enables collaboration on feature branches
- Prevents loss of commits
- Facilitates pull request creation
- Maintains continuous integration triggers
</detail>