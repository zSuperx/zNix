{
  description = "System flake";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    hyprland.url = "github:hyprwm/Hyprland";

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    flake-parts,
    nixpkgs,
    home-manager,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        # To import a flake module
        # 1. Add foo to inputs
        # 2. Add foo as a parameter to the outputs function
        # 3. Add here: foo.flakeModule
      ];
      systems = ["x86_64-linux"];
      perSystem = {
        config,
        self',
        inputs',
        pkgs,
        system,
        ...
      }: {
        packages.neovim =
          (inputs.nvf.lib.neovimConfiguration {
            inherit pkgs;
            modules = [./editor/nvim-settings.nix];
          })
          .neovim;
      };
      flake = {
        nixosConfigurations = {
          nixos = nixpkgs.lib.nixosSystem {
            specialArgs = {inherit inputs;};
            modules = [
              ./system/configuration.nix
              inputs.stylix.nixosModules.stylix

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
      };
    };
}
