{self, ...}: {
  unify.modules.wayland-utils = {
    home = {pkgs, ...}: {
      imports = with self.modules.home; [
        wofi
      ];
    };

    nixos = {pkgs, ...}: {
      imports = with self.modules.nixos; [
        stylix
      ];

      environment.systemPackages = with pkgs; [
        wl-clipboard
        wf-recorder
        socat
        swaynotificationcenter
        brightnessctl
        networkmanagerapplet
        playerctl
        pavucontrol
      ];
    };
  };
}
