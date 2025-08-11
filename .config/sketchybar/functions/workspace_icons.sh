#!/usr/bin/env bash

function workspace_icons() {
    apps=$(aerospace list-windows --workspace "$1" | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')
    icons=""

    if [ "${apps}" != "" ]
    then
        while read -r app
        do
        icons+=" $($CONFIG_DIR/functions/icon_map.sh "$app")"
        done <<< "${apps}"
    else
        icons=" —"
    fi

    echo "$icons"
}

workspace_icons "$@"
