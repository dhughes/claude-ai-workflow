---
timing: "before"
applies_to:
  - file_patterns: ["*.rule.md"]
  - contexts: ["rules", "meta"]
  - actions: ["creating", "editing"]
action: "Structure rules with YAML frontmatter followed by rule content"
---

<purpose>
This rule ensures all rule files follow a consistent, machine-readable structure that enables efficient indexing and loading while maintaining clarity for both Claude and human readers.
</purpose>

<condition>
When creating or editing any rule file
</condition>

<instructions>
All rules MUST follow this exact structure:

1. Start with YAML frontmatter between `---` markers
2. Include all required fields in the frontmatter
3. Follow with brief, tightly focused, rule content using XML tags for organization
4. XML tags must be `purpose`, `condition`, `instructions`, `detail`
5. Do not add any other tags or sections

If a rule can not fit this structure, STOP, explain the problem, and ask for guidance.
If a rule has more than one condition, STOP, explain the problem, and ask for guidance.
Rules MUST be concise and easy to follow. If a rule is complex, STOP, explain the problem, and ask for guidance.
</instructions>

<detail>

# Frontmatter

Frontmatter MUST contain:

```
---
applies_to:
  - file_patterns: [array of glob patterns, can be empty [] for non-file rules]
  - contexts: [array of relevant domains/areas]
  - actions: [array of triggering actions like "creating", "editing", "after_commit", etc.]
timing: "before" | "after"
action: "One-line description of the action this rule enforces"
---
```

# Purpose

Explain why this rule exists and what problem it solves

# Condition

Explains when this rule applies, e.g. "When committing code changes".
Does not specify before or after, just the condition or scenario to which the rule applies.
CRITICAL: There MUST only be one condition per rule.
Conditions MAY be combined with logical operators like AND/OR.

# Instructions

Step-by-step guidance for following this rule.

# Detail

Additional supporting information on how to follow the rule's instructions.
The most important details are called with "CRITICAL" prefix.
Keep this section concise and focused on the most important aspects of the rule.

</detail>
