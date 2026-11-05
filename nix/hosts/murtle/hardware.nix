{self, ...}: {
  flake.nixosModules.murtle-hardware = {
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
    disko.devices.disk = {
      main.device = "/dev/disk/by-id/nvme-WDC_PC_SN520_SDAPNUW-256G-1006_19525E800918";
      secondary = {
        content = {
          partitions.data = {
            content = {
              extraArgs = [
                "-f"
                "-l"
                "data"
              ];
              format = "f2fs";
              mountOptions = ["noatime"];
              mountpoint = "/data";
              type = "filesystem";
            };
            size = "100%";
          };
          type = "gpt";
        };
        device = "/dev/disk/by-id/ata-Samsung_SSD_860_EVO_250GB_S4CJNZFN216585Y";
        type = "disk";
      };
    };
    environment.etc."machine-id".text = "7e60c7ca2a71416792a2269fcb20a530\n";
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  };
}
