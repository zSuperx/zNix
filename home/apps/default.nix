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
      matugen
      rofi
      spotify-player
      thunderbird
      nmgui
    ]
    ++ [
      inputs.zen-browser.packages.${system}.default
      inputs.muxie.packages.${system}.default
    ]
    ++ (with self.packages.${system}; [
      nvim
      tmux
      waybar
    ]);

  programs.vesktop = {
    enable = true;
    vencord.settings.enabledThemes = [ "matugen.css" ];
  };

  home.file = {
    "matugen" = {
      source = ./matugen;
      target = ".config/matugen/";
    };
  };
}
