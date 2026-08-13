#!/usr/bin/env sh

. "$CONFIG_DIR/colors.sh"

if [ "$SELECTED" = "true" ]; then
    sketchybar --set "$NAME" \
        icon.color="$BASE" \
        background.color="$ACCENT"
else
    sketchybar --set "$NAME" \
        icon.color="$TEXT" \
        background.color="$SURFACE0"
fi
