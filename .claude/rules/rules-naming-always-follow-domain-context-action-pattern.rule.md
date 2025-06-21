---
timing: "before"
applies_to:
  - file_patterns: ["*.rule.md"]
  - contexts: ["rules", "meta", "naming"]
  - actions: ["creating"]
action: "Rule filenames must follow [domain]-[context]-[directive-action].rule.md pattern"
---

<purpose>
This rule ensures rule filenames are self-documenting and form complete, actionable instructions that can be understood without opening the file, enabling efficient rule discovery and application.
</purpose>

<condition>
When creating a rule file
</condition>

<instructions>
1. START by identifying the domain area
2. SPECIFY the context within that domain
3. FORMULATE a clear directive using imperative verbs:
   - always-[action]
   - never-[action]
   - must-[action]
   - avoid-[action]
4. COMBINE using hyphens only (no underscores or camelCase)
5. ENSURE lowercase throughout
6. END with `.rule.md` extension
7. VERIFY the complete filename reads as a clear instruction
</instructions>

<detail>
CRITICAL: The filename pattern is `[domain]-[context]-[directive-action].rule.md`

Components:
- Domain: The broad area (testing, git, swift, workflow, rules, security, etc.)
- Context: The specific tool/framework/situation (rspec, commits, swiftui, naming, etc.)
- Directive-action: The imperative instruction (always-use-x, never-do-y, prefer-x-over-y)

Examples:
- `testing-rspec-always-use-four-phase-structure.rule.md`
- `git-commits-never-commit-sensitive-data.rule.md`
- `swift-optionals-prefer-guard-over-if-let.rule.md`

CRITICAL: The filename must form a complete, readable instruction when read.
</detail>