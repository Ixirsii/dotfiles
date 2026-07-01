#!/usr/bin/env bash

front_app=(
    display=active
    script="$PLUGIN_DIR/front_app.sh"
)

sketchybar --add item front_app left \
    --set front_app "${front_app[@]}" \
    --subscribe front_app front_app_switched
