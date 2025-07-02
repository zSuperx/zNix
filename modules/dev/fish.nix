{
  unify.modules.fish = {
    home = {pkgs, ...}: {
      home.packages = with pkgs; [
        fishPlugins.tide
      ];

      programs.fish = {
        enable = true;
        plugins = [
          {
            name = "tide";
            inherit (pkgs.fishPlugins.tide) src;
          }
        ];

        shellAliases = {
          # Remaps to modern versions
          ls = "eza";
          l = "eza -alh";
          grep = "rg --color";
          cat = "bat";

          # Useful shorthands
          wlc = "wl-copy";
          wlp = "wl-paste";
          gs = "git status";
          gc = "git commit -m";
          ga = "git add";
          ww = "wonderwall";
          nv = "nvim";

          clera = "clear"; # Yes, I'm that bad at typing

          # Actual shortcuts
          y = "cd $(yazi --cwd-file=/dev/stdout)";
        };

        # Disable Fish greeting & add ~/bin to path
        interactiveShellInit = ''
          set fish_greeting
          nitch
        '';
      };
    };

    nixos = {
      programs.fish.enable = true;
    };
  };
}
