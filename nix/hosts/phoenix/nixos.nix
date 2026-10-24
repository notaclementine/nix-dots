{moduleWithSystem, ...}: {
  flake.nixosModules.phoenix-config = moduleWithSystem ({self', ...}: {
    config,
    lib,
    ...
  }: {
    environment.systemPackages = [
      self'.packages.nvim-qwerty
    ];
    boot.loader.efi.canTouchEfiVariables = lib.mkForce false;
    boot.loader.limine.efiInstallAsRemovable = true;
    networking.hostName = "phoenix";
    nix.settings = {
      experimental-features = [
        "pipe-operators"
      ];
      cores = 4;
      http-connections = 100;
      max-jobs = 4;
      secret-key-files = [config.security.nix-secrets.secrets."nix-cache-key".path];
    };
    programs.nh.flake = "/persistent/dotfiles";
    security.nix-secrets.identityPaths = ["/persistent/keys/age-identity.txt"];
    services.openssh.settings.PasswordAuthentication = false; # force login to only yubikey
    time.timeZone = "Europe/London";
    users = {
      mutableUsers = false;
      users = {
        clementine.hashedPasswordFile = config.security.nix-secrets.secrets."clementine/linux".path;
      };
    };
  });
}
