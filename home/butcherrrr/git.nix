{ ... }:

{
  # Git Configuration
  programs.git = {
    enable = true;

    settings = {
      # User identity
      user = {
        name = "butcherrrr";
        email = "butcherrrr7@protonmail.com";
      };

      # Default branch name
      init = {
        defaultBranch = "main";
      };

      # Pull behavior
      pull = {
        rebase = true;
        ff = "only";
      };

      # Push behavior
      push = {
        default = "simple";
        autoSetupRemote = true;
      };

      # Merge conflict style
      merge = {
        conflictstyle = "diff3";
      };

      # Better diffs
      diff = {
        colorMoved = "default";
      };

      # Faster operations + Delta pager
      core = {
        pager = "delta";
        fsmonitor = true;
        untrackedCache = true;
      };

      interactive = {
        diffFilter = "delta --color-only";
      };

      # Common aliases
      alias = {
        st = "status";
        co = "checkout";
        br = "branch";
        ci = "commit";
        unstage = "reset HEAD --";
        last = "log -1 HEAD";
        ls = "log --pretty=format:'%C(yellow)%h %C(blue)%ad %C(red)%d %C(reset)%s %C(green)[%cn]' --decorate --date=short";
        ll = "log --pretty=format:'%C(yellow)%h%C(red)%d %C(reset)%s %C(green)[%cn] %C(blue)%ad' --decorate --numstat --date=short";
        graph = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)'";
      };

      # Include machine-specific config if it exists
      include = {
        path = "~/.gitconfig.local";
      };
    };
  };

  # ============================================================================
  # Delta - Syntax-highlighting pager for git
  # ============================================================================

  programs.delta = {
    enable = true;
    options = {
      navigate = true; # use n and N to move between diff sections
      light = false; # dark theme (set to true for light terminals)
      side-by-side = true; # split view
      line-numbers = true; # show line numbers
    };
  };
}
