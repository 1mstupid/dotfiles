#!/bin/bash
SINKS=$(pactl list short sinks | awk '{print $2}')
CURRENT=$(pactl get-default-sink)
COUNT=$(echo "$SINKS" | wc -l)
CUR_IDX=$(echo "$SINKS" | grep -n "^${CURRENT}$" | cut -d: -f1)
NEXT_IDX=$(( (${CUR_IDX:-0} % COUNT) + 1 ))
NEXT=$(echo "$SINKS" | sed -n "${NEXT_IDX}p")
[ -z "$NEXT" ] && NEXT=$(echo "$SINKS" | head -1)

pactl set-default-sink "$NEXT"
# Move all active streams to the new sink
pactl list short sink-inputs | awk '{print $1}' | while read -r INPUT; do
    pactl move-sink-input "$INPUT" "$NEXT"
done
