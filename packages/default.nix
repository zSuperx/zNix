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

    # You have to instantiate base16's lib before using its functions
    inherit (inputs.base16.lib { inherit (pkgs) pkgs lib; }) mkSchemeAttrs;
    colorscheme = mkSchemeAttrs "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
  in
  {
    nvim = pkgs.callPackage ./nvim { inherit inputs colorscheme; };
    tmux = pkgs.callPackage ./tmux { inherit inputs colorscheme; };
  }
)
