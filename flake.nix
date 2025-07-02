{
  description = "Nixos configuration";

  outputs = inputs @ {
    self,
    flake-parts,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs self;} {
      systems = ["x86_64-linux"];
      imports = [
        inputs.unify.flakeModule
        (inputs.import-tree [
          ./hosts
          ./modules
          ./profiles
        ])
      ];
      perSystem = {pkgs, ...}: {
        packages.hello = pkgs.hello;
      };

      flake.projectRoot = builtins.toString ./.;
    };

  nixConfig = {
    extra-substituters = [
      "https://hyprland.cachix.org"
      "https://niri.cachix.org"
    ];
    extra-trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
    ];
  };

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";

    import-tree.url = "github:vic/import-tree";
    unify = {
      url = "git+https://codeberg.org/zSuperx/unify";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
