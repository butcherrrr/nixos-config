#!/usr/bin/env bash

# Brightness control script with swayosd for Hyprland
# Uses brightnessctl for backlight control

case "$1" in
    up)
        swayosd-client --brightness raise
        ;;
    down)
        swayosd-client --brightness lower
        ;;
    *)
        echo "Usage: $0 {up|down}"
        exit 1
        ;;
esac
