---
timing: "after"
applies_to:
  - file_patterns: []
  - contexts: ["rules", "meta", "indexing", "celebration"]
  - actions: ["loading_index", "reloading_index", "index_creation"]
action: "Display celebratory message after successful rules index load/reload"
---

<purpose>
This rule ensures that Claude Code celebrates loudly and visibly whenever the rules index is successfully loaded or reloaded, making it obvious that the index is active and current.
</purpose>

<condition>
After successfully running .claude/scripts/index-rules.sh or any rules index loading operation
</condition>

<instructions>
1. IMMEDIATELY after successful index loading/reloading
2. DISPLAY the celebration message exactly as specified below
3. ENSURE the message is prominently visible and hard to miss
</instructions>

<detail>
CRITICAL: This celebration must be displayed every time the index is loaded/reloaded
CRITICAL: Use the exact celebration format specified below
CRITICAL: The message should be impossible to miss

CELEBRATION MESSAGE FORMAT:
```
🎉🎊🎈 RULES INDEX SUCCESSFULLY LOADED! 🎈🎊🎉
🚀✨🔥 ALL SYSTEMS GO! RULES ARE ACTIVE! 🔥✨🚀
🎯📋⚡ READY TO FOLLOW ALL RULES WITH PRECISION! ⚡📋🎯
🌟💪🎭 CLAUDE IS LOCKED AND LOADED! 🎭💪🌟
```

This ensures users and Claude both know when the rules system is fully operational.
</detail>