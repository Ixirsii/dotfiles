#!/usr/bin/env sh

. "$CONFIG_DIR/colors.sh"

INFO="$(media-control get)"
if [ "$(printf '%s\n' "$INFO" | jq -r '.playing')" = "true" ]; then
    MEDIA="$(echo "$INFO" | jq -r '.artist + " - " + .title')"

    sketchybar --set "$NAME" drawing=on label="$MEDIA"
else
    sketchybar --set "$NAME" drawing=off
fi
