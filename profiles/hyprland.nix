{
  profiles.hyprland =
    { self, ... }:
    {
      imports = with self.nixosModules; [
        hyprland
        hyprutil
        wayland-utils
      ];
    };
}
