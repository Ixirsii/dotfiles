#!/usr/bin/env bash

for m in $(aerospace list-monitors | awk '{print $1}'); do
  for sid in $(aerospace list-workspaces --monitor $m); do
    space=(
      space="$sid"
      icon="$sid"
      label.font="sketchybar-app-font:Regular:16.0"
      label.padding_right=20
      label.y_offset=-1
      click_script="aerospace workspace $sid"
      script="$PLUGIN_DIR/space.sh"
    )

    sketchybar --add space space.$sid left \
               --set space.$sid "${space[@]}" \
               --subscribe space.$sid aerospace_workspace_change

    apps=$(aerospace list-windows --workspace $sid | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')

    icon_strip=" "
    if [ "${apps}" != "" ]; then
        while read -r app
        do
        icon_strip+=" $($PLUGIN_DIR/icon_map.sh "$app")"
        done <<< "${apps}"
    else
        icon_strip=" —"
    fi

    sketchybar --set space.$sid label="$icon_strip"
  done
done

space_creator=(
  icon=􀆊
  icon.color=$ACCENT_COLOR
  icon.padding_left=4
  label.drawing=off
  background.drawing=off
  script="$PLUGIN_DIR/space_windows.sh"
)

sketchybar --add item space_creator left               \
           --set space_creator "${space_creator[@]}"   \
           --subscribe space_separator space_windows_change aerospace_workspace_change aerospace_monitor_change
