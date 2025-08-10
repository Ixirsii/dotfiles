#!/usr/bin/env bash

if [ "$SENDER" = "space_change" ]; then
  source "$CONFIG_DIR/colors.sh"

  sketchybar --set space.$(aerospace list-workspaces --all) \
    background.drawing=off \
    label.color=$ACCENT_COLOR \
    icon.color=$ACCENT_COLOR

  sketchybar --set space.$(aerospace list-workspaces --focused) \
    background.drawing=on \
    background.color=$ITEM_BG_COLOR \
    label.color=$ACCENT_COLOR \
    icon.color=$ACCENT_COLOR
fi
