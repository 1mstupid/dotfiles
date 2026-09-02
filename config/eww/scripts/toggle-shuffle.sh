#!/bin/bash
PLAYER="chromium,chrome,firefox,brave,%any"
playerctl --player="$PLAYER" shuffle Toggle 2>/dev/null
