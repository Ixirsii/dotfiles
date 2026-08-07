#!/usr/bin/env sh

. "$CONFIG_DIR/colors.sh"

if [ "$SELECTED" = "true" ]; then
    sketchybar --set "$NAME" \
        icon.color="$BASE" \
        background.color="$SKY"
else
    sketchybar --set "$NAME" \
        icon.color="$TEXT" \
        background.color="$SURFACE0"
fi
