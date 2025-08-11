#!/usr/bin/env bash

if [ "$SENDER" = "front_app_switched" ]
then
  sketchybar --set "$NAME" icon="$($CONFIG_DIR/functions/icon_map.sh "$INFO")" label="$INFO"
fi
