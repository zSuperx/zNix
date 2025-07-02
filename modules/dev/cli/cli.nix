{self, ...}: {
  unify.modules.cli = {
    home = {pkgs, ...}: {
      imports = with self.modules.home; [
        yazi
        zoxide
        nh
      ];
    };

    nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        jq
        fzf
        nitch
        eza
        ripgrep
        bat
        dust
      ];
    };
  };
}
