#!/usr/bin/env bash

sketchybar --add item media_icon q \
    --set media_icon icon=􀑪 label.drawing=off script="$PLUGIN_DIR/media_icon.sh" \
    --subscribe media_icon media_change

sketchybar --add item media_label e \
    --set media_label icon.drawing=off label.max_chars=20 scroll_texts=on script="$PLUGIN_DIR/media_label.sh" \
    --subscribe media_label media_change
