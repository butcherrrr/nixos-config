{ pkgs, awww, ... }:

{
  # User Packages

  # Packages installed for this user (not system-wide)
  # Only include packages WITHOUT home-manager modules
  home.packages = with pkgs; [
    # Wayland utilities
    awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
    swayidle

    # System utilities
    fastfetch
    brightnessctl
    bat
    dust

    # Development tools
    nodejs
    python3
    go
    rustup
    nil # Nix language server
    lazygit
    lazydocker
    lazysql

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

  home.file.".local/bin/toggle-tui" = {
    source = ../../scripts/toggle-tui.sh;
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

  home.file.".local/bin/wallpaper" = {
    source = ../../scripts/wallpaper.sh;
    executable = true;
  };

  home.file.".local/bin/cycle-windows" = {
    source = ../../scripts/cycle-windows.sh;
    executable = true;
  };

  home.file.".local/bin/focus-window-number" = {
    source = ../../scripts/focus-window-number.sh;
    executable = true;
  };
}
