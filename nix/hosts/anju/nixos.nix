{moduleWithSystem, ...}: {
  flake.nixosModules.anju-config = moduleWithSystem ({self', ...}: {
    config,
    lib,
    ...
  }: {
    environment.systemPackages = [
      self'.packages.nvim-qwerty
    ];
    boot.loader = {
      efi.canTouchEfiVariables = lib.mkForce false;
      limine.efiInstallAsRemovable = true;
    };
    networking.hostName = "anju";
    nix.settings = {
      experimental-features = [
        "pipe-operators"
      ];
      cores = 4;
      http-connections = 100;
      max-jobs = 4;
      #secret-key-files = [config.security.nix-secrets.secrets."nix-cache-key".path];
    };
    programs.nh.flake = "/persistent/dotfiles";
    security.nix-secrets.enable = lib.mkForce false; #identityPaths = ["/persistent/keys/age-identity.txt"];
    services = {
      openssh = {
        settings.PasswordAuthentication = false; # force login to only yubikey
        openFirewall = lib.mkForce true; # temp
      };
      caddy = {
        enable = true;
        globalConfig = ''
          auto_https off
          servers {
            timeouts {
              idle 1m
            }
          }
        '';
      };
    };
    system.nixos-core.persistence.stores."/persistent".directories = [
      {
        group = "caddy";
        owner = "caddy";
        target = "/var/lib/caddy";
      }
    ];
    time.timeZone = "Europe/London";
    users = {
      mutableUsers = false;
      users = {
        clementine.password = "changeMe"; #hashedPasswordFile = config.security.nix-secrets.secrets."clementine/linux".path;
      };
    };
  });
}
