#!/bin/bash
PLAYER="chromium,chrome,firefox,brave,%any"
playerctl --player="$PLAYER" previous 2>/dev/null
