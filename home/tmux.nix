{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    # FIXME:
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      sensible
      yank
      prefix-highlight
      resurrect
      catppuccin
      #tmux-pomodoro-plus
    ];
    terminal = "screen-256color";
    escapeTime = 10;
    historyLimit = 50000;
    extraConfig = ''
      set -g default-terminal "xterm-256color"
      set -ag terminal-overrides ",xterm-256color:RGB"
      set-option -g default-shell /run/current-system/sw/bin/zsh

      set -g base-index 1
      setw -g pane-base-index 1

      set -g set-titles-string ' #{pane_title} '
      set -g mouse on
      set-option -g visual-activity off
      set-option -g visual-bell off
      set-option -g visual-silence off
      set-window-option -g monitor-activity off

      set -g @catppuccin_flavour 'latte'
      # set -g status-right "#{pomodoro_status}"
    '';
  };
}
