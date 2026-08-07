#!/usr/bin/env sh

. "$CONFIG_DIR/colors.sh"

case "$NAME" in
    clock)
        sketchybar --set "$NAME" label="$(date '+%a %d %b %H:%M')"
        ;;
    volume)
        if [ "$SENDER" = "volume_change" ] && [ -n "$INFO" ]; then
            volume="${INFO%.*}"
        else
            volume="$(osascript -e 'output volume of (get volume settings)')"
        fi

        case "$volume" in
            0) icon="󰝟" ;;
            [1-2][0-9]|[1-9]) icon="󰕿" ;;
            [3-6][0-9]) icon="󰖀" ;;
            *) icon="󰕾" ;;
        esac

        sketchybar --set "$NAME" icon="$icon" label="$volume%"
        ;;
    battery)
        battery="$(pmset -g batt)"
        percentage="$(printf '%s\n' "$battery" | grep -Eo '[0-9]+%' | tr -d '%')"

        [ -n "$percentage" ] || exit 0

        case "$percentage" in
            100|9[0-9]) icon="󰁹"; charging_icon="󰂅" ;;
            8[0-9]) icon="󰂂"; charging_icon="󰂋" ;;
            7[0-9]) icon="󰂁"; charging_icon="󰂊" ;;
            6[0-9]) icon="󰂀"; charging_icon="󰢞" ;;
            5[0-9]) icon="󰁿"; charging_icon="󰂉" ;;
            4[0-9]) icon="󰁾"; charging_icon="󰢝" ;;
            3[0-9]) icon="󰁽"; charging_icon="󰂈" ;;
            2[0-9]) icon="󰁼"; charging_icon="󰂇" ;;
            1[0-9]) icon="󰁻"; charging_icon="󰂆" ;;
            *) icon="󰁺"; charging_icon="󰢜" ;;
        esac

        color="$TEXT"
        if [ "$percentage" -le 15 ]; then
            color="$RED"
        elif [ "$percentage" -le 30 ]; then
            color="$YELLOW"
        fi

        case "$battery" in
            *"; charging;"*|*"; charged;"*) icon="$charging_icon"; color="$GREEN" ;;
        esac

        sketchybar --set "$NAME" icon="$icon" icon.color="$color" label="$percentage%"
        ;;
esac
