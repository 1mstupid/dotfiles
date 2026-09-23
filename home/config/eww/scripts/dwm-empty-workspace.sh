#!/bin/bash

# Get current desktop (dwm tags are 0-indexed)
current=$(xprop -root -notype _NET_CURRENT_DESKTOP | awk '{print $3}')

# Get all client window IDs
clients=$(xprop -root -notype _NET_CLIENT_LIST | sed 's/.*= //; s/,//g')

# Count windows on current tag
count=0
for id in $clients; do
    ws=$(xprop -id "$id" -notype _NET_WM_DESKTOP 2>/dev/null | awk '{print $3}')
    if [ "$ws" = "$current" ]; then
        count=$((count + 1))
    fi
done

if [ "$count" -eq 0 ]; then
    echo "true"
else
    echo "false"
fi
