#!/usr/bin/env bash

for monitor in $(aerospace list-monitors | awk '{print $1}'); do
    for sid in $(aerospace list-workspaces --monitor $monitor); do
        space=(
            click_script="aerospace workspace $sid"
            icon=$sid
            icon.font="$LABEL_FONT"
            icon.padding_right=0
            label.font="$ICON_FONT"
            label.padding_left=4
            label.padding_right=8
            script="$PLUGIN_DIR/space.sh $sid"
        )

        sketchybar --add item space.$sid left \
            --set space.$sid "${space[@]}" \
            --subscribe space.$sid aerospace_workspace_change space_windows_change
    done
done
