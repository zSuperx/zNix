{
  self,
  inputs,
  ...
}: {
  unify.modules.tmux = {
    home = {
      pkgs,
      config,
      lib,
      ...
    }: {
      programs.tmux = let
        smart-split-script = "${self}/scripts/tmux-smart-split.sh";
        get-battery-capacity = "${self}/scripts/battery-capacity.sh";
        get-battery-icon = "${self}/scripts/battery-icon.sh";
        rename-session = pkgs.writeShellScriptBin "rename-session.sh" ''
          tmux send-keys Enter
          tmux choose-session
          tmux command-prompt -p "New session name:" -I "#{session_name}" "rename-session '%%'"
        '';
      in {
        enable = true;
        keyMode = "vi";
        shortcut = "g";
        sensibleOnTop = true;

        customPaneNavigationAndResize = true;

        extraConfig = ''

          bind * set-option -w synchronize-panes

          bind -T copy-mode-vi v send -X begin-selection
          bind -T copy-mode-vi y send-keys -X copy-pipe "pbcopy"
          bind -T copy-mode-vi i send-keys -X cancel
          bind -T copy-mode-vi a send-keys -X cancel

          bind -n M-f resize-pane -Z

          bind -n M-h select-pane -L
          bind -n M-j select-pane -D
          bind -n M-k select-pane -U
          bind -n M-l select-pane -R

          bind -n M-H resize-pane -L 5
          bind -n M-J resize-pane -D 5
          bind -n M-K resize-pane -U 5
          bind -n M-L resize-pane -R 5

          bind -n M-n run-shell ${smart-split-script}

          # bind-key -T root n if-shell -F '#{==:#{pane_mode},tree-mode}' \
          #     'new-session' \
          #     'send-keys n'

          # bind-key -T root d if-shell -F '#{==:#{pane_mode},tree-mode}' \
          #     'send-keys x' \
          #     'send-keys d'

          # bind-key -T root r if-shell -F '#{==:#{pane_mode},tree-mode}' \
          #     'run-shell ${lib.getExe rename-session}' \
          #     'send-keys r'

          # Options to make tmux more pleasant
          set -g mouse on

          bind R source ~/.config/tmux/tmux.conf
        '';

        plugins = with pkgs.tmuxPlugins; [
          sensible
          {
            plugin = catppuccin;
            extraConfig = with config.lib.stylix.colors.withHashtag; ''
              set -g @catppuccin_flavor "mocha"
              set -g @catppuccin_window_status_style "slanted"

              # Make the status line pretty and add some modules
              set -g status-right-length 100
              set -g status-left-length 100
              set -g status-left ""

              set -g status-right ""
              set -ag status-right "#{E:@catppuccin_status_application}"

              set -ag status-right '#{?pane_synchronized,#[bg=#{@thm_green}],#[bg=#{@thm_red}]}#[fg#{@thm_mantle}]#[reverse]#[noreverse]'
              set -ag status-right '#{?pane_synchronized,#[bg=#{@thm_green}],#[bg=#{@thm_red}]}#[fg#{@thm_crust}]  '
              set -ag status-right "#[fg=#{@thm_fg},bg=#{@thm_surface_0}] sync "

              set -ag status-right "#{E:@catppuccin_status_session}"
              set -ag status-right "#{E:@catppuccin_status_date_time}"

              set -ag status-right "#[bg=#{@thm_yellow},fg=#{@thm_surface_0}]#[reverse]#[noreverse]"
              set -ag status-right "#[bg=#{@thm_yellow},fg=#{@thm_crust}]#(${get-battery-icon}) "
              set -ag status-right "#[fg=#{@thm_fg},bg=#{@thm_surface_0}] #(${get-battery-capacity})% "

              # Stylix Theme

              set -ogq @thm_bg "${base01}"
              set -ogq @thm_fg "${base05}"

              # Colors
              set -ogq @thm_rosewater "${base06}"
              set -ogq @thm_flamingo "${base0F}"
              set -ogq @thm_pink "${base0F}"
              set -ogq @thm_mauve "${base0E}"
              set -ogq @thm_red "${base08}"
              set -ogq @thm_maroon "${base08}"
              set -ogq @thm_peach "${base09}"
              set -ogq @thm_yellow "${base0A}"
              set -ogq @thm_green "${base0B}"
              set -ogq @thm_teal "${base0C}"
              set -ogq @thm_sky "${base0C}"
              set -ogq @thm_sapphire "${base0D}"
              set -ogq @thm_blue "${base0D}"
              set -ogq @thm_lavender "${base07}"

              # Surfaces and overlays
              set -ogq @thm_subtext_0 "#bac2de"
              set -ogq @thm_subtext_1 "#a6adc8"

              set -ogq @thm_overlay_0 "#6c7086"
              set -ogq @thm_overlay_1 "#7f849c"
              set -ogq @thm_overlay_2 "#9399b2"

              set -ogq @thm_surface_0 "${base02}"
              set -ogq @thm_surface_1 "${base03}"
              set -ogq @thm_surface_2 "${base04}"

              set -ogq @thm_mantle "${base01}"
              set -ogq @thm_crust "#11111b"

            '';
          }
        ];
      };
    };
  };
}
