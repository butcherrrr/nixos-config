{ pkgs, user, ...}:

{
  # ============================================================================
  # Nix Configuration
  # ============================================================================

  # Enable experimental Nix features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree (proprietary) packages
  nixpkgs.config.allowUnfree = true;

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
    # "docker" - allows using Docker without sudo
    extraGroups = [ "wheel" "network" "netdev" "docker" ];

    # Default shell
    shell = pkgs.zsh;
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
  # Console Configuration
  # ============================================================================

  # Console keyboard layout (for TTY/virtual console)
  console.keyMap = "sv-latin1";

  # Console font for better readability in tuigreet
  console.font = "${pkgs.terminus_font}/share/consolefonts/ter-v16n.psf.gz";

  # X11 keyboard layout (also used by Wayland compositors as fallback)
  services.xserver.xkb = {
    layout = "se";
    variant = "";
    options = "";
  };

  # keyd - keyboard remapping daemon
  # Remap Caps Lock to Hyper key (Ctrl+Shift+Alt+Super combined)
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = ["*"];
        settings = {
          main = {
            # Remap Caps Lock to Hyper (Ctrl+Shift+Alt+Super)
            # Tapped alone = Escape, held with other keys = Hyper modifier
            capslock = "overload(hyper, esc)";
          };
          # Hyper layer - when Caps Lock is held
          "hyper:C-S-M-A" = {
            # C-S-M-A = Ctrl+Shift+Meta(Alt)+Super
            # All keys pressed with Caps Lock will have all 4 modifiers
            # Example: Caps+h = Ctrl+Shift+Alt+Super+h
          };
        };
      };
    };
  };

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
  # Bluetooth Configuration
  # ============================================================================

  # Enable Bluetooth support
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;  # Power on Bluetooth adapter on boot
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;  # Enable experimental features
      };
    };
  };

  # ============================================================================
  # Docker Configuration
  # ============================================================================

  # Enable Docker
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;  # Start Docker daemon on boot
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
    curl
    wget
    ripgrep
    jq
    keyd  # Keyboard remapping daemon
    impala  # WiFi manager
    bluetui  # Bluetooth manager
    btop  # System monitor
    libnotify
    docker-compose
  ];

  # Enable zsh system-wide
  programs.zsh.enable = true;
}
