{
  flake.nixosModules.phoenix-brewery = {config, ...}: {
    services = {
      brewery = {
        enable = true;
        sessionKeyFile = config.security.nix-secrets.secrets."other/brewery".path;
        ssh = {
          enable = true;
          publicHost = "git-ssh.ts.econnah.uk";
        };
      };
      caddy.extraConfig = ''
        http://git.ts.econnah.uk {
          reverse_proxy 127.0.0.1:7000
        }
      '';
    };
    systemd.services.brewery.environment.BREWERY_PUBLIC_URL = "https://git.ts.econnah.uk";
    security = {
      nix-secrets.secrets."other/brewery" = {
        recipients = [
          "phoenix"
          "yubikey"
        ];
        owner = "git";
        group = "git";
        mode = "0400";
      };
      acme = {
        acceptTerms = true;
        defaults.email = "me@econnah.uk";
      };
    };
    system.nixos-core.persistence.stores."/persistent".directories = [
      {
        target = "/var/lib/brewery";
        owner = "git";
        group = "git";
        mode = "0700";
      }
    ];
  };
}
