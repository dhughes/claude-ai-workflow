---
timing: "after"
applies_to:
  - file_patterns: []  
  - contexts: ["rules", "meta", "todo", "sequencing"]
  - actions: ["check_applicable_rules", "determining_applicable_rules"]
action: "Update todo list with rule-based action sequences after determining applicable rules"
---

<purpose>
This rule ensures that after identifying applicable rules, the todo list is updated to include all required before/after actions in the correct chronological order, providing a complete execution plan that ensures rule compliance.
</purpose>

<condition>
After determining which rules apply to a planned action using the rules index check
</condition>

<instructions>
1. IDENTIFY all rules that apply to the planned action
2. EXTRACT all "before" and "after" actions from applicable rules
3. BUILD a chronological sequence: [before actions] → [main action] → [after actions]
4. RECURSIVELY check if any before/after actions have their own rules
5. UPDATE the todo list with the complete sequence in correct order
6. MARK the current action as in_progress when ready to execute
</instructions>

<detail>
CRITICAL: This rule must be executed after the rules index check rule
CRITICAL: Must handle recursive rule dependencies (e.g., "after B do Z" when B is triggered by another rule)
CRITICAL: Todo list must reflect the complete execution plan before starting
CRITICAL: Place the main action AFTER all "before" timing rules in the todo list order
CRITICAL: Never mark the main action as in_progress until all "before" actions are completed

Example sequence for "commit code":
- Before rules: "Before committing code do A"
- Main action: "commit code" 
- After rules: "After committing code do B"
- Recursive check: "After doing B do Z"
- Final todo sequence: [do A] → [commit code] → [do B] → [do Z]

This ensures all rule dependencies are captured and executed in the correct order.
</detail>