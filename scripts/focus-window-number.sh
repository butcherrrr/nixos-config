#!/usr/bin/env bash

# Focus Window by Number - Focus the Nth window on current workspace
# Uses window address (creation order) for consistent numbering
# Usage: focus-window-number.sh <number>

window_number="$1"

# Exit if no number provided
if [ -z "$window_number" ]; then
    echo "Usage: focus-window-number.sh <number>"
    exit 1
fi

# Get current workspace
current_workspace=$(hyprctl activeworkspace -j | jq -r '.id')

# Get all windows on current workspace, sorted by address (consistent order)
windows=$(hyprctl clients -j | jq -r --arg workspace "$current_workspace" \
    '[.[] | select(.workspace.id == ($workspace | tonumber))] | sort_by(.address) | .[].address')

# Exit if no windows
if [ -z "$windows" ]; then
    exit 0
fi

# Convert to array
IFS=$'\n' read -d '' -r -a window_array <<< "$windows"

# Get total number of windows
total_windows=${#window_array[@]}

# Check if requested number is valid (1-based indexing for user, 0-based for array)
if [ "$window_number" -lt 1 ] || [ "$window_number" -gt "$total_windows" ]; then
    # Silently exit if number is out of range (no windows at that position)
    exit 0
fi

# Convert to 0-based index
window_index=$((window_number - 1))

# Focus the target window
target_window="${window_array[$window_index]}"
hyprctl dispatch focuswindow "address:$target_window"
