{
  cli =
    {
      self,
      inputs,
      pkgs,
      ...
    }:
    {
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
        kitty
        vim
        wget
        git
        nix-tree

        # Networking
        nmap
        traceroute
        dig
        busybox
      ];

      # Reverse map from binary names to Nix packages
      programs.command-not-found = {
        enable = true;
        dbPath = inputs.programsdb.packages.${pkgs.system}.programs-sqlite;
      };

      imports = with self.nixosModules; [
        yazi
        nh
        direnv
        zoxide
      ];
    };
}
