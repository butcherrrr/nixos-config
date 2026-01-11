{ ... }:

{
  programs.fastfetch = {
    enable = true;

    settings = {
      logo = {
        type = "kitty-direct";
        source = "~/.config/waybar/assets/NixOS.png";
        width = 30;
        height = 15;
        padding = {
          top = 1;
          left = 2;
          right = 3;
        };
      };

      display = {
        separator = " ";
        color = {
          keys = "blue";
          title = "magenta";
        };
      };

      modules = [
        {
          type = "title";
          color = {
            user = "blue";
            host = "magenta";
          };
        }
        {
          type = "separator";
          string = "─────────────────────────────────";
        }

        # System
        {
          type = "custom";
          format = "╭─   System ─────────────────────╮";
        }
        {
          type = "os";
          key = "│    ";
          keyColor = "blue";
        }
        {
          type = "host";
          key = "│    ";
          keyColor = "green";
        }
        {
          type = "kernel";
          key = "│    ";
          keyColor = "yellow";
        }
        {
          type = "uptime";
          key = "│    ";
          keyColor = "red";
        }
        {
          type = "packages";
          key = "│    ";
          keyColor = "cyan";
        }

        # Desktop
        {
          type = "custom";
          format = "├─   Desktop ────────────────────┤";
        }
        {
          type = "de";
          key = "│    ";
          keyColor = "cyan";
        }
        {
          type = "wm";
          key = "│    ";
          keyColor = "blue";
        }
        {
          type = "wmtheme";
          key = "│    ";
          keyColor = "magenta";
        }
        {
          type = "terminal";
          key = "│    ";
          keyColor = "green";
        }
        {
          type = "shell";
          key = "│    ";
          keyColor = "magenta";
        }
        {
          type = "display";
          key = "│    ";
          keyColor = "yellow";
        }

        # Hardware
        {
          type = "custom";
          format = "├─   Hardware ───────────────────┤";
        }
        {
          type = "cpu";
          key = "│    ";
          keyColor = "red";
        }
        {
          type = "gpu";
          key = "│    ";
          keyColor = "blue";
        }
        {
          type = "memory";
          key = "│    ";
          keyColor = "yellow";
        }
        {
          type = "disk";
          key = "│    ";
          keyColor = "magenta";
        }
        {
          type = "battery";
          key = "│    ";
          keyColor = "green";
        }

        {
          type = "custom";
          format = "╰────────────────────────────────╯";
        }
        {
          type = "separator";
          string = "─────────────────────────────────";
        }
        {
          type = "colors";
          symbol = "circle";
        }
      ];

    };
  };
}
