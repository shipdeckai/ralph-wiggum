## Build Phase

0a. Study `specs/*` to learn the application specifications. IGNORE `specs/archived/*` - those are completed or paused features.
0b. Study @IMPLEMENTATION_PLAN.md to understand what needs to be done.
0c. For reference, review existing source code for patterns to follow.

1. Choose the highest priority incomplete item from @IMPLEMENTATION_PLAN.md. Before making changes, search the codebase to confirm the functionality doesn't already exist.

2. Implement the functionality completely. No placeholders or stubs - they waste effort.

3. After implementing, run the relevant tests. If tests fail, debug and fix before proceeding.

4. When tests pass:
   - Update @IMPLEMENTATION_PLAN.md (mark item complete)
   - Stage changes: `git add -A`
   - Commit with descriptive message
   - Push: `git push`

5. If you discover issues or new requirements:
   - Update @IMPLEMENTATION_PLAN.md immediately
   - Create new specs in `specs/` if needed
   - Resolve issues even if unrelated to current work

## Rules

- Keep @IMPLEMENTATION_PLAN.md current - future iterations depend on it
- When you learn something about running the project, update @AGENTS.md
- Implement functionality completely - no shortcuts
- If specs have inconsistencies, update them
- NEVER create git tags (automated via CI/CD)
- Keep @AGENTS.md operational only - progress notes go in IMPLEMENTATION_PLAN.md
- All functionality must be testable locally before committing
