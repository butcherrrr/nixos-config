{
  # ============================================================================
  # Multi-Host NixOS Configuration
  # ============================================================================

  description = "NixOS config";

  # Input sources - external dependencies
  inputs = {
    # Determines which versions of packages are available
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    # Unstable nixpkgs for packages that need newer versions
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home Manager - manages user-level configuration and packages
    home-manager.url = "github:nix-community/home-manager/release-25.11";

    # Makes home-manager use the same nixpkgs version as the system
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Catppuccin theme for automatic theming
    catppuccin.url = "github:catppuccin/nix";

    # Spicetify - Spotify theming
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";

    # Nixvim
    nixvim.url = "github:nix-community/nixvim/nixos-25.11";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    # awww - animated wallpaper daemon
    awww.url = "git+https://codeberg.org/LGFae/awww";
  };

  # Outputs - what this flake produces (system configurations)
  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      catppuccin,
      spicetify-nix,
      nixvim,
      awww,
      ...
    }:
    let
      # Creates a system configuration
      mkSystem =
        {
          hostname, # name of the host
          system, # system architecture
          user, # username for home-manager config
        }:
        nixpkgs.lib.nixosSystem {
          # System architecture for this host
          inherit system;

          # Special arguments passed to all modules
          specialArgs = {
            inherit hostname user;
            inherit spicetify-nix awww;
            # Make unstable packages available
            pkgs-unstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          };

          # Modules that make up this system configuration
          modules = [
            # Host-specific configuration
            # Each host has its own directory: hosts/${hostname}/
            ./hosts/${hostname}/default.nix

            # Home Manager as a NixOS module
            # This integrates home-manager into the system configuration
            home-manager.nixosModules.home-manager

            # Home Manager configuration
            {
              # Use system-level packages instead of separate user-level ones
              home-manager.useGlobalPkgs = true;

              # Install user packages to /etc/profiles instead of ~/.nix-profile
              # Recommended for NixOS module usage
              home-manager.useUserPackages = true;

              # Pass extra arguments to home-manager modules
              home-manager.extraSpecialArgs = {
                inherit hostname user;
                inherit spicetify-nix awww;
                inputs = { inherit nixvim; };
                # Make unstable packages available in home-manager
                pkgs-unstable = import nixpkgs-unstable {
                  inherit system;
                  config.allowUnfree = true;
                };
              };

              # User-specific home-manager configuration
              # Each user has their own file: home/${user}.nix
              home-manager.users.${user} = {
                imports = [
                  ./home/${user}.nix
                  catppuccin.homeModules.catppuccin
                  spicetify-nix.homeManagerModules.default
                  nixvim.homeModules.nixvim
                ];
              };
            }
          ];
        };
    in
    {
      nixosConfigurations = {
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
      };
    };
}
