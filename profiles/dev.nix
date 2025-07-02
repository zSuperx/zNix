{self, ...}: {
  unify.modules.profile-dev = {
    home = {pkgs, ...}: {
      imports = with self.modules.home; [
        cli
        fish
        nvf
        kitty
        wezterm
      ];
    };

    nixos = {pkgs, ...}: {
      imports = with self.modules.nixos; [
        cli
        languages
        fish
      ];
    };
  };
}
