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
    LOG_FILE="ralph_plan.log"
    echo "=== Ralph Planning Phase ==="
else
    PROMPT_FILE="PROMPT_build.md"
    LOG_FILE="ralph_build.log"
    echo "=== Ralph Build Phase ==="
fi

CURRENT_BRANCH=$(git branch --show-current)

if [ ! -f "$PROMPT_FILE" ]; then
    echo "Error: $PROMPT_FILE not found"
    echo "Run /ralph to set up the project first"
    exit 1
fi

echo "Prompt: $PROMPT_FILE"
echo "Branch: $CURRENT_BRANCH"
echo "Max iterations: $MAX_ITERATIONS"
echo "Log: $LOG_FILE"
echo ""

ITERATION=0

while [ $ITERATION -lt $MAX_ITERATIONS ]; do
    ITERATION=$((ITERATION + 1))
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "Iteration $ITERATION of $MAX_ITERATIONS"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

    # Run Claude with the prompt file
    stty sane 2>/dev/null  # Reset terminal
    if claude -p \
        --dangerously-skip-permissions \
        --output-format=stream-json \
        --model opus \
        --verbose < "$PROMPT_FILE" 2>&1 | tee -a "$LOG_FILE" | jq -r '
          if .type == "assistant" and .message.content then
            (.message.content[] | select(.type == "text") | "💬 " + .text) // empty
          elif .type == "result" then
            "✅ Cost: $" + (.total_cost_usd | tostring) + " | Turns: " + (.num_turns | tostring)
          elif .error then
            "❌ " + .error
          else empty end
        ' 2>/dev/null; then
        echo ""
        echo "Iteration $ITERATION completed successfully"
    else
        echo ""
        echo "Iteration $ITERATION exited (this is normal for Ralph)"
    fi
    stty sane 2>/dev/null  # Reset terminal after

    # Push changes if remote exists
    if git remote get-url origin &>/dev/null; then
        git push origin "$CURRENT_BRANCH" 2>/dev/null || git push -u origin "$CURRENT_BRANCH" 2>/dev/null || true
    fi

    echo ""
    sleep 5  # Brief pause between iterations
done

echo ""
echo "=== Ralph Loop Complete ==="
echo "Completed $ITERATION iterations"
echo ""
echo "Review your changes:"
echo "  git log --oneline -10"
echo "  git diff main...HEAD"
