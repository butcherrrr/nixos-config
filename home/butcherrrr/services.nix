{ ... }:

{
  # Services Configuration

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

      [app-name=volume]
      format=<b>%s</b>\n%b

      [app-name=brightness]
      format=<b>%s</b>\n%b
    '';
  };
}
