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
        '';

        plugins = with pkgs.tmuxPlugins; [
          tmux-which-key
          tmux-sessionx
          tmux-fzf
          nord
          sensible
        ];
      };
    };
  };
}
