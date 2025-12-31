{
  description = "NixOS config";

  # Input sources - these are external dependencies
  inputs = {
    # NixOS package repository
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    # Home Manager - manages user-level configuration and packages
    # Must use the same release branch as nixpkgs to avoid version mismatches
    home-manager.url = "github:nix-community/home-manager/release-25.11";

    # Makes home-manager use the same nixpkgs version as the system
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  # Outputs - what this flake produces
  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
    in
    {
      # NixOS system configurations
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          ./hosts/nixos/default.nix

          home-manager.nixosModules.home-manager

          # Home Manager configuration block
          {
            # Use system-level packages instead of separate user-level ones
            home-manager.useGlobalPkgs = true;

            # Install user packages to /etc/profiles instead of ~/.nix-profile
            home-manager.useUserPackages = true;

            # Configuration for the "butcherrrr" user
            home-manager.users.butcherrrr = import ./home/butcherrrr.nix;
          }
        ];
      };
    };
}
