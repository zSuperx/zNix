{pkgs, ...}: {
  # Language utilities (most LSPs are provided by NVF)
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
