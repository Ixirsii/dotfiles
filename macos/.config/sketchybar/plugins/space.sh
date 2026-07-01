#!/usr/bin/env bash

source $CONFIG_DIR/functions/icon_map.sh

function space() {
    if [ "$SENDER" = "space_windows_change" ]; then
        icons=$(workspace_icons "$1")

        sketchybar --set $NAME label="$icons"
    elif [ "$SENDER" = "aerospace_workspace_change" ]; then
        if [ "$1" = "$AEROSPACE_FOCUSED_WORKSPACE" ]; then
            sketchybar --set $NAME background.drawing=on
        else
            sketchybar --set $NAME background.drawing=off
        fi
    fi
}

function workspace_icons() {
    apps=$(aerospace list-windows --workspace "$1" | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')
    icons=""

    if [ "${apps}" != "" ]; then
        while read -r app; do
            icons+=" $(icon_map "$app")"
        done <<<"${apps}"
    else
        icons=" —"
    fi

    echo "$icons"
}

space "$@"
