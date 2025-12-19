{ inputs, pkgs, ... }:
{
  # CachyOS Kernel
  # imports = [
  #   inputs.chaotic.nixosModules.default
  # ];
  # boot.kernelPackages = pkgs.linuxPackages_cachyos;
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_17;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
