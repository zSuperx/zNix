{self, ...}: {
  unify.modules.cli = {
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

    home.imports = with self.modules.home; [
      yazi
      nh
      direnv
      zoxide
    ];
  };
}
