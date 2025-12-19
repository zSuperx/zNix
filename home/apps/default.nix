{
  self,
  inputs,
  pkgs,
  system,
  ...
}:
{
  home.packages =
    with pkgs;
    [
      spotify
      mpv
      obsidian
      nautilus
      blueman
      zathura
      firefox
      matugen
      rofi
      spotify-player
      thunderbird
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
