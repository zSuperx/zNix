{
  description = "My system flake";

  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    mkSystem = {
      pkgs,
      system,
      hostname,
    }:
      pkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs;};
        modules = [
          {networking.hostName = hostname;}
          (./. + "/hosts/${hostname}/hardware-configuration.nix")

          ./modules/system/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPkgs = true;
              users.zsuper = ./. + "/hosts/${hostname}/user.nix";
              extraSpecialArgs = {inherit inputs;};
            };

            nixpkgs.overlays = [
              ./overlays
            ];
          }
        ];
      };
  in {
    nixosConfigurations = {
      storm = mkSystem {
        pkgs = inputs.nixpkgs;
        system = "x86_64-linux";
        hostname = "storm";
      };
    };
  };

  nixConfig.extra-substituters = [
    "https://hyprland.cachix.org"
    "https://niri.cachix.org"
  ];
  nixConfig.extra-trusted-public-keys = [
    "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
  ];

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    hyprland.url = "github:hyprwm/Hyprland";

    niri-flake.url = "github:sodiboo/niri-flake";

    gBar.url = "github:scorpion-26/gBar";

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
