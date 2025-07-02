{self, config, ...}: {
  unify.modules.profile-gaming = {
    nixos = {pkgs, ...}: {
      imports = with self.modules.nixos; [
        gaming
      ];
    };
  };
}
