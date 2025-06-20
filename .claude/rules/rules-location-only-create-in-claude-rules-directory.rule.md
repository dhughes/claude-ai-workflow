---
applies_to:
  - file_patterns: ["*.rule.md"]
  - contexts: ["rules", "meta", "filesystem"]
  - actions: ["creating"]
timing: "before"
summary: "Only create rule files in .claude/rules/ directory"
---

# Rule: Only Create Rules in Claude Rules Directory

<purpose>
This rule enforces a single, consistent location for all rule files to ensure reliable rule discovery and prevent fragmentation of the rules system across the codebase.
</purpose>

<thinking>
Before creating any rule file, I need to verify:
1. Is this a rule file (ends with .rule.md)?
2. Am I attempting to create it in the correct directory?
3. Is the full path exactly `.claude/rules/[filename].rule.md`?
</thinking>

<instructions>
When creating a new rule file:

1. ALWAYS use the path `.claude/rules/` as the directory
2. NEVER create subdirectories within `.claude/rules/`
3. NEVER place rule files anywhere else in the project
4. REJECT any attempt to create rule files outside this location
</instructions>

<validation_checks>
<check>File extension MUST be `.rule.md`</check>
<check>Directory path MUST be exactly `.claude/rules/`</check>
<check>No subdirectories allowed within rules directory</check>
<check>Full path pattern: `.claude/rules/[domain]-[context]-[action].rule.md`</check>
</validation_checks>

<examples>
<correct>
<example>
Path: `.claude/rules/testing-rspec-always-use-four-phase-structure.rule.md`
Reason: Correct directory and naming pattern
</example>

<example>
Path: `.claude/rules/git-commits-always-sign-commits.rule.md`
Reason: Correct directory and naming pattern
</example>

<example>
Path: `.claude/rules/workflow-pr-never-merge-without-approval.rule.md`
Reason: Correct directory and naming pattern
</example>
</correct>

<incorrect>
<example>
Path: `rules/testing-rspec-structure.rule.md`
Reason: Wrong directory - must be in .claude/rules/
Action: REJECT - Ask user to specify correct path
</example>

<example>
Path: `.claude/testing-rules/rspec-structure.rule.md`
Reason: Wrong directory structure - rules must be in .claude/rules/
Action: REJECT - Rules cannot be in subdirectories
</example>

<example>
Path: `testing-rspec-structure.rule.md`
Reason: No directory specified - must be in .claude/rules/
Action: REJECT - Must use full path
</example>

<example>
Path: `.claude/rules/testing/rspec-structure.rule.md`
Reason: Subdirectories not allowed within .claude/rules/
Action: REJECT - Keep rules flat in .claude/rules/
</example>
</incorrect>
</examples>

<rejection_message>
When rejecting invalid rule creation:
"Rule files MUST be created in `.claude/rules/` directory. Please use the path `.claude/rules/[domain]-[context]-[action].rule.md`"
</rejection_message>