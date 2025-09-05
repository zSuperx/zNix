{
  wayland-utils =
    { self, pkgs, ... }:
    {
      imports = with self.nixosModules; [
        stylix
        rofi
      ];

      environment.systemPackages = with pkgs; [
        wl-clipboard
        wf-recorder
        slurp
        libnotify
        socat
        swaynotificationcenter
        brightnessctl
        networkmanagerapplet
        playerctl
        xwayland-satellite
        swww
      ];
    };
}
