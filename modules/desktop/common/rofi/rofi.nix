{
  rofi =
    { pkgs, lib, ... }:
    {
      environment.systemPackages = with pkgs; [
        rofi-wayland
      ];
      hm = {
        xdg.configFile."rofi/config.rasi" = {
          force = true;
          text = lib.mkForce null;
          source = ./config.rasi;
        };
      };
    };
}
