{
  description = "Me and what army, you ask?";

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      colmena,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeModules.zsuper = ./home; # So NixOS configurations can reference via self
      homeConfigurations.zsuper = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          self.homeModules.zsuper
        ];
        extraSpecialArgs = {
          inherit inputs self;
          inherit (pkgs.stdenv.hostPlatform) system;
        };
      };

      colmenaHive = colmena.lib.makeHive (import ./nodes/colmena.nix { inherit inputs self pkgs; });

      nixosConfigurations = self.colmenaHive.nodes; # useful for repl debugging

      packages = import ./packages { inherit inputs; };
    };

  nixConfig = {
    extra-substituters = [
      "https://niri.cachix.org" # Niri Window Manager
    ];
    extra-trusted-public-keys = [
      "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964=" # Niri Window Manager
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    programsdb = {
      url = "github:wamserma/flake-programs-sqlite";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    yazi.url = "github:sxyazi/yazi";
    minegrub-theme.url = "github:Lxtharia/minegrub-theme";
    muxie.url = "github:zSuperx/muxie";
    mnw.url = "github:Gerg-L/mnw";
    niri.url = "github:sodiboo/niri-flake";

    disko.url = "github:nix-community/disko";
    colmena.url = "github:zhaofengli/colmena";
    server-modules = {
      url = "/home/zsuper/server-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
