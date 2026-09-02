#!/bin/bash
# MPRIS has no like/dislike API; we toggle the eww variable directly
CURRENT=$(eww get liked 2>/dev/null || echo "false")
if [ "$CURRENT" = "true" ]; then
    eww update liked=false
else
    eww update liked=true
fi
