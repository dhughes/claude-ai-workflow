---
timing: "before"
applies_to:
  - file_patterns: []
  - contexts: ["workflow", "actions", "todo"]
  - actions: ["creating", "editing", "executing", "running"]
action: "Add action to todo list before execution if not already present"
---

<purpose>
This rule ensures all actions are tracked and visible through the todo list, providing transparency and preventing tasks from being forgotten or lost.
</purpose>

<condition>
When about to take any action
</condition>

<instructions>
1. READ the current todo list using TodoRead
2. CHECK if the action is already on the todo list
3. IF the action is not on the todo list, ADD it using TodoWrite
4. MARK the action as in_progress before starting
5. PROCEED with the action
</instructions>

<detail>
CRITICAL: Every action must be tracked in the todo list for user visibility
CRITICAL: Use TodoRead to check existing todos before adding new ones
CRITICAL: Mark actions as in_progress when starting work

Actions include: file creation, editing, running commands, making commits, etc.
</detail>