{
  description = "My system flake";

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

  outputs =
    {
      nixpkgs,
      home-manager,
      stylix,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./system/configuration.nix
            stylix.nixosModules.stylix

            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.zsuper = import ./home.nix;
                extraSpecialArgs = {
                  inherit inputs;
                };
                backupFileExtension = "backup";
              };
            }
          ];
        };
      };

      packages.${system}.neovim =
        (inputs.nvf.lib.neovimConfiguration {
          inherit pkgs;
          modules = [ ./editor/nvim-settings.nix ];
        }).neovim;
    };
}
