#!/usr/bin/env bash
# If Firefox is open, focus it. Otherwise, launch a new instance.

FIREFOX_CMD="firefox"

FIREFOX_WINDOW=$(hyprctl clients -j | jq -r '.[] | select(.class | test("firefox"; "i")) | .address' | head -n1)

if [ -n "$FIREFOX_WINDOW" ]; then
    hyprctl dispatch workspace 3
    hyprctl dispatch focuswindow "address:$FIREFOX_WINDOW"
else
    hyprctl dispatch workspace 3
    $FIREFOX_CMD &
fi