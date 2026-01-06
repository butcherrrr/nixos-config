{ config, pkgs, ... }:

{
  # Rofi Configuration
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;

    extraConfig = {
      display-drun = "Applications";
      display-window = "Windows";
      display-combi = "Search";
      show-icons = true;
      icon-theme = "Papirus-Dark";
      terminal = "ghostty";
      disable-history = false;
      sorting-method = "fzf";
      matching = "fuzzy";
      modes = "drun,run,window";
      drun-display-format = "{name}";
      lines = 6;
    };

    theme =
      let
        inherit (config.lib.formats.rasi) mkLiteral;
      in
      {
        "*" = {
          font = "JetBrainsMono Nerd Font 9";
        };

        window = {
          transparency = "real";
          border = mkLiteral "1px";
          border-radius = mkLiteral "6px";
          width = mkLiteral "420px";
          padding = mkLiteral "8px";
        };

        mainbox = {
          background-color = mkLiteral "transparent";
          children = map mkLiteral [
            "inputbar"
            "listview"
          ];
          spacing = mkLiteral "6px";
        };

        inputbar = {
          border-radius = mkLiteral "4px";
          padding = mkLiteral "6px 8px";
          children = map mkLiteral [
            "prompt"
            "entry"
          ];
          spacing = mkLiteral "6px";
        };

        prompt = {
          background-color = mkLiteral "transparent";
          font = "JetBrainsMono Nerd Font Bold 9";
        };

        entry = {
          background-color = mkLiteral "transparent";
          placeholder = "Search...";
          cursor = mkLiteral "text";
        };

        listview = {
          background-color = mkLiteral "transparent";
          columns = 1;
          lines = 6;
          spacing = mkLiteral "1px";
          cycle = false;
          dynamic = true;
          layout = mkLiteral "vertical";
          scrollbar = false;
        };

        element = {
          background-color = mkLiteral "transparent";
          orientation = mkLiteral "horizontal";
          border-radius = mkLiteral "3px";
          padding = mkLiteral "4px 6px";
        };

        element-icon = {
          background-color = mkLiteral "transparent";
          size = mkLiteral "18px";
          margin = mkLiteral "0px 6px 0px 0px";
        };

        element-text = {
          background-color = mkLiteral "transparent";
          vertical-align = mkLiteral "0.5";
        };

        message = {
          border = mkLiteral "0px";
          border-radius = mkLiteral "4px";
          padding = mkLiteral "6px";
        };

        textbox = {
          background-color = mkLiteral "transparent";
        };

        mode-switcher = {
          background-color = mkLiteral "transparent";
          spacing = mkLiteral "6px";
        };

        button = {
          border-radius = mkLiteral "4px";
          padding = mkLiteral "6px";
        };
      };
  };
}
