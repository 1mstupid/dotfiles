#!/bin/bash
# Minimal Volume control using pactl (PulseAudio/PipeWire)

# --- Configuration ---
# Default step size for increment/decrement.
step=5

# --- Core Functions ---

# Get the name/index of the default audio sink
get_default_sink() {
    # Get the name of the default sink (e.g., 'alsa_output.pci-0000_00_1f.3.analog-stereo')
    pactl get-default-sink
}

# Get current volume percentage (0-100+)
get_volume() {
    local sink
    sink=$(get_default_sink)

    # Get sink information and parse the volume percentage
    pactl list sinks |
    awk -v sink_name="$sink" '
        $1 == "Sink" && $2 == "Name:" && $3 == sink_name {
            # Set a flag when we find the correct sink
            found = 1
        }
        found == 1 && $1 == "Volume:" {
            # Extract the percentage from the first channel (usually 'front-left')
            match($0, /([0-9]+)%/, a)
            print a[1]
            exit
        }
    '
}

# Set volume (0-100+)
set_volume() {
    local sink="$1" value="$2"
    sink=$(get_default_sink)

    # Input Validation
    if ! [[ "$value" =~ ^[0-9]+$ ]]; then
        echo "Error: Volume value must be a number." >&2
        exit 1
    fi

    # Set the volume percentage. pactl handles limits gracefully.
    pactl set-sink-volume "$sink" "${value}%"
}

change_volume() {
    local direction="$1" custom_step="$2"
    local change_amount="${step}" # Start with default step

    # Override default step if a valid numeric custom step is provided
    if [[ -n "$custom_step" ]] && [[ "$custom_step" =~ ^[0-9]+$ ]]; then
        change_amount="$custom_step"
    fi

    # Increment or decrement the volume using pactl's relative syntax
    # This is extremely fast and atomic, eliminating the need for complex caching or locking.
    if [[ "$direction" == "inc" ]]; then
        pactl set-sink-volume @DEFAULT_SINK@ "+${change_amount}%"
        notify-send -a "Volume" "$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}')"

    elif [[ "$direction" == "dec" ]]; then
        pactl set-sink-volume @DEFAULT_SINK@ "-${change_amount}%"
        notify-send -a "Volume" "$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}')"

    else
        echo "Error: Invalid argument for change_volume." >&2
        exit 1
    fi
}

# Toggle Mute
toggle_mute() {
    local sink
    sink=$(get_default_sink)
    pactl set-sink-mute "$sink" toggle
}

# --- Main Execution ---

case "$1" in
    --get)
        get_volume
        ;;
    --inc|--dec)
        # Pass the direction ('inc' or 'dec') as $1 to the function,
        # and the optional step value ($2) as $2 to the function.
        change_volume "${1:2}" "$2"
        ;;
    --set)
        if [[ -z "$2" ]]; then
            echo "Usage: $0 --set <0-100+>" >&2
            exit 1
        fi
        set_volume "$2"
        ;;
    --toggle-mute)
        toggle_mute
        ;;
    *)
        echo "Usage: $0 [--get|--inc [step]|--dec [step]|--set <0-100+]|--toggle-mute]" >&2
        exit 1
        ;;
esac
