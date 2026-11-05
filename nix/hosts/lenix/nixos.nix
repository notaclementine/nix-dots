{moduleWithSystem, ...}: {
  flake.nixosModules.lenix-config = moduleWithSystem (
    {self', ...}: {
      config,
      pkgs,
      ...
    }: {
      boot = {
        binfmt.emulatedSystems = ["x86_64-linux"];
        extraModprobeConfig = "options hid_apple iso_layout=0";
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
      environment.systemPackages = [self'.packages.nvim-qwerty];
      hardware = {
        asahi.peripheralFirmwareDirectory = pkgs.requireFile {
          hash = "sha256-ich1SH/YkuDja91ln/PcD0/Oe6Zb5uxGhWIBCeYaHvc=";
          hashMode = "recursive";
          message = "Please run 'nix-store --add-fixed sha256 --recursive /boot/vendorfw' to add the firmware.";
          name = "vendorfw";
        };
        sensor.iio.enable = true;
      };
      networking.hostName = "lenix";
      nix.settings = {
        cores = 4;
        http-connections = 30;
        max-jobs = 1;
        secret-key-files = [config.security.nix-secrets.secrets."nix-cache-key".path];
      };
      nix.settings.extra-platforms = ["x86_64-linux"];
      programs = {
        iio-hyprland.enable = true;
        nh.flake = "/persistent/dotfiles";
        steam.enable = false;
      };
      security.nix-secrets = {
        identityPaths = [
          "/persistent/nix-keys/age-identity.txt"
          "/persistent/nix-keys/yubikey-age.txt"
        ];
        storagePath = "/persistent/secrets";
      };
      systemd.tmpfiles.rules = [
        "L+ /var/lib/iwd/eduroam.8021x - - - - ${
          config.security.nix-secrets.secrets."clementine/wifi/eduroam".path
        }"
      ];
      time.timeZone = "Europe/Amsterdam";
      users = {
        mutableUsers = false;
        users.clementine.hashedPasswordFile = config.security.nix-secrets.secrets."clementine/linux".path;
      };
    }
  );
}
