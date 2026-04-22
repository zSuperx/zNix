{ inputs, config, pkgs, ... }:
{
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_18;
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];

  # Bootloader.
  # TODO: find a way to use Grub. Supposedly grub doesn't work on FW13?
  boot.loader.systemd-boot.enable = true;

  #
  # imports = [
  #   inputs.minegrub-theme.nixosModules.default
  # ];
  #
  # boot.loader.grub = {
  #   device = "/dev/disk/by-uuid/6484b88c-1c68-4aa9-ae83-4510aa1d0725";
  #   enable = true;
  #   minegrub-theme = {
  #     enable = false;
  #     splash = "Now with 100% more Flakes!";
  #     background = "background_options/1.8  - [Classic Minecraft].png";
  #     boot-options-count = 4;
  #   };
  # };
}
