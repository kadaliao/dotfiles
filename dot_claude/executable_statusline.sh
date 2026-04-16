#!/bin/bash

# Enhanced statusline script for Claude CLI with reliable token tracking
# This version reads token usage from transcript and session files

# Read JSON input from stdin
input=$(cat)

# Extract Claude model and output style information
model_name=$(echo "$input" | jq -r '.model.display_name // .model.id // "claude"')
output_style=$(echo "$input" | jq -r '.output_style.name // "default"')
current_dir=$(echo "$input" | jq -r '.workspace.current_dir // ""')
project_dir=$(echo "$input" | jq -r '.workspace.project_dir // ""')
session_id=$(echo "$input" | jq -r '.session_id // ""')
transcript_path=$(echo "$input" | jq -r '.transcript_path // ""')

# Function to extract token usage from transcript file
# NOTE: Claude Code writes one JSONL entry per content block (thinking, text,
# tool_use), but every block from the same API call carries identical usage.
# We deduplicate by skipping consecutive entries whose usage signature matches.
extract_tokens_from_transcript() {
    local file="$1"
    local input_total=0
    local output_total=0
    local message_count=0
    local cache_creation=0
    local cache_read=0
    local prev_sig=""

    if [[ -f "$file" ]]; then
        # Use jq to extract all usage signatures in one pass (much faster than per-line)
        while IFS=',' read -r input_tok output_tok cache_create cache_rd; do
            local sig="${input_tok},${output_tok},${cache_create},${cache_rd}"
            if [[ "$sig" == "$prev_sig" ]]; then
                continue  # duplicate content block from same API call
            fi
            prev_sig="$sig"
            input_total=$((input_total + input_tok))
            output_total=$((output_total + output_tok))
            cache_creation=$((cache_creation + cache_create))
            cache_read=$((cache_read + cache_rd))
            message_count=$((message_count + 1))
        done < <(jq -r 'select(.message.usage != null)
            | .message.usage
            | "\(.input_tokens // 0),\(.output_tokens // 0),\(.cache_creation_input_tokens // 0),\(.cache_read_input_tokens // 0)"' "$file" 2>/dev/null)
    fi

    echo "$input_total,$output_total,$message_count,$cache_creation,$cache_read"
}

# Extract token information from transcript file or fallback to input
input_tokens=0
output_tokens=0
message_count=0
cache_creation_tokens=0
cache_read_tokens=0

if [[ -n "$transcript_path" && -f "$transcript_path" ]]; then
    # Extract from transcript file
    token_data=$(extract_tokens_from_transcript "$transcript_path")
    IFS=',' read -r input_tokens output_tokens message_count cache_creation_tokens cache_read_tokens <<< "$token_data"
else
    # Fallback to input data
    input_tokens=$(echo "$input" | jq -r '.usage.input_tokens // 0' 2>/dev/null)
    output_tokens=$(echo "$input" | jq -r '.usage.output_tokens // 0' 2>/dev/null)
    cache_creation_tokens=$(echo "$input" | jq -r '.usage.cache_creation_input_tokens // 0' 2>/dev/null)
    cache_read_tokens=$(echo "$input" | jq -r '.usage.cache_read_input_tokens // 0' 2>/dev/null)
    message_count=$(echo "$input" | jq -r '.message_count // 0' 2>/dev/null)
fi

# Calculate total tokens including cache
total_tokens=$((input_tokens + output_tokens))
total_input_with_cache=$((input_tokens + cache_creation_tokens + cache_read_tokens))

# Get current working directory (basename if same as project_dir, otherwise show relative path)
if [[ -n "$current_dir" && -n "$project_dir" ]]; then
    if [[ "$current_dir" == "$project_dir" ]]; then
        work_dir=$(basename "$current_dir")
    else
        work_dir="${current_dir#$project_dir/}"
        [[ "$work_dir" == "$current_dir" ]] && work_dir=$(basename "$current_dir")
    fi
else
    work_dir=$(basename "$(pwd)")
fi

# Get current git branch (skip locks for performance)
git_branch=""
git_status=""
if git rev-parse --git-dir >/dev/null 2>&1; then
    git_branch=$(git branch --show-current 2>/dev/null || git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "detached")
    # Check if there are uncommitted changes
    if ! git diff-index --quiet HEAD -- 2>/dev/null; then
        git_status="*"
    fi
fi

# Function to format token count for display (K for thousands, M for millions)
format_tokens() {
    local tokens="$1"
    if [[ $tokens -gt 1000000 ]]; then
        awk "BEGIN {printf \"%.1fM\", $tokens/1000000}"
    elif [[ $tokens -gt 1000 ]]; then
        awk "BEGIN {printf \"%.1fK\", $tokens/1000}"
    else
        echo "$tokens"
    fi
}

# Format token displays
input_display=$(format_tokens "$input_tokens")
output_display=$(format_tokens "$output_tokens")
total_display=$(format_tokens "$total_tokens")

# Format message count
if [[ "$message_count" == "0" || "$message_count" == "null" ]]; then
    message_display="0"
else
    message_display="$message_count"
fi

# Build token usage string with input/output breakdown
if [[ "$cache_creation_tokens" -gt 0 || "$cache_read_tokens" -gt 0 ]]; then
    # Show cache info if present
    cache_create_display=$(format_tokens "$cache_creation_tokens")
    cache_read_display=$(format_tokens "$cache_read_tokens")
    token_display="↑${input_display}+${cache_create_display}c+${cache_read_display}r ↓${output_display}"
else
    # Simple input/output display
    token_display="↑${input_display} ↓${output_display}"
fi

# Add total if significant
if [[ $total_tokens -gt 0 ]]; then
    token_display="${token_display} (${total_display})"
fi

# ---------------------------------------------------------------------------
# Dynamic model pricing
# Cache file: ~/.claude/model_pricing.json
# Structure:  { "model-key": { "input": N, "cache_write": N, "cache_read": N, "output": N }, ... }
# Prices are per 1M tokens in USD.
# ---------------------------------------------------------------------------

PRICING_CACHE="$HOME/.claude/model_pricing.json"

# Canonical known prices (written on first run or if cache is missing)
BUILTIN_PRICING='{
  "claude-opus-4-6":   {"input":5.00,"cache_write":6.25,"cache_read":0.50,"output":25.00},
  "claude-opus-4-5":   {"input":5.00,"cache_write":6.25,"cache_read":0.50,"output":25.00},
  "claude-opus-4-1":   {"input":15.00,"cache_write":18.75,"cache_read":1.50,"output":75.00},
  "claude-opus-4":     {"input":15.00,"cache_write":18.75,"cache_read":1.50,"output":75.00},
  "claude-sonnet-4-6": {"input":3.00,"cache_write":3.75,"cache_read":0.30,"output":15.00},
  "claude-sonnet-4-5": {"input":3.00,"cache_write":3.75,"cache_read":0.30,"output":15.00},
  "claude-sonnet-4":   {"input":3.00,"cache_write":3.75,"cache_read":0.30,"output":15.00},
  "claude-haiku-4-5":  {"input":1.00,"cache_write":1.25,"cache_read":0.10,"output":5.00},
  "claude-haiku-4":    {"input":0.80,"cache_write":1.00,"cache_read":0.08,"output":4.00},
  "claude-haiku-3-5":  {"input":0.80,"cache_write":1.00,"cache_read":0.08,"output":4.00},
  "claude-opus-3":     {"input":15.00,"cache_write":18.75,"cache_read":1.50,"output":75.00},
  "claude-sonnet-3-7": {"input":3.00,"cache_write":3.75,"cache_read":0.30,"output":15.00},
  "claude-sonnet-3-5": {"input":3.00,"cache_write":3.75,"cache_read":0.30,"output":15.00},
  "claude-haiku-3":    {"input":0.25,"cache_write":0.30,"cache_read":0.03,"output":1.25}
}'

# Write builtin prices to cache if it does not exist yet
if [[ ! -f "$PRICING_CACHE" ]]; then
    echo "$BUILTIN_PRICING" > "$PRICING_CACHE" 2>/dev/null
fi

# Attempt a background fetch from Anthropic's public pricing page.
# We look for a pre-built JSON mirror first; fall back to nothing silently.
# The fetch writes a merged file so new models appear automatically.
fetch_and_merge_pricing() {
    local tmp
    tmp=$(mktemp 2>/dev/null) || return
    # Try a known community-maintained JSON endpoint; adjust URL if a better
    # source becomes available. --max-time 3 keeps this non-blocking.
    if curl -sf --max-time 3 \
        "https://raw.githubusercontent.com/BerriAI/litellm/main/model_prices_and_context_window.json" \
        -o "$tmp" 2>/dev/null; then
        # Extract only Claude models and reshape into our format, then merge
        # with the existing cache (existing keys take lower priority so we
        # get fresh prices when available).
        merged=$(jq -n \
            --slurpfile existing "$PRICING_CACHE" \
            --slurpfile fetched "$tmp" '
            # Build a map of claude models from the fetched data
            ($fetched[0] | to_entries
              | map(select(.key | test("^claude"; "i")))
              | map({
                  key: .key,
                  value: {
                    input:       ((.value.input_cost_per_token  // 0) * 1000000),
                    cache_write: ((.value.cache_creation_input_token_cost // .value.input_cost_per_token // 0) * 1000000),
                    cache_read:  ((.value.cache_read_input_token_cost // 0) * 1000000),
                    output:      ((.value.output_cost_per_token // 0) * 1000000)
                  }
                })
              | from_entries) as $fresh
            # Merge: fresh data wins over existing for same keys
            | $existing[0] * $fresh
        ' 2>/dev/null)
        if [[ -n "$merged" && "$merged" != "null" ]]; then
            echo "$merged" > "$PRICING_CACHE" 2>/dev/null
        fi
    fi
    rm -f "$tmp"
}

# Run fetch asynchronously so it never blocks the status line render
fetch_and_merge_pricing &
disown 2>/dev/null

# Read current pricing cache
pricing_json=$(cat "$PRICING_CACHE" 2>/dev/null || echo "$BUILTIN_PRICING")

# Resolve pricing for the active model using prefix matching.
# Strategy: try progressively shorter prefixes of the model ID until we hit
# a key in the cache, e.g.:
#   claude-sonnet-4-6-20251015 -> claude-sonnet-4-6 -> claude-sonnet-4 -> ...
model_id=$(echo "$input" | jq -r '.model.id // ""')

price_input=3.00
price_cwrite=3.75
price_cread=0.30
price_output=15.00

resolve_price() {
    local mid="$1"
    local json="$2"
    # Direct lookup first
    local row
    row=$(echo "$json" | jq -r --arg k "$mid" '.[$k] // empty' 2>/dev/null)
    if [[ -n "$row" ]]; then
        echo "$row"
        return
    fi
    # Prefix-strip: remove last hyphen-separated segment and retry
    local prefix="$mid"
    while [[ "$prefix" == *-* ]]; do
        prefix="${prefix%-*}"
        row=$(echo "$json" | jq -r --arg k "$prefix" '.[$k] // empty' 2>/dev/null)
        if [[ -n "$row" ]]; then
            echo "$row"
            return
        fi
    done
    # Not found
    echo ""
}

if [[ -n "$model_id" ]]; then
    price_row=$(resolve_price "$model_id" "$pricing_json")
    if [[ -n "$price_row" ]]; then
        price_input=$(echo "$price_row"  | jq -r '.input       // 3.00')
        price_cwrite=$(echo "$price_row" | jq -r '.cache_write // 3.75')
        price_cread=$(echo "$price_row"  | jq -r '.cache_read  // 0.30')
        price_output=$(echo "$price_row" | jq -r '.output      // 15.00')
    fi
fi

# Calculate approximate USD cost using resolved per-model prices
cost=$(awk "BEGIN {
    input_cost  = $input_tokens           * $price_input  / 1000000;
    cwrite_cost = $cache_creation_tokens  * $price_cwrite / 1000000;
    cread_cost  = $cache_read_tokens      * $price_cread  / 1000000;
    output_cost = $output_tokens          * $price_output / 1000000;
    total = input_cost + cwrite_cost + cread_cost + output_cost;
    printf \"\$%.4f\", total
}")

# Format the status line with color codes and emojis — two lines
# Line 1: directory | git | model | output style
# Line 2: messages | tokens | cost
printf "\033[34m📁 %s\033[0m | \033[36m🌿 %s%s\033[0m | \033[32m🤖 %s\033[0m | \033[37m✨ %s\033[0m\n\033[33m💬 %s\033[0m | \033[35m🪙 %s\033[0m | \033[33m💰 %s\033[0m" \
    "$work_dir" \
    "${git_branch:-"no-git"}" \
    "$git_status" \
    "$model_name" \
    "$output_style" \
    "$message_display" \
    "$token_display" \
    "$cost"