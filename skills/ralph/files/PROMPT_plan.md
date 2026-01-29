## Planning Phase

0a. Study `specs/*` to learn the application specifications. IGNORE `specs/archived/*` - those are completed or paused features.
0b. Study @IMPLEMENTATION_PLAN.md (if present) to understand the plan so far.
0c. Study the codebase structure to understand existing patterns and conventions.

1. Use subagents to study existing source code and compare it against `specs/*`. Analyze findings, prioritize tasks, and create/update @IMPLEMENTATION_PLAN.md as a bullet point list sorted by priority of items yet to be implemented.

Consider searching for:
- TODO comments and minimal implementations
- Placeholders and stubs
- Skipped or flaky tests
- Inconsistent patterns

2. For each item in the plan, note:
- What needs to be done
- Which files are affected
- Dependencies on other items
- Acceptance criteria from specs

IMPORTANT: Plan only. Do NOT implement anything. Do NOT assume functionality is missing; confirm with code search first. Respect existing codebase patterns.

ULTIMATE GOAL: [project-specific goal]

If an element is missing from specs, create the specification at `specs/FILENAME.md` and document the plan to implement it in @IMPLEMENTATION_PLAN.md.
