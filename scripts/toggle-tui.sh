#!/usr/bin/env bash
# Toggle TUI applications in floating windows
# Usage: toggle-tui.sh <app-name> <command>
#
# Example: toggle-tui.sh "btop" "btop"
#          toggle-tui.sh "bluetui" "bluetui"
#          toggle-tui.sh "impala" "impala"
#
# These windows will be floating and not bound to workspaces.
# Only one instance per app can exist - if already open, it will be focused.

if [ $# -lt 2 ]; then
    echo "Usage: $0 <app-name> <command>"
    exit 1
fi

APP_NAME="$1"
shift
COMMAND="$@"

# Find window matching the TUI class with this app name in the initial title
# We use initialTitle because it's set at launch and doesn't change
WINDOW_ADDRESS=$(hyprctl clients -j | jq -r --arg app "$APP_NAME" '
  .[] |
  select(.class == "com.mitchellh.ghostty.tui") |
  select(.initialTitle == $app) |
  .address' | head -n1)

if [ -n "$WINDOW_ADDRESS" ]; then
    # Window exists, focus it
    hyprctl dispatch focuswindow "address:$WINDOW_ADDRESS"
else
    # Window doesn't exist, launch it in background
    # We use --title to set initialTitle for detection
    setsid -f ghostty --class=com.mitchellh.ghostty.tui --title="$APP_NAME" -e sh -c "$COMMAND" >/dev/null 2>&1 &
fi
