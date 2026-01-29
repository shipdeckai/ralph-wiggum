# Ralph Wiggum Philosophy

## Origin

The technique is named after Ralph Wiggum from The Simpsons, embodying the philosophy of persistent iteration despite setbacks. As Geoffrey Huntley describes it: **"Ralph is a Bash loop"**.

## Core Principles

### 1. Iteration > Perfection
Don't aim for perfect on the first try. Let the loop refine the work over multiple iterations.

### 2. Failures Are Data
"Deterministically bad" means failures are predictable and informative. Use them to improve prompts and specs.

### 3. Operator Skill Matters
Success depends on writing good specs and prompts, not just having a good model.

### 4. Persistence Wins
Keep trying until success. The loop handles retry logic automatically.

### 5. Self-Referential Improvement
Each iteration, Claude sees:
- Modified files from previous iterations
- Git history of changes
- Updated IMPLEMENTATION_PLAN.md
- Test results and errors

This creates a feedback loop where the AI improves its own work.

## When to Use Ralph

**Good for:**
- Well-defined tasks with clear success criteria
- Tasks requiring iteration (getting tests to pass)
- Greenfield projects you can walk away from
- Tasks with automatic verification (tests, linters, type checkers)

**Not good for:**
- Tasks requiring human judgment or design decisions
- One-shot operations
- Tasks with unclear success criteria
- Production debugging (use targeted approaches instead)

## Real-World Results

From Geoffrey Huntley's experience:
- Successfully generated 6 repositories overnight in Y Combinator hackathon
- One $50k contract completed for $297 in API costs
- Created entire programming language ("cursed") over 3 months

## The Loop Structure

```
┌─────────────────────────────────────┐
│         Read PROMPT_*.md            │
└─────────────────┬───────────────────┘
                  │
                  ▼
┌─────────────────────────────────────┐
│    Study specs/* and codebase       │
└─────────────────┬───────────────────┘
                  │
                  ▼
┌─────────────────────────────────────┐
│  Check IMPLEMENTATION_PLAN.md       │
└─────────────────┬───────────────────┘
                  │
                  ▼
┌─────────────────────────────────────┐
│     Implement next item             │
└─────────────────┬───────────────────┘
                  │
                  ▼
┌─────────────────────────────────────┐
│      Run tests, fix issues          │
└─────────────────┬───────────────────┘
                  │
                  ▼
┌─────────────────────────────────────┐
│   Update plan, commit, push         │
└─────────────────┬───────────────────┘
                  │
                  ▼
┌─────────────────────────────────────┐
│           Exit session              │
└─────────────────┬───────────────────┘
                  │
                  ▼
          (Loop restarts)
```

## Key Files

| File | Purpose |
|------|---------|
| `specs/*.md` | Feature specifications - the "what" |
| `specs/archived/*.md` | Completed specs (ignored by loop) |
| `AGENTS.md` | Build commands and operational notes |
| `PROMPT_plan.md` | Planning phase instructions |
| `PROMPT_build.md` | Build phase instructions |
| `IMPLEMENTATION_PLAN.md` | Current progress and next steps |
| `loop.sh` | The bash loop that drives iteration |

## Learn More

- Original technique: https://ghuntley.com/ralph/
- Video explanation: Search "Geoffrey Huntley Ralph Wiggum AI"
