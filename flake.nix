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

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    programsdb = {
      url = "github:wamserma/flake-programs-sqlite";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    base16.url = "github:SenchoPens/base16.nix";
    base16-schemes = {
      url = "github:tinted-theming/base16-schemes";
      flake = false;
    };

    spicetify.url = "github:Gerg-L/spicetify-nix";
    muxie.url = "github:zSuperx/muxie";
    # muxie.url = "github:phanorcoll/muxie"; # TODO: switch back to upstream once PR gets merged.
    mnw.url = "github:Gerg-L/mnw";
    # hyprland.url = "github:hyprwm/Hyprland";
    niri.url = "github:sodiboo/niri-flake";
    # gBar.url = "github:scorpion-26/gBar";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
