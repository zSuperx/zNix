{
  yazi =
    { pkgs, ... }:
    {
      hm = {
        xdg.configFile."xdg-desktop-portal-termfilechooser/config" = {
          force = true;
          text = ''
            [filechooser]
            cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
          '';
        };
        programs.yazi = {
          enable = true;
          keymap = {
            mgr.prepend_keymap = [
              {
                on = ";";
                run = "shell --interactive --block";
                desc = "Run and block";
              }
              {
                on = ":";
                run = "shell --interactive --orphan";
                desc = "Run and orphan";
              }
              {
                on = "<Space>";
                run = "toggle";
                desc = "Toggle select";
              }
              {
                on = [
                  "g"
                  "r"
                ];
                run = "shell -- ya emit cd \$(git rev-parse --show-toplevel)";
                desc = "Go to git root";
              }
            ];
          };
        };
      };
    };
}
