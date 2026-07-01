#!/usr/bin/env bash

space_separator=(
    icon=󰄛
    icon.color=$ACCENT_COLOR
    label.drawing=off
)

sketchybar --add item space_separator left \
    --set space_separator "${space_separator[@]}"
