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

    # Applications
    neovim
    firefox
    zed-editor
  ];
}
