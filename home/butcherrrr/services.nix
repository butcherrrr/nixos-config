{ pkgs, lib, ... }:

{
  # Services Configuration

  # SwayOSD - OSD overlay for volume and brightness
  # Styled with Catppuccin Mocha colors
  services.swayosd = {
    enable = true;

    # Catppuccin Mocha styling - green background, purple text/progress
    stylePath = pkgs.writeText "swayosd.css" ''
      window {
        background: rgba(166, 227, 161, 0.95); /* Catppuccin Mocha green */
      }

      progress {
        background: #1e1e2e; /* Catppuccin Mocha base */
      }

      label {
        color: #1e1e2e; /* Catppuccin Mocha base */
      }

      image {
        color: #1e1e2e; /* Catppuccin Mocha base */
      }
    '';
  };

  # Mako notification daemon
  # Styled with Catppuccin Mocha - green background, purple text
  services.mako = {
    enable = true;

    settings = {
      # Layout
      width = 450;
      height = 100;
      margin = "5,20,20,20"; # top, right, bottom, left - small top margin to overlay waybar
      padding = "15,20"; # vertical, horizontal
      border-size = 2;
      border-radius = 10;

      # Font
      font = "JetBrainsMono Nerd Font 14";

      # Behavior
      default-timeout = 3000; # 3 seconds
      ignore-timeout = false;

      # Positioning
      anchor = "top-center";

      # Layer - overlay to appear above waybar
      layer = "overlay";

      # Catppuccin Mocha colors - green background, purple text
      background-color = "#a6e3a1F2"; # Catppuccin Mocha green with transparency
      text-color = "#1e1e2e"; # Catppuccin Mocha base (dark purple)
      border-color = "#a6e3a1"; # Catppuccin Mocha green

      # Progress bar styling
      progress-color = "source #1e1e2e"; # Catppuccin Mocha base (dark purple)

      # Format with progress bar
      format = "<b>%s</b>\\n%b";

      # Markup
      markup = true;
    };

    # Critical notifications stay until dismissed
    extraConfig = ''
      [urgency=critical]
      default-timeout=0
      background-color=#a6e3a1F2
      border-color=#f38ba8
      text-color=#1e1e2e
    '';
  };

  # SwayOSD configuration file for top-center positioning and vertical orientation
  home.file.".config/swayosd/swayosd.conf".text = ''
    [osd]
    display = vertical
    anchor = top-center
    margin-top = 50
  '';
}
