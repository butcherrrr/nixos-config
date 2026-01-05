{
  # ============================================================================
  # Multi-Host NixOS Configuration
  # ============================================================================

  description = "NixOS config";

  # ============================================================================
  # Input Sources
  # ============================================================================

  # Input sources - these are external dependencies for your configuration
  inputs = {
    # NixOS package repository - using the stable 25.11 release
    # This determines which versions of packages are available
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    # Home Manager - manages user-level configuration and packages
    # Must use the same release branch as nixpkgs to avoid version mismatches
    # Allows you to configure dotfiles, user packages, and user services declaratively
    home-manager.url = "github:nix-community/home-manager/release-25.11";

    # Makes home-manager use the same nixpkgs version as the system
    # This prevents version conflicts between system and user packages
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Catppuccin theme for automatic theming across 70+ applications
    catppuccin.url = "github:catppuccin/nix";

    # Spicetify - Spotify theming
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  # ============================================================================
  # Outputs
  # ============================================================================

  # Outputs - what this flake produces (your system configurations)
  outputs = { self, nixpkgs, home-manager, catppuccin, spicetify-nix, ... }:
    let
      # ========================================================================
      # Helper Function: mkSystem
      # ========================================================================

      # Helper function to create a system configuration
      # This reduces duplication when defining multiple hosts
      #
      # Parameters:
      #   hostname - Name of the host (e.g., "nixos", "laptop", "desktop")
      #   system   - System architecture (e.g., "x86_64-linux", "aarch64-linux")
      #   user     - Primary username for home-manager configuration
      mkSystem = { hostname, system, user }:
        nixpkgs.lib.nixosSystem {
          # System architecture for this host
          inherit system;

          # Special arguments passed to all modules
          # Makes these values accessible in all your configuration files
          specialArgs = {
            inherit hostname user;
            inherit spicetify-nix;
          };

          # Modules that make up this system configuration
          modules = [
            # Host-specific configuration
            # Each host has its own directory: hosts/${hostname}/
            ./hosts/${hostname}/default.nix

            # Home Manager as a NixOS module
            # This integrates home-manager into your system configuration
            home-manager.nixosModules.home-manager

            # Home Manager configuration
            {
              # Use system-level packages instead of separate user-level ones
              # More efficient and ensures consistency
              home-manager.useGlobalPkgs = true;

              # Install user packages to /etc/profiles instead of ~/.nix-profile
              # Recommended for NixOS module usage
              home-manager.useUserPackages = true;

              # Pass extra arguments to home-manager modules
              # Makes hostname and user available in home-manager config
              home-manager.extraSpecialArgs = {
                inherit hostname user;
                inherit spicetify-nix;
              };

              # User-specific home-manager configuration
              # Each user has their own file: home/${user}.nix
              home-manager.users.${user} = {
                imports = [
                  ./home/${user}.nix
                  catppuccin.homeModules.catppuccin
                  spicetify-nix.homeManagerModules.default
                ];
              };
            }
          ];
        };
    in
    {
      # ========================================================================
      # NixOS System Configurations
      # ========================================================================

      # Define all your systems here
      # Each system can be built with: nixos-rebuild switch --flake .#<hostname>
      nixosConfigurations = {

        # Primary desktop/laptop - your current system
        # Rebuild with: sudo nixos-rebuild switch --flake .#guinea-pig
        guinea-pig = mkSystem {
          hostname = "guinea-pig";
          system = "x86_64-linux";
          user = "butcherrrr";
        };

        x1 = mkSystem {
          hostname = "x1";
          system = "x86_64-linux";
          user = "butcherrrr";
        };

        # Example: Add more systems as needed
        # Uncomment and customize these templates for additional machines:

        # laptop = mkSystem {
        #   hostname = "laptop";
        #   system = "x86_64-linux";
        #   user = "butcherrrr";
        # };

        # workstation = mkSystem {
        #   hostname = "workstation";
        #   system = "x86_64-linux";
        #   user = "butcherrrr";
        # };

        # server = mkSystem {
        #   hostname = "server";
        #   system = "x86_64-linux";
        #   user = "admin";
        # };

        # ARM-based system example (e.g., Raspberry Pi, M1/M2 Mac via Asahi)
        # rpi = mkSystem {
        #   hostname = "rpi";
        #   system = "aarch64-linux";
        #   user = "butcherrrr";
        # };
      };
    };
}
