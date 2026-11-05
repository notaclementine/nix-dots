{self, ...}: {
  flake.nixosModules.phoenix-hardware = {
    lib,
    modulesPath,
    ...
  }: {
    imports = [
      (modulesPath + "/profiles/qemu-guest.nix")
      self.nixosModules.imperm-btrfs
    ];
    boot = {
      initrd.availableKernelModules = [
        "sd_mod"
        "virtio_blk"
        "virtio_pci"
        "virtio_scsi"
      ];
      kernelParams = ["console=ttyAMA0,115200"];
    };
    disko.devices.disk.main.device = "/dev/disk/by-id/scsi-360d93e21fea24a0db441a57099a55a29";
    environment.etc."machine-id".text = "37b4b744492f46a28db8d0ffac48d8e8\n";
    nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
  };
}
