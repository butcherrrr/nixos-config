{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;

    # Terminal settings
    terminal = "tmux-256color";

    # Enable mouse support
    mouse = true;

    # Set prefix to Ctrl-a instead of Ctrl-b
    prefix = "C-a";

    # Start window numbering at 1 instead of 0
    baseIndex = 1;

    # Renumber windows when one is closed
    escapeTime = 0;
    historyLimit = 50000;

    # Enable focus events
    sensibleOnTop = true;

    plugins = with pkgs.tmuxPlugins; [
      # Better defaults
      sensible

      # Easy pane navigation
      pain-control

      # Resurrect sessions
      resurrect

      # Auto-save sessions
      continuum
    ];

    extraConfig = ''
      # Enable true color support
      set -ga terminal-overrides ",*256col*:Tc"
      set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      set-environment -g COLORTERM "truecolor"

      # Renumber windows sequentially after closing any of them
      set -g renumber-windows on

      # Enable activity alerts
      setw -g monitor-activity on
      set -g visual-activity off

      # Increase scrollback buffer size
      set -g history-limit 50000

      # Tmux messages are displayed for 4 seconds
      set -g display-time 4000

      # Refresh status bar more often
      set -g status-interval 5

      # Focus events enabled for terminals that support them
      set -g focus-events on

      # Super useful when using "grouped sessions" and multi-monitor setup
      setw -g aggressive-resize on

      # Easier and faster switching between next/prev window
      bind C-p previous-window
      bind C-n next-window

      # Split panes using | and -
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      unbind '"'
      unbind %

      # Reload config file
      bind r source-file ~/.config/tmux/tmux.conf \; display "Reloaded!"

      # Don't rename windows automatically
      set -g allow-rename off

      # Enable continuum auto-save
      set -g @continuum-restore 'on'
      set -g @continuum-save-interval '15'

      # Move status bar to top
      set -g status-position top
    '';
  };

  # Enable Catppuccin theme for tmux via the flake
  catppuccin.tmux.enable = true;
}
