#!/usr/bin/env bash

# Volume control script with notifications for Hyprland
# Uses wpctl (WirePlumber/PipeWire) for audio control

# Get the default audio sink
get_volume() {
    wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}'
}

is_muted() {
    wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q "MUTED"
}

send_notification() {
    volume=$(get_volume)
    
    if is_muted; then
        icon="󰖁"
        notify-send -a "volume" \
            -u low \
            -h string:x-canonical-private-synchronous:volume \
            -h int:value:0 \
            "Volume" "${icon}  Muted"
    else
        # Select icon based on volume level
        if [ "$volume" -ge 70 ]; then
            icon="󰕾"
        elif [ "$volume" -ge 30 ]; then
            icon="󰖀"
        else
            icon="󰕿"
        fi
        
        notify-send -a "volume" \
            -u low \
            -h string:x-canonical-private-synchronous:volume \
            -h int:value:"$volume" \
            "Volume" "${icon}  ${volume}%"
    fi
}

case "$1" in
    up)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ --limit 1.0
        ;;
    down)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
        ;;
    mute)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        ;;
    *)
        echo "Usage: $0 {up|down|mute}"
        exit 1
        ;;
esac