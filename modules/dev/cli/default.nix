{
  self,
  inputs,
  ...
}: {
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
        fd
        gotop

        # Networking
        nmap
        traceroute
        dig
        busybox
      ];
      programs.command-not-found.enable = true;
      programs.command-not-found.dbPath = inputs.programsdb.packages.${pkgs.system}.programs-sqlite;
    };
    home.imports = with self.modules.home; [
      yazi
      nh
      direnv
      zoxide
    ];
  };
}
