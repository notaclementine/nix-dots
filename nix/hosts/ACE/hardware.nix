{self, ...}: {
  flake.nixosModules.ACE-hardware = {
    lib,
    modulesPath,
    ...
  }: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
      self.nixosModules.imperm-f2fs
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
    disko.devices.disk.main.device = "/dev/disk/by-id/ata-Micron_1300_MTFDDAV256TDL_2006266A1573";
    environment.etc."machine-id".text = "54b5ba77e1af49dbab5bd2edad98249f\n";
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  };
}
