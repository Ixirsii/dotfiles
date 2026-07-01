#!/usr/bin/env bash

apple_logo=(
    background.drawing=off
    icon=􀣺
    icon.padding_right=10
    label.drawing=off
)

sketchybar --add item apple.logo left \
    --set apple.logo "${apple_logo[@]}"
