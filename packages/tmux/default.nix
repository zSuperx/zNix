{
  inputs,
  pkgs,
  lib,
  colorscheme,
}:
let
  inherit (lib.strings) concatMapStrings;
  scripts = pkgs.callPackage ./scripts.nix { };
  plugins = pkgs.callPackage ./config/plugins.nix { inherit scripts colorscheme; };
  settings = pkgs.callPackage ./config/settings.nix {
    inherit inputs scripts colorscheme;
  };
  config-files = [
    plugins
    settings
  ];
  # Populate `tmux-main.conf` with imports for other files
  tmux-main = pkgs.writeText "tmux-main-bruh.conf" ''
    ${concatMapStrings (x: "source-file " + x + "\n") config-files}

      # I don't like that I have to do this here, but it's to do with the way tmux
      # orders its source files. Imperative option-setting, yuck...
      setw -g popup-style bg=${colorscheme.withHashtag.base01}
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
    echo $hash
    makeWrapper ${lib.getExe pkgs.tmux} $out/bin/tmux \
      --add-flags "-f${tmux-main}"
  '';
}
