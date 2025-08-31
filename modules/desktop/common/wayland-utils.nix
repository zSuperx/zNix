{
  wayland-utils =
    { self, pkgs, ... }:
    {
      imports = with self.nixosModules; [
        stylix
        wofi
      ];

      environment.systemPackages = with pkgs; [
        wl-clipboard
        wf-recorder
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
