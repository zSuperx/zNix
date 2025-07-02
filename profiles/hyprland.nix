{self, ...}: {
  unify.modules.profile-hyprland = {
    home = {pkgs, ...}: {
      imports = with self.modules.home; [
        hyprland
        wayland-utils
        hypr-util
      ];
    };

    nixos = {pkgs, ...}: {
      imports = with self.modules.nixos; [
        hyprland
        wayland-utils
        hypr-util
      ];
    };
  };
}
