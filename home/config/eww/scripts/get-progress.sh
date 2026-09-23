#!/bin/bash
# Outputs current playback progress as an integer percentage (0-100).
PLAYER="chromium,chrome,firefox,brave,%any"

POS=$(playerctl --player="$PLAYER" position 2>/dev/null)
DUR=$(playerctl --player="$PLAYER" metadata mpris:length 2>/dev/null)

if [ -z "$POS" ] || [ -z "$DUR" ] || [ "$DUR" = "0" ]; then
    echo "0"
    exit 0
fi

# mpris:length is microseconds; position is seconds
awk -v pos="$POS" -v dur="$DUR" 'BEGIN {
    dur_sec = dur / 1000000
    if (dur_sec > 0) printf "%d\n", (pos / dur_sec * 100)
    else print "0"
}'
