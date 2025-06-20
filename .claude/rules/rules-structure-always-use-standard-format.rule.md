---
applies_to:
  - file_patterns: ["*.rule.md"]
  - contexts: ["rules", "meta"]
  - actions: ["creating", "editing"]
timing: "before"
summary: "Always structure rules with YAML frontmatter followed by detailed content"
---

# Rule: Always Use Standard Format for Rules

## Description

When creating or editing any rule file, always structure it with YAML frontmatter at the top, followed by the detailed rule content.

## Required Structure

Every rule file MUST follow this exact structure:

1. **YAML Frontmatter** (between `---` markers):
   - `applies_to`: Conditions when this rule applies
     - `file_patterns`: Array of glob patterns for files this rule applies to
     - `contexts`: Array of domains/areas this rule relates to
     - `actions`: Array of actions that trigger this rule (creating, editing, deleting, etc.)
   - `timing`: When the rule should be evaluated ("before", "after", or "both")
   - `summary`: One-line description of what the rule enforces

2. **Detailed Content** (after frontmatter):
   - Rule title as H1
   - Description section
   - Detailed requirements
   - Examples if applicable
   - Any additional guidance

## Example

```markdown
---
applies_to:
  - file_patterns: ["*_spec.rb", "spec/**/*.rb"]
  - contexts: ["testing", "rspec", "ruby"]
  - actions: ["editing", "creating"]
timing: "before"
summary: "Always structure RSpec tests using four-phase pattern"
---

# Rule: Always Use Four-Phase Test Structure in RSpec

## Description
[Detailed description here]

## Requirements
[Specific requirements here]
```

## Validation

- The YAML frontmatter MUST be valid YAML
- All required fields must be present
- The frontmatter must be the first content in the file
- There must be exactly one blank line between the closing `---` and the rule content