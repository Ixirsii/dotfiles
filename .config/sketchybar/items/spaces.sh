#!/usr/bin/env bash

for monitor in $(aerospace list-monitors | awk '{print $1}')
do
  for sid in $(aerospace list-workspaces --monitor "$monitor")
  do
    icons="$($FUNCTION_DIR/workspace_icons.sh "$sid")"

    space=(
      click_script="aerospace workspace $sid"
      drawing=on
      icon="$sid"
      icon.font="$LABEL_FONT"
      icon.padding_right=0
      label="$icons"
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

space_separator=(
  background.drawing=off
  icon=􀆊
  icon.padding_right=8
  label.drawing=off
)

sketchybar --add item space_separator left \
           --set space_separator "${space_separator[@]}"
