---
timing: "before"
applies_to:
  - file_patterns: ["*.rule.md"]
  - contexts: ["rules", "meta", "filesystem"]
  - actions: ["creating"]
action: "Only create rule files in .claude/rules/ directory"
---

<purpose>
This rule enforces a single, consistent location for all rule files to ensure reliable rule discovery and prevent fragmentation of the rules system across the codebase.
</purpose>

<condition>
When creating a new rule file
</condition>

<instructions>
1. ALWAYS use the path `.claude/rules/` as the directory
2. NEVER create subdirectories within `.claude/rules/`
3. NEVER place rule files anywhere else in the project
4. REJECT any attempt to create rule files outside this location
</instructions>

<detail>
CRITICAL: Directory path MUST be exactly `.claude/rules/`
CRITICAL: No subdirectories allowed within rules directory

Rule files must be created with the full path `.claude/rules/[filename].rule.md`
</detail>