{ pkgs, spicetify-nix, ... }:

let
  spicePkgs = spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  # Spicetify Configuration (Spotify Customization)
  programs.spicetify = {
    enable = true;

    # Catppuccin Mocha theme
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";

    # Enable extensions
    enabledExtensions = with spicePkgs.extensions; [
      hidePodcasts # Hide podcast section
      shuffle # Better shuffle
    ];
  };
}
