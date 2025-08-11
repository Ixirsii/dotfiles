#!/usr/bin/env bash

if [ "$SENDER" = "space_windows_change" ]
then
  icons="$($CONFIG_DIR/functions/workspace_icons.sh "$1")"

  sketchybar --set $NAME label="$icons"
fi

if [ "$1" = "$AEROSPACE_FOCUSED_WORKSPACE" ]
then
  sketchybar --set $NAME background.drawing=on
else
  sketchybar --set $NAME background.drawing=off
fi
