---
applies_to:
  - file_patterns: ["*.rule.md"]
  - contexts: ["rules", "meta", "versioning"]
  - actions: ["creating"]
timing: "before"
summary: "All new rules must start with version 1.0.0"
version: "1.0.0"
---

# Rule: Always Start New Rules at Version 1.0.0

<purpose>
This rule ensures all new rules begin with a consistent initial version number following semantic versioning, providing a clear baseline for version tracking and future updates.
</purpose>

<instructions>
When creating any new rule file:

1. ALWAYS include a version field in the YAML frontmatter
2. ALWAYS set the initial version to exactly "1.0.0"
3. NEVER start with version 0.x.x or any other version number
4. ENSURE the version field follows the format: version: "1.0.0"
5. PLACE the version field at the end of the frontmatter before the closing ---
</instructions>

<examples>
<correct>
New rule with proper initial version:
---
applies_to:
  - file_patterns: ["*.py"]
  - contexts: ["python", "testing"]
  - actions: ["creating"]
timing: "before"
summary: "Python test files must use pytest framework"
version: "1.0.0"
---

# Rule: Always Use Pytest for Python Tests

<purpose>
Ensures consistency in Python testing framework
</purpose>
</correct>

<incorrect>
Missing version field:
---
applies_to:
  - file_patterns: ["*.py"]
  - contexts: ["python", "testing"]
  - actions: ["creating"]
timing: "before"
summary: "Python test files must use pytest framework"
---

Wrong initial version:
---
applies_to:
  - file_patterns: ["*.py"]
  - contexts: ["python", "testing"]
  - actions: ["creating"]
timing: "before"
summary: "Python test files must use pytest framework"
version: "0.1.0"
---

Version not a string:
---
applies_to:
  - file_patterns: ["*.py"]
  - contexts: ["python", "testing"]
  - actions: ["creating"]
timing: "before"
summary: "Python test files must use pytest framework"
version: 1.0.0
---
</incorrect>
</examples>

<validation>
- Version field MUST be present in frontmatter
- Version value MUST be exactly "1.0.0" (quoted string)
- Version field MUST be placed at the end of frontmatter
- NO exceptions for initial version numbers
</validation>