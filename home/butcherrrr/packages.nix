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

    # System utilities
    fastfetch

    # Applications
    neovim
    firefox
  ];

  # ============================================================================
  # Scripts
  # ============================================================================

  # Install custom scripts
  home.file.".local/bin/toggle-terminal" = {
    source = ../../scripts/toggle-terminal.sh;
    executable = true;
  };
}
