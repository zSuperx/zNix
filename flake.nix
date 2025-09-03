{
  description = "Nixos configuration";

  outputs =
    inputs@{
      self,
      ...
    }:
    {
      lib = import ./lib { inherit inputs self; };

      nixosConfigurations = import ./hosts { inherit self inputs; };

      nixosModules = self.lib.recursiveImport [
        ./modules
        ./profiles
      ];

      packages = import ./packages { inherit inputs; };
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
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    programsdb = {
      url = "github:wamserma/flake-programs-sqlite";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify.url = "github:Gerg-L/spicetify-nix";
    muxie.url = "github:phanorcoll/muxie";
    mnw.url = "github:Gerg-L/mnw";
    base16.url = "github:SenchoPens/base16.nix";
    hyprland.url = "github:hyprwm/Hyprland";
    niri.url = "github:sodiboo/niri-flake";
    gBar.url = "github:scorpion-26/gBar";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
