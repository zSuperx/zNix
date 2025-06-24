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
  };
}
