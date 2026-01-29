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

## Context Management

Context is everything in Ralph. When 200K+ tokens advertised = ~176K truly usable, and 40-60% context utilization is the "smart zone", tight tasks + 1 task per loop = 100% smart zone utilization.

### Key Context Rules

1. **Use the main agent as a scheduler**
   - Don't allocate expensive work to main context
   - Spawn subagents for heavy lifting

2. **Use subagents as memory extension**
   - Each subagent gets ~156KB that's garbage collected
   - Fan out to avoid polluting main context

3. **Simplicity and brevity win**
   - Verbose inputs degrade determinism
   - Keep specs focused and concise

4. **Prefer Markdown over JSON**
   - Better token efficiency
   - Easier for the model to parse

5. **First ~5,000 tokens are deterministic**
   - Specs load first, same every iteration
   - Model starts from known state

## Steering Ralph: Patterns + Backpressure

You can steer Ralph from two directions:

### Steer Upstream (Inputs)
- Ensure deterministic setup (same files every loop)
- Your existing code shapes what gets generated
- If Ralph generates wrong patterns, add utilities that demonstrate correct ones
- Add/update specs to clarify requirements

### Steer Downstream (Backpressure)
- Tests, typechecks, lints reject invalid work
- Build failures force correction
- AGENTS.md specifies actual commands
- **LLM-as-judge tests** can provide backpressure for subjective criteria (aesthetics, UX feel) with binary pass/fail

### Signs Aren't Just Prompts

Signs are anything Ralph can discover:
- Prompt guardrails ("don't assume not implemented")
- AGENTS.md operational learnings
- Utilities in your codebase (patterns to follow)
- Comments in existing code
- Test files showing expected behavior

## Move Outside the Loop

To get the most out of Ralph, get out of his way. Your job is now to sit **on** the loop, not **in** it.

### Observe and Course Correct
- Watch especially early on
- What patterns emerge? Where does Ralph go wrong?
- The prompts you start with won't be the prompts you end with

### Tune It Like a Guitar
- Instead of prescribing everything upfront, observe and adjust reactively
- When Ralph fails a specific way, add a sign to help next time

### The Plan Is Disposable
- If it's wrong, throw it out and regenerate
- Don't try to salvage a bad trajectory

## Escape Hatches

- `Ctrl+C` stops the loop
- `git reset --hard` reverts uncommitted changes
- Regenerate plan if trajectory goes wrong
- Set `--max-iterations` as safety net

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
