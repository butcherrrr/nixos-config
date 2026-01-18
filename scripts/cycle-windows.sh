#!/usr/bin/env bash

# Cycle Windows - Cycle through windows on current workspace in consistent order
# Uses window address (creation order) instead of focus history
# Usage: cycle-windows.sh [next|prev]

direction="${1:-next}"

# Get current workspace
current_workspace=$(hyprctl activeworkspace -j | jq -r '.id')

# Get all windows on current workspace, sorted by address (consistent order)
windows=$(hyprctl clients -j | jq -r --arg workspace "$current_workspace" \
    '[.[] | select(.workspace.id == ($workspace | tonumber))] | sort_by(.address) | .[].address')

# Exit if no windows
if [ -z "$windows" ]; then
    exit 0
fi

# Get currently focused window address
current_window=$(hyprctl activewindow -j | jq -r '.address')

# Convert to array
IFS=$'\n' read -d '' -r -a window_array <<< "$windows"

# Find index of current window
current_index=-1
for i in "${!window_array[@]}"; do
    if [[ "${window_array[$i]}" == "$current_window" ]]; then
        current_index=$i
        break
    fi
done

# Calculate next/previous index
total_windows=${#window_array[@]}

if [ "$direction" = "next" ]; then
    next_index=$(( (current_index + 1) % total_windows ))
else
    next_index=$(( (current_index - 1 + total_windows) % total_windows ))
fi

# Focus the target window
target_window="${window_array[$next_index]}"
hyprctl dispatch focuswindow "address:$target_window"
