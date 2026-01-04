{ ... }:

{
  # ============================================================================
  # Services Configuration
  # ============================================================================

  # Mako notification daemon
  # Colors are managed by catppuccin.mako.enable in butcherrrr.nix
  services.mako = {
    enable = true;

    settings = {
      # Layout
      width = 300;
      height = 150;
      margin = "30";
      padding = "10";
      border-size = 1;
      border-radius = 5;

      # Font
      font = "JetBrainsMono Nerd Font 9";

      # Behavior
      default-timeout = 5000;  # 5 seconds
      ignore-timeout = false;

      # Positioning
      anchor = "top-right";

      # Layer - overlay to appear above waybar
      layer = "overlay";
    };

    # Critical notifications stay until dismissed
    extraConfig = ''
      [urgency=critical]
      default-timeout=0
    '';
  };
}
