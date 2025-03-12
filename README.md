## Directory Structure

The `home-manager` and `system` directories contain `.nix` files for building my system. For security and reproducibility reasons, `hardware-configuration.nix` has been omitted from this repository (since it's automatically created by NixOS on each machine).

The actual dotfiles are located in `home-manager/dotfiles`, and are sym-linked to their desired locations through Home Manager (see `home.file` in `home.nix`).
