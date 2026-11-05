{
  inputs,
  self,
  ...
}: {
  flake.nixosModules.imperm-f2fs = {pkgs, ...}: {
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
          persistent = {
            content = {
              extraArgs = [
                "-f"
                "-l"
                "persistent"
              ];
              format = "f2fs";
              mountOptions = ["noatime"];
              mountpoint = "/persistent";
              postMountHook = ''
                mkdir -p /mnt/persistent/nix
                mkdir -p /mnt/nix
                mount --bind /mnt/persistent/nix /mnt/nix
              '';
              type = "filesystem";
            };
            name = "persistent";
            priority = 4;
            size = "100%";
          };
          root = {
            content = {
              extraArgs = [
                "-f"
                "-l"
                "root"
              ];
              format = "f2fs";
              mountOptions = ["noatime"];
              mountpoint = "/";
              type = "filesystem";
            };
            name = "root";
            priority = 3;
            size = "8G";
          };
          swap = {
            content = {
              resumeDevice = true;
              type = "swap";
            };
            name = "swap";
            priority = 2;
            size = "12G";
          };
        };
        type = "gpt";
      };
      type = "disk";
    };
    fileSystems = {
      "/nix" = {
        options = ["bind"];
        device = "/persistent/nix";
        fsType = "none";
        neededForBoot = true;
      };
      "/persistent".neededForBoot = true;
      "/var/lib/nixos" = {
        device = "/persistent/var/lib/nixos";
        fsType = "none";
        options = ["bind"];
        neededForBoot = true;
        depends = ["/persistent"];
      };
    };
    boot.initrd = {
      supportedFilesystems = ["f2fs"];
      systemd.services.wipe-root = {
        after = [
          "dev-disk-by\\x2dpartlabel-disk\\x2dmain\\x2droot.device"
          "systemd-hibernate-resume.service"
        ];
        before = ["sysroot.mount"];
        description = "Reformat root filesystem";
        serviceConfig = {
          ExecStart = "${pkgs.f2fs-tools}/bin/mkfs.f2fs -f -l root /dev/disk/by-partlabel/disk-main-root";
          Type = "oneshot";
        };
        unitConfig.DefaultDependencies = "no";
        wantedBy = ["initrd.target"];
      };
    };
  };
}
