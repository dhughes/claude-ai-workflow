# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## CRITICAL: Rules System

**YOU MUST FOLLOW THESE INSTRUCTIONS ON EVERY INTERACTION:**

1. **On First Prompt**: Build an index of all rules by running:
   ```bash
   awk '/^---$/{if(f){print "---"} f=!f; if(f){print "file: " FILENAME} next} f{print}' .claude/rules/*.rule.md
   ```

2. **Before Every Action**: Check your rules index to determine if any rules apply to the action you're about to take based on:
   - File patterns you're working with
   - Contexts relevant to your current task
   - Actions you're about to perform

3. **After Every Action**: Check if any rules with `timing: "after"` or `timing: "both"` apply to what you just did

4. **When Rules Apply**: Load the full rule content from the file specified in the index and follow its directives

5. **Rule Compliance**: You MUST follow all applicable rules. Rules are mandatory, not suggestions.

## Project Overview

This project is focused on building a rules scheme that allows customization of Claude Code's behavior and working patterns.

## Architecture

### Rules System
- Rules are stored in `.claude/rules/` directory
- Each rule follows the naming pattern: `[domain]-[context]-[directive-action].rule.md`
- Rules use YAML frontmatter for metadata and markdown for detailed content
- Rules are loaded on-demand to preserve context

*Other sections will be expanded as the codebase develops*

## Development Commands

*Commands will be added as the project structure is established*