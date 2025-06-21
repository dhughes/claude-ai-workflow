---
timing: "after"
applies_to:
  - file_patterns: ["*.rule.md"]
  - contexts: ["rules", "meta", "indexing", "filesystem"]
  - actions: ["creating", "editing", "deleting"]
action: "Reload rules index by running .claude/scripts/index-rules.sh after any rule file changes"
---

<purpose>
This rule ensures that the rules index remains current and accurate whenever rule files are created, modified, or deleted, maintaining consistency between the actual rule files and the loaded index.
</purpose>

<condition>
After creating, editing, or deleting any .rule.md file in the .claude/rules/ directory
</condition>

<instructions>
1. COMPLETE the rule file operation (create, edit, or delete)
2. IMMEDIATELY run `.claude/scripts/index-rules.sh` to reload the rules index
3. VERIFY the script completes successfully
4. IF the script fails, report the error and fix any issues
</instructions>

<detail>
CRITICAL: This rule ensures rule changes are immediately reflected in the active index
CRITICAL: The script path is exactly `.claude/scripts/index-rules.sh`
CRITICAL: Must run after ANY rule file modification to maintain index accuracy

This rule works in conjunction with the initialization rule to maintain a current rules index throughout the session.
Rule changes without index reloading can lead to inconsistent behavior and rule violations.
</detail>