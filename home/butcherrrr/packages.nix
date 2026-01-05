{ pkgs, ... }:

{
  # ============================================================================
  # User Packages
  # ============================================================================

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

    # Applications
    firefox
    slack
    obsidian
    
    # Media viewers
    imv    # Image viewer
    mpv    # Video player
  ];

  # ============================================================================
  # Scripts
  # ============================================================================

  # Install custom scripts
  home.file.".local/bin/toggle-terminal" = {
    source = ../../scripts/toggle-terminal.sh;
    executable = true;
  };
  
  home.file.".local/bin/toggle-zed" = {
    source = ../../scripts/toggle-zed.sh;
    executable = true;
  };
  
  home.file.".local/bin/toggle-firefox" = {
    source = ../../scripts/toggle-firefox.sh;
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
