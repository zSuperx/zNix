{pkgs, ...}: let
  myAliases = {
    l = "ls -lah";
    grep = "grep --color";
    egrep = "egrep --color";
    wlc = "wl-copy";
    wlp = "wl-paste";
    nv = "nvim";
    vi = "nvim";
    vim = "nvim";
    gs = "git status";
    gc = "git commit -m";
    ga = "git add";
    clera = "clear"; # Yes, I'm that bad at typing
    ww = "wonderwall";
  };
in {
  home.packages = [
    pkgs.fishPlugins.tide
    pkgs.nitch
    pkgs.nerd-fonts.jetbrains-mono
  ];
  programs = {
    kitty = {
      enable = true;
      settings = {
        font_family = "JetBrainsMono Nerd Font Mono";
        bold_font = "JetBrainsMono Nerd Font Mono Extra Bold";
        bold_italic_font = "JetBrainsMono Nerd Font Mono Extra Bold Italic";
        shell = "fish";
        background_opacity = pkgs.lib.mkForce "0.9";
        cursor_trail = "1";
        font_size = "13.0";
      };
      themeFile = "Catppuccin-Macchiato";
    };

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
      shellInit = ''
        set fish_greeting
        set PATH "$HOME/bin:$PATH"
        nitch
      '';
    };

    zoxide = {
      enable = true;
      enableBashIntegration = true;
      options = ["--cmd cd"];
    };

    # cd into a directory will activate its flake.nix (if found + allowed)
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
