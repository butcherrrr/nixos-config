{ pkgs, ... }:

{
  # ============================================================================
  # Services Configuration
  # ============================================================================

  # Mako notification daemon
  services.mako = {
    enable = true;
  };

  # Hyprpaper configuration file
  # Note: hyprpaper is started via Hyprland's exec-once
  home.file.".config/hypr/hyprpaper.conf".text = ''
    preload = ~/.config/hypr/wallpaper.jpg
    wallpaper = ,~/.config/hypr/wallpaper.jpg

    splash = false
    ipc = on
  '';
}
