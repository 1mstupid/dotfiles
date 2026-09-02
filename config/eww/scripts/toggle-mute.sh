#!/bin/bash
# MPRIS has no like/dislike API; we toggle the eww variable directly
CURRENT=$(eww get muted 2>/dev/null || echo "false")
if [ "$CURRENT" = "true" ]; then
    pactl set-sink-mute @DEFAULT_SINK@ toggle
    eww update muted=false
else
    pactl set-sink-mute @DEFAULT_SINK@ toggle
    eww update muted=true
fi
