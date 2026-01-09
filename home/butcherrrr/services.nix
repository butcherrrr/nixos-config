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
  # Colors are managed by catppuccin.mako.enable in butcherrrr.nix
  services.mako = {
    enable = true;

    settings = {
      # Layout
      width = 350;
      height = 100;
      margin = "20";
      padding = "15,20"; # vertical, horizontal
      border-size = 2;
      border-radius = 2;

      # Font
      font = "JetBrainsMono Nerd Font 17";

      # Behavior
      default-timeout = 3000; # 3 seconds
      ignore-timeout = false;

      # Positioning
      anchor = "top-right";

      # Layer - overlay to appear above waybar
      layer = "overlay";

      # Progress bar styling
      progress-color = "source #89b4fa"; # Catppuccin blue - uses source mode for better control

      # Format with progress bar
      format = "<b>%s</b>\\n%b";

      # Markup
      markup = true;
    };

    # Critical notifications stay until dismissed
    extraConfig = ''
      [urgency=critical]
      default-timeout=0
      border-color=#f38ba8
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
