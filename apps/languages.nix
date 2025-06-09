{pkgs, ...}: {
  # Language utilities
  # All LSPs are provided by NVF since they are only used in IDE environments
  home.packages = with pkgs; [
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
