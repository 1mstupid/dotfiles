#!/bin/dash

STATE_FILE="${XDG_RUNTIME_DIR:-/tmp}/eww-pomo-state"
TIME_FILE="${XDG_RUNTIME_DIR:-/tmp}/eww-pomo-time"
PHASE_FILE="${XDG_RUNTIME_DIR:-/tmp}/eww-pomo-phase"
PROGRESS_FILE="${XDG_RUNTIME_DIR:-/tmp}/eww-pomo-progress"
COMPLETED_FILE="${XDG_RUNTIME_DIR:-/tmp}/eww-pomo-completed"
TIME_ELAPSED_FILE="${XDG_RUNTIME_DIR:-/tmp}/eww-pomo-time-elapsed"
PID_FILE="${XDG_RUNTIME_DIR:-/tmp}/eww-pomo-pid"

# Sound configuration
ALERT_SOUND="${ALERT_SOUND:-/usr/share/sounds/freedesktop/stereo/complete.oga}"
PLAY_SOUND="${PLAY_SOUND:-canberra-gtk-play --file}"

init() {
    printf "idle" > "$STATE_FILE"
    printf "25:00" > "$TIME_FILE"
    printf "focus" > "$PHASE_FILE"
    [ -f "$TIME_ELAPSED_FILE" ] || printf "00:00:00" > "$TIME_ELAPSED_FILE"
    printf "0" > "$PROGRESS_FILE"
    [ -f "$COMPLETED_FILE" ] || printf "0" > "$COMPLETED_FILE"
    sync_vars
}

sync_vars() {
    eww update pomo-time="$(cat "$TIME_FILE")"
    eww update pomo-phase="$(cat "$PHASE_FILE")"
    eww update pomo-progress="$(cat "$PROGRESS_FILE")"
    eww update pomo-running="$(cat "$STATE_FILE")"
    eww update pomo-elapsed="$(cat "$TIME_ELAPSED_FILE")"
    eww update pomo-completed="$(cat "$COMPLETED_FILE")"
}

play_alert() {
    # Run in background so it doesn't block the script
    (
        # Try canberra-gtk-play with file first (most reliable)
        if command -v canberra-gtk-play >/dev/null 2>&1; then
            canberra-gtk-play --file="$ALERT_SOUND" 2>/dev/null && exit 0
            canberra-gtk-play --id="message" 2>/dev/null && exit 0
            canberra-gtk-play --id="complete" 2>/dev/null && exit 0
        fi

        # Try paplay (PulseAudio)
        if command -v paplay >/dev/null 2>&1 && [ -f "$ALERT_SOUND" ]; then
            paplay "$ALERT_SOUND" 2>/dev/null && exit 0
        fi

        # Try aplay (ALSA)
        if command -v aplay >/dev/null 2>&1 && [ -f "$ALERT_SOUND" ]; then
            aplay "$ALERT_SOUND" 2>/dev/null && exit 0
        fi

        # Try ffplay
        if command -v ffplay >/dev/null 2>&1 && [ -f "$ALERT_SOUND" ]; then
            ffplay -nodisp -autoexit "$ALERT_SOUND" 2>/dev/null && exit 0
        fi

        # Fallback: terminal bell
        printf '\a' >/dev/tty 2>/dev/null || printf '\a'
    ) &
}

tick() {
    phase="$(cat "$PHASE_FILE")"
    total=1500
    case "$phase" in
        focus) total=1500 ;;
        short) total=300 ;;
        long) total=900 ;;
    esac

    while [ "$(cat "$STATE_FILE")" = "running" ]; do
        current="$(cat "$TIME_FILE")"
        min="${current%:*}"
        sec="${current#*:}"

        min="${min#0}"
        sec="${sec#0}"
        min="${min:-0}"
        sec="${sec:-0}"

        left=$(( min * 60 + sec ))

        [ "$left" -le 0 ] && { finish; return; }

        left=$(( left - 1 ))
        new_min=$(( left / 60 ))
        new_sec=$(( left % 60 ))
        printf "%02d:%02d\n" "$new_min" "$new_sec" > "$TIME_FILE"
        if [ "$phase" = "focus" ]; then
            elapsed="$(cat "$TIME_ELAPSED_FILE")"

            h="${elapsed%%:*}"
            rest="${elapsed#*:}"
            m="${rest%%:*}"
            s="${rest#*:}"

            h="${h#0}"; m="${m#0}"; s="${s#0}"
            h="${h:-0}"; m="${m:-0}"; s="${s:-0}"

            total_elapsed=$(( h * 3600 + m * 60 + s + 1 ))

            eh=$(( total_elapsed / 3600 ))
            em=$(( (total_elapsed % 3600) / 60 ))
            es=$(( total_elapsed % 60 ))

            printf "%02d:%02d:%02d\n" "$eh" "$em" "$es" > "$TIME_ELAPSED_FILE"
        fi        
        
        prog=$(awk "BEGIN {printf \"%.4f\", 1 - ($left / $total)}")
        printf "%s\n" "$prog" > "$PROGRESS_FILE"

        sync_vars
        sleep 1
    done
}

finish() {
    phase="$(cat "$PHASE_FILE")"
    completed="$(cat "$COMPLETED_FILE")"

    # Play sound FIRST (non-blocking)
    play_alert

    # Reveal the widget BEFORE changing state
    eww update pomo-reveal=true

    case "$phase" in
        focus)
            completed=$(( completed + 1 ))
            printf "%d" "$completed" > "$COMPLETED_FILE"
            if [ $(( completed % 4 )) -eq 0 ]; then
                printf "long" > "$PHASE_FILE"
                printf "15:00" > "$TIME_FILE"
            else
                printf "short" > "$PHASE_FILE"
                printf "05:00" > "$TIME_FILE"
            fi
            ;;
        short|long)
            printf "focus" > "$PHASE_FILE"
            printf "25:00" > "$TIME_FILE"
            ;;
    esac

    printf "idle" > "$STATE_FILE"
    printf "0" > "$PROGRESS_FILE"
    sync_vars
}

toggle() {
    state="$(cat "$STATE_FILE")"
    if [ "$state" = "running" ]; then
        printf "idle" > "$STATE_FILE"
        # Kill existing tick loop
        [ -f "$PID_FILE" ] && kill "$(cat "$PID_FILE")" 2>/dev/null
        sync_vars
    else
        printf "running" > "$STATE_FILE"
        sync_vars
        tick &
        printf "%s" "$!" > "$PID_FILE"
    fi
}

stop() {
    printf "idle" > "$STATE_FILE"
    [ -f "$PID_FILE" ] && kill "$(cat "$PID_FILE")" 2>/dev/null
    rm -f "$PID_FILE"
    printf "25:00" > "$TIME_FILE"
    printf "focus" > "$PHASE_FILE"
    printf "0" > "$PROGRESS_FILE"
    sync_vars
}

reset() {
    stop
    printf "0" > "$COMPLETED_FILE"
    printf "00:00:00" > "$TIME_ELAPSED_FILE"
    sync_vars
}

case "${1:-}" in
    init) init ;;
    toggle) toggle ;;
    stop) stop ;;
    reset) reset ;;
    *) echo "usage: $0 {init|toggle|stop|reset}" ;;
esac
