#!/bin/bash
PLAYER="chromium,chrome,firefox,brave,%any"
playerctl --player="$PLAYER" next 2>/dev/null
