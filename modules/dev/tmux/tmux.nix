{inputs, ...}: {
  unify.modules.tmux = {
    home = {pkgs, ...}: {
      programs.tmux = {
        enable = true;
        keyMode = "vi";
        newSession = true;
        shortcut = "g";

        customPaneNavigationAndResize = true;

        extraConfig = ''
          bind -T copy-mode-vi v send -X begin-selection
          bind -T copy-mode-vi y send-keys -X copy-pipe "pbcopy"
          bind -T copy-mode-vi i send-keys -X cancel
          bind -T copy-mode-vi a send-keys -X cancel

          bind -n M-h select-pane -L
          bind -n M-j select-pane -D
          bind -n M-k select-pane -U
          bind -n M-l select-pane -R

          bind -n M-H resize-pane -L 5
          bind -n M-J resize-pane -D 5
          bind -n M-K resize-pane -U 5
          bind -n M-L resize-pane -R 5

          # Alt+n to smart-split and create a new pane
          bind -n M-n split-window -h
          bind -n M-N split-window -v

          # Options to make tmux more pleasant
          set -g mouse on
          set -g default-terminal "tmux-256color"
        '';

        plugins = with pkgs.tmuxPlugins; [
          tmux-which-key
          tmux-fzf
          sensible
          {
            plugin = tmux-sessionx;
            extraConfig = ''
              unbind o
              set -g @sessionx-bind 'o'
            '';
          }
          {
            plugin = catppuccin;
            extraConfig = ''
              set -g @catppuccin_flavor "mocha"
              set -g @catppuccin_window_status_style "rounded"

              # Load catppuccin
              run ~/.config/tmux/plugins/catppuccin/tmux/catppuccin.tmux

              # Make the status line pretty and add some modules
              set -g status-right-length 100
              set -g status-left-length 100
              set -g status-left ""
              set -g status-right "#{E:@catppuccin_status_application}"
              set -ag status-right "#{E:@catppuccin_status_session}"
              set -ag status-right "#{E:@catppuccin_status_date_time}"
            '';
          }
          resurrect
          cpu
          battery
        ];
      };
    };
  };
}
