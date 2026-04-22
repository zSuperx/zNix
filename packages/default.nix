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

    # This will create a single derivation containing all scripts
    # in ./custom-scripts/
    # These scripts will be part of $out/bin, so adding this to
    # environment.systemPackages will add ALL scripts to $PATH.
    scripts = pkgs.stdenv.mkDerivation {
      name = "custom-scripts";
      src = ./custom-scripts;

      # These "shell-like" interpreters will be part of buildInputs
      # This way, patchShebangs allows not just bash scripts,
      # but Perl, Python, etc if I want those in the future
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
