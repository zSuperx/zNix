{
  pkgs,
  lib,
  scripts,
  colorscheme,
  writeText
}: let
  inherit (lib) types;
  pluginName = p:
    if types.package.check p
    then p.pname
    else p.plugin.pname;

  plugins = with pkgs.tmuxPlugins; [
    {
      plugin = catppuccin;
      extraConfig =
        ''
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
          set -ag status-right "#[bg=#{@thm_yellow},fg=#{@thm_crust}]#(${scripts.get-battery-icon}) "
          set -ag status-right "#[fg=#{@thm_fg},bg=#{@thm_surface_0}] #(${scripts.get-battery-capacity})% "
        ''
        + (with colorscheme.withHashtag; ''
          # Colors
          set -ogq @thm_bg "#3b4252"
          set -ogq @thm_fg "#e5e9f0"
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
        '');
    }
  ];
in
  writeText "plugins.conf" ''
    ${
      (lib.concatMapStringsSep "\n\n" (p: ''
          # ${pluginName p}
          # ---------------------
          ${p.extraConfig or ""}
          run-shell ${
            if types.package.check p
            then p.rtp
            else p.plugin.rtp
          }
        '')
        plugins)
    }
  ''
