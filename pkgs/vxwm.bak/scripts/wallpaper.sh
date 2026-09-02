#!/bin/sh

# Define the wallpaper directory
WALLPAPER_DIR="$HOME/.local/share/wallpapers"

# Ensure the directory exists
if [ ! -d "$WALLPAPER_DIR" ]; then
    printf "Error: %s not found.\n" "$WALLPAPER_DIR"
    exit 1
fi

# List files and pipe to dmenu
# -i: case insensitive, -p: prompt, -l: vertical lines
CHOICE=$(ls "$WALLPAPER_DIR" | bemenu --tb "#1c1c1c" --tf "#eeeeee" --fb "#1c1c1c" --ff "#eeeeee" --cb "#1c1c1c" --hb "#1c1c1c" --sb "#1c1c1c" --ab "#1c1c1c" --nb "#1c1c1c"  -M 760 -i -c -p "Set Wallpaper:" -l 15)

# If the user didn't hit Esc (choice is not empty)
if [ -n "$CHOICE" ]; then
    feh --bg-fill "$WALLPAPER_DIR/$CHOICE"
fi
