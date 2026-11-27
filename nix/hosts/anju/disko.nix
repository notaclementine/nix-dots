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

    # my master plan
    /*
    the ssd will have about 345 GB of storage for the bcachefs pool
    2x 16TB hdd's will also join the pool
    default to promote off
    nix cache will have promote on

        fileSystems."/swimming-pool" = {
          device = "UUID=";
          fsType = "bcachefs";
          options = ["noatime" "nofail" "x-systemd.device-timeout=30s"];
        };
    */
  };
}
