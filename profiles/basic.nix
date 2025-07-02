{self, ...}: {
  unify.modules.profile-basic = {
    home = {pkgs, ...}: {
      imports = with self.modules.home; [
        vesktop
      ];
    };

    nixos = {pkgs, ...}: {
      imports = with self.modules.nixos; [
        apps
      ];
    };
  };
}
