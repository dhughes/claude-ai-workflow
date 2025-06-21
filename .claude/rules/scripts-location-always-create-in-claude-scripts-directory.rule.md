---
applies_to:
  - file_patterns: ["*.sh", "*.py", "*.js", "*.rb", "*.pl"]
  - contexts: ["scripts", "automation", "rules", "workflow"]
  - actions: ["creating"]
timing: "before"
summary: "Always create executable scripts in .claude/scripts directory when they will be referenced by rules"
version: "1.0.0"
---

# Rule: Always Create Scripts in Claude Scripts Directory

<purpose>
This rule ensures all executable scripts that will be referenced or executed by other rules are placed in a consistent, discoverable location (.claude/scripts), preventing fragmentation of automation scripts across the codebase and enabling reliable rule-based script execution.
</purpose>

<instructions>
When creating any executable script that will be referenced by rules:

1. ALWAYS place the script in the `.claude/scripts/` directory
2. NEVER create scripts in other locations if they will be executed by rules
3. ENSURE the script file has appropriate executable permissions
4. VERIFY the script path will be `.claude/scripts/[script-name]`
5. MAKE scripts that accept parameters clearly document their interface

Examples of scripts that MUST be in .claude/scripts:
- Scripts that pull PR comments using gh api
- Scripts that process git data
- Scripts that manipulate rule indexes
- Scripts that automate workflow tasks
- Any script referenced in rule instructions
</instructions>

<validation_checks>
<check>Script file MUST be in `.claude/scripts/` directory</check>
<check>Script MUST have appropriate file extension (.sh, .py, .js, etc.)</check>
<check>Script path MUST be `.claude/scripts/[filename]`</check>
<check>No subdirectories allowed within .claude/scripts/</check>
<check>Script MUST be executable if shell script</check>
</validation_checks>

<examples>
<correct>
<example>
Path: `.claude/scripts/pull-pr-comments.sh`
Purpose: Script that accepts PR number and uses gh api to pull comments
Reason: Correct directory for rule-referenced script
</example>

<example>
Path: `.claude/scripts/index-rules.sh`
Purpose: Script that builds rule index for rule system
Reason: Automation script used by rule system
</example>

<example>
Path: `.claude/scripts/validate-commits.py`
Purpose: Script to validate commit message format
Reason: Workflow automation script referenced by git rules
</example>
</correct>

<incorrect>
<example>
Path: `scripts/pull-pr-comments.sh`
Problem: Wrong directory - must be in .claude/scripts/
Action: REJECT - Must use .claude/scripts/ directory
</example>

<example>
Path: `.claude/pull-pr-comments.sh`
Problem: Missing scripts subdirectory
Action: REJECT - Must be in .claude/scripts/ not .claude/
</example>

<example>
Path: `pull-pr-comments.sh` (in project root)
Problem: Not in designated scripts directory
Action: REJECT - All rule-referenced scripts must be in .claude/scripts/
</example>

<example>
Path: `.claude/scripts/github/pull-pr-comments.sh`
Problem: Subdirectories not allowed within .claude/scripts/
Action: REJECT - Keep scripts flat in .claude/scripts/
</example>
</incorrect>
</examples>

<script_requirements>
When creating scripts for rule execution:

1. **Parameter handling**: Scripts should clearly document expected parameters
2. **Error handling**: Scripts should handle errors gracefully and return appropriate exit codes
3. **Documentation**: Include brief comments explaining script purpose and usage
4. **Permissions**: Shell scripts should be executable (chmod +x)
5. **Portability**: Consider cross-platform compatibility when possible
</script_requirements>

<integration>
This rule works with:
- Rule system that references script execution
- Workflow automation that needs consistent script locations
- CI/CD systems that expect scripts in known locations

Scripts in .claude/scripts/ are:
- Easily discoverable by rules
- Properly organized and maintained
- Available for automation workflows
- Protected from being scattered across the codebase
</integration>

<validation>
Script creation complete when:
- [ ] Script file created in `.claude/scripts/` directory
- [ ] Script has appropriate file extension
- [ ] Script is executable if shell script (chmod +x applied)
- [ ] Script parameters and usage are documented
- [ ] Script handles errors appropriately
- [ ] Script path follows `.claude/scripts/[filename]` pattern
- [ ] No subdirectories created within .claude/scripts/
</validation>