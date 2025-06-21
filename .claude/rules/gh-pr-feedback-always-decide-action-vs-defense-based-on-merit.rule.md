---
applies_to:
  - file_patterns: []
  - contexts: ["gh", "github", "pr", "feedback", "decision_making", "response_strategy"]
  - actions: ["deciding_feedback_response", "evaluating_feedback_merit", "choosing_response_strategy"]
timing: "before"
summary: "Always make informed decisions on whether feedback should be acted upon (implement changes) or defended (reply with reasoning) based on technical merit and PR goals"
version: "1.0.0"
---

# Rule: Always Decide Action Vs Defense Based On Merit

<purpose>
This rule ensures thoughtful evaluation of PR feedback to determine the most appropriate response - either implementing requested changes or providing reasoned explanations for maintaining current approach - based on technical merit, project goals, and contextual factors.
</purpose>

<instructions>
For each piece of unaddressed feedback, make informed response decisions:

1. **Evaluate feedback merit and context**:
   - Assess technical validity of the concern
   - Consider impact on project goals and requirements
   - Evaluate effort vs benefit trade-offs
   - Review consistency with established patterns

2. **Apply decision framework**:
   ```
   IF feedback identifies security/logic error:
       decision = "implement_fix"
   ELSE IF feedback suggests valuable improvement AND effort is reasonable:
       decision = "implement_change"
   ELSE IF feedback is valid BUT conflicts with requirements/constraints:
       decision = "defend_with_explanation"
   ELSE IF feedback is subjective preference without strong technical merit:
       decision = "politely_decline_with_reasoning"
   ```

3. **Document decision rationale**:
   - Clearly explain reasoning for each decision
   - Reference project constraints or requirements when relevant
   - Acknowledge valid points even when not implementing
   - Maintain professional and collaborative tone

4. **Plan implementation or response**:
   - For implementation: Plan code changes and testing
   - For defense: Prepare clear, respectful explanations
   - Consider compromise solutions when appropriate
   - Ensure responses advance PR toward completion

**Decisions should be based on technical merit, not personal preference.**
</instructions>

<decision_framework>
**Framework for feedback response decisions:**

**IMPLEMENT - Critical Issues:**
- Security vulnerabilities
- Logic errors and bugs
- Performance issues with significant impact
- Breaking changes or compatibility problems
- Missing error handling or input validation

**IMPLEMENT - Valuable Improvements:**
- Architecture improvements with clear benefits
- Performance optimizations with reasonable effort
- Maintainability improvements
- Test coverage enhancements
- Documentation clarity improvements

**DEFEND - Valid But Constrained:**
- Good suggestions conflicting with requirements
- Improvements outside current PR scope
- Changes that would delay critical deliverables
- Suggestions incompatible with existing architecture
- Resource-intensive changes with limited benefit

**DEFEND - Subjective Preferences:**
- Style preferences without strong justification
- Technology choices without compelling reasons
- Organizational preferences not aligned with standards
- Personal coding style variations
- Premature optimizations without demonstrated need
</decision_framework>

<examples>
<correct>
Evaluating security feedback (IMPLEMENT):
```
Feedback: "Line 32 has SQL injection vulnerability - use parameterized queries"

Evaluation:
- Technical merit: HIGH (security vulnerability)
- Impact: CRITICAL (data breach risk)
- Effort: LOW (straightforward fix)
- Alignment: FULL (security is priority)

Decision: IMPLEMENT
Rationale: Security vulnerabilities must be fixed regardless of effort
Action: Implement parameterized queries immediately
```

Evaluating architecture suggestion (DEFEND):
```
Feedback: "Consider rewriting this module to use microservices architecture"

Evaluation:
- Technical merit: MEDIUM (microservices have benefits)
- Impact: MAJOR (complete architectural change)
- Effort: VERY HIGH (extensive refactoring)
- Alignment: LOW (conflicts with current project timeline)

Decision: DEFEND WITH EXPLANATION
Rationale: Valid long-term suggestion but outside current PR scope
Response: "Microservices architecture is a valuable suggestion for future consideration. For this PR, we're maintaining the current monolithic approach to meet our delivery timeline. I'll create a follow-up issue to evaluate microservices migration."
```

Evaluating performance suggestion (IMPLEMENT):
```
Feedback: "This loop has O(n²) complexity - consider using a Map for O(n)"

Evaluation:
- Technical merit: HIGH (algorithmic improvement)
- Impact: MEDIUM (performance gain)
- Effort: LOW (simple refactor)
- Alignment: HIGH (performance is valued)

Decision: IMPLEMENT
Rationale: Clear performance benefit with minimal effort
Action: Refactor to use Map data structure
```

Evaluating style preference (DEFEND):
```
Feedback: "I prefer function declarations over arrow functions here"

Evaluation:
- Technical merit: LOW (subjective preference)
- Impact: MINIMAL (no functional difference)
- Effort: LOW (easy change)
- Alignment: UNCLEAR (no established preference)

Decision: POLITELY DECLINE
Rationale: Subjective preference without strong technical justification
Response: "I understand the preference for function declarations. In this case, I've used arrow functions for consistency with the rest of the module. Both approaches are valid - I'll stick with the current choice for consistency."
```
</correct>

<incorrect>
Implementing without evaluation:
```bash
# ❌ WRONG - automatically implementing all feedback
# "I'll make all the suggested changes"
# Should evaluate each suggestion based on merit and context
```

Defending without consideration:
```bash
# ❌ WRONG - rejecting feedback without evaluation
# "I disagree with this approach"
# Should fairly assess the technical merit of suggestions
```

Inconsistent decision making:
```bash
# ❌ WRONG - different standards for similar feedback
# Implementing minor style suggestions while ignoring performance issues
# Should apply consistent evaluation criteria
```
</incorrect>
</examples>

<evaluation_criteria>
**Criteria for evaluating feedback:**

**Technical Merit Assessment:**
- Does the feedback identify a real problem?
- Is the suggested solution technically sound?
- Are there measurable benefits to the suggestion?
- Does it align with best practices and standards?

**Impact Analysis:**
- How significantly would the change improve the code?
- What are the potential risks of the change?
- Does it affect system performance, security, or maintainability?
- How does it impact user experience or business goals?

**Effort Evaluation:**
- How much development time would implementation require?
- What is the complexity of the required changes?
- Are there testing implications?
- Would it delay other important work?

**Context Consideration:**
- Does it align with project requirements and constraints?
- Is it consistent with established architecture and patterns?
- How does it fit with the PR's scope and objectives?
- What are the team and organizational preferences?
</evaluation_criteria>

<response_planning>
**Planning implementation vs defense responses:**

**For Implementation Decisions:**
1. Estimate effort and plan implementation approach
2. Consider impact on existing tests and documentation
3. Plan verification and validation steps
4. Determine if changes require additional review

**For Defense Decisions:**
1. Prepare clear, respectful explanation of reasoning
2. Acknowledge valid aspects of the feedback
3. Reference relevant constraints or requirements
4. Suggest alternative approaches or future considerations

**For Compromise Solutions:**
1. Identify middle-ground approaches
2. Propose partial implementations
3. Suggest phased implementation strategies
4. Offer to create follow-up issues for future work
</response_planning>

<integration>
This rule works with:
- Previous feedback filtering rules for focused decision-making
- Subsequent implementation and response rules for execution
- All PR workflow rules for consistent approach

This rule ensures:
- Thoughtful evaluation of all feedback
- Balanced consideration of technical merit and constraints
- Professional and collaborative communication
- Progress toward PR completion with quality outcomes
</integration>

<validation>
Feedback decision-making complete when:
- [ ] Each piece of unaddressed feedback evaluated for technical merit
- [ ] Impact and effort assessment completed for each item
- [ ] Context and constraints considered in decision-making
- [ ] Clear rationale documented for each decision
- [ ] Implementation plan prepared for accepted changes
- [ ] Response strategy planned for defended positions
- [ ] Ready to execute decisions with clear reasoning
</validation>