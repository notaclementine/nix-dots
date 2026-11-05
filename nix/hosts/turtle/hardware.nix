{self, ...}: {
  flake.nixosModules.turtle-hardware = {
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
        "kvm-intel"
      ];
    };
    disko.devices.disk = {
      hdd = {
        content = {
          partitions.storage = {
            content = {
              extraArgs = ["-f"];
              subvolumes."/data" = {
                mountOptions = [
                  "subvol=data"
                  "compress=zstd:3"
                  "noatime"
                ];
                mountpoint = "/data";
              };
              type = "btrfs";
            };
            size = "100%";
          };
          type = "gpt";
        };
        device = "/dev/disk/by-id/ata-TOSHIBA_DT01ACA100_897K99ANS";
        type = "disk";
      };
      main.device = "/dev/disk/by-id/ata-SanDisk_SDSSDH3_500G_21107B801252";
    };
    environment.etc."machine-id".text = "913d87e12b95456b83a3427fbd512e9b\n";
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  };
}
