#!/bin/bash
PLAYER="chromium,chrome,firefox,brave,%any"
playerctl --player="$PLAYER" play-pause 2>/dev/null
