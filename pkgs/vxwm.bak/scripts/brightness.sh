#!/bin/bash
# Optimized & Compatible Brightness control using ddcutil
# Fixes "junky" behavior by using a concurrency lock with a short wait time (Rate Limiting).

# --- Configuration ---
# Default step size for increment/decrement.
step=20
# Cache file for I²C bus number
CACHE="/tmp/ddc_bus"
# Lock file to prevent concurrent execution (Fixes rapid key presses/junky behavior)
LOCK_FILE="/tmp/ddc_lock"
# Max wait time for lock acquisition in seconds (0.1s).
# If a keypress happens while the lock is held, it waits 0.1s and then exits quietly.
LOCK_WAIT_TIME=0.1


# --- Core Functions ---

# Detect the I²C bus for the monitor (cached for performance)
get_bus() {
    if [[ -f "$CACHE" ]]; then
        cat "$CACHE"
        return 0
    fi

    local bus
    # Find the first monitor bus number
    bus=$(ddcutil detect --brief | grep -oP '/dev/i2c-\K[0-9]+' | head -n 1)

    if [[ -z "$bus" ]]; then
        echo "Error: No DDC-capable monitor found." >&2
        exit 1
    fi

    echo "$bus" > "$CACHE"
    echo "$bus"
}

# Get current brightness (0-100) - Used inside the locked block
get_brightness_locked() {
    local bus
    bus=$(get_bus)
    ddcutil -b "$bus" getvcp 10 --brief | awk '{print $4}'
}

# Set brightness (0-100) - Used inside the locked block
set_brightness_locked() {
    local bus value="$1"
    bus=$(get_bus)

    # Input Clamping (0-100)
    if (( value < 0 )); then
        value=0
    elif (( value > 100 )); then
        value=100
    fi

    # Set VCP feature 10 (Brightness)
    ddcutil -b "$bus" setvcp 10 "$value"
}

# Change brightness (inc/dec) - Uses lock to wrap the slow commands
change_brightness() {
    local current new_brightness direction="$1" custom_step="$2" cache_file="/tmp/brightness_level"
    local change_amount="${step}" # Start with default step

    # Override default step
    if [[ -n "$custom_step" ]] && [[ "$custom_step" =~ ^[0-9]+$ ]]; then
        change_amount="$custom_step"
    fi

    # *** CRITICAL FIX: Lock the entire slow operation (GET/READ -> CALC -> SET/WRITE) ***
    (
        flock -x -w $LOCK_WAIT_TIME 200
        if [ $? -ne 0 ]; then
            exit 0 # Monitor busy, drop the command
        fi

        # 1. ATTEMPT to read from cache (FAST)
        if [[ -f "$cache_file" ]] && [[ "$(cat "$cache_file")" =~ ^[0-9]+$ ]]; then
            current=$(cat "$cache_file")
            echo "DEBUG: Read current brightness from cache: $current" >&2
        else
            # 2. FALLBACK: Get current brightness from monitor (SLOW)
            current=$(get_brightness_locked)
            echo "DEBUG: Read current brightness from ddcutil (SLOW): $current" >&2
        fi

        # 3. Validation/Sanity check
        if ! [[ "$current" =~ ^[0-9]+$ ]] || (( current < 0 )) || (( current > 100 )); then
            echo "Error: Could not read valid current brightness. Cannot change." >&2
            # Clear invalid cache to force ddcutil read next time
            rm -f "$cache_file"
            exit 1
        fi

        # 4. Calculate new brightness
        if [[ "$direction" == "inc" ]]; then
            new_brightness=$((current + change_amount))
        elif [[ "$direction" == "dec" ]]; then
            new_brightness=$((current - change_amount))
        else
            echo "Error: Invalid argument for change_brightness." >&2
            exit 1
        fi

        # 5. Set new brightness (handles 0-100 clamping and execution)
        set_brightness_locked "$new_brightness"

        # 6. WRITE the new value to the cache (VERY IMPORTANT for next fast read)
        echo "$new_brightness" > "$cache_file"

    ) 200>"$LOCK_FILE"
}

# --- Main Execution ---

case "$1" in
    --get)
        get_brightness_locked
        ;;
    --inc|--dec)
        change_brightness "${1:2}" "$2"
        ;;
    --set)
        if [[ -z "$2" ]]; then
            echo "Usage: $0 --set <0-100>" >&2
            exit 1
        fi
        # --set must also be locked
        (
            flock -x -w $LOCK_WAIT_TIME 200
            if [ $? -ne 0 ]; then
                exit 0
            fi
            set_brightness_locked "$2"
        ) 200>"$LOCK_FILE"
        ;;
    *)
        echo "Usage: $0 [--get|--inc [step]|--dec [step]|--set <0-100>]" >&2
        exit 1
        ;;
esac
