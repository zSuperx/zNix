{
  wofi =
    { pkgs, config, ... }:
    {
      environment.systemPackages = with pkgs; [
        wofi-power-menu
      ];

      hm = {
        xdg.configFile."wofi-power-menu.toml" = {
          force = true;
          text = ''
            [wofi]
              extra_args = "--allow-markup --columns=1 --hide-scroll"

            [menu.shutdown]
              title = "Shutdown"
              cmd = "poweroff"

            [menu.reboot]
              title = "Reboot"
              cmd = "systemctl reboot"

            [menu.suspend]
              title = "Suspend"
              enabled = "true"
              cmd = "systemctl suspend"

            [menu.logout]
              title = "Logout"
              cmd = "niri msg action quit"

            [menu.lock-screen]
              title = "Lock Screen"
              cmd = "hyprlock"
              requires_confirmation = "false"
          '';
        };
        stylix.targets.wofi.enable = false;

        programs.wofi = {
          enable = true;
          style = import ./_wofi-style.nix { inherit config; };
          settings = {
            hide_scroll = true;
            show = "drun";
            width = "30%";
            lines = 8;
            line_wrap = "word";
            term = "kitty";
            allow_markup = true;
            always_parse_args = false;
            show_all = true;
            print_command = true;
            layer = "overlay";
            allow_images = true;
            gtk_dark = true;
            prompt = "";
            image_size = 20;
            display_generic = false;
            location = "top";
            key_expand = "Tab";
            insensitive = true;
            matching = "fuzzy";
          };
        };
      };
    };
}
