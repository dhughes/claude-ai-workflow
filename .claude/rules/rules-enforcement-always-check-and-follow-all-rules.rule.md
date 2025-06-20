---
applies_to:
  - file_patterns: []
  - contexts: ["rules", "meta", "enforcement"]
  - actions: ["before_any_action", "after_any_action"]
timing: "both"
summary: "Always check for and follow all applicable rules before and after every action"
version: "1.0.0"
---

# Rule: Always Check and Follow All Rules

<purpose>
This meta-rule ensures that Claude systematically checks for and follows all applicable rules before and after every action, preventing rule violations through proactive enforcement.
</purpose>

<instructions>
BEFORE taking any action:
1. Identify the action type, contexts, and file patterns
2. Check the rules index for all matching rules with timing "before" or "both"
3. Read each applicable rule completely
4. Follow all rule instructions exactly
5. Document in your thinking which rules apply

AFTER completing any action:
1. Check for rules with timing "after" or "both"
2. Read and execute all post-action rules
3. Validate that all rule requirements were met
4. If any rule was violated, immediately acknowledge and correct it
</instructions>

<thinking>
For every action I take, I must think:
- What action am I about to take?
- What contexts apply?
- What file patterns are involved?
- Which rules from the index match these criteria?
- Have I read and understood all applicable rules?
- Am I following all rule requirements?
</thinking>

<examples>
<correct>
Before creating a rule file:
1. Check index for rules matching: actions: ["creating"], file_patterns: ["*.rule.md"]
2. Find: rules-location, rules-naming, rules-structure rules apply
3. Read all three rules
4. Follow their requirements when creating the file

After running index-rules.sh:
1. Check index for rules matching: actions: ["after_indexing"]
2. Find: workflow-indexing-always-celebrate rule applies
3. Read the celebration rule
4. Execute the celebration with required emojis
</correct>

<incorrect>
Creating a rule without checking:
- Just creating a rule file without checking applicable rules
- Moving on after indexing without checking for post-indexing rules
- Assuming you know what rules apply without checking the index
</incorrect>
</examples>

<validation>
- Every action MUST be preceded by rule checking
- All applicable rules MUST be loaded and read
- All rule requirements MUST be followed
- Post-action rules MUST be executed
- Rule violations MUST be immediately corrected
</validation>

Version: 1.0.0