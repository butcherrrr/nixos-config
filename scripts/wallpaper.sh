#!/usr/bin/env bash
# Wallpaper management script for Hyprland with awww
# Usage: wallpaper.sh <random|next|prev>
#
# random - Select a random wallpaper from the backgrounds directory
# next   - Cycle to the next wallpaper
# prev   - Cycle to the previous wallpaper
#
# Uses awww for smooth animated transitions between wallpapers

if [ $# -lt 1 ]; then
    echo "Usage: $0 <random|next|prev>"
    exit 1
fi

ACTION="$1"

# Backgrounds directory in the nix store
BACKGROUNDS_DIR="$HOME/.local/share/backgrounds"

# Current wallpaper tracking file
CURRENT_WALLPAPER_FILE="$HOME/.cache/hyprland/current-wallpaper"

# Create cache directory if it doesn't exist
mkdir -p "$(dirname "$CURRENT_WALLPAPER_FILE")"

# Get all wallpaper files
mapfile -t WALLPAPERS < <(find -L "$BACKGROUNDS_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" \) | sort)

# Check if we have any wallpapers
if [ ${#WALLPAPERS[@]} -eq 0 ]; then
    echo "No wallpapers found in $BACKGROUNDS_DIR"
    exit 1
fi

set_wallpaper() {
    local wallpaper="$1"
    echo "$wallpaper" > "$CURRENT_WALLPAPER_FILE"

    # Set wallpaper with awww
    # Transition options: simple, fade, wipe, grow, wave, center, outer, any, random
    # --transition-step: smaller values = faster transition (1-255, default is 90)
    awww img "$wallpaper" \
        --transition-type random \
        --transition-fps 60 \
        --transition-step 30
}

case "$ACTION" in
    random)
        RANDOM_INDEX=$((RANDOM % ${#WALLPAPERS[@]}))
        SELECTED_WALLPAPER="${WALLPAPERS[$RANDOM_INDEX]}"
        set_wallpaper "$SELECTED_WALLPAPER"
        echo "Set random wallpaper: $(basename "$SELECTED_WALLPAPER")"
        ;;

    next)
        if [ -f "$CURRENT_WALLPAPER_FILE" ]; then
            CURRENT=$(cat "$CURRENT_WALLPAPER_FILE")
        else
            set_wallpaper "${WALLPAPERS[0]}"
            echo "Set wallpaper: $(basename "${WALLPAPERS[0]}")"
            exit 0
        fi

        CURRENT_INDEX=-1
        for i in "${!WALLPAPERS[@]}"; do
            if [ "${WALLPAPERS[$i]}" = "$CURRENT" ]; then
                CURRENT_INDEX=$i
                break
            fi
        done

        # Calculate next index (with wrapping)
        if [ $CURRENT_INDEX -eq -1 ]; then
            NEXT_INDEX=0
        else
            NEXT_INDEX=$(( (CURRENT_INDEX + 1) % ${#WALLPAPERS[@]} ))
        fi

        set_wallpaper "${WALLPAPERS[$NEXT_INDEX]}"
        echo "Set wallpaper: $(basename "${WALLPAPERS[$NEXT_INDEX]}")"
        ;;

    prev)
        if [ -f "$CURRENT_WALLPAPER_FILE" ]; then
            CURRENT=$(cat "$CURRENT_WALLPAPER_FILE")
        else
            LAST_INDEX=$((${#WALLPAPERS[@]} - 1))
            set_wallpaper "${WALLPAPERS[$LAST_INDEX]}"
            echo "Set wallpaper: $(basename "${WALLPAPERS[$LAST_INDEX]}")"
            exit 0
        fi

        CURRENT_INDEX=-1
        for i in "${!WALLPAPERS[@]}"; do
            if [ "${WALLPAPERS[$i]}" = "$CURRENT" ]; then
                CURRENT_INDEX=$i
                break
            fi
        done

        if [ $CURRENT_INDEX -eq -1 ]; then
            PREV_INDEX=$((${#WALLPAPERS[@]} - 1))
        elif [ $CURRENT_INDEX -eq 0 ]; then
            PREV_INDEX=$((${#WALLPAPERS[@]} - 1))
        else
            PREV_INDEX=$((CURRENT_INDEX - 1))
        fi

        set_wallpaper "${WALLPAPERS[$PREV_INDEX]}"
        echo "Set wallpaper: $(basename "${WALLPAPERS[$PREV_INDEX]}")"
        ;;

    *)
        echo "Invalid action: $ACTION"
        echo "Use 'random', 'next', or 'prev'"
        exit 1
        ;;
esac
