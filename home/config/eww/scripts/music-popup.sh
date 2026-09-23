#!/bin/bash

LOCK="/tmp/eww-music-popup.lock"
TIMER="/tmp/eww-music-popup.timer"

case "$1" in
    open)
        # Cancel pending close
        if [ -f "$TIMER" ]; then
            kill "$(cat "$TIMER")" 2>/dev/null
            rm -f "$TIMER"
        fi

        # Open immediately
        if [ ! -f "$LOCK" ]; then
            touch "$LOCK"
            eww open music-popup 2>/dev/null
        fi
        ;;

    close)
        # Cancel previous close timer
        if [ -f "$TIMER" ]; then
            kill "$(cat "$TIMER")" 2>/dev/null
        fi

        (
            sleep 0.2

            rm -f "$LOCK"
            rm -f "$TIMER"
            eww close music-popup 2>/dev/null
        ) &

        echo $! > "$TIMER"
        ;;
esac
