{ pkgs, ...}:

{
  # ============================================================================
  # Nix Configuration
  # ============================================================================

  # Enable experimental Nix features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # ============================================================================
  # User Configuration
  # ============================================================================

  users.users.butcherrrr = {
    isNormalUser = true;

    # "wheel" - allows using sudo for administrative tasks
    # "networkmanager" - allows managing network connections without sudo
    extraGroups = [ "wheel" "networkmanager" ];
  };

  # ============================================================================
  # Security Configuration
  # ============================================================================

  # Enable sudo
  security.sudo.enable = true;

  # ============================================================================
  # Networking Configuration
  # ============================================================================

  # Enable NetworkManager
  networking.networkmanager.enable = true;

  # ============================================================================
  # Audio Configuration
  # ============================================================================

  # Enable RealtimeKit
  # Reduces audio latency and prevents crackling/stuttering
  security.rtkit.enable = true;

  # PipeWire - audio/video server
  services.pipewire = {
    enable = true;

    # Enable PulseAudio compatibility layer
    # Allows apps designed for PulseAudio to work with PipeWire
    pulse.enable = true;

    # Enable ALSA (Advanced Linux Sound Architecture) support
    # Allows direct ALSA applications to work with PipeWire
    alsa.enable = true;

    # Enable 32-bit ALSA support
    # Needed for 32-bit applications on 64-bit systems
    alsa.support32Bit = true;
  };

  # ============================================================================
  # System Packages
  # ============================================================================

  # Packages installed system-wide (available to all users)
  environment.systemPackages = with pkgs; [
    git
    curl
    wget
    ripgrep
    jq
  ];
}
