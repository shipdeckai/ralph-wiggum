#!/bin/bash
# Ralph Loop - Iterative AI Development
# Usage: ./loop.sh [plan|build] [iterations]
# Example: ./loop.sh plan 3    # Planning phase, 3 iterations
# Example: ./loop.sh 30        # Build phase, 30 iterations

set -e

MODE="${1:-build}"
MAX_ITERATIONS="${2:-30}"

# Handle shorthand: ./loop.sh 30 means build mode with 30 iterations
if [[ "$MODE" =~ ^[0-9]+$ ]]; then
    MAX_ITERATIONS="$MODE"
    MODE="build"
fi

# Select prompt file based on mode
if [ "$MODE" = "plan" ]; then
    PROMPT_FILE="PROMPT_plan.md"
    echo "=== Ralph Planning Phase ==="
else
    PROMPT_FILE="PROMPT_build.md"
    echo "=== Ralph Build Phase ==="
fi

if [ ! -f "$PROMPT_FILE" ]; then
    echo "Error: $PROMPT_FILE not found"
    echo "Run /ralph to set up the project first"
    exit 1
fi

echo "Prompt: $PROMPT_FILE"
echo "Max iterations: $MAX_ITERATIONS"
echo ""

ITERATION=0

while [ $ITERATION -lt $MAX_ITERATIONS ]; do
    ITERATION=$((ITERATION + 1))
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "Iteration $ITERATION of $MAX_ITERATIONS"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

    # Run Claude with the prompt file
    # The --prompt flag reads the file content as the initial prompt
    if claude --prompt "$(cat $PROMPT_FILE)" --allowedTools "Read,Write,Edit,Bash,Glob,Grep,Task,WebFetch"; then
        echo ""
        echo "Iteration $ITERATION completed successfully"
    else
        echo ""
        echo "Iteration $ITERATION exited with error (this is normal for Ralph)"
    fi

    echo ""
    sleep 2  # Brief pause between iterations
done

echo ""
echo "=== Ralph Loop Complete ==="
echo "Completed $ITERATION iterations"
echo ""
echo "Review your changes:"
echo "  git log --oneline -10"
echo "  git diff HEAD~5"
