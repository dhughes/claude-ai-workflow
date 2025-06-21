---
applies_to:
  - file_patterns: ["*.rule.md"]
  - contexts: ["rules", "meta", "indexing"]
  - actions: ["creating", "editing"]
timing: "after"
summary: "Always reload the rule index after creating or editing any rule file"
version: "1.0.0"
---

# Rule: Always Reload Rule Index After Rule Changes

<purpose>
This rule ensures that the rule index is immediately updated whenever rule files are created or modified, keeping the rule system current and preventing Claude from operating with stale rule information.
</purpose>

<instructions>
After creating or editing ANY rule file (*.rule.md), you MUST:

1. IMMEDIATELY run the rule indexing command:
   ```bash
   .claude/scripts/index-rules.sh
   ```

2. VERIFY the indexing completed successfully by checking the output

3. APPLY any "after_indexing" rules that may have been triggered

4. UPDATE your internal rule mapping with the new index information

This applies to:
- Creating new rule files
- Editing existing rule files
- Any modifications to *.rule.md files
- Even minor changes like typo fixes or version updates
</instructions>

<rationale>
The rule index must stay current because:
- Claude relies on the index to find applicable rules
- New rules won't be discovered without reindexing
- Modified rules might have changed their applicability
- Stale indexes can cause rules to be missed or misapplied
- The index is used for rule enforcement and validation
- Other rules depend on accurate rule discovery
</rationale>

<timing_requirements>
The reindexing MUST happen:
- IMMEDIATELY after any rule file changes
- BEFORE continuing with other work
- BEFORE applying rules that might use the updated index
- AFTER the file changes are complete but BEFORE moving to other tasks
</timing_requirements>

<examples>
<correct>
After creating a new rule:
```bash
# Just finished creating new-rule.rule.md
.claude/scripts/index-rules.sh
# Index updated successfully, found 8 rules
# Now continuing with other work...
```

After editing an existing rule:
```bash
# Just finished editing existing-rule.rule.md to fix typo
.claude/scripts/index-rules.sh
# Index updated successfully, found 8 rules
# Continue with next task...
```

After updating rule version:
```bash
# Just updated version in rule frontmatter
.claude/scripts/index-rules.sh
# Index updated, version change reflected
# Ready for next action...
```
</correct>

<incorrect>
Forgetting to reindex after rule creation:
```bash
# Created new rule file
# Immediately started other work without reindexing
# Risk: New rule won't be discovered by rule system
```

Reindexing much later:
```bash
# Modified rule file
# Did several other tasks
# Finally remembered to reindex
# Risk: Operated with stale rule information
```

Partial reindexing:
```bash
# Modified rule file
# Started reindexing command but interrupted it
# Risk: Index may be incomplete or corrupted
```
</incorrect>
</examples>

<validation>
After reindexing, verify:
- [ ] The .claude/scripts/index-rules.sh command completed without errors
- [ ] The output shows the correct number of rules indexed
- [ ] Any new rules appear in the index output
- [ ] Modified rules show updated information
- [ ] No error messages or warnings in the output
- [ ] The index appears complete and current
</validation>

<error_handling>
If reindexing fails:
1. Check the error message for specific issues
2. Verify the rule file syntax is correct
3. Ensure the rule file is in the correct location (.claude/rules/)
4. Fix any syntax errors in the rule file
5. Retry the indexing command
6. Do not proceed with other work until indexing succeeds
</error_handling>

<integration_with_other_rules>
This rule works with:
- workflow-indexing-always-celebrate-after-reading-rules.rule.md (celebration after)
- rules-enforcement-always-check-and-follow-all-rules.rule.md (rule discovery)
- All other rules that depend on accurate rule indexing

The celebration rule may trigger after reindexing, which is expected behavior.
</integration_with_other_rules>