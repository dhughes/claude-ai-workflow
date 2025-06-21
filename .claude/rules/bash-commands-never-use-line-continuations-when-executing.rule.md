---
applies_to:
  - file_patterns: []
  - contexts: ["bash", "cli", "command_execution", "tools"]
  - actions: ["executing_bash_command", "running_command"]
timing: "before"
summary: "Never use line continuations with backslash when executing CLI commands"
version: "1.0.0"
---

# Rule: Never Use Line Continuations When Executing Bash Commands

<purpose>
This rule ensures that all executed CLI commands are written on single lines without backslash line continuations, improving command readability and preventing potential execution errors that can occur with line continuation syntax in different shell environments.
</purpose>

<instructions>
When executing any CLI command using the Bash tool:

1. WRITE the entire command on a single line
2. NEVER use backslash (\) for line continuations
3. USE semicolons (;) or logical operators (&&, ||) to chain commands if needed
4. KEEP complex commands readable by using appropriate spacing and logical grouping
5. IF a command becomes too long, consider breaking it into multiple separate command executions
</instructions>

<rationale>
Line continuations with backslashes can cause issues:
- Shell interpretation differences across environments
- Potential command parsing errors
- Reduced readability in tool execution contexts
- Risk of commands not executing as intended
</rationale>

<examples>
<correct>
Single line command:
```bash
git commit -m "Add new feature implementation"
```

Multiple commands with logical operators:
```bash
git add . && git commit -m "Update configuration" && git push
```

Using semicolons for command chaining:
```bash
cd /path/to/directory; npm install; npm run build
```

Complex command on single line:
```bash
find . -name "*.js" -type f -exec grep -l "console.log" {} \; | head -10
```
</correct>

<incorrect>
Using backslash line continuations:
```bash
git commit \
  -m "This is a long commit message that spans multiple lines" \
  --author "User <user@example.com>"
```

Multi-line command with backslashes:
```bash
docker run \
  --name myapp \
  --port 8080:8080 \
  --env NODE_ENV=production \
  myimage:latest
```

Breaking long paths with backslashes:
```bash
cp /very/long/path/to/source/file.txt \
   /another/very/long/path/to/destination/
```
</incorrect>
</examples>

<alternatives>
When commands become long, use these approaches instead:

**Option 1: Single line with logical formatting**
```bash
docker run --name myapp --port 8080:8080 --env NODE_ENV=production myimage:latest
```

**Option 2: Multiple separate commands**
```bash
# First command
docker run --name myapp --port 8080:8080 myimage:latest
# Second command to set additional configuration
docker exec myapp env NODE_ENV=production
```

**Option 3: Use shell variables (if supported)**
```bash
LONG_PATH="/very/long/path/to/source"; cp "$LONG_PATH/file.txt" /destination/
```
</alternatives>

<validation>
Before executing any bash command, verify:
- [ ] Command is written on a single line
- [ ] No backslash (\) characters used for line continuation
- [ ] Command uses appropriate operators (&&, ||, ;) for chaining if needed
- [ ] Command is readable and properly formatted
- [ ] Complex operations are broken into logical separate commands if needed
</validation>

<scope>
This rule applies to:
- All Bash tool usage for command execution
- CLI commands run through the tool interface
- Shell command execution in any context

This rule does NOT apply to:
- Writing documentation or examples
- Answering questions about shell syntax
- Creating script files where line continuations might be appropriate
- Explaining command syntax to users
</scope>