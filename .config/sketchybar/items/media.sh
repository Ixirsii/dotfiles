#!/usr/bin/env bash

sketchybar --add item media_icon q \
           --set media background.drawing=off \
                       icon=􀑪 \
                       label.drawing=off \
                       padding_right=8 \
                       script="$PLUGIN_DIR/media_icon.sh" \
           --subscribe media_icon media_change

sketchybar --add item media_label e \
           --set media background.drawing=off \
                       icon.drawing=off \
                       label.max_chars=20 \
                       padding_left=8 \
                       scroll_texts=on \
                       script="$PLUGIN_DIR/media_label.sh" \
           --subscribe media_label media_change
