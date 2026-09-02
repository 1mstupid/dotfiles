#!/bin/bash
# Emits "true"/"false" whenever playback status changes.
# Used by eww deflisten for the playing variable.
PLAYER="chromium,chrome,firefox,brave,%any"

# Emit initial state
STATUS=$(playerctl --player="$PLAYER" status 2>/dev/null)
[ "$STATUS" = "Playing" ] && echo "true" || echo "false"

# Follow changes indefinitely
playerctl --player="$PLAYER" --follow status 2>/dev/null | while IFS= read -r line; do
    [ "$line" = "Playing" ] && echo "true" || echo "false"
done
