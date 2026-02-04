{ inputs, config, pkgs, ... }:
{
  imports = [
    inputs.minegrub-theme.nixosModules.default
  ];
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_18;
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];

  # Bootloader.
  boot.loader.grub = {
    device = "/dev/disk/by-uuid/daadb322-6837-4b71-b219-89cfe1e3aa33";
    enable = true;
    minegrub-theme = {
      enable = true;
      splash = "Now with 100% more Flakes!";
      background = "background_options/1.8  - [Classic Minecraft].png";
      boot-options-count = 4;
    };
  };
}
