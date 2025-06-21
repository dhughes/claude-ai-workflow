---
applies_to:
  - file_patterns: []
  - contexts: ["rules", "meta", "enforcement"]
  - actions: ["before_any_action"]
timing: "before"
summary: "MANDATORY: Query index and load all applicable 'before' rules before taking any action"
version: "1.0.0"
---

# Rule: Always Check Before Rules For Actions

<purpose>
This meta-rule implements the "before_action" consultation process from CLAUDE.md by automatically querying the rule index to find and load all applicable rules with timing "before" or "both", ensuring no required pre-action rules are skipped.
</purpose>

<instructions>
Before taking ANY action, you MUST consult the rule index and load applicable rules:

1. **Identify action details**:
   - Action type (creating, editing, deleting, reviewing, committing, etc.)
   - Relevant contexts (git, github, rules, language, framework, etc.)
   - File patterns involved (*.js, *.rule.md, etc.)

2. **Query index for matching rules**:
   - Find rules where actions array contains your action type
   - Find rules where contexts array overlaps with your contexts
   - Find rules where file_patterns match your target files
   - Filter for timing "before" or "both"

3. **Load and execute found rules**:
   - Use Read tool to load full content of each applicable rule
   - Follow all instructions in each rule
   - Complete all requirements before proceeding

4. **Block action until compliance**:
   - Do not proceed until all before-rules are satisfied
   - Verify compliance with each rule's requirements
</instructions>

<consultation_algorithm>
```
BEFORE taking action_X on file_Y in context_Z:

    # Step 1: Extract action details
    action_type = identify_action_type(action_X)
    contexts = identify_contexts(context_Z)  
    file_patterns = identify_patterns(file_Y)
    
    # Step 2: Query loaded index for matches
    applicable_rules = []
    
    FOR each rule in rule_index:
        IF (action_type IN rule.actions OR 
            any_overlap(contexts, rule.contexts) OR
            any_match(file_patterns, rule.file_patterns)) AND
            rule.timing IN ["before", "both"]:
            applicable_rules.append(rule)
    
    # Step 3: Load and execute each applicable rule
    FOR each rule in applicable_rules:
        rule_content = Read(rule.filename)
        execute_rule_instructions(rule_content)
        verify_rule_compliance(rule_content)
    
    # Step 4: Only now proceed with action
    IF all_rules_satisfied:
        PROCEED with action_X
    ELSE:
        STOP "Before-rules not satisfied"
```
</consultation_algorithm>

<action_identification>
**How to identify action details:**

**Action Types:**
- creating (files, directories, content)
- editing (modifying existing files)  
- deleting (removing files/content)
- reviewing_pr (PR review activities)
- committing (git commit operations)
- merging_pr (PR merge operations)
- before_commit, after_commit, etc.

**Context Identification:**
- Programming language: javascript, python, swift, etc.
- Tools: git, github, npm, etc.
- Frameworks: react, node, etc.
- Domains: testing, security, performance, etc.

**File Pattern Matching:**
- Exact: "specific-file.js"
- Extensions: "*.js", "*.rule.md"  
- Paths: "src/**/*.js", "test/*.py"
- Globs: "**/*.test.js"
</action_identification>

<examples>
<correct>
Before creating a JavaScript file:
```bash
# Action: creating
# Context: javascript, frontend
# File pattern: *.js

# Query index for applicable rules:
# Found: javascript-style-always-use-semicolons.rule.md (before)
# Found: git-branching-always-create-branch-before-file-modifications.rule.md (before)

# Load and follow each rule:
Read file_path=".claude/rules/javascript-style-always-use-semicolons.rule.md"
# Follow semicolon requirements

Read file_path=".claude/rules/git-branching-always-create-branch-before-file-modifications.rule.md"  
# Verify not on main branch, create branch if needed

# All before-rules satisfied, now proceed with file creation
```

Before reviewing a PR:
```bash
# Action: reviewing_pr
# Context: github, pr, review
# File pattern: (none specific)

# Query index for applicable rules:
# Found: gh-pr-review-always-fetch-pr-details-first.rule.md (before)
# Found: gh-pr-review-always-enforce-mandatory-api-workflow.rule.md (before)

# Load and follow each rule:
Read file_path=".claude/rules/gh-pr-review-always-fetch-pr-details-first.rule.md"
# Execute gh auth, gh pr view, gh pr diff commands

Read file_path=".claude/rules/gh-pr-review-always-enforce-mandatory-api-workflow.rule.md"
# Verify API workflow setup

# All before-rules satisfied, now proceed with review
```
</correct>

<incorrect>
Taking action without rule consultation:
```bash
# ❌ WRONG - creating file without checking applicable rules
touch new-component.js  # Should have checked for git branching rules, style rules, etc.
```

Assuming no rules apply without checking:
```bash
# ❌ WRONG - proceeding without querying index
# "This seems simple, probably no rules apply"
# Must check index regardless of perceived simplicity
```

Partial rule consultation:
```bash
# ❌ WRONG - only checking some rule types
# Checked git rules but missed style rules
# Must check ALL applicable rule categories
```
</incorrect>
</examples>

<rule_loading_process>
**When loading applicable rules:**

1. **Use Read tool for each rule file**:
   ```bash
   Read file_path=".claude/rules/[rule-filename].rule.md"
   ```

2. **Parse rule content for instructions**:
   - Look for `<instructions>` section
   - Note any `<requirements>` or `<mandatory>` sections
   - Identify specific actions to take

3. **Execute rule requirements**:
   - Follow step-by-step instructions
   - Complete all mandatory actions
   - Verify compliance before proceeding

4. **Document rule compliance**:
   - Note which rules were loaded and followed
   - Confirm all requirements met
</rule_loading_process>

<integration>
This rule depends on:
- `rules-meta-always-ensure-index-loaded-before-actions.rule.md` for index availability

This rule enables:
- All domain-specific "before" rules to be automatically discovered and executed
- Consistent rule consultation regardless of action complexity
- Just-in-time rule loading without relying on memory
</integration>

<validation>
Before-rule consultation complete when:
- [ ] Action type, contexts, and file patterns identified
- [ ] Index queried for all matching "before"/"both" rules
- [ ] Each applicable rule loaded using Read tool
- [ ] All rule instructions followed and requirements met
- [ ] Compliance verified for each loaded rule
- [ ] No applicable before-rules skipped or ignored
- [ ] Ready to proceed with confidence that pre-conditions are met
</validation>