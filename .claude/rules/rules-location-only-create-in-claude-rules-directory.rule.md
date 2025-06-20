---
applies_to:
  - file_patterns: ["*.rule.md"]
  - contexts: ["rules", "meta", "filesystem"]
  - actions: ["creating"]
timing: "before"
summary: "Only create rule files in .claude/rules/ directory"
---

# Rule: Only Create Rules in Claude Rules Directory

## Description

Rule files must ONLY be created in the `.claude/rules/` directory. No rule files should exist anywhere else in the project structure.

## Requirements

When creating a new rule file:

1. **Location**: The file MUST be created in `.claude/rules/`
2. **Path**: The full path must be `.claude/rules/[rule-name].rule.md`
3. **No Subdirectories**: Rules should be created directly in `.claude/rules/`, not in subdirectories

## Rejected Actions

The following actions will be rejected:
- Creating a rule file in the project root
- Creating a rule file in any other directory
- Creating rule subdirectories within `.claude/rules/`

## Valid Examples

✅ `.claude/rules/testing-rspec-always-use-four-phase-structure.rule.md`
✅ `.claude/rules/git-commits-always-sign-commits.rule.md`

## Invalid Examples

❌ `rules/testing-rspec-always-use-four-phase-structure.rule.md`
❌ `.claude/testing-rules/rspec-structure.rule.md`
❌ `testing-rspec-always-use-four-phase-structure.rule.md`
❌ `.claude/rules/testing/rspec-structure.rule.md`