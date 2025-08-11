#!/usr/bin/env bash

STATE="$(echo "$INFO" | jq -r '.state')"
if [ "$STATE" = "playing" ]
then
  sketchybar --set $NAME drawing=on
else
  sketchybar --set $NAME drawing=off
fi
