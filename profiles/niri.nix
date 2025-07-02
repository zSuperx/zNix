{self, ...}: {
  unify.modules.profile-niri = {
    home = {pkgs, ...}: {
      imports = with self.modules.home; [

      ];
    };

    nixos = {pkgs, ...}: {
      imports = with self.modules.nixos; [

      ];
    };
  };
}
