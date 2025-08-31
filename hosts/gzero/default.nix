{
  self,
  userInfo,
  ...
}:
self.lib.mkSystem {
  inherit (userInfo) username;
  hostname = "gzero";
  system = "x86_64-linux";
  insanelySpecialArgs = userInfo;
  modules = with self.nixosModules; [
    profiles.basic
    profiles.dev
    profiles.hyprland
    profiles.gaming
    profiles.niri

    wayland-utils
    gBar
    gnome

    ./configuration.nix
    ./hardware-configuration.nix
  ];
}
