{
  boot =
    { inputs, pkgs, ... }:
    {
      # CachyOS Kernel
      imports = [
        inputs.chaotic.nixosModules.default
      ];
      boot.kernelPackages = pkgs.linuxPackages_cachyos-lto;

      # Bootloader.
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
    };
}
