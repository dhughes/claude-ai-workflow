---
applies_to:
  - file_patterns: ["*.rule.md"]
  - contexts: ["rules", "meta"]
  - actions: ["creating", "editing"]
timing: "before"
summary: "Always structure rules with YAML frontmatter followed by detailed content"
version: "1.0.0"
---

# Rule: Always Use Standard Format for Rules

<purpose>
This rule ensures all rule files follow a consistent, machine-readable structure that enables efficient indexing and loading while maintaining clarity for both Claude and human readers.
</purpose>

<instructions>
When creating or editing any rule file, you MUST follow this exact structure:

1. Start with YAML frontmatter between `---` markers
2. Include all required fields in the frontmatter
3. Follow with detailed rule content using XML tags for organization
4. Use clear examples to demonstrate correct and incorrect usage
</instructions>

<required_structure>
Every rule file MUST contain these sections in order:

<frontmatter>
---
applies_to:
  - file_patterns: [array of glob patterns, can be empty [] for non-file rules]
  - contexts: [array of relevant domains/areas]
  - actions: [array of triggering actions like "creating", "editing", "after_commit", etc.]
timing: "before" | "after" | "both"
summary: "One-line description of what the rule enforces"
version: "semantic version number following semver (e.g. 1.0.0)"
---
</frontmatter>

<content>
# Rule: [Clear Rule Title]

<purpose>
Explain why this rule exists and what problem it solves
</purpose>

<instructions>
Step-by-step guidance for following this rule
</instructions>

<examples>
<correct>
Show correct implementation
</correct>

<incorrect>
Show incorrect implementation
</incorrect>
</examples>

<validation>
List specific checks to ensure compliance
</validation>
</content>
</required_structure>

<examples>
<correct>
Example with file patterns:
---
applies_to:
  - file_patterns: ["*.zyx", "**/*.zyx"]
  - contexts: ["zorblang", "formatting", "style"]
  - actions: ["editing", "creating"]
timing: "before"
summary: "Example rule showing correct structure (not an actual rule)"
version: "1.0.0"
---

# Rule: Example Rule Title

<purpose>
This is a hypothetical example showing proper rule structure
</purpose>

<instructions>
1. First instruction step
2. Second instruction step
3. Third instruction step
</instructions>

Example without file patterns (context-only):
---
applies_to:
  - file_patterns: []
  - contexts: ["git", "workflow"]
  - actions: ["after_commit"]
timing: "after"
summary: "Example of non-file-specific rule (not an actual rule)"
version: "1.0.0"
---

# Rule: Example Context-Only Rule

<purpose>
Shows a rule that applies based on context/action only, not files
</purpose>
</correct>

<incorrect>
Missing required frontmatter fields:
---
applies_to:
  - contexts: ["git"]
timing: "before"
---
(Missing: file_patterns field even if empty, summary, version)

Or invalid structure without XML tags:
# Rule Title
Some content without proper XML tag structure
Just plain text sections
</incorrect>
</examples>

<validation>
- YAML frontmatter MUST be valid YAML syntax
- All required fields MUST be present
- Frontmatter MUST be the first content in the file
- Content MUST use XML tags for organization
- At least one example MUST be provided
</validation>