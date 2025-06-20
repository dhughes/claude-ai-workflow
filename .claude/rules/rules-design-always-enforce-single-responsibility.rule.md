---
applies_to:
  - file_patterns: ["*.rule.md"]
  - contexts: ["rules", "meta", "design", "validation"]
  - actions: ["creating"]
timing: "before"
summary: "STRICTLY enforce single responsibility - each rule has exactly ONE action and ONE outcome"
version: "2.0.0"
---

# Rule: Always Enforce Single Responsibility in Rule Design

<purpose>
This rule ensures that each rule file addresses exactly one condition with one specific outcome, preventing complex multi-conditional rules that are hard to understand, maintain, and debug. It enforces the single responsibility principle for rule design.
</purpose>

<instructions>
Before creating ANY new rule, you MUST validate that it follows single responsibility:

1. ANALYZE the proposed rule for:
   - Multiple conditions (if X OR if Y)
   - Multiple outcomes (do A, but if Z then do B)
   - Multiple actions in applies_to (["action1", "action2"])
   - Multiple git operations (commit AND push)
   - Multiple file operations (create AND edit)
   - Complex branching logic within a single rule
   - Multiple unrelated contexts or actions
   - Any use of "AND" or "OR" in rule summaries

2. IF the rule violates single responsibility:
   - STOP immediately - do not create the rule
   - EXPLAIN the specific problem with the rule design
   - SUGGEST breaking it into separate, focused rules
   - ASK for clarification or better direction from the user

3. ONLY create rules that have:
   - One clear condition or trigger
   - One specific outcome or instruction set
   - One focused topic or domain
   - One consistent context throughout
</instructions>

<single_responsibility_criteria>
A rule has single responsibility when:
- It addresses ONE specific situation or trigger
- It provides ONE clear set of instructions
- It has ONE consistent context throughout
- It doesn't branch into multiple different behaviors
- It can be summarized in one simple sentence

A rule violates single responsibility when:
- It contains "OR" conditions for different scenarios
- It has "IF this THEN that, BUT IF other THEN different"
- It mixes multiple unrelated contexts
- It tries to handle variations of a topic in one rule
- It requires complex decision trees within the rule
- It lists multiple actions in applies_to (e.g., ["before_commit", "before_push"])
- It handles multiple git operations (commit AND push)
- It handles multiple file operations (create AND edit)
- The summary contains "and" connecting different actions
- It tries to enforce multiple different behaviors
</single_responsibility_criteria>

<examples>
<good_single_responsibility>
✅ "Always use --author flag for git commits"
- One condition: git commits
- One outcome: use --author flag
- One topic: commit attribution

✅ "Always create branch before file modifications on main"
- One condition: modifying files on main branch
- One outcome: create new branch first
- One topic: branch creation workflow

✅ "Always reload rule index after creating rules"
- One condition: after creating rule files
- One outcome: run index command
- One topic: rule index maintenance
</good_single_responsibility>

<bad_multiple_responsibility>
❌ "Never commit or push directly to main branch"
- Multiple actions: commit AND push
- Multiple git operations: mixing commit and push concerns
- Multiple enforcement points: before_commit AND before_push

❌ "Use --author for commits, but if on main branch create new branch first, and if pushing then set upstream"
- Multiple conditions: commits, main branch, pushing
- Multiple outcomes: attribution, branching, upstream
- Multiple topics: mixing commit, branch, and push concerns

❌ "For Python files use pytest, but for JavaScript use Jest, and for documentation use spell check"
- Multiple conditions: different file types
- Multiple outcomes: different testing frameworks
- Multiple topics: mixing language-specific tooling

❌ "Always commit after work, but push only if network available, and create PR if on feature branch"
- Multiple conditions: after work, network status, branch type
- Multiple outcomes: commit, conditional push, conditional PR
- Multiple topics: mixing commit, push, and PR workflows

❌ "Create or edit files only on feature branches"
- Multiple actions: create AND edit
- Should be separate rules for each operation
</bad_multiple_responsibility>

<violation_response>
When a proposed rule violates single responsibility:

1. STOP rule creation immediately
2. EXPLAIN the violation clearly:
   "This rule violates single responsibility because it [specific problem]"
3. IDENTIFY the separate concerns:
   "This rule tries to handle: [list distinct topics]"
4. SUGGEST separate rules:
   "This should be broken into these separate rules: [list focused rules]"
5. ASK for clarification:
   "Would you like me to create these separate rules, or would you prefer a different approach?"
</violation_response>

<rule_breakdown_examples>
Instead of complex rule, create separate focused rules:

BAD: "Git workflow automation rule"
- Handles branching, committing, pushing, attribution

GOOD: Four separate rules:
1. "Always create branch before file modifications"
2. "Always commit after completing tasks"  
3. "Always push after commits"
4. "Always use proper attribution in commits"

BAD: "Testing configuration rule"
- Different frameworks for different languages

GOOD: Separate rules per language:
1. "Always use pytest for Python testing"
2. "Always use Jest for JavaScript testing"
3. "Always use RSpec for Ruby testing"
</rule_breakdown_examples>

<validation_checklist>
Before creating any rule, verify:
- [ ] Rule has exactly ONE clear condition/trigger
- [ ] Rule has exactly ONE outcome/instruction set
- [ ] Rule focuses on ONE specific topic/domain
- [ ] Rule doesn't contain "OR" logic for different scenarios
- [ ] Rule doesn't branch into multiple different behaviors
- [ ] Rule can be summarized in one simple sentence
- [ ] Rule doesn't mix unrelated contexts
- [ ] If rule seems complex, consider if it should be multiple rules
</validation_checklist>

<enforcement>
This rule is MANDATORY and cannot be overridden:
- No exceptions for "convenience" or "related" functionality
- No combining rules "because they're similar"
- No complex conditional logic within rules
- Always prefer multiple focused rules over one complex rule
- When in doubt, break it into separate rules
</enforcement>