#!/bin/bash
# $1 = progress percentage (0-100) from eww scale
PLAYER="chromium,chrome,firefox,brave,%any"
PERCENT="${1:-0}"
DUR=$(playerctl --player="$PLAYER" metadata mpris:length 2>/dev/null)
[ -z "$DUR" ] && exit 0
# mpris:length is in microseconds; convert percentage to seconds
POS=$(awk -v pct="$PERCENT" -v dur="$DUR" 'BEGIN { printf "%.2f", pct * dur / 100 / 1000000 }')
playerctl --player="$PLAYER" position "$POS"
