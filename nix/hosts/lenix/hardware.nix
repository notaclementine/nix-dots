{
  flake.nixosModules.lenix-hardware = {
    lib,
    pkgs,
    modulesPath,
    ...
  }: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];
    boot = {
      extraModulePackages = [];
      initrd = {
        availableKernelModules = ["uas"];
        kernelModules = [];
        luks.devices."cryptlenix".device = "/dev/disk/by-uuid/6a31662c-38a3-43f7-bf31-2185d0baf64d";
        systemd.services.rollback-void = {
          after = [
            "cryptsetup.target"
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
            mount /dev/mapper/cryptlenix /mnt
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
      kernelModules = [];
    };
    fileSystems = {
      "/" = {
        options = [
          "subvol=@void"
          "compress=zstd"
          "noatime"
        ];
        device = "/dev/disk/by-uuid/31955c6c-b21a-48f1-aa60-b2e9ac155e28";
        fsType = "btrfs";
      };
      "/boot" = {
        options = [
          "fmask=0077"
          "dmask=0077"
        ];
        device = "/dev/disk/by-uuid/33D3-16FC";
        fsType = "vfat";
      };
      "/nix" = {
        options = [
          "subvol=@nix"
          "compress=zstd"
          "noatime"
        ];
        device = "/dev/disk/by-uuid/31955c6c-b21a-48f1-aa60-b2e9ac155e28";
        fsType = "btrfs";
        neededForBoot = true;
      };
      "/persistent" = {
        options = [
          "subvol=@persistent"
          "compress=zstd"
          "noatime"
        ];
        device = "/dev/disk/by-uuid/31955c6c-b21a-48f1-aa60-b2e9ac155e28";
        fsType = "btrfs";
        neededForBoot = true;
      };
      "/snapshots" = {
        options = ["subvol=@snapshots"];
        device = "/dev/disk/by-uuid/31955c6c-b21a-48f1-aa60-b2e9ac155e28";
        fsType = "btrfs";
      };
      "/swap" = {
        options = [
          "subvol=@swap"
          "noatime"
        ];
        device = "/dev/disk/by-uuid/31955c6c-b21a-48f1-aa60-b2e9ac155e28";
        fsType = "btrfs";
      };
      "/var/lib/nixos" = {
        device = "/persistent/var/lib/nixos";
        fsType = "none";
        options = ["bind"];
        neededForBoot = true;
        depends = ["/persistent"];
      };
    };
    environment.etc."machine-id".text = "6bba83dbc7c44c879acc6a15582d5e30\n";
    nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
    swapDevices = [{device = "/swap/swapfile";}];
  };
}
