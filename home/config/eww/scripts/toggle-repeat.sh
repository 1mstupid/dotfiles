#!/bin/bash
PLAYER="chromium,chrome,firefox,brave,%any"
CURRENT=$(playerctl --player="$PLAYER" loop 2>/dev/null)
case "$CURRENT" in
    None)  playerctl --player="$PLAYER" loop Track    ;;
    Track) playerctl --player="$PLAYER" loop Playlist ;;
    *)     playerctl --player="$PLAYER" loop None     ;;
esac
