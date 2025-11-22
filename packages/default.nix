{ inputs }:
let
  systems = [
    "x86_64-linux"
    "aarch64-linux"
    "aarch64-darwin"
    "x86_64-darwin"
  ];
in
inputs.nixpkgs.lib.genAttrs systems (
  system:
  let
    pkgs = inputs.nixpkgs.legacyPackages.${system};
  in
  {
    nvim = pkgs.callPackage ./nvim { inherit inputs; };
    tmux = pkgs.callPackage ./tmux { inherit inputs; };
    waybar = pkgs.callPackage ./waybar { };
  }
)
