{
  self,
  userInfo,
  ...
}:
self.lib.mkSystem {
  inherit (userInfo) username;
  hostname = "zero";
  system = "x86_64-linux";
  insanelySpecialArgs = { inherit userInfo; };
  modules = with self.nixosModules; [
    profiles.system
    profiles.basic
    profiles.dev
    profiles.gaming
    profiles.niri

    wayland-utils
    gnome
    
    ./hardware-configuration.nix
  ];
}
