#!/usr/bin/env bash
# Toggle/Focus Zed Editor Script
# If Zed is open, focus it. Otherwise, launch a new one.

TERMINAL_CMD="zeditor"

# Try to find Zed window by checking common class names
ZED_WINDOW=$(hyprctl clients -j | jq -r '.[] | select(.class | test("zed"; "i")) | .address' | head -n1)

if [ -n "$ZED_WINDOW" ]; then
    # Zed exists, switch to workspace 2 and focus it
    hyprctl dispatch workspace 2
    hyprctl dispatch focuswindow "address:$ZED_WINDOW"
else
    # No Zed found, switch to workspace 2 and launch a new one
    hyprctl dispatch workspace 2
    $TERMINAL_CMD &
fi
