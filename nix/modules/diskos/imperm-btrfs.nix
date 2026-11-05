{
  inputs,
  self,
  ...
}: {
  flake.nixosModules.imperm-btrfs = {pkgs, ...}: {
    imports = [
      inputs.disko.nixosModules.disko
      self.nixosModules.preservation
    ];
    disko.devices.disk.main = {
      content = {
        partitions = {
          esp = {
            content = {
              format = "vfat";
              mountOptions = ["umask=0077"];
              mountpoint = "/boot";
              type = "filesystem";
            };
            name = "ESP";
            priority = 1;
            size = "5G";
            type = "EF00";
          };
          root = {
            content = {
              extraArgs = ["-f"];
              subvolumes = {
                "/@nix" = {
                  mountOptions = [
                    "subvol=@nix"
                    "compress=zstd"
                    "noatime"
                  ];
                  mountpoint = "/nix";
                };
                "/@persistent" = {
                  mountOptions = [
                    "subvol=@persistent"
                    "compress=zstd"
                    "noatime"
                  ];
                  mountpoint = "/persistent";
                };
                "/@snapshots" = {
                  mountOptions = ["subvol=@snapshots"];
                  mountpoint = "/snapshots";
                };
                "/@void" = {
                  mountOptions = [
                    "subvol=@void"
                    "compress=zstd"
                    "noatime"
                  ];
                  mountpoint = "/";
                };
                "/@void-blank" = {
                  mountOptions = ["subvol=@void-blank"];
                };
              };
              type = "btrfs";
            };
            name = "root";
            priority = 3;
            size = "100%";
          };
        };
        type = "gpt";
      };
      type = "disk";
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
    };
    boot.initrd.systemd.services.rollback-void = {
      after = [
        "dev-disk-by\\x2dpartlabel-disk\\x2dmain\\x2droot.device"
        "systemd-hibernate-resume.service"
      ];
      before = ["sysroot.mount"];
      description = "Roll back @void root subvolume to blank snapshot";
      path = [
        pkgs.btrfs-progs
        pkgs.coreutils
        pkgs.gawk
        pkgs.util-linux
      ];
      script = ''
        mkdir -p /mnt
        mount /dev/disk/by-partlabel/disk-main-root /mnt
        for sub in $(btrfs subvolume list -o /mnt/@void 2>/dev/null | awk '{print $NF}' | sort -r); do
          btrfs subvolume delete "/mnt/$sub" || true
        done
        btrfs subvolume delete /mnt/@void
        btrfs subvolume snapshot /mnt/@void-blank /mnt/@void
        umount /mnt
      '';
      serviceConfig.Type = "oneshot";
      unitConfig.DefaultDependencies = "no";
      wantedBy = ["initrd.target"];
    };
  };
}
