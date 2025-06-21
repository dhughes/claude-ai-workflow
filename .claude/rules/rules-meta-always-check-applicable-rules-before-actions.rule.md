---
timing: "before"
applies_to:
  - file_patterns: []
  - contexts: ["rules", "meta", "planning"]
  - actions: ["any_action"]
action: "Check rules index to determine applicable rules before taking any action"
---

<purpose>
This rule ensures that Claude Code reviews the loaded rules index to identify which rules may be applicable to any planned action, preventing rule violations and ensuring comprehensive compliance.
</purpose>

<condition>
Before taking any action that could be governed by rules
</condition>

<instructions>
1. REVIEW the loaded rules index to identify potentially applicable rules
2. EXAMINE each rule's applies_to criteria against the planned action
3. IDENTIFY which rules may govern the planned action
4. EXPLICITLY STATE which rules apply (this triggers rule sequencing)
5. PROCEED only after rule sequencing is complete
</instructions>

<detail>
CRITICAL: This rule applies to ALL actions, not just file operations
CRITICAL: Must check rules index that was loaded by the mandatory initialization rule
CRITICAL: Consider file patterns, contexts, and action types when determining applicability

Actions include but are not limited to: responding to any messages, tool use, file creation, editing, deletion, git operations, script execution, and workflow steps.
This rule works in conjunction with the rules index loading rule to ensure comprehensive rule compliance.
</detail>