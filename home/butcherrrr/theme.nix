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
    ".local/share/backgrounds/black-hole.png" = {
      source = ../../backgrounds/black-hole.png;
    };
    ".local/share/backgrounds/bluehour.jpg" = {
      source = ../../backgrounds/bluehour.jpg;
    };
    ".local/share/backgrounds/cloud-coffee.jpg" = {
      source = ../../backgrounds/cloud-coffee.jpg;
    };
    ".local/share/backgrounds/dominik-mayer-18.png" = {
      source = ../../backgrounds/dominik-mayer-18.png;
    };
    ".local/share/backgrounds/jellyfish.jpg" = {
      source = ../../backgrounds/jellyfish.jpg;
    };
    ".local/share/backgrounds/minimalist-black-hole.png" = {
      source = ../../backgrounds/minimalist-black-hole.png;
    };
    ".local/share/backgrounds/nix-black-4k.png" = {
      source = ../../backgrounds/nix-black-4k.png;
    };
    ".local/share/backgrounds/old-computer.png" = {
      source = ../../backgrounds/old-computer.png;
    };
    ".local/share/backgrounds/wavy_lines_v02_5120x2880.png" = {
      source = ../../backgrounds/wavy_lines_v02_5120x2880.png;
    };
  };
}
