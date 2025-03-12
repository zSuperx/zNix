{
    description = "My system flake";

    inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    };

    outputs = { self, nixpkgs }: {
        nixosConfigurations = {
            nixos = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [
                    ./configuration.nix  
                    ./hardware-configuration.nix
                ];
            };
        };
    };
}
