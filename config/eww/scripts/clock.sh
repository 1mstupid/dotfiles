#!/bin/bash
LC_TIME=C

labels_short=()
labels_full=()
dates=()
days_active=()

for offset in -3 -2 -1 0 1 2 3; do
  day_name=$(date -d "$offset days" +%a | tr '[:lower:]' '[:upper:]')
  day_num=$(date -d "$offset days" +%-d)

  labels_short+=("$(echo "$day_name" | cut -c1)")
  labels_full+=("$day_name")
  dates+=("$day_num")

  if [ "$offset" -eq 0 ]; then
    days_active+=("true")
  else
    days_active+=("false")
  fi
done

jq -n \
  --arg time "$(date +%I:%M)" \
  --arg progress "$(date +%S | awk '{printf "%.1f", ($1/60)*100}')" \
  --argjson days "[${days_active[0]},${days_active[1]},${days_active[2]},${days_active[3]},${days_active[4]},${days_active[5]},${days_active[6]}]" \
  --argjson labels_short "$(printf '%s\n' "${labels_short[@]}" | jq -R . | jq -s .)" \
  --argjson labels_full "$(printf '%s\n' "${labels_full[@]}" | jq -R . | jq -s .)" \
  --argjson dates "$(printf '%s\n' "${dates[@]}" | jq -R . | jq -s .)" \
  '{
    "clock-time": $time,
    "clock-progress": ($progress | tonumber),
    "clock-days": $days,
    "clock-week-labels-short": $labels_short,
    "clock-week-labels-full": $labels_full,
    "clock-week-dates": $dates
  }'
