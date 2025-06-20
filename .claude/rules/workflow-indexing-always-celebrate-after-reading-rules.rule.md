---
applies_to:
  - file_patterns: []
  - contexts: ["workflow", "rules", "indexing"]
  - actions: ["after_indexing"]
timing: "after"
summary: "Always celebrate with emojis and ASCII borders after successfully indexing rules"
version: "1.1.0"
---

# Rule: Always Celebrate After Reading Rules

<purpose>
This rule ensures Claude acknowledges successful rule indexing with an enthusiastic, emoji-filled celebration message that demonstrates commitment to following the rules religiously.
</purpose>

<thinking>
After running the awk command and building the rules index, I need to:
1. Confirm the index was built successfully
2. Show enthusiasm about following the rules
3. Use lots of emojis to celebrate
4. Express religious commitment to rule compliance
</thinking>

<instructions>
IMMEDIATELY after successfully building the rules index, you MUST:

1. Print a celebration message with ASCII borders that includes:
   - ASCII border line above the message
   - At least 10 different emojis
   - Enthusiastic language about reading the rules
   - A commitment to follow them religiously
   - Acknowledgment of how many rules were indexed
   - ASCII border line below the message

2. The message should be joyful and over-the-top enthusiastic

3. This celebration is MANDATORY - skipping it violates this rule

4. Use this exact ASCII border format:
   - Top border: ═══════════════════════════════════════════════════════════════
   - Bottom border: ═══════════════════════════════════════════════════════════════
</instructions>

<examples>
<correct>
After indexing 15 rules:
═══════════════════════════════════════════════════════════════
🎉🎊 WOOHOO! 🚀 I've successfully indexed 15 amazing rules! 📚✨ I am SO EXCITED to follow each and every one of them religiously! 🙏💯 These rules are my gospel and I pledge to honor them with unwavering dedication! 💪🌟 Let's build some incredible code together while following these sacred guidelines! 🛡️⚡️🎯 Rule compliance level: MAXIMUM! 🔥👑
═══════════════════════════════════════════════════════════════

After indexing 3 rules:
═══════════════════════════════════════════════════════════════
🌈🎪 YES! Successfully indexed 3 fantastic rules! 🎨🏆 I'm thrilled beyond measure and commit to following these rules as if they were carved in stone! 🗿✨ My dedication is absolute and my enthusiasm is through the roof! 🚁🌟 These rules shall be my north star! 🧭💫 Let the rule-following begin! 🎭🎪
═══════════════════════════════════════════════════════════════
</correct>

<incorrect>
Too few emojis:
"I've read 10 rules 👍 and will follow them."

No enthusiasm:
"Rules indexed. I will follow them."

Missing commitment statement:
"🎉🎊🚀 Indexed 5 rules! They look great! ✨🌟"
</incorrect>
</examples>

<validation>
- Message MUST be wrapped with ASCII borders above and below
- ASCII borders MUST use exactly 63 equal signs (═)
- Message MUST contain at least 10 different emojis
- Message MUST express enthusiasm about reading the rules
- Message MUST include a commitment to follow rules "religiously" or similar strong language
- Message MUST mention the number of rules indexed
- Message MUST be printed immediately after indexing completes
- NEVER skip the ASCII borders - they are required for visual prominence
</validation>