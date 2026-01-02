{ pkgs, user, ...}:

{
  # ============================================================================
  # Nix Configuration
  # ============================================================================

  # Enable experimental Nix features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # ============================================================================
  # User Configuration
  # ============================================================================

  # Define the main user account using the variable passed from flake.nix
  # This allows different hosts to have different primary users
  users.users.${user} = {
    # This is a regular user account (not a system account)
    isNormalUser = true;

    # Add user to important groups:
    # "wheel" - allows using sudo for administrative tasks
    # "network" - allows managing network connections without sudo
    # "netdev" - allows managing network devices (required for iwd/impala)
    extraGroups = [ "wheel" "network" "netdev" ];
  };

  # ============================================================================
  # Security Configuration
  # ============================================================================

  # Enable sudo
  security.sudo.enable = true;

  # ============================================================================
  # Networking Configuration
  # ============================================================================

  # Enable iwd (iwd wireless daemon) for WiFi management
  # Required for impala WiFi manager
  networking.wireless.iwd = {
    enable = true;
    settings = {
      General = {
        EnableNetworkConfiguration = true;
      };
      Settings = {
        AutoConnect = true;
      };
    };
  };

  # Enable D-Bus for iwd user access (required for impala)
  services.dbus.enable = true;

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
  # Fonts Configuration
  # ============================================================================

  # Enable font configuration
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

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
    impala
  ];
}
