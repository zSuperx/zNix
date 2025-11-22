{
  symlinkJoin,
  waybar,
  jq,
  makeWrapper,
  pkgs,
  lib,
}:
let
  waybar-config = import ./config.nix { inherit pkgs lib; };
in
symlinkJoin {
  name = "waybar";

  paths = [
    waybar
  ];

  buildInputs = [
    makeWrapper
    jq
  ];

  postBuild = ''
    echo '${builtins.toJSON waybar-config}' | jq > $out/share/config.json

    wrapProgram $out/bin/waybar \
      --add-flags "-c $out/share/config.json"
  '';
}
