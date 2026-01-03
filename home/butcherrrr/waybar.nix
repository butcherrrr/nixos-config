{ pkgs, ... }:

{
  # ============================================================================
  # Waybar Configuration
  # ============================================================================

  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 26;
        spacing = 0;

        modules-left = ["hyprland/workspaces"];
        modules-center = [];
        modules-right = ["tray" "bluetooth" "network" "pulseaudio" "cpu" "battery" "clock"];

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            default = "";
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
            "10" = "0";
          };
          persistent-workspaces = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
            "5" = [];
          };
        };

        clock = {
          format = "{:L%A %H:%M}";
          format-alt = " {:%A, %B %d, %Y (%H:%M)}";
          tooltip = false;
        };

        cpu = {
          format = "󰻠";
          tooltip = false;
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon}";
          format-charging = "󰂄";
          format-plugged = "󰚥";
          format-alt = "{icon} {time}";
          format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        };

        network = {
          format-icons =["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
          format = "{icon}";
          format-wifi = "{icon}";
          format-ethernet = "󰀂";
          format-disconnected = "󰤮";
          tooltip-format-wifi = "{essid} ({frequency} GHz)\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
          tooltip-format-ethernet = "⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
          tooltip-format-disconnected = "Disconnected";
        };

        pulseaudio = {
          format = "{icon}";
          format-bluetooth = "󰂯";
          format-bluetooth-muted = "󰂲";
          format-muted = "󰖁";
          format-icons = {
            headphone = "󰋋";
            hands-free = "󰋎";
            headset = "󰋎";
            phone = "󰄜";
            portable = "󰄜";
            car = "󰄋";
            default = ["󰕿" "󰖀" "󰕾"];
          };
          on-click = "pavucontrol";
        };

        bluetooth = {
          format = "󰂯";
          format-disabled = "󰂲";
          format-connected = "󰂱 {num_connections}";
          tooltip-format = "{controller_alias}\t{controller_address}";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          on-click = "ghostty -e bluetui";
        };

        tray = {
          icon-size = 18;
          spacing = 10;
        };
      };
    };

    # Styles loaded from separate CSS file
    style = builtins.readFile ./waybar-style.css;
  };
}
