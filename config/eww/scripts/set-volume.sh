#!/bin/bash
# $1 = volume percentage (0-100), eww scale may send decimals
VOL=$(printf "%.0f" "${1:-50}")
pactl set-sink-volume @DEFAULT_SINK@ "${VOL}%"
