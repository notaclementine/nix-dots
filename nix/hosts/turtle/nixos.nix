{moduleWithSystem, ...}: {
  flake.nixosModules.turtle-config = moduleWithSystem ({self', ...}: {
    config,
    pkgs,
    ...
  }: {
    boot = {
      kernelPackages = pkgs.linuxPackages_latest;
      loader.limine = {
        resolution = "1920x1080x32";
        style.interface.resolution = "1920x1080";
      };
    };
    environment.systemPackages = [
      self'.packages.nvim-qwerty
    ];
    networking.hostName = "turtle";
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
    };
    security.nix-secrets.identityPaths = ["/persistent/nix-keys/age-identity.txt"];
    services.pipewire.extraConfig.pipewire."92-custom-quantum" = {
      "context.properties" = {
        "default.clock.max-quantum" = 8192;
        "default.clock.min-quantum" = 512;
        "default.clock.quantum" = 512;
        "default.clock.rate" = 48000;
      };
    };
    time.timeZone = "Europe/London";
    users = {
      mutableUsers = false;
      users = {
        aude.hashedPasswordFile = config.security.nix-secrets.secrets."aude/linux".path;
        ewan.hashedPasswordFile = config.security.nix-secrets.secrets."ewan/linux".path;
        kyla.hashedPasswordFile = config.security.nix-secrets.secrets."kyla/linux".path;
      };
    };
    zramSwap = {
      enable = true;
      memoryPercent = 25;
    };
    # printer stuff
    services = {
      printing = {
        enable = true;
        drivers = [pkgs.hplipWithPlugin];
      };
      avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };
    };
    hardware.sane = {
      enable = true;
      extraBackends = [pkgs.hplipWithPlugin];
    };
    users.users = {
      aude.extraGroups = ["lp" "scanner"];
      ewan.extraGroups = ["lp" "scanner"];
      kyla.extraGroups = ["lp" "scanner"];
    };
  });
}
