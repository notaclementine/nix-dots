{moduleWithSystem, ...}: {
  flake.nixosModules.escapepod3-config = moduleWithSystem ({self', ...}: {pkgs, ...}: {
    boot = {
      initrd.kernelModules = ["lz4"];
      kernel.sysctl = {
        "vm.swappiness" = 70;
      };
      kernelParams = [
        "zswap.compressor=lz4"
        "zswap.enabled=1"
        "zswap.max_pool_percent=20"
        "zswap.shrinker_enabled=1"
      ];
    };
    boot.binfmt.emulatedSystems = ["x86_64-linux"];
    boot.extraModprobeConfig = "options hid_apple iso_layout=0";
    environment.systemPackages = [self'.packages.nvim-qwerty];
    fileSystems = {
      "/".options = ["compress=zstd"];
      "/home".options = ["compress=zstd"];
      "/nix".options = [
        "compress=zstd"
        "noatime"
      ];
      "/swap".options = ["noatime"];
      "/var/cache".options = ["noatime"];
      "/var/log".options = ["compress=zstd"];
    };
    hardware.asahi.peripheralFirmwareDirectory = pkgs.requireFile {
      hash = "sha256-X+HF1Ste4dAthjcjE/RtC5sOPGgLh10nZvvQVXvvr6k=";
      hashMode = "recursive";
      message = "Please run 'nix-store --add-fixed sha256 --recursive /boot/vendorfw' to add the firmware.";
      name = "vendorfw";
    };
    hardware.sensor.iio.enable = true;
    networking.hostName = "escapepod3";
    nix.settings = {
      cores = 4;
      max-jobs = 2;
    };
    nix.settings.extra-platforms = ["x86_64-linux"];
    programs = {
      iio-hyprland.enable = true;
      nh.flake = "/home/leo/Documents/dotfiles";
      steam.enable = false;
    };
    security.nix-secrets.identityPaths = [
      "/persistent/secrets/leo/age-identity.txt" # uh I forgot u weren't on impermenance but doesn't matter
    ];
    swapDevices = [{device = "/swap/swapfile";}];
    time.timeZone = "Europe/London";
  });
}
