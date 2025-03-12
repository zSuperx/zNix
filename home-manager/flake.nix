{
	description = "Home Manager flake configuration";

	inputs = {
		# Specify the source of Home Manager and Nixpkgs.
		nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
		home-manager = {
			url = "github:nix-community/home-manager/release-24.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";

		fenix = {
			url = "github:nix-community/fenix";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { nixpkgs, home-manager, ... }@inputs:
		let
			system = "x86_64-linux";
			pkgs = import nixpkgs {
				inherit system;
				overlays = [
					inputs.hyprpanel.overlay
					inputs.fenix.overlays.default
				];
			};
		in {
			homeConfigurations."zsuper" = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;

				modules = [ 
						./home.nix 
				];

				# Optionally use extraSpecialArgs
				# to pass through arguments to home.nix
			};
		};
}
