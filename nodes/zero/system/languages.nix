{ inputs, pkgs, ... }:
{
  nixpkgs.overlays = [
    inputs.fenix.overlays.default
  ];
  environment.systemPackages = with pkgs; [
    # C
    libclang
    gcc
    gnumake
    valgrind
    gdb

    # Rust
    (fenix.complete.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rustc"
      "rustfmt"
    ])

    # Python
    python313
    uv
  ];
}
