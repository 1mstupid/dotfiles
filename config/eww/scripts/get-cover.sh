#!/bin/bash
# Extract and resize MPRIS cover art for Eww.

PLAYER="mpv,chromium,chrome,firefox,brave,%any"
COVER_DIR="/tmp/eww-music-cover"

mkdir -p "$COVER_DIR"

URL=$(playerctl --player="$PLAYER" metadata mpris:artUrl 2>/dev/null)

if [ -z "$URL" ]; then
    echo ""
    exit 0
fi

HASH=$(printf "%s" "$URL" | md5sum | cut -d' ' -f1)

ORIGINAL="$COVER_DIR/$HASH.img"
FINAL="$COVER_DIR/$HASH.png"

# Already cached
if [ -f "$FINAL" ]; then
    echo "$FINAL"
    exit 0
fi

# Remove old covers
rm -f "$COVER_DIR"/*

# Download/extract artwork
if [[ "$URL" == data:* ]]; then
    printf "%s" "${URL#*,}" \
        | tr -d '\n\r' \
        | base64 -d > "$ORIGINAL" 2>/dev/null

elif [[ "$URL" == file://* ]]; then
    cp "${URL#file://}" "$ORIGINAL" 2>/dev/null

else
    curl -fsSL "$URL" -o "$ORIGINAL" 2>/dev/null
fi

# Resize to exactly 56x56 (cover style)
if [ -f "$ORIGINAL" ]; then
        magick "$ORIGINAL" \
        -resize 76x76^ \
        -gravity center \
        -extent 76x76 \
        \( +clone \
            -alpha transparent \
            -background none \
            -fill white \
            -draw "roundrectangle 0,0,75,75,10,10" \
        \) \
        -compose CopyOpacity \
        -composite \
        "$FINAL"

    rm -f "$ORIGINAL"

    if [ -f "$FINAL" ]; then
        echo "$FINAL"
    else
        echo ""
    fi
else
    echo ""
fi
