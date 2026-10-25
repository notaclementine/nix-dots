{inputs, ...}: {
  flake.nixosModules.phoenix-circus = {config, ...}: {
    imports = [inputs.circus.nixosModules.default];
    services.circus = {
      enable = true;
      server.enable = true;
      evaluator.enable = true;
      queueRunner.enable = true;

      settings = {
        database.url = "postgresql:///circus?host=/run/postgresql&user=circus";
        cache = {
          enabled = true;
          cache_url = "https://circus.ts.econnah.uk/nix-cache";
        };
        declarative = {
          users = [
            {
              username = "admin";
              email = "git@econnah.uk";
              password_file = config.security.nix-secrets.secrets."other/circus/admin-password".path;
              role = "admin";
            }
          ];
          api_keys = [
            {
              name = "admin-key";
              key_file = config.security.nix-secrets.secrets."other/circus/admin-key".path;
              role = "admin";
            }
          ];
        };
        server = {
          host = "100.110.83.57";
          port = 3000;
          force_secure_cookies = true;
        };
        queue_runner = {
          build_timeout = 15000;
          workers = 2;
        };
        evaluator = {
          poll_interval = 300;
          restrict_eval = false;
        };
        signing = {
          enabled = true;
          key_file = config.security.nix-secrets.secrets."nix-cache-key".path;
          public_key = "lecache:T6owlM58CGYc8X5xrAMq+IP6ilNWBpWlR8VazPPkjAQ=";
        };
      };
    };
    system.nixos-core.persistence.stores."/persistent".directories = [
      "/var/lib/circus"
      "/var/lib/postgresql"
    ];
    security.nix-secrets.secrets = {
      "other/circus/admin-password" = {
        group = "circus";
        owner = "circus";
        recipients = ["phoenix" "yubikey"];
      };
      "other/circus/admin-key" = {
        group = "circus";
        owner = "circus";
        recipients = ["phoenix" "yubikey"];
      };
      "nix-cache-key" = {
        group = "circus";
        owner = "circus";
      };
    };
    systemd.services = {
      tailscale-online = {
        description = "wait for tailscale to get an ip";
        after = ["tailscaled.service"];
        requires = ["tailscaled.service"];
        partOf = ["tailscaled.service"];
        wantedBy = ["multi-user.target"];
        path = [config.services.tailscale.package];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
          TimeoutStartSec = "infinity";
        };
        script = ''
          until tailscale ip -4 >/dev/null 2>&1; do
            sleep 1
          done
        '';
      };
      circus-server = {
        after = ["tailscale-online.service"];
        requires = ["tailscale-online.service"];
        partOf = ["tailscale-online.service"];

        serviceConfig.LimitNOFILE = 65536;
      };
      circus-evaluator = {
        after = ["tailscale-online.service"];
        requires = ["tailscale-online.service"];
        partOf = ["tailscale-online.service"];
      };
      circus-queue-runner = {
        after = ["tailscale-online.service"];
        requires = ["tailscale-online.service"];
        partOf = ["tailscale-online.service"];

        serviceConfig.LimitNOFILE = 65536;
      };
    };
  };
}
