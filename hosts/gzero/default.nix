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
    profiles.system
    profiles.basic
    profiles.dev
    profiles.hyprland
    profiles.gaming
    profiles.niri
    gnome
    ./configuration.nix
    ./hardware-configuration.nix
  ];
}
