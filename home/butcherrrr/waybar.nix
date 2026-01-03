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
        modules-right = ["tray" "network" "pulseaudio" "cpu" "memory" "battery" "clock"];

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
          format = "󰻠 {usage}%";
          tooltip = false;
        };

        memory = {
          format = " {percentage}%";
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󰚥 {capacity}%";
          format-alt = "{icon} {time}";
          format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        };

        network = {
          format-wifi = "󰖩 {signalStrength}%";
          format-ethernet = "󰈀 {ipaddr}/{cidr}";
          tooltip-format = "{ifname} via {gwaddr}";
          format-linked = "󰈂 {ifname} (No IP)";
          format-disconnected = "󰖪 Disconnected";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-bluetooth = "󰂯 {volume}%";
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

        tray = {
          icon-size = 18;
          spacing = 10;
        };
      };
    };

    # Custom Catppuccin Mocha styling
    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "JetBrainsMono Nerd Font";
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background: rgba(26, 27, 38, 0.95);
        color: #cdd6f4;
      }

      tooltip {
        background: #1e1e2e;
        border: 1px solid #45475a;
        border-radius: 8px;
      }

      tooltip label {
        color: #cdd6f4;
      }

      #workspaces {
        margin: 0 4px;
      }

      #workspaces button {
        padding: 0 8px;
        color: #6c7086;
        background: transparent;
        border-bottom: 2px solid transparent;
        transition: all 0.3s ease;
      }

      #workspaces button:hover {
        color: #cdd6f4;
        background: rgba(108, 112, 134, 0.1);
      }

      #workspaces button.active {
        color: #89b4fa;
        border-bottom: 2px solid #89b4fa;
      }

      #workspaces button.urgent {
        color: #f38ba8;
        border-bottom: 2px solid #f38ba8;
      }

      #window {
        margin: 0 8px;
        padding: 0 12px;
        color: #cdd6f4;
        font-weight: 500;
      }

      #clock {
        padding: 0 16px;
        color: #cdd6f4;
        font-weight: 600;
        background: rgba(137, 180, 250, 0.1);
        border-radius: 8px;
        margin: 4px 8px;
      }

      #cpu,
      #memory,
      #battery,
      #network,
      #pulseaudio,
      #tray {
        padding: 0 12px;
        margin: 4px 2px;
        background: rgba(69, 71, 90, 0.4);
        border-radius: 6px;
      }

      #cpu {
        color: #f9e2af;
      }

      #memory {
        color: #cba6f7;
      }

      #battery {
        color: #a6e3a1;
      }

      #battery.charging {
        color: #89dceb;
      }

      #battery.warning:not(.charging) {
        color: #fab387;
      }

      #battery.critical:not(.charging) {
        color: #f38ba8;
        animation: blink 1s linear infinite;
      }

      @keyframes blink {
        to {
          opacity: 0.5;
        }
      }

      #network {
        color: #89b4fa;
      }

      #network.disconnected {
        color: #f38ba8;
      }

      #pulseaudio {
        color: #89dceb;
      }

      #pulseaudio.muted {
        color: #6c7086;
      }

      #tray {
        padding: 0 8px;
      }

      #tray > .passive {
        -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
      }
    '';
  };
}
