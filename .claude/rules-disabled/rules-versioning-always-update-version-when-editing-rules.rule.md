---
applies_to:
  - file_patterns: ["*.rule.md"]
  - contexts: ["rules", "meta", "versioning"]
  - actions: ["editing"]
timing: "before"
summary: "Update version number appropriately when editing existing rules"
version: "1.0.0"
---

# Rule: Always Update Version When Editing Rules

<purpose>
This rule ensures that rule changes are properly tracked through semantic versioning, enabling users to understand the scope and impact of rule modifications over time.
</purpose>

<instructions>
When editing any existing rule file, you MUST update the version number according to semantic versioning principles:

1. IDENTIFY the type of change being made:
   - PATCH (x.x.X): Bug fixes, typos, minor clarifications that don't change behavior
   - MINOR (x.X.x): New functionality, additional instructions, or enhanced examples that are backward compatible
   - MAJOR (X.x.x): Breaking changes that alter rule behavior or requirements

2. UPDATE the version field in the frontmatter:
   - For patch: increment the patch number (1.0.0 → 1.0.1)
   - For minor: increment the minor number, reset patch to 0 (1.0.1 → 1.1.0)
   - For major: increment the major number, reset minor and patch to 0 (1.1.0 → 2.0.0)

3. NEVER skip version updates when making changes
4. NEVER decrease version numbers
5. ALWAYS use semantic versioning format (MAJOR.MINOR.PATCH)
</instructions>

<change_types>
<patch_changes>
- Fixing typos or grammar
- Adding clarifying examples that don't change requirements
- Reformatting without changing content
- Minor wording improvements that don't alter meaning
</patch_changes>

<minor_changes>
- Adding new examples that enhance understanding
- Adding new validation checks that don't break existing compliance
- Expanding instructions with additional guidance
- Adding new optional requirements
</minor_changes>

<major_changes>
- Changing rule requirements that break existing compliance
- Removing required fields or validation checks
- Fundamentally altering rule behavior or purpose
- Changing file patterns or contexts in ways that affect applicability
</major_changes>
</change_types>

<examples>
<correct>
Patch update (typo fix):
Before: version: "1.0.0"
After: version: "1.0.1"
Change: Fixed spelling error in instructions

Minor update (added example):
Before: version: "1.0.1"
After: version: "1.1.0"
Change: Added new example showing correct usage

Major update (changed requirement):
Before: version: "1.1.0"
After: version: "2.0.0"
Change: Changed from optional to required validation
</correct>

<incorrect>
Forgetting to update version:
Before: version: "1.0.0"
After: version: "1.0.0"
Change: Added new required field (should be 2.0.0)

Wrong version type:
Before: version: "1.0.0"
After: version: "1.1.0"
Change: Fixed typo (should be 1.0.1)

Decreasing version:
Before: version: "1.2.0"
After: version: "1.1.0"
Change: Any change (versions should never decrease)
</incorrect>
</examples>

<validation>
- Version MUST be updated for every rule edit
- Version MUST follow semantic versioning (MAJOR.MINOR.PATCH)
- Version MUST be a quoted string in YAML
- Version MUST increase from the previous version
- Version type MUST match the scope of changes made
</validation>