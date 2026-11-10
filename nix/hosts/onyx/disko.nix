{inputs, ...}: {
  flake.nixosModules.onyx-disko = {
    imports = [inputs.disko.nixosModules.disko];
    disko.devices = {
      disk.hdd = {
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
        device = "/dev/disk/by-id/ata-ST2000LM015-2E8174_ZDZQ7T41";
        type = "disk";
      };
      disk.main = {
        content.partitions = {
          esp = {
            content = {
              format = "vfat";
              mountpoint = "/boot";
              type = "filesystem";
            };
            name = "ESP";
            size = "5G";
            type = "EF00";
          };
          root = {
            content = {
              extraArgs = ["-f"];
              subvolumes = {
                "/nix" = {
                  mountOptions = [
                    "subvol=nix"
                    "compress=zstd:3"
                    "noatime"
                  ];
                  mountpoint = "/nix";
                };
                "/persistent" = {
                  mountOptions = [
                    "subvol=persistent"
                    "compress=zstd:3"
                    "noatime"
                  ];
                  mountpoint = "/persistent";
                };
                "/tmp" = {
                  mountOptions = [
                    "subvol=tmp"
                    "compress=zstd:3"
                    "noatime"
                  ];
                  mountpoint = "/tmp";
                };
              };
              type = "btrfs";
            };
            name = "root";
            size = "100%";
          };
        };
        content.type = "gpt";
        device = "/dev/disk/by-id/nvme-Samsung_SSD_980_PRO_2TB_S6B0NU0WA12347K";
        type = "disk";
      };
      nodev = {
        "/" = {
          fsType = "tmpfs";
          mountOptions = [
            "size=25%"
            "mode=755"
          ];
        };
      };
    };
    fileSystems = {
      "/nix".neededForBoot = true;
      "/persistent".neededForBoot = true;
      "/var/lib/nixos" = {
        device = "/persistent/var/lib/nixos";
        fsType = "none";
        options = ["bind"];
        neededForBoot = true;
        depends = ["/persistent"];
      };
      "/var/log" = {
        depends = ["/persistent"];
        device = "/persistent/var/log";
        fsType = "none";
        neededForBoot = true;
        options = ["bind"];
      };
    };
  };
}
