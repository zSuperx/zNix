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

    fleet-services.url = "git+ssh://git@github.com/zSuperx/fleet-services";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri-flake.url = "github:sodiboo/niri-flake";

    programsdb = {
      url = "github:wamserma/flake-programs-sqlite";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    minegrub-theme = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:Lxtharia/minegrub-theme";
    };

    muffin = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:zSuperx/muffin";
    };
    hellpaper = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:zSuperx/hellpaper";
    };

    mnw.url = "github:Gerg-L/mnw";
    wlctl.url = "github:aashish-thapa/wlctl";

    disko = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/disko";
    };
    colmena = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:zhaofengli/colmena";
    };
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify = {
      url = "github:Gerg-L/spicetify-nix";
    };
  };
}
