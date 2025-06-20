---
applies_to:
  - file_patterns: ["*.rule.md"]
  - contexts: ["rules", "meta", "naming"]
  - actions: ["creating"]
timing: "before"
summary: "Rule filenames must follow [domain]-[context]-[directive-action].rule.md pattern"
version: "1.0.0"
---

# Rule: Always Follow Domain-Context-Action Pattern for Rule Names

<purpose>
This rule ensures rule filenames are self-documenting and form complete, actionable instructions that can be understood without opening the file, enabling efficient rule discovery and application.
</purpose>

<thinking>
When naming a rule file, I need to:
1. Identify the domain (broad area)
2. Identify the context (specific tool/framework)
3. Formulate a clear directive-action
4. Ensure it reads as a complete instruction
5. Verify all naming conventions are followed
</thinking>

<naming_pattern>
`[domain]-[context]-[directive-action].rule.md`

<components>
<domain>The broad area: testing, git, swift, workflow, rules, security, etc.</domain>
<context>The specific tool/framework/situation: rspec, commits, swiftui, naming, etc.</context>
<directive-action>The imperative instruction: always-use-x, never-do-y, prefer-x-over-y</directive-action>
</components>
</naming_pattern>

<instructions>
1. START by identifying the domain area
2. SPECIFY the context within that domain
3. FORMULATE a clear directive using imperative verbs:
   - always-[action]
   - never-[action]
   - prefer-[x]-over-[y]
   - must-[action]
   - avoid-[action]
4. COMBINE using hyphens only (no underscores or camelCase)
5. ENSURE lowercase throughout
6. END with `.rule.md` extension
7. VERIFY the complete filename reads as a clear instruction
</instructions>

<validation_checklist>
<check>Does the filename form a complete, readable instruction?</check>
<check>Are all three components (domain, context, directive-action) present?</check>
<check>Is everything lowercase?</check>
<check>Are only hyphens used as separators?</check>
<check>Does it end with `.rule.md`?</check>
<check>Is the directive-action imperative and clear?</check>
</validation_checklist>

<examples>
<correct>
<example>
Filename: `testing-rspec-always-use-four-phase-structure.rule.md`
Reads as: "In testing with RSpec, always use four-phase structure"
Components: domain=testing, context=rspec, directive=always-use-four-phase-structure
</example>

<example>
Filename: `git-commits-never-commit-sensitive-data.rule.md`
Reads as: "In git commits, never commit sensitive data"
Components: domain=git, context=commits, directive=never-commit-sensitive-data
</example>

<example>
Filename: `swift-optionals-prefer-guard-over-if-let.rule.md`
Reads as: "In Swift optionals, prefer guard over if-let"
Components: domain=swift, context=optionals, directive=prefer-guard-over-if-let
</example>

<example>
Filename: `workflow-pr-must-include-tests.rule.md`
Reads as: "In workflow for PRs, must include tests"
Components: domain=workflow, context=pr, directive=must-include-tests
</example>

<example>
Filename: `security-api-keys-never-hardcode-credentials.rule.md`
Reads as: "In security for API keys, never hardcode credentials"
Components: domain=security, context=api-keys, directive=never-hardcode-credentials
</example>
</correct>

<incorrect>
<example>
Filename: `rspec-testing.rule.md`
Problem: Missing directive-action component
Fix: Add what to do, e.g., `testing-rspec-always-use-descriptive-names.rule.md`
</example>

<example>
Filename: `TestingRspecFourPhase.rule.md`
Problems: Wrong case (not lowercase), no hyphens, unclear directive
Fix: `testing-rspec-always-use-four-phase-structure.rule.md`
</example>

<example>
Filename: `testing_rspec_structure.rule.md`
Problem: Uses underscores instead of hyphens
Fix: `testing-rspec-always-follow-structure.rule.md`
</example>

<example>
Filename: `use-four-phase-tests.rule.md`
Problem: Missing domain and context
Fix: `testing-rspec-always-use-four-phase-tests.rule.md`
</example>

<example>
Filename: `git-commits.rule.md`
Problem: Missing directive-action
Fix: Add specific instruction, e.g., `git-commits-always-write-clear-messages.rule.md`
</example>
</incorrect>
</examples>

<rejection_message>
When rejecting invalid rule names:
"Rule filename must follow pattern: [domain]-[context]-[directive-action].rule.md
Example: testing-rspec-always-use-four-phase-structure.rule.md
Your filename should form a complete instruction when read."
</rejection_message>