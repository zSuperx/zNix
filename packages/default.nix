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

    scripts = pkgs.stdenv.mkDerivation {
      name = "custom-scripts";
      src = ./custom-scripts;
      buildInputs = with pkgs; [
        python3Minimal
        perl
      ];

      buildPhase = ''
        mkdir -p $out/bin
        cp $src/* $out/bin
        for f in $out/*; do
          if [ -f "$f" ]; then
            patchShebangs --host "$f"
          fi
        done
      '';
    };
  }
)
