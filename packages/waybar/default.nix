{
  symlinkJoin,
  waybar,
  jq,
  makeWrapper,
  pkgs,
}:
let
  scripts = import ./scripts.nix { inherit (pkgs) lib pkgs; };
  waybar-config = import ./config.nix { inherit pkgs scripts; };
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
