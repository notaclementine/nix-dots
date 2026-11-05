{self, ...}: {
  flake.nixosModules.cookie-hardware = {
    lib,
    modulesPath,
    ...
  }: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
      self.nixosModules.imperm-btrfs
    ];
    boot = {
      initrd.availableKernelModules = [
        "nvme"
        "xhci_pci"
        "ahci"
        "usb_storage"
        "sd_mod"
      ];
      kernelModules = [
        "kvm-amd"
      ];
    };
    disko.devices.disk.main = {
      content.partitions.swap = {
        content = {
          resumeDevice = true;
          type = "swap";
        };
        name = "swap";
        priority = 2;
        size = "12G";
      };
      device = "/dev/disk/by-id/ata-ST1000LM035-1RK172_WDEFKAEW";
    };
    environment.etc."machine-id".text = "eb776f59c84a4dc98cb16da737ff5b33\n";
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  };
}
