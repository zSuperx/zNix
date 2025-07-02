{pkgs, ...}: let
  myAliases = {
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
in {
  imports = [
    ./wezterm.nix
  ];

  home.packages = [
    pkgs.fishPlugins.tide
    pkgs.nitch
    pkgs.nerd-fonts.jetbrains-mono
  ];

  programs = {
    fish = {
      enable = true;
      plugins = [
        {
          name = "tide";
          inherit (pkgs.fishPlugins.tide) src;
        }
      ];
      shellAliases = myAliases;

      # Disable Fish greeting & add ~/bin to path
      interactiveShellInit = ''
        set fish_greeting
        set PATH "$HOME/bin:$PATH"
      '';
    };

    zoxide = {
      enable = true;
      enableBashIntegration = true;
      options = ["--cmd cd"];
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    yazi = {
      enable = true;
      keymap = {
        manager.prepend_keymap = [
          {
            on = ";";
            run = "shell --interactive --block";
            desc = "Run shell in yazi and block until done";
          }
          {
            on = ":";
            run = "shell --interactive --orphan";
            desc = "Run shell and orphan";
          }
          {
            on = "<C-d>";
            run = "shell --block fish";
            desc = "Drop into terminal";
          }
          {
            on = "<Space>";
            run = "toggle";
            desc = "Toggle select on current file";
          }
          {
            on = ["g" "r"];
            run = "shell -- ya emit cd '$(git rev-parse --show-toplevel)'";
            desc = "Go to git repo root";
          }
        ];
      };
    };
  };
}
