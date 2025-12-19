{ inputs, ... }: {
  imports = [
    ./settings.nix
    ./binds/application.nix
    ./binds/hardware.nix
    ./binds/workspace.nix
  ];
}
