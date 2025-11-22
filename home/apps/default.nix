{
  self,
  inputs,
  pkgs,
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
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    ]
    ++ (with self.packages.${pkgs.stdenv.hostPlatform.system}; [
      nvim
      tmux
      waybar
    ]);

  programs.vesktop = {
    enable = true;
    vencord.settings.enabledThemes = [ "matugen.css" ];
  };
}
