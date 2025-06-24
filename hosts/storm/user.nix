{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/default.nix # Import our module system
  ];

  # Enable our modified modules here
  config.modules = {
    yazi.enable = true;
    nvf.enable = true;
    wofi.enable = true;
  };
}
