{
  inputs,
  pkgs,
  lib,
  scripts,
  system,
}:
let
  muxie = inputs.muxie.packages.${system}.default;
in
pkgs.writeText "tmux-settings.conf" ''
  set  -g base-index      0
  setw -g pane-base-index 0

  set -g status-keys vi
  set -g mode-keys   vi
  set -g default-terminal xterm-256color

  bind -N "Select pane to the left of the active pane" h select-pane -L
  bind -N "Select pane below the active pane" j select-pane -D
  bind -N "Select pane above the active pane" k select-pane -U
  bind -N "Select pane to the right of the active pane" l select-pane -R

  bind -r -N "Resize the pane left by 5" \
    H resize-pane -L 5
  bind -r -N "Resize the pane down by 5" \
    J resize-pane -D 5
  bind -r -N "Resize the pane up by 5" \
    K resize-pane -U 5
  bind -r -N "Resize the pane right by 5" \
    L resize-pane -R 5


  # rebind main key: C-g
  unbind C-b
  set -g prefix C-g
  bind -N "Send the prefix key through to the application" \
    g send-prefix
  bind C-g last-window

  set  -g mouse             off
  set  -g focus-events      off
  setw -g aggressive-resize off
  setw -g clock-mode-style  12
  set  -s escape-time       500
  set  -g history-limit     2000

  bind * set-option -w synchronize-panes

  bind -T copy-mode-vi v send -X begin-selection
  bind -T copy-mode-vi y send-keys -X copy-pipe "pbcopy"
  bind -T copy-mode-vi i send-keys -X cancel
  bind -T copy-mode-vi a send-keys -X cancel
  bind-key -T copy-mode-vi Y send-keys -X copy-end-of-line

  bind -n M-f resize-pane -Z

  bind -n M-h select-pane -L
  bind -n M-j select-pane -D
  bind -n M-k select-pane -U
  bind -n M-l select-pane -R

  bind -n M-H resize-pane -L 5
  bind -n M-J resize-pane -D 5
  bind -n M-K resize-pane -U 5
  bind -n M-L resize-pane -R 5

  bind -n C-M-h previous-window
  bind -n C-M-j next-window
  bind -n C-M-k previous-window
  bind -n C-M-l next-window

  # Alt+n to smart-split and create a new pane
  bind -n M-n run-shell ${scripts.smart-split}

  # Ctrl+Alt+n to create new window
  bind -n C-M-n new-window 

  # Override tmux's builtin session manager with muxie
  unbind s
  bind s popup -EB ${lib.getExe muxie}

  # Options to make tmux more pleasant
  set -g mouse on
''
