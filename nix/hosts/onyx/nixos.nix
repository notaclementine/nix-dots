{moduleWithSystem, ...}: {
  flake.nixosModules.onyx-config = moduleWithSystem (
    {self', ...}: {
      config,
      pkgs,
      ...
    }: {
      boot = {
        kernelPackages = pkgs.linuxPackages_zen;
        extraModulePackages = [config.boot.kernelPackages.r8125];
        blacklistedKernelModules = ["r8169"];
        extraModprobeConfig = ''
          options r8125 disable_wol_support=0 s5wol=1 aspm=0
        '';
        loader.limine = {
          extraEntries = ''
            /+Other
            //Windows 11
              protocol: efi_chainload
              image_path: guid(8fef2ca3-6a98-445a-80a0-0e94b8ea8ba6):/EFI/Microsoft/Boot/bootmgfw.efi
          '';
          resolution = "2560x1440x32";
          secureBoot = {
            enable = true;
            autoEnrollKeys.enable = true;
            autoGenerateKeys = true;
          };
          style.interface.resolution = "2560x1440";
        };
      };
      environment.systemPackages = [
        pkgs.efibootmgr
        self'.packages.nvim-qwerty
      ];
      networking = {
        hostName = "onyx";
        dhcpcd.enable = false;
        useDHCP = false;
      };
      nix.settings = {
        cores = 0;
        http-connections = 100;
        max-jobs = 2;
        secret-key-files = [config.security.nix-secrets.secrets."nix-cache-key".path];
      };
      programs = {
        gamescope = {
          enable = true;
          capSysNice = true;
        };
        nh.flake = "/persistent/dotfiles";
      };
      security.nix-secrets = {
        identityPaths = [
          "/persistent/nix-keys/age-identity.txt"
          "/persistent/nix-keys/yubikey-age.txt"
        ];
        storagePath = "/persistent/secrets";
      };
      services.pipewire.extraConfig.pipewire."92-custom-quantum" = {
        "context.properties" = {
          "default.clock.max-quantum" = 8192;
          "default.clock.min-quantum" = 512;
          "default.clock.quantum" = 512;
          "default.clock.rate" = 48000;
        };
      };
      services.resolved.enable = true;
      systemd.network = {
        enable = true;
        links."10-ethernet" = {
          matchConfig.Name = "en*";
          linkConfig.WakeOnLan = "magic";
        };
        networks."10-ethernet" = {
          linkConfig = {
            RequiredForOnline = "routable";
          };
          matchConfig.Name = "en*";
          networkConfig = {
            DHCP = "ipv4";
            IPv6AcceptRA = false;
          };
        };
      };
      time.timeZone = "Europe/Amsterdam";
      users = {
        mutableUsers = false;
        users.clementine.hashedPasswordFile = config.security.nix-secrets.secrets."clementine/linux".path;
      };
      zramSwap = {
        enable = true;
        memoryPercent = 25;
      };
      hardware.bluetooth.enable = true;
    }
  );
}
