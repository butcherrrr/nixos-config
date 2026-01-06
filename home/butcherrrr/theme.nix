{ pkgs, ... }:

{
  # Theme Configuration

  # Cursor theming
  home.pointerCursor = {
    gtk.enable = true;
    name = "Banana";
    package = pkgs.banana-cursor;
    size = 24;
  };

  # Wallpaper symlink
  home.file = {
    ".config/hypr/wallpaper.jpg" = {
      source = ../../backgrounds/minimalist-black-hole.png;
    };
  };
}
