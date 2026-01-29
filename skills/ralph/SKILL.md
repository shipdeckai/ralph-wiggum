---
name: ralph
description: Set up Ralph (Huntley method) for iterative AI development. Use when starting a new project, adding features to existing code, or cloning a website design. Creates specs, prompts, and loop automation for autonomous coding sessions.
argument-hint: "[optional: URL to clone]"
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, WebFetch, AskUserQuestion, Task
user-invocable: true
---

# Ralph Setup

Set up the Ralph Wiggum technique for iterative AI development loops.

## What is Ralph?

Ralph is a development methodology based on continuous AI agent loops. The core concept: run Claude in a `while true` loop with the same prompt until task completion. Each iteration, Claude sees its previous work in files and git history, allowing autonomous improvement.

Learn more: https://ghuntley.com/ralph/

## What You Create

```
project/
├── specs/              # Feature specifications (active)
│   └── archived/       # Completed/paused specs (ignored)
├── AGENTS.md           # Build/test commands
├── PROMPT_plan.md      # Planning phase prompt
├── PROMPT_build.md     # Build phase prompt
└── loop.sh             # The bash loop script
```

## Process

### Step 1: Detect Project Type

Run these checks to detect if this is an existing project:

```bash
# Check for package manager files (any of these = existing project)
ls package.json pyproject.toml Cargo.toml go.mod pom.xml build.gradle build.sbt composer.json Gemfile mix.exs 2>/dev/null
```

**Detection rules:**

| Found | Project Type | Reason |
|-------|--------------|--------|
| `package.json` | Existing (Node.js) | npm/yarn/pnpm project |
| `pyproject.toml` or `requirements.txt` | Existing (Python) | Python project |
| `Cargo.toml` | Existing (Rust) | Rust project |
| `go.mod` | Existing (Go) | Go module |
| `pom.xml` or `build.gradle` | Existing (Java) | Maven/Gradle project |
| `build.sbt` | Existing (Scala) | SBT project |
| `composer.json` | Existing (PHP) | PHP project |
| `Gemfile` | Existing (Ruby) | Ruby project |
| `mix.exs` | Existing (Elixir) | Elixir project |
| `src/` or `app/` directory with code | Existing | Has source code |
| `specs/` folder already exists | Existing | Previous Ralph setup |
| None of the above | New Project | Empty or minimal directory |

**Tell the user what you detected:**

- "I detected this is an existing **Next.js + TypeScript** project (found package.json with next dependency). Adding features to existing codebase."
- "This looks like a **new project** (empty directory). Starting from scratch."

Then proceed with the appropriate mode.

---

## Mode A: Existing Project

### A1. Explore Codebase

Read the package manager file to detect:
- Tech stack and framework
- Build/dev/test/lint commands
- Key dependencies

Briefly explore file structure to understand patterns. Tell the user what you found.

### A2. Interview

Ask ONE question at a time using AskUserQuestion:

1. "What do you want to add or change?"
2. "What are the main features/topics for this work?" (get a list)

### A3. Create Specs

For each topic, create `specs/[topic].md` using this template:

```markdown
# [Topic Name]

## Overview
[Brief description of what this feature does]

## Requirements
- [Requirement 1]
- [Requirement 2]

## Acceptance Criteria
- [ ] [Testable criterion 1]
- [ ] [Testable criterion 2]

## Files Likely Affected
- [path/to/file1.ts]
- [path/to/file2.py]

## Out of Scope
- [What this spec does NOT cover]
```

Ask user to confirm each spec before creating the next.

**Spec Scoping Test: "One Sentence Without 'And'"**

Before creating a spec, validate its scope:
- Can you describe it in one sentence without conjoining unrelated capabilities?
- ✓ "The authentication system handles user login and session management"
- ✗ "The user system handles authentication, profiles, and billing" → Split into 3 specs

If you need "and" to connect unrelated capabilities, it's multiple specs.

### A4. Create Configuration Files

Copy the template files from this skill's `files/` directory:

```bash
mkdir -p specs specs/archived
```

Create `loop.sh` with content from [files/loop.sh](files/loop.sh).
Create `AGENTS.md` using detected build commands.
Create `PROMPT_plan.md` from [files/PROMPT_plan.md](files/PROMPT_plan.md), replacing `[project-specific goal]`.
Create `PROMPT_build.md` from [files/PROMPT_build.md](files/PROMPT_build.md).

Make loop.sh executable: `chmod +x loop.sh`

---

## Mode B: New Project

### B1. Interview

Ask ONE question at a time:

1. "What are you building? (2-3 sentences)"
2. "Are you starting from scratch, or cloning an existing website's design?"

**If cloning:** Ask for the URL, then use WebFetch to analyze:
- Layout structure (header, hero, sections, footer)
- Colors (extract hex values)
- Typography (fonts)
- Component patterns

3. "What tech stack? (e.g., Next.js + Tailwind + TypeScript)"
4. "What are the main features/topics?"

### B2. Create Specs

For each topic, create `specs/[topic].md`:

```markdown
# [Topic Name]

## Overview
[Brief description]

## Requirements
- [Requirement 1]
- [Requirement 2]

## Acceptance Criteria
- [ ] [Testable criterion]
- [ ] [Testable criterion]

## Out of Scope
- [What this doesn't cover]
```

**If cloning a website**, also create:
- `specs/design-system.md` with colors, typography, spacing
- `specs/[section].md` for each section to replicate

Ask user to confirm each spec.

**Spec Scoping Test: "One Sentence Without 'And'"**

Before creating a spec, validate its scope:
- Can you describe it in one sentence without conjoining unrelated capabilities?
- ✓ "The authentication system handles user login and session management"
- ✗ "The user system handles authentication, profiles, and billing" → Split into 3 specs

If you need "and" to connect unrelated capabilities, it's multiple specs.

### B3. Create Configuration Files

```bash
mkdir -p specs specs/archived src
```

Create files same as Mode A, but with the user's chosen tech stack commands.

---

## Final Steps (Both Modes)

### Verify Setup

List created files:
```bash
ls -la specs/
ls -la *.md loop.sh
```

### Done - Show Next Steps

Tell the user:

```
Ralph setup complete!

Created:
- specs/[list specs]
- AGENTS.md
- PROMPT_plan.md
- PROMPT_build.md
- loop.sh

Next steps:
1. Exit Claude Code (type: exit)
2. Run planning phase: ./loop.sh plan 3
3. Review the generated IMPLEMENTATION_PLAN.md
4. Run build phase: ./loop.sh 30

The loop will iterate until completion. Each iteration:
- Reads specs/* for requirements
- Checks IMPLEMENTATION_PLAN.md for progress
- Implements the next item
- Commits changes
- Repeats

Tip: Use specs/archived/ for completed features to keep active specs focused.
```

---

## Reference Files

The following files are templates to copy into the user's project:

- [files/loop.sh](files/loop.sh) - The bash loop script
- [files/PROMPT_plan.md](files/PROMPT_plan.md) - Planning phase prompt
- [files/PROMPT_build.md](files/PROMPT_build.md) - Build phase prompt
- [files/AGENTS.md](files/AGENTS.md) - Build commands template

### Background & Advanced Topics

- [references/philosophy.md](references/philosophy.md) - Ralph methodology, context management, steering patterns
- [references/sandbox-environments.md](references/sandbox-environments.md) - Secure sandbox options (E2B, Sprites, Modal, Docker)
