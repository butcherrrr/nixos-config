{ pkgs, ... }:

{
  # ============================================================================
  # Theme Configuration
  # ============================================================================

  # Cursor theming
  home.pointerCursor = {
    gtk.enable = true;
    name = "catppuccin-mocha-blue-cursors";
    package = pkgs.catppuccin-cursors.mochaBlue;
    size = 24;
  };

  # Wallpaper symlink
  home.file = {
    ".config/hypr/wallpaper.jpg" = {
      source = ../../backgrounds/minimalist-black-hole.png;
    };
  };
}