#!/usr/bin/env bash
# Generic toggle/focus script for any application
# Usage: toggle-app.sh <window-pattern> <launch-command>
#
# Example: toggle-app.sh "ghostty" "ghostty"
#          toggle-app.sh "firefox" "firefox"

if [ $# -lt 2 ]; then
    echo "Usage: $0 <window-pattern> <launch-command>"
    exit 1
fi

WINDOW_PATTERN="$1"
LAUNCH_COMMAND="$2"

# Find window matching the pattern (case-insensitive search in class)
WINDOW_ADDRESS=$(hyprctl clients -j | jq -r --arg pattern "$WINDOW_PATTERN" '.[] | select(.class | test($pattern; "i")) | .address' | head -n1)

if [ -n "$WINDOW_ADDRESS" ]; then
    # Window exists, focus it
    hyprctl dispatch focuswindow "address:$WINDOW_ADDRESS"
else
    # Window doesn't exist, launch it
    exec setsid $LAUNCH_COMMAND
fi
