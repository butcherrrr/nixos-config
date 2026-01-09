#!/usr/bin/env bash

# Volume control script with swayosd for Hyprland
# Uses wpctl (WirePlumber/PipeWire) for audio control

case "$1" in
    up)
        swayosd-client --output-volume raise
        ;;
    down)
        swayosd-client --output-volume lower
        ;;
    mute)
        swayosd-client --output-volume mute-toggle
        ;;
    *)
        echo "Usage: $0 {up|down|mute}"
        exit 1
        ;;
esac
