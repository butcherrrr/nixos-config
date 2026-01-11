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

  home.file = {
    ".local/share/backgrounds/minimalist-black-hole.png" = {
      source = ../../backgrounds/minimalist-black-hole.png;
    };
    ".local/share/backgrounds/nix-black-4k.png" = {
      source = ../../backgrounds/nix-black-4k.png;
    };
    ".local/share/backgrounds/wavy_lines_v02_5120x2880.png" = {
      source = ../../backgrounds/wavy_lines_v02_5120x2880.png;
    };
  };
}
