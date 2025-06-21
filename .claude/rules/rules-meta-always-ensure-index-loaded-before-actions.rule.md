---
timing: "before"
applies_to:
  - file_patterns: []
  - contexts: ["rules", "meta", "initialization"]
  - actions: ["first_message", "session_start", "any_action"]
action: "Load rules index by running .claude/scripts/index-rules.sh before any actions"
---

<purpose>
This rule ensures that Claude Code always has the complete rules index loaded in context before taking any actions, preventing rule violations and ensuring consistent behavior throughout the session.
</purpose>

<condition>
When receiving the first message from a human or before taking any action in a new session
</condition>

<instructions>
1. IMMEDIATELY run `.claude/scripts/index-rules.sh` to load the rules index
2. WAIT for the script to complete successfully
3. ONLY then proceed with any requested actions
4. IF the script fails, STOP and report the error to the user
</instructions>

<detail>
CRITICAL: This rule has the highest priority and must be executed before any other actions
CRITICAL: The script path is exactly `.claude/scripts/index-rules.sh`
CRITICAL: No actions should be taken until the rules index is successfully loaded

This rule is mandatory and cannot be overridden by other rules or user requests.
The rules index must be loaded to ensure all subsequent actions follow the established rules.
</detail>