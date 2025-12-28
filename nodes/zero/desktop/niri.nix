{
  inputs,
  pkgs,
  ...
}:
{
  xdg.portal = {
    config.niri.default = [ # required for screenshare on Niri
      "gnome"
      "gtk"
    ];
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
  };

  nixpkgs.overlays = [
    inputs.niri.overlays.niri
  ];

  imports = [
    inputs.niri.nixosModules.niri
  ];

  programs.niri.enable = true;
  programs.niri.package = pkgs.niri-unstable;

  # Niri options will be configured through Home Manager
  home-manager.users.zsuper = import ./niri;
}
