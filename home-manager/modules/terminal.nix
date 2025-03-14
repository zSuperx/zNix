{
  config,
  pkgs,
  ...
}: {
  home.packages = [
    # Fish prompt plugin
    pkgs.fishPlugins.tide

    # Nerd Font
    (pkgs.nerdfonts.override {
      fonts = [
        "JetBrainsMono"
      ];
    })
  ];

  programs.kitty = {
    enable = true;
    settings = {
      font_family = "JetBrainsMono Nerd Font Mono";
      bold_font = "JetBrainsMono Nerd Font Mono Extra Bold";
      bold_italic_font = "JetBrainsMono Nerd Font Mono Extra Bold Italic";
      shell = "fish";
      background_opacity = "0.9";
      cursor_trail = "1";
      font_size = "15.0";
    };
    themeFile = "Catppuccin-Macchiato";
  };

  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "tide";
        src = pkgs.fishPlugins.tide.src;
      }
    ];
    shellAliases = {
      l = "ls -lah";
      grep = "grep --color";
      egrep = "egrep --color";
      # Clipboard
      wlc = "wl-copy";
      wlp = "wl-paste";
      # "It's all nvim?"
      nv = "nvim";
      vi = "nvim";
      vim = "nvim";
      # "Always has been..."
      gs = "git status";
      gc = "git commit -m";
    };

    # Disable Fish greeting & add ~/bin to path
    # Also disable direnv logging, it's so damn noisy
    shellInit = ''
      set fish_greeting
      set PATH "$HOME/bin:$PATH"
      export DIRENV_LOG_FORMAT=
    '';
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    options = ["--cmd cd"];
  };

  # cd into a directory will activate its flake.nix (if found + allowed)
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
