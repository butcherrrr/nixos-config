{ ... }:

{
  # ============================================================================
  # Chromium Configuration
  # ============================================================================

  programs.chromium = {
    enable = true;

    # Command line arguments for Chromium
    commandLineArgs = [
      # Use system GTK theme (Catppuccin from theme.nix)
      "--gtk-version=4"
      # Enable Wayland support
      "--enable-features=UseOzonePlatform"
      "--ozone-platform=wayland"

      # Dark mode
      "--force-dark-mode"

      # Hardware acceleration
      "--enable-gpu-rasterization"
      "--enable-zero-copy"
    ];
  };
}
