{ ... }:

{
  # Ghostty Terminal Configuration
  programs.ghostty = {
    enable = true;

    settings = {
      # Theme (catppuccin mocha built-in)
      theme = "catppuccin-mocha";

      # Font configuration
      font-family = "JetBrainsMono Nerd Font";
      font-size = 18;

      # Window configuration
      window-padding-x = 14;
      window-padding-y = 14;
      window-padding-balance = true;
      window-decoration = false;

      # Cursor
      cursor-style = "bar";
      cursor-style-blink = true;

      # Shell integration
      shell-integration = "zsh";
      shell-integration-features = "cursor,sudo,title";

      # Mouse
      mouse-hide-while-typing = true;
      copy-on-select = true;

      # Misc
      confirm-close-surface = false;
      resize-overlay = "never";
    };
  };
}
