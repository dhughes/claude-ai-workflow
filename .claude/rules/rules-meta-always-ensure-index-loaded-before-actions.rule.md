---
applies_to:
  - file_patterns: []
  - contexts: ["rules", "meta", "enforcement"]
  - actions: ["before_any_action", "starting_any_task"]
timing: "before"
summary: "MANDATORY: Ensure rule index is loaded in memory before taking any action"
version: "1.0.0"
---

# Rule: Always Ensure Index Loaded Before Actions

<purpose>
This foundational meta-rule ensures that the rule index is always loaded in memory before any action is taken, enabling just-in-time rule consultation and preventing actions from proceeding without access to applicable rules.
</purpose>

<instructions>
Before taking ANY action, you MUST verify the rule index is loaded:

1. **Check if index is in memory**: Determine if you have the current rule index available
2. **Load index if missing**: If not loaded, immediately run `.claude/scripts/index-rules.sh`
3. **Parse index into memory**: Create in-memory map of patterns → rules, contexts → rules, actions → rules
4. **Block action until loaded**: Do not proceed with any action until index is available
5. **Verify index completeness**: Ensure index contains expected rule count and structure

**This check is MANDATORY before every single action - no exceptions.**
</instructions>

<index_verification>
**How to verify index is loaded:**

1. **Mental check**: Do I have access to the current rule mappings?
2. **Content check**: Can I identify which rules apply to my next action?
3. **Freshness check**: Is my index current with the file system?

**If answer to ANY is NO, must reload index:**
```bash
.claude/scripts/index-rules.sh
```

**Index load success criteria:**
- Can identify rules by file patterns
- Can identify rules by contexts  
- Can identify rules by actions
- Can identify rules by timing
- Index reflects current file system state
</index_verification>

<blocking_mechanism>
**This rule BLOCKS all actions until index is loaded:**

```
IF attempting_any_action:
    IF NOT rule_index_loaded_in_memory:
        EXECUTE ".claude/scripts/index-rules.sh"
        PARSE index_output into memory_structures
        VERIFY index_completeness
        IF index_load_failed:
            STOP "Cannot proceed without rule index"
    PROCEED with action (other meta-rules will now check for applicable rules)
```

**NO ACTION IS PERMITTED WITHOUT A LOADED INDEX**
</blocking_mechanism>

<memory_structure>
**Index should be parsed into these lookups:**

```
file_patterns_to_rules = {
    "*.rule.md": ["rules-structure-...", "rules-naming-...", ...],
    "*.js": ["javascript-specific-rules", ...],
    etc.
}

contexts_to_rules = {
    "git": ["git-commits-...", "git-branching-...", ...],
    "pr": ["gh-pr-review-...", "gh-pr-always-...", ...],
    etc.
}

actions_to_rules = {
    "creating": ["rules-design-...", "git-branching-...", ...],
    "reviewing_pr": ["gh-pr-review-...", ...],
    etc.
}

timing_to_rules = {
    "before": ["rules that run before actions"],
    "after": ["rules that run after actions"], 
    "both": ["rules that run before and after"]
}
```
</memory_structure>

<examples>
<correct>
Starting any action with proper index check:
```bash
# Before taking action, verify index is loaded
# Mental check: Do I have rule mappings? NO
# Therefore, must load index first:

.claude/scripts/index-rules.sh
# Parse output into memory structures
# Now can proceed with action knowing rules are accessible
```

Index already loaded from previous work:
```bash
# Mental check: Do I have current rule mappings? YES
# Index loaded and current
# Proceed with action (other meta-rules will check for applicable rules)
```
</correct>

<incorrect>
Taking action without index verification:
```bash
# ❌ WRONG - starting work without checking index
touch new-file.js  # VIOLATION - index not verified first
```

Assuming index is loaded without verification:
```bash
# ❌ WRONG - proceeding on assumption
# "I think I loaded the index earlier..."
# Must verify explicitly, not assume
```
</incorrect>
</examples>

<integration>
This meta-rule enables all other rules by ensuring:
- `rules-meta-always-check-before-rules-for-actions.rule.md` has access to rule mappings
- `rules-meta-always-check-after-rules-for-actions.rule.md` can find applicable rules
- All domain-specific rules can be discovered and loaded just-in-time
- Rule consultation becomes automatic rather than memory-dependent
</integration>

<validation>
Index loading verification complete when:
- [ ] Index load command executed if needed
- [ ] Rule mappings parsed into memory structures
- [ ] File patterns → rules mapping available
- [ ] Contexts → rules mapping available  
- [ ] Actions → rules mapping available
- [ ] Timing → rules mapping available
- [ ] Index reflects current file system state
- [ ] Ready to proceed with rule-aware actions
</validation>