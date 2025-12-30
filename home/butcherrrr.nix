{ config, pkgs, ... }:

{
  home.stateVersion = "25.11";
  home.packages = with pkgs; [
    kitty
    wofi
    waybar
    mako
    neovim
    ghostty
    firefox
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      input = {
        kb_layout = "se";
      };

      general.gaps_in = 5;
      general.gaps_out = 10;

      bind = [
        "SUPER, Return, exec, kitty"
	      "SUPER, Space, exec, wofi --show drun"
	      "SUPER, W, killactive"
      ];

      exec-once = [
        "waybar"
	       "wofi"
      ];
    };
  };
}
