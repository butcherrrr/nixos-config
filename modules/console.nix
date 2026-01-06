{ ... }:

{
  # ============================================================================
  # Console Configuration (No Plymouth)
  # ============================================================================

  # Disable Plymouth boot splash
  boot.plymouth.enable = false;

  # Kernel parameters for clean boot
  boot.kernelParams = [
    "quiet"           # Suppress most kernel messages
    "vt.global_cursor_default=0"  # Hide blinking cursor
    "loglevel=3"      # Reduce kernel log verbosity
  ];

  # Set console resolution for larger text
  boot.loader.systemd-boot.consoleMode = "1";  # Use mode 1 (lower resolution, bigger text)

  # ============================================================================
  # Console Configuration
  # ============================================================================

  # Use Intel graphics driver early (adjust if using AMD/NVIDIA)
  boot.initrd.kernelModules = [ "i915" ];
  boot.kernelModules = [ "i915" ];

  # Reduce console log level
  boot.consoleLogLevel = 0;
}
