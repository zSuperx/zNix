{
  self,
  inputs,
  pkgs,
  system,
  ...
}:
{
  imports = [
    # TODO: maybe wrap this into its own package and then dogfood it back in?
    ./swaync
  ];

  home.packages =
    with pkgs;
    [
      spotify
      mpv
      obsidian
      nautilus
      blueman
      zathura
      rofi
      spotify-player
      thunderbird
      nmgui
      vscode-fhs
    ]
    ++ [
      # Third party binaries
      inputs.zen-browser.packages.${system}.default
      inputs.hellpaper.packages.${system}.default
      inputs.matugen.packages.${system}.default
    ]
    ++ (with self.packages.${system}; [
      # Custom-packaged programs
      nvim
      tmux
      waybar
    ]);

  programs.vesktop = {
    enable = true;
    vencord.settings = {
      enabledThemes = [ "matugen.css" ];
      transparent = true;
    };
  };

  home.file = {
    "matugen" = {
      source = ./matugen;
      target = ".config/matugen/";
    };
    "hypridle" = {
      source = ./hypr/hypridle.conf;
      target = ".config/hypr/hypridle.conf";
    };
    "hyprlock" = {
      source = ./hypr/hyprlock.conf;
      target = ".config/hypr/hyprlock.conf";
    };
  };
}
