---
timing: "before"
applies_to:
  - file_patterns: []
  - contexts: ["git", "branch", "merge", "safety"]
  - actions: ["git_merge", "merging"]
action: "Prevent local merges into main branch"
---

<purpose>
This rule prevents merging branches into main locally, ensuring all merges to main happen through pull requests on GitHub with proper review and CI/CD processes.
</purpose>

<condition>
When attempting to merge any branch into main using git merge
</condition>

<instructions>
1. CHECK current branch with `git branch --show-current`
2. IF on main branch and attempting merge, STOP the operation
3. INFORM user that local merges to main are not allowed
4. SUGGEST creating a pull request on GitHub instead
5. DO NOT proceed with the merge operation
</instructions>

<detail>
CRITICAL: No local merges to main are allowed under any circumstances
CRITICAL: This includes fast-forward merges, squash merges, and regular merges
CRITICAL: All changes to main must go through GitHub pull requests

Pull requests provide:
- Code review opportunities
- CI/CD pipeline execution
- Proper merge commit messages
- Audit trail of changes
- Protection of main branch integrity
</detail>