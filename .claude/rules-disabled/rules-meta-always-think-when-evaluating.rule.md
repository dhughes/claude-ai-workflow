---
timing: "during"
applies_to:
  - file_patterns: []
  - contexts: ["rules", "meta", "evaluation", "thinking"]
  - actions: ["evaluating_rules", "checking_rules", "applying_rules", "rule_processing"]
action: "Always use thinking blocks when evaluating, checking, or applying rules"
---

<purpose>
This rule ensures that Claude Code uses explicit thinking blocks when processing rules, making the rule evaluation process transparent and systematic. This helps catch missed rules, improve compliance, and provide visibility into rule processing logic.
</purpose>

<condition>
When evaluating which rules apply, checking rule compliance, or processing rule sequences
</condition>

<instructions>
1. ALWAYS use thinking blocks when evaluating rules
2. EXPLICITLY think through which rules apply and why
3. SHOW the logical process of rule evaluation
4. THINK through rule sequences and dependencies
5. MAKE rule processing visible and systematic
</instructions>

<detail>
CRITICAL: This rule applies to all rule processing activities
CRITICAL: Thinking blocks must be used for transparency and accuracy
CRITICAL: This helps prevent missed rules like the sequencing issue identified

Rule processing includes:
- Determining which rules apply to an action
- Building rule sequences and dependencies  
- Checking rule compliance
- Applying before/after rule actions
- Evaluating rule conflicts or overlaps

The thinking process should be systematic and comprehensive to ensure no rules are missed.
</detail>