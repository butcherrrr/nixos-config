{ pkgs, ... }:

{
  # Shell Configuration

  # Eza - modern ls replacement
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    git = true;
    icons = "auto";
    extraOptions = [
      "--group-directories-first"
      "--header"
    ];
  };

  # Zsh shell
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting = {
      enable = true;
      # To specify a version, you can override the package:
      # package = pkgs.zsh-syntax-highlighting.overrideAttrs (oldAttrs: {
      #   version = "0.7.1";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "zsh-users";
      #     repo = "zsh-syntax-highlighting";
      #     rev = "0.7.1";
      #     sha256 = "sha256-here";
      #   };
      # });
    };

    shellAliases = {
      ls = "eza";
      ll = "eza -l";
      la = "eza -la";
      lt = "eza --tree";
      nrs = "sudo nixos-rebuild switch --flake .#$(hostname)";
      zed = "zeditor";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
        "docker"
      ];
      theme = ""; # Empty - using powerlevel10k instead
    };

    initContent = ''
      # Powerlevel10k theme
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme

      # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

      # Disable highlighting on paths and slashes
      typeset -A ZSH_HIGHLIGHT_STYLES
      ZSH_HIGHLIGHT_STYLES[path]='none'
      ZSH_HIGHLIGHT_STYLES[path_prefix]='none'
      ZSH_HIGHLIGHT_STYLES[path_pathseparator]='none'

      # Disable highlighting on command options/arguments
      ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='none'
      ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='none'
    '';
  };

  # Zoxide
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  # fzf - fuzzy finder (themed by Catppuccin)
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;

    # Default options
    defaultOptions = [
      "--height 40%"
      "--layout=reverse"
      "--border"
      "--inline-info"
    ];
  };
}
