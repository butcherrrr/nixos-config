{ pkgs, ... }:

{
  # User Packages

  # Packages installed for this user (not system-wide)
  # Only include packages WITHOUT home-manager modules
  home.packages = with pkgs; [
    # Icons for rofi
    papirus-icon-theme

    # Wayland utilities
    swaybg
    swayidle

    # System utilities
    fastfetch
    brightnessctl

    # Development tools
    nodejs
    python3
    go
    rustup
    nil # Nix language server

    # Applications
    firefox
    slack
    obsidian

    # Media viewers
    imv # Image viewer
    mpv # Video player
  ];

  # Scripts
  home.file.".local/bin/toggle-app" = {
    source = ../../scripts/toggle-app.sh;
    executable = true;
  };

  home.file.".local/bin/volume" = {
    source = ../../scripts/volume.sh;
    executable = true;
  };

  home.file.".local/bin/brightness" = {
    source = ../../scripts/brightness.sh;
    executable = true;
  };
}
