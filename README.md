# Ralph Wiggum Plugin

Implementation of the Ralph Wiggum technique for iterative AI development loops in Claude Code.

## What is Ralph?

Ralph is a development methodology based on continuous AI agent loops. The core concept: run Claude in a `while true` loop with the same prompt until task completion. Each iteration, Claude sees its previous work in files and git history, allowing autonomous improvement.

Named after Ralph Wiggum from The Simpsons, embodying persistent iteration despite setbacks.

**Learn more:** https://ghuntley.com/ralph/

## Installation

```bash
# Add the marketplace (if not already added)
/plugin marketplace add https://github.com/shipdeckai/claude-skills

# Install the plugin
/plugin install ralph-wiggum@claude-skills
```

Or install directly:

```bash
/plugin install https://github.com/shipdeckai/ralph-wiggum
```

## Usage

Run `/ralph` in any project directory:

```bash
/ralph
```

The skill will:
1. **Auto-detect** if you're in an existing project or starting fresh
2. **Interview you** about what you want to build
3. **Create specs** for each feature
4. **Set up automation** files (loop.sh, prompts, AGENTS.md)

### Two Modes

| Mode | When | What Happens |
|------|------|--------------|
| **Existing Project** | package.json/pyproject.toml found | Explores codebase, detects patterns, creates feature specs |
| **New Project** | Empty directory | Asks about tech stack, optionally clones a website design |

## What Gets Created

```
your-project/
├── specs/                  # Feature specifications
│   ├── feature-one.md
│   ├── feature-two.md
│   └── archived/           # Completed specs (ignored by loop)
├── AGENTS.md               # Build/test commands
├── PROMPT_plan.md          # Planning phase prompt
├── PROMPT_build.md         # Build phase prompt
├── IMPLEMENTATION_PLAN.md  # Auto-generated progress tracker
└── loop.sh                 # The bash loop
```

## Running the Loop

After setup:

```bash
# Exit Claude Code
exit

# Run planning phase (3 iterations)
./loop.sh plan 3

# Review the generated plan
cat IMPLEMENTATION_PLAN.md

# Run build phase (30 iterations)
./loop.sh 30
```

The loop will:
- Read specs for requirements
- Check IMPLEMENTATION_PLAN.md for progress
- Implement the next item
- Run tests
- Commit changes
- Repeat until done

## Example Workflow

```bash
# 1. Start in your project
cd my-project

# 2. Run Ralph setup
/ralph

# Claude asks: "What do you want to add?"
# You: "Add user authentication with OAuth"

# Claude asks: "What features?"
# You: "Login, logout, profile page, password reset"

# Claude creates:
# - specs/authentication.md
# - specs/user-profile.md
# - specs/password-reset.md
# - AGENTS.md, PROMPT_*.md, loop.sh

# 3. Exit and run the loop
exit
./loop.sh plan 3
./loop.sh 30

# 4. Come back to a working feature!
```

## Spec Format

Each spec follows this template:

```markdown
# Feature Name

## Overview
Brief description of what this feature does.

## Requirements
- Requirement 1
- Requirement 2

## Acceptance Criteria
- [ ] Testable criterion 1
- [ ] Testable criterion 2

## Files Likely Affected
- path/to/file.ts

## Out of Scope
- What this does NOT include
```

## Tips

- **Be specific in specs** - Vague specs lead to vague implementations
- **Use `specs/archived/`** - Move completed specs there to keep focus
- **Review IMPLEMENTATION_PLAN.md** - Check progress between loop runs
- **Set realistic iterations** - Start with 10-20, increase as needed
- **Trust the process** - Ralph improves through iteration, not perfection
- **Scope test** - If a spec needs "and" to describe, split it into multiple specs

## Philosophy

1. **Iteration > Perfection** - Don't aim for perfect on first try
2. **Failures Are Data** - Use them to improve specs
3. **Persistence Wins** - The loop handles retries
4. **Self-Referential Improvement** - Each iteration sees previous work
5. **Context Is Everything** - Keep tasks tight for smart zone utilization
6. **Steer With Backpressure** - Tests/lints reject invalid work automatically

## Advanced Topics

The plugin includes detailed guides on:

- **Context Management** - How to maximize the ~176K usable tokens
- **Steering Patterns** - Upstream (specs, code patterns) and downstream (tests, lints)
- **Sandbox Environments** - Running Ralph securely in E2B, Sprites, Modal, Docker
- **Escape Hatches** - Ctrl+C, git reset, plan regeneration

## License

MIT
