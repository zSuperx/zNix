{ config, pkgs, ... }:

{
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

		# LUA
		lua-language-server
	
        # Python
        pyright
        uv
    ];
}
