{
  inputs,
  pkgs,
  lib,
}:
let
  inherit (lib.strings) concatMapStrings;
  scripts = pkgs.callPackage ./scripts.nix { };
  plugins = pkgs.callPackage ./config/plugins.nix { };
  settings = pkgs.callPackage ./config/settings.nix {
    inherit inputs scripts;
  };
  status = ./config/status.conf;
  config-files = [
    plugins
    settings
    status

    # This file will be generated at runtime by matugen
    # Even if the path is incorrect, matugen will re-source the true path
    "~/.config/tmux/matugen.conf" 
  ];
  # Populate `tmux-main.conf` with imports for other files
  tmux-main = pkgs.writeText "tmux-main.conf" ''
    ${concatMapStrings (x: "source-file " + x + "\n") config-files}

    # I don't like that I have to do this here, but it's to do with the way tmux
    # orders its source files. Imperative option-setting, yuck...
    setw -g popup-style bg=default
    set  -g escape-time     10
  '';
in
pkgs.stdenv.mkDerivation {
  inherit (pkgs.tmux) pname version;

  src = ./.;

  nativeBuildInputs = [
    pkgs.makeBinaryWrapper
  ];

  installPhase = ''
    mkdir -p $out/bin
    makeWrapper ${lib.getExe pkgs.tmux} $out/bin/tmux \
      --add-flags "-f${tmux-main}"
  '';
}
