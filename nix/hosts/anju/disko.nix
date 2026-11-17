{self, ...}: {
  flake.nixosModules.anju-disko = {lib, ...}: {
    imports = [
      self.nixosModules.imperm-btrfs
    ];

    boot.supportedFilesystems = ["bcachefs"];

    disko.devices = {
      disk = {
        main = {
          device = "/dev/disk/by-id/nvme-512GB_SSD_CN276BH4010366";
          content.partitions = {
            root.size = lib.mkForce "150G";
            bcachefs_ssd = {
              name = "bcachefs_ssd";
              priority = 4;
              size = "100%";
            };
          };
        };
      };
    };

    /*
    fileSystems."/swimming-pool" = {
      device = "UUID=";
      fsType = "bcachefs";
      options = ["noatime" "nofail" "x-systemd.device-timeout=30s"];
    };
    */
  };
}
