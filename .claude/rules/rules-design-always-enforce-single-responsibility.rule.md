---
applies_to:
  - file_patterns: ["*.rule.md"]
  - contexts: ["rules", "meta", "design", "validation"]
  - actions: ["creating"]
timing: "before"
action: "Enforce single responsibility - each rule handles one concept with related actions allowed"
---

<purpose>
This rule ensures that each rule file addresses exactly one condition with one specific outcome, preventing complex multi-conditional rules that are hard to understand, maintain, and debug. It enforces the single responsibility principle for rule design.
</purpose>

<condition>
When creating any new rule file
</condition>

<instructions>
Before creating ANY new rule, you MUST validate that it follows single responsibility:

1. ANALYZE the proposed rule for violations:
   - Multiple conditions (if X OR if Y)
   - Multiple outcomes (do A, but if Z then do B)
   - Multiple DISTINCT operations (commit AND push, create AND merge)
   - Complex branching logic within a single rule
   - Multiple unrelated contexts or actions
   - Any use of "AND" or "OR" connecting different concepts in rule summaries

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

<detail>
CRITICAL: This rule is MANDATORY and cannot be overridden
CRITICAL: No exceptions for "convenience" or "related" functionality
CRITICAL: Always prefer multiple focused rules over one complex rule

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
- It handles DISTINCT operations (commit AND push are different concepts)
- The summary contains "and" connecting different concepts

ACCEPTABLE patterns (conceptually similar operations):
- File operations: create AND edit (both modify file contents)
- Related workflow actions that are part of the same logical operation
- Actions that are conceptually identical but triggered at different times

When a proposed rule violates single responsibility:
1. STOP rule creation immediately
2. EXPLAIN the violation clearly
3. IDENTIFY the separate concerns
4. SUGGEST separate rules
5. ASK for clarification
</detail>