---
applies_to:
  - file_patterns: []
  - contexts: ["rules", "meta", "enforcement"]
  - actions: ["after_any_action"]
timing: "after"
summary: "MANDATORY: Query index and load all applicable 'after' rules after completing any action"
version: "1.0.0"
---

# Rule: Always Check After Rules For Actions

<purpose>
This meta-rule implements the "after_action" consultation process from CLAUDE.md by automatically querying the rule index to find and load all applicable rules with timing "after" or "both", ensuring no required follow-up actions are forgotten or skipped.
</purpose>

<instructions>
After completing ANY action, you MUST consult the rule index and execute applicable rules:

1. **Identify completed action details**:
   - Action type that was just completed (created, edited, deleted, reviewed, etc.)
   - Contexts that were involved (git, github, rules, language, etc.)
   - File patterns that were affected (*.js, *.rule.md, etc.)

2. **Query index for matching after-rules**:
   - Find rules where actions array contains your completed action type
   - Find rules where contexts array overlaps with your contexts
   - Find rules where file_patterns match your affected files
   - Filter for timing "after" or "both"

3. **Load and execute found rules**:
   - Use Read tool to load full content of each applicable rule
   - Follow all instructions in each rule
   - Complete all required follow-up actions

4. **Verify completion**:
   - Ensure all after-rules are satisfied
   - Document any follow-up actions taken
   - Confirm no required steps were missed
</instructions>

<consultation_algorithm>
```
AFTER completing action_X on file_Y in context_Z:

    # Step 1: Extract completed action details
    completed_action = identify_action_type(action_X)
    contexts = identify_contexts(context_Z)
    affected_patterns = identify_patterns(file_Y)
    
    # Step 2: Query loaded index for after-matches
    applicable_after_rules = []
    
    FOR each rule in rule_index:
        IF (completed_action IN rule.actions OR
            any_overlap(contexts, rule.contexts) OR  
            any_match(affected_patterns, rule.file_patterns)) AND
            rule.timing IN ["after", "both"]:
            applicable_after_rules.append(rule)
    
    # Step 3: Load and execute each applicable after-rule
    FOR each rule in applicable_after_rules:
        rule_content = Read(rule.filename)
        execute_rule_follow_up_actions(rule_content)
        verify_rule_completion(rule_content)
    
    # Step 4: Confirm all follow-ups complete
    IF all_after_rules_satisfied:
        COMPLETE "All follow-up actions completed"
    ELSE:
        CONTINUE "Additional follow-up actions required"
```
</consultation_algorithm>

<common_after_actions>
**Typical follow-up actions enforced by after-rules:**

**After file creation/editing:**
- git-workflow-always-commit-after-completing-batch-work.rule.md
- rules-indexing-always-reload-after-rule-changes.rule.md (for rule files)

**After commits:**
- git-push-always-push-after-commits.rule.md

**After PR merge:**
- git-workflow-always-switch-to-main-after-pr-merge.rule.md

**After rule changes:**
- rules-indexing-always-reload-after-rule-changes.rule.md

**After completing user requests:**
- git-workflow-always-commit-after-completing-batch-work.rule.md
</common_after_actions>

<examples>
<correct>
After creating rule files:
```bash
# Completed action: creating
# Context: rules, meta
# File pattern: *.rule.md

# Query index for applicable after-rules:
# Found: rules-indexing-always-reload-after-rule-changes.rule.md (after)
# Found: git-workflow-always-commit-after-completing-batch-work.rule.md (after)

# Load and follow each after-rule:
Read file_path=".claude/rules/rules-indexing-always-reload-after-rule-changes.rule.md"
# Execute: .claude/scripts/index-rules.sh

Read file_path=".claude/rules/git-workflow-always-commit-after-completing-batch-work.rule.md"  
# Execute: git add, git commit, git push

# All after-rules satisfied, work complete
```

After making git commits:
```bash
# Completed action: committing
# Context: git, workflow
# File pattern: (various)

# Query index for applicable after-rules:
# Found: git-push-always-push-after-commits.rule.md (after)

# Load and follow after-rule:
Read file_path=".claude/rules/git-push-always-push-after-commits.rule.md"
# Execute: git push --set-upstream origin branch-name

# All after-rules satisfied, commits properly pushed
```

After completing user request:
```bash
# Completed action: after_completing_user_request
# Context: workflow, task_completion
# File pattern: (various files modified)

# Query index for applicable after-rules:
# Found: git-workflow-always-commit-after-completing-batch-work.rule.md (after)

# Load and follow after-rule:
Read file_path=".claude/rules/git-workflow-always-commit-after-completing-batch-work.rule.md"
# Execute: git add ., git commit, git push

# All after-rules satisfied, work properly saved
```
</correct>

<incorrect>
Completing action without checking after-rules:
```bash
# ❌ WRONG - created files but didn't check for follow-up requirements
# Files created successfully... moving on
# Should have checked for commit rules, indexing rules, etc.
```

Assuming no follow-up needed:
```bash
# ❌ WRONG - finished work without querying index
# "That's done, nothing else needed"  
# Must check index for after-rules regardless
```

Partial after-rule execution:
```bash
# ❌ WRONG - executed some after-rules but missed others
# Committed changes but didn't push
# Didn't reindex after creating rule files
```
</incorrect>
</examples>

<critical_after_rules>
**After-rules that are frequently missed:**

1. **Commit and push rules**: After any file modifications
2. **Index reload rules**: After creating or editing *.rule.md files  
3. **Branch switching rules**: After PR merges
4. **Update rules**: After pushing to PR branches

**These rules prevent:**
- Lost work (uncommitted changes)
- Stale rule index (outdated rule mappings)
- Wrong branch state (staying on feature branch after merge)
- Incomplete workflows (commits without pushes)
</critical_after_rules>

<timing_considerations>
**When to trigger after-rule consultation:**

**Immediately after:**
- Creating any files
- Editing any files
- Completing git operations
- Finishing PR reviews
- Completing user requests
- Any logical task completion

**Not triggered by:**
- Read-only operations (Read tool, ls, grep)
- Intermediate steps within larger actions
- Planning or thinking activities
</timing_considerations>

<integration>
This rule works with:
- `rules-meta-always-ensure-index-loaded-before-actions.rule.md` for index access
- `rules-meta-always-check-before-rules-for-actions.rule.md` for complete rule coverage

This rule ensures:
- Follow-up actions are never forgotten
- Workflows are completed properly  
- Changes are persisted (committed/pushed)
- System state remains consistent
</integration>

<validation>
After-rule consultation complete when:
- [ ] Completed action type, contexts, and affected files identified
- [ ] Index queried for all matching "after"/"both" rules
- [ ] Each applicable after-rule loaded using Read tool
- [ ] All rule follow-up instructions executed
- [ ] Required actions completed (commits, pushes, index reloads, etc.)
- [ ] No applicable after-rules skipped or ignored
- [ ] System left in proper state for next actions
</validation>