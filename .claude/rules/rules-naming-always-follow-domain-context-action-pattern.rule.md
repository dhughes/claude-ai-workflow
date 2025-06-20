---
applies_to:
  - file_patterns: ["*.rule.md"]
  - contexts: ["rules", "meta", "naming"]
  - actions: ["creating"]
timing: "before"
summary: "Rule filenames must follow [domain]-[context]-[directive-action].rule.md pattern"
---

# Rule: Always Follow Domain-Context-Action Pattern for Rule Names

## Description

All rule files must follow a specific naming convention that makes the rule's purpose clear from the filename alone. The filename should read as a complete, actionable instruction.

## Naming Pattern

`[domain]-[context]-[directive-action].rule.md`

Where:
- **domain**: The broad area the rule applies to (e.g., testing, git, swift, workflow, rules)
- **context**: The specific tool, framework, or situation (e.g., rspec, commits, swiftui, naming)
- **directive-action**: The actual rule/behavior in imperative form (e.g., always-use-four-phase-structure, never-force-push)

## Requirements

1. **Readable as a sentence**: The filename should form a logical instruction when read
2. **Use hyphens**: All parts should be connected with hyphens, no underscores or camelCase
3. **Lowercase only**: All parts of the filename should be lowercase
4. **End with .rule.md**: Every rule file must have the `.rule.md` extension
5. **Action-oriented**: The directive-action part should be imperative (always-do-x, never-do-y, prefer-x-over-y)

## Valid Examples

✅ `testing-rspec-always-use-four-phase-structure.rule.md`
✅ `git-commits-always-sign-commits.rule.md`
✅ `swift-optionals-prefer-guard-over-if-let.rule.md`
✅ `workflow-pr-never-merge-without-approval.rule.md`
✅ `rules-structure-always-use-standard-format.rule.md`

## Invalid Examples

❌ `rspec-testing.rule.md` (missing directive-action)
❌ `TestingRspecFourPhase.rule.md` (wrong case, missing hyphens)
❌ `testing_rspec_structure.rule.md` (underscores instead of hyphens)
❌ `testing-rspec.md` (missing .rule extension)
❌ `use-four-phase-tests.rule.md` (missing domain and context)