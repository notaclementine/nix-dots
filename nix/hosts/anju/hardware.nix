{
  flake.nixosModules.anju-hardware = {
    lib,
    modulesPath,
    ...
  }: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
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
        "kvm-intel"
      ];
    };
    environment.etc."machine-id".text = "80581d17707f4515805b37f268547c38\n";
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  };
}
