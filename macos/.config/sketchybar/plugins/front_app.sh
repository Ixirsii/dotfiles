#!/usr/bin/env bash

source $CONFIG_DIR/functions/icon_map.sh

if [ "$SENDER" = "front_app_switched" ]; then
    sketchybar --set "$NAME" icon="$(icon_map "$INFO")" label="$INFO"
fi
