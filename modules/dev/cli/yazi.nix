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
                  "p"
                ];
                run = "cd ~/Pictures";
                desc = "Go to ~/Pictures";
              }
              {
                on = [
                  "g"
                  "s"
                ];
                run = "cd ~/School/Current";
                desc = "Go to ~/School/Current";
              }
              {
                on = [
                  "g"
                  "r"
                ];
                run = "shell -- ya emit cd \$(git rev-parse --show-toplevel)";
                desc = "Go to git root";
              }
              {
                on = [ "b" ];
                run = "plugin bunny fuzzy";
                desc = "Fuzzy find bookmarks";
              }
            ];
          };

          plugins = {
            # https://github.com/stelcodes/bunny.yazi
            bunny = pkgs.fetchFromGitHub {
              owner = "stelcodes";
              repo = "bunny.yazi";
              tag = "v1.3.2";
              hash = "sha256-HnzuR12c4wJaI7dzZrf/Zdc6yCjvsfhPEcnzNNgcLnA=";
            };
          };
          initLua = ''
            require("bunny"):setup({
              hops = {
                { key = "/", path = "/",                                 },
                { key = "t", path = "/tmp",                              },
                { key = "n", path = "/nix/store",  desc = "Nix store"    },
                { key = "~", path = "~",           desc = "Home"         },
                { key = "p", path = "~/Pictures",  desc = "Pictures"     },
                { key = "d", path = "~/Desktop",   desc = "Desktop"      },
                { key = "D", path = "~/Documents", desc = "Documents"    },
                { key = "c", path = "~/.config",   desc = "Config files" },
              },
              desc_strategy = "path", 
              ephemeral = true, 
              tabs = true, 
              notify = false, 
              fuzzy_cmd = "fzf", 
            })
          '';
        };
      };
    };
}
