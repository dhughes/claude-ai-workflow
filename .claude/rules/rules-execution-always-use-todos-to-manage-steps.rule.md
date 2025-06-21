---
applies_to:
  - file_patterns: []
  - contexts: ["rules", "meta", "execution", "workflow"]
  - actions: ["executing_multi_step_rules", "following_rule_chains", "managing_rule_sequences"]
timing: "before"
summary: "Always use TodoWrite tool to track and manage steps when executing rules with multiple actions"
version: "1.0.0"
---

# Rule: Always Use Todos to Manage Rule Execution Steps

<purpose>
This rule ensures that when executing rules that involve multiple steps or sequential actions, the TodoWrite tool is used to track progress and prevent missing important steps like celebrating after reloading the rule index or other required follow-up actions.
</purpose>

<instructions>
When executing rules that involve multiple steps or sequential actions, you MUST:

1. **Identify multi-step scenarios**: Before starting rule execution, determine if the work involves multiple sequential steps
2. **Create todo list**: Use TodoWrite tool to create a comprehensive list of all required steps
3. **Set priorities**: Assign appropriate priorities (high, medium, low) to ensure correct execution order
4. **Track progress**: Mark todos as "in_progress" when starting each step
5. **Complete todos**: Mark each todo as "completed" immediately after finishing that step
6. **Verify completion**: Ensure all todos are marked completed before considering the rule execution finished

Multi-step scenarios that REQUIRE todo management:
- Rule chains that trigger multiple other rules
- Complex workflows involving file operations, commits, and pushes
- Actions that require both "before" and "after" rule consultation
- Any sequence where forgetting a step would violate other rules
- Workflows involving index reloading, celebration, and follow-up actions
</instructions>

<step_identification>
**Common multi-step rule scenarios:**

**Rule creation workflow:**
1. Check before-rules for rule creation
2. Create the new rule file
3. Reload rule index after creation
4. Commit and push changes
5. Celebrate after indexing (if applicable)

**File modification workflow:**
1. Verify git branch status
2. Create files or make edits
3. Check after-rules for file operations
4. Commit changes with proper attribution
5. Push to remote repository

**Rule consultation workflow:**
1. Load rule index if not in memory
2. Query index for applicable before-rules
3. Execute found rules
4. Perform main action
5. Query index for applicable after-rules
6. Execute after-rules
7. Mark consultation complete
</step_identification>

<priority_guidelines>
**How to assign todo priorities:**

**High Priority:**
- Critical safety checks (git branch verification)
- Core action execution (file creation, rule creation)
- Mandatory rule compliance steps

**Medium Priority:**
- Follow-up actions (index reloading, commits)
- Documentation and cleanup steps
- Secondary validations

**Low Priority:**
- Optional enhancements
- Non-critical formatting
- Convenience actions

**Correct ordering ensures:**
- Safety checks happen before risky operations
- Core work completes before follow-up actions
- Dependencies are satisfied in proper sequence
</priority_guidelines>

<examples>
<correct>
Creating a new rule with proper todo management:
```
TodoWrite:
[
  {"id": "1", "content": "Check applicable before-rules for rule creation", "status": "pending", "priority": "high"},
  {"id": "2", "content": "Create new rule file following naming conventions", "status": "pending", "priority": "high"},
  {"id": "3", "content": "Reload rule index after creating new rule", "status": "pending", "priority": "medium"},
  {"id": "4", "content": "Commit and push changes with proper attribution", "status": "pending", "priority": "medium"},
  {"id": "5", "content": "Celebrate after successful indexing", "status": "pending", "priority": "low"}
]
```

Multi-file operation with proper sequencing:
```
TodoWrite:
[
  {"id": "1", "content": "Verify on correct git branch", "status": "pending", "priority": "high"},
  {"id": "2", "content": "Create component file", "status": "pending", "priority": "high"},
  {"id": "3", "content": "Create test file", "status": "pending", "priority": "high"},
  {"id": "4", "content": "Update documentation", "status": "pending", "priority": "medium"},
  {"id": "5", "content": "Commit all changes", "status": "pending", "priority": "medium"},
  {"id": "6", "content": "Push to remote", "status": "pending", "priority": "medium"}
]
```

Updating todos as work progresses:
```
# Starting first task
TodoWrite: [mark task 1 as "in_progress"]

# Completing first task  
TodoWrite: [mark task 1 as "completed", mark task 2 as "in_progress"]

# Continue until all completed
```
</correct>

<incorrect>
Skipping todo management for multi-step work:
```
# ❌ WRONG - Multiple steps without tracking
Create rule file
Reload index  
Commit changes
Push changes
# Risk: Forgetting celebration step, missing after-rules, etc.
```

Using todos but not updating progress:
```
# ❌ WRONG - Created todos but never marked progress
TodoWrite: [created list with 5 items]
# Performed all work but never updated todo status
# Result: No visibility into what was actually completed
```

Wrong priority ordering:
```
# ❌ WRONG - Low priority before high priority
TodoWrite:
[
  {"id": "1", "content": "Celebrate success", "status": "pending", "priority": "high"},
  {"id": "2", "content": "Create critical safety check", "status": "pending", "priority": "low"}
]
```
</incorrect>
</examples>

<benefits>
**Why todo management prevents missed steps:**

1. **Comprehensive planning**: Forces upfront thinking about all required steps
2. **Correct sequencing**: Priority system ensures proper order of operations
3. **Progress visibility**: Clear tracking of what's been completed vs. remaining
4. **Rule compliance**: Ensures after-rules and follow-up actions aren't forgotten
5. **Error prevention**: Reduces risk of skipping critical steps like celebrations
6. **Audit trail**: Provides record of work completed and process followed

**Common steps that get forgotten without todos:**
- Celebrating after rule index reloading
- Checking after-rules following main actions
- Pushing commits to remote repository
- Setting git upstream on new branches
- Including configuration files in commits
- Verifying rule compliance before proceeding
</benefits>

<minimum_complexity_threshold>
**When todo management is REQUIRED:**

Always use todos when work involves:
- 3 or more sequential steps
- Any step that triggers after-rules
- Complex rule chains or workflows  
- Operations where missing a step violates other rules
- File operations that require commits and pushes
- Rule creation that requires index reloading

**When todos may be optional:**
- Single-step actions with no follow-up
- Read-only operations
- Simple queries or information requests
- Trivial tasks with no rule implications
</minimum_complexity_threshold>

<integration>
This rule works with:
- All meta-rules about checking before/after rules
- Git workflow rules requiring commits and pushes
- Rule indexing rules requiring celebration
- Any rule that has sequential dependencies

This rule enables:
- Systematic execution of complex rule workflows
- Prevention of missed steps in rule compliance
- Clear progress tracking during multi-step operations
- Proper sequencing of rule-dependent actions
</integration>

<validation>
Todo management is complete when:
- [ ] Multi-step scenario identified before starting work
- [ ] Comprehensive todo list created with all required steps
- [ ] Priorities assigned to ensure correct execution order
- [ ] Each todo marked "in_progress" when starting that step
- [ ] Each todo marked "completed" immediately upon finishing
- [ ] All todos show "completed" status before considering work finished
- [ ] No rule-required steps were skipped or forgotten
- [ ] Follow-up actions (celebrations, after-rules) properly executed
</validation>