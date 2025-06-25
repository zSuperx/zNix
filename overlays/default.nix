{inputs, ...}: {
  inputs.nixpkgs.overlays = [
    inputs.hyprpanel.overlay
    inputs.fenix.overlays.default
  ];
}
