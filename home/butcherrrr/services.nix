{ config, pkgs, ... }:

{
  # ============================================================================
  # Services Configuration
  # ============================================================================

  # Mako notification daemon
  services.mako = {
    enable = true;
  };

  # Swaybg wallpaper service (more reliable than hyprpaper)
  # The wallpaper symlink is created in theme.nix
  # Note: This will be started via Hyprland's exec-once
}
