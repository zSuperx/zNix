{pkgs, ...}: {
  home.packages = with pkgs; [
    # This file will only add languages. LSPs will be managed by Neovim

    # C
    libclang
    gcc
    gnumake
    valgrind
    gdb

    # RUST
    (fenix.complete.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rustc"
      "rustfmt"
    ])
    rust-analyzer

    # Python
    python312
  ];
}
