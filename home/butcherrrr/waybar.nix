{ ... }:

{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        reload_style_on_change = true;
        layer = "top";
        position = "top";
        height = 28;
        spacing = 0;
        margin-top = 26;
        margin-left = 26;
        margin-right = 26;

        modules-left = [
          "custom/nix"
        ];

        modules-center = [ ];

        modules-right = [
          "tray"
          "group/network"
          "clock"
          "custom/notification"
        ];

        "hyprland/workspaces" = {
          format = "{name}";
          all-outputs = false;
          active-only = true;
          disable-click = true;
        };

        clock = {
          format = "{:%A, %H:%M}";
          format-alt = "{:%Y-%m-%d %H:%M:%S}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "month";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#f5e0dc'><b>{}</b></span>";
              days = "<span color='#cdd6f4'><b>{}</b></span>";
              weeks = "<span color='#89dceb'><b>W{}</b></span>";
              weekdays = "<span color='#f9e2af'><b>{}</b></span>";
              today = "<span color='#f38ba8'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            on-click-right = "mode";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };

        "custom/notification" = {
          tooltip = false;
          format = "{icon}";
          format-icons = {
            notification = "<span foreground='#a6e3a1'>󰂚</span>";
            none = "󰂚";
            dnd-notification = "<span foreground='#a6e3a1'>󰂚</span>";
            dnd-none = "󰂚";
            inhibited-notification = "<span foreground='#a6e3a1'>󰂚</span>";
            inhibited-none = "󰂚";
            dnd-inhibited-notification = "<span foreground='#a6e3a1'>󰂚</span>";
            dnd-inhibited-none = "󰂚";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };

        "group/network" = {
          orientation = "horizontal";
          modules = [
            "hyprland/workspaces"
            "network"
            "bluetooth"
            "cpu"
            "battery"
          ];
        };

        cpu = {
          interval = 10;
          format = "󰍛";
          tooltip = true;
          on-click = "~/.local/bin/toggle-tui btop 'btop'";
        };

        network = {
          format-icons = [
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];
          format = "{icon}";
          format-wifi = "{icon}";
          format-ethernet = "󰀂";
          format-disconnected = "󰤮";
          tooltip-format-wifi = "{essid} ({frequency} GHz)\nSignal: {signalStrength}%\n󰇚 {bandwidthDownBytes}  󰕒 {bandwidthUpBytes}";
          tooltip-format-ethernet = "{ifname}\n󰇚 {bandwidthDownBytes}  󰕒 {bandwidthUpBytes}";
          tooltip-format-disconnected = "Disconnected";
          interval = 5;
          on-click = "~/.local/bin/toggle-tui impala 'impala'";
        };

        bluetooth = {
          format = "󰂯";
          format-disabled = "󰂲";
          format-off = "󰂲";
          format-connected = "󰂱 {num_connections}";
          format-connected-battery = "󰂱";
          tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
          on-click = "~/.local/bin/toggle-tui bluetui 'bluetui'";
        };

        battery = {
          interval = 30;
          format = "{icon}";
          format-discharging = "{icon}";
          format-charging = "󰂄";
          format-plugged = "󰚥";
          format-full = "󱟢";
          format-icons = {
            charging = [
              "󰢜"
              "󰂆"
              "󰂇"
              "󰂈"
              "󰢝"
              "󰂉"
              "󰢞"
              "󰂊"
              "󰂋"
              "󰂅"
            ];
            default = [
              "󰂎"
              "󰁺"
              "󰁻"
              "󰁼"
              "󰁽"
              "󰁾"
              "󰁿"
              "󰂀"
              "󰂁"
              "󰂂"
              "󰁹"
            ];
          };
          tooltip-format = "{capacity}%\n{timeTo}\nPower: {power:0.1f}W\nHealth: {health}%";
          tooltip-format-charging = "{capacity}% - Charging: {timeTo}\nPower: {power:0.1f}W ↑";
          tooltip-format-discharging = "{capacity}% - Discharging: {timeTo}\nPower: {power:0.1f}W ↓";
          tooltip-format-full = "{capacity}% - Battery Full\nHealth: {health}%";
          states = {
            warning = 30;
            critical = 15;
          };
        };

        tray = {
          icon-size = 18;
          spacing = 12;
          show-passive-items = true;
        };

        "custom/nix" = {
          format = "󱄅";
          tooltip-format = "NixOS";
          on-click = "~/.local/bin/toggle-tui fastfetch 'fastfetch; echo; read -p \"Press enter to close...\"'";
        };
      };
    };

    style = builtins.readFile ./waybar-style.gtk.css;
  };
}
