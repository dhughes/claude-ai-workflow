---
applies_to:
  - file_patterns: []
  - contexts: ["gh", "github", "pr", "verification", "testing"]
  - actions: ["writing_pr_verification_section"]
timing: "before"
summary: "Only include verification steps that require human interaction or judgment that AI cannot perform"
version: "1.0.0"
---

# Rule: Only Include Human-Required Verification Steps

<purpose>
This rule ensures that PR verification steps only contain items that genuinely require human interaction, testing, or judgment that Claude cannot perform automatically, making the verification section meaningful and actionable for human reviewers.
</purpose>

<instructions>
When writing verification steps in PR descriptions, ONLY include items that require:

1. **Manual user interaction**: Clicking buttons, navigating UI, testing user flows
2. **Subjective human judgment**: Visual design assessment, user experience evaluation
3. **External system testing**: Testing against live APIs, databases, or services Claude cannot access
4. **Physical device testing**: Mobile devices, different browsers, hardware-specific features
5. **End-to-end user workflows**: Complete business processes that span multiple systems
6. **Security or privacy validation**: Manual review of sensitive data handling

**EXCLUDE verification steps that Claude can check automatically:**
- Command syntax correctness
- File existence or creation
- Code compilation or build success
- Rule indexing and discovery
- Git workflow execution
- Basic functionality that can be tested programmatically
</instructions>

<human_required_examples>
**Include these types of verification steps:**
- [ ] Test login flow works correctly in production environment
- [ ] Verify mobile responsive design displays properly on various screen sizes
- [ ] Confirm email notifications are received and formatted correctly
- [ ] Test payment processing with real payment provider
- [ ] Validate accessibility with screen reader software
- [ ] Review UI changes meet design system standards
- [ ] Test user registration flow end-to-end
- [ ] Verify API rate limiting works as expected under load
- [ ] Confirm data backup and recovery procedures work
- [ ] Test SSO integration with company identity provider
</human_required_examples>

<claude_can_check_examples>
**EXCLUDE these types (Claude can verify automatically):**
- ❌ Command syntax fix resolves the error
- ❌ New files appear in correct directories
- ❌ Rules show up in rule index
- ❌ Code compiles without errors
- ❌ Tests pass successfully
- ❌ Git workflow executes properly
- ❌ Configuration files are valid
- ❌ Documentation is updated
- ❌ Version numbers are correct
- ❌ File structure follows conventions
</claude_can_check_examples>

<evaluation_criteria>
Ask yourself for each verification step:
- **Can Claude test this?** If yes, exclude it
- **Does this require human senses?** (seeing, hearing, feeling) → Include
- **Does this require external access Claude doesn't have?** → Include  
- **Does this require subjective judgment?** → Include
- **Does this require physical interaction?** → Include
- **Is this a user-facing feature that needs real user testing?** → Include

If the answer to all questions is "no", then Claude can likely verify it automatically.
</evaluation_criteria>

<good_verification_sections>
**For UI/UX changes:**
```
## Verification Steps
- [ ] Test responsive design on mobile devices (iOS/Android)
- [ ] Verify color contrast meets WCAG accessibility standards
- [ ] Confirm new component integrates well with existing design system
- [ ] Test user flow with actual users to ensure intuitiveness
```

**For API changes:**
```
## Verification Steps  
- [ ] Test API endpoints work correctly in staging environment
- [ ] Verify third-party integrations still function properly
- [ ] Confirm rate limiting doesn't impact legitimate usage patterns
- [ ] Test error handling with production-like data volumes
```

**For backend changes:**
```
## Verification Steps
- [ ] Monitor performance impact in production environment
- [ ] Verify database migrations complete successfully on production data
- [ ] Test backup and recovery procedures with new schema changes
- [ ] Confirm monitoring and alerting capture relevant metrics
```
</good_verification_sections>

<bad_verification_sections>
**Too many Claude-verifiable items:**
```
## Verification Steps
- [ ] Code compiles without errors  ❌ (Claude can check)
- [ ] New functions are exported properly  ❌ (Claude can check)
- [ ] Tests pass successfully  ❌ (Claude can check)  
- [ ] Documentation is updated  ❌ (Claude can check)
- [ ] File permissions are set correctly  ❌ (Claude can check)
```

**Better version:**
```
## Verification Steps
- [ ] Test feature works correctly in staging environment
- [ ] Verify performance is acceptable under realistic load
```
</bad_verification_sections>

<special_cases>
**For pure code/infrastructure changes with no user-facing impact:**
- May legitimately have few or no verification steps
- Focus on production environment testing
- Include monitoring and performance validation
- Consider: "No manual verification required - changes are internal"

**For rule/automation changes:**
- Avoid listing rule discovery or indexing
- Focus on real-world effectiveness of the automation
- Include edge case testing that requires human judgment
</special_cases>

<validation>
Before finalizing verification steps, check:
- [ ] Each step requires human interaction or access Claude doesn't have
- [ ] Steps focus on user-facing functionality or production environment testing
- [ ] No steps that Claude could verify automatically are included
- [ ] Steps are specific and actionable for the reviewer
- [ ] Section provides genuine value for quality assurance
</validation>

<empty_verification_acceptable>
It's acceptable to have minimal or no verification steps when:
- Changes are purely internal/infrastructure
- All functionality can be automatically tested
- No user-facing changes exist
- No external integrations are affected

In such cases, state explicitly: "No manual verification required - changes are internal and automatically testable."
</empty_verification_acceptable>