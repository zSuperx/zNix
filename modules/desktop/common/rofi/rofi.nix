{
  rofi =
    { pkgs, lib, ... }:
    {
      environment.systemPackages = with pkgs; [
        rofi
      ];
    };
}
