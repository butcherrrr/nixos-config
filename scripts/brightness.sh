#!/usr/bin/env bash

# Brightness control script with notifications for Hyprland
# Uses brightnessctl for backlight control

get_brightness() {
    brightnessctl -m | cut -d',' -f4 | tr -d '%'
}

send_notification() {
    brightness=$(get_brightness)
    
    # Select icon based on brightness level
    if [ "$brightness" -ge 75 ]; then
        icon="󰃠"
    elif [ "$brightness" -ge 50 ]; then
        icon="󰃟"
    elif [ "$brightness" -ge 25 ]; then
        icon="󰃝"
    else
        icon="󰃞"
    fi
    
    notify-send -a "brightness" \
        -u low \
        -h string:x-canonical-private-synchronous:brightness \
        -h int:value:"$brightness" \
        "Brightness" "${icon}  ${brightness}%"
}

case "$1" in
    up)
        brightnessctl set 5%+
        ;;
    down)
        brightnessctl set 5%-
        ;;
    *)
        echo "Usage: $0 {up|down}"
        exit 1
        ;;
esac