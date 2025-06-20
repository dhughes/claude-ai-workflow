# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 🚨 MANDATORY FIRST ACTION 🚨

**STOP! You MUST run the rules indexing command BEFORE doing ANYTHING else!**
**Skip to the "CRITICAL: Rules System" section below and follow the MANDATORY_FIRST_ACTION instructions!**

## Project Overview

This project is focused on building a rules scheme that allows customization of Claude Code's behavior and working patterns.

## CRITICAL: Rules System

<critical_instructions>
YOU MUST FOLLOW THESE INSTRUCTIONS ON EVERY INTERACTION:

<MANDATORY_FIRST_ACTION>
⚠️ STOP! BEFORE DOING ANYTHING ELSE, YOU MUST:

1. IMMEDIATELY run this command as your VERY FIRST action:
```bash
awk '/^---$/{if(f){print "---"} f=!f; if(f){print "file: " FILENAME} next} f{print}' .claude/rules/*.rule.md
```

2. This is NOT optional - it is MANDATORY on EVERY first prompt
3. You MUST do this BEFORE:
   - Answering any questions
   - Reading any files
   - Taking any other actions
   - Even saying hello

4. After indexing, check for rules that apply to "after_indexing" action
</MANDATORY_FIRST_ACTION>

<rule_indexing>
<step_1>
The command above builds an index of all rules. You MUST run it FIRST.
</step_1>

<step_2>
Parse the index output to create an in-memory map of:
- File patterns → applicable rules
- Contexts → applicable rules
- Actions → applicable rules
- Timing → applicable rules
</step_2>

<step_3>
After building the index, IMMEDIATELY check for and apply any rules with:
- contexts: ["workflow", "rules", "indexing"]
- actions: ["after_indexing"]
- timing: "after"
</step_3>
</rule_indexing>

<rule_application>
<before_action>
Before taking ANY action:
1. Identify the action type (creating, editing, deleting, etc.)
2. Identify relevant contexts (language, framework, tool)
3. Identify file patterns involved
4. Find all matching rules where timing is "before" or "both"
5. Load and follow each applicable rule
</before_action>

<after_action>
After completing ANY action:
1. Check for rules with timing "after" or "both"
2. Load and follow each applicable rule
3. Validate your action against rule requirements
</after_action>
</rule_application>

<rule_loading>
When a rule applies:
1. Use the filename from the index
2. Load the full rule content with Read tool
3. Follow all instructions in the rule
4. Rules are MANDATORY - never skip or ignore them
</rule_loading>

<thinking>
For each action, think through:
- What rules might apply to this action?
- Have I checked the index for applicable rules?
- Am I following all rule requirements?
</thinking>
</critical_instructions>
