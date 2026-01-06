#!/usr/bin/env bash
# If a terminal (ghostty) is open, focus it. Otherwise, launch a new one.

TERMINAL_CMD="ghostty"

TERMINAL_WINDOW=$(hyprctl clients -j | jq -r '.[] | select(.class | test("ghostty"; "i")) | .address' | head -n1)

if [ -n "$TERMINAL_WINDOW" ]; then
    hyprctl dispatch focuswindow "address:$TERMINAL_WINDOW"
else
    exec setsid $TERMINAL_CMD
fi
