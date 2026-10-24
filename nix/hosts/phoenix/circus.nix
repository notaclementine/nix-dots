{inputs, ...}: {
  flake.nixosModules.phoenix-circus = {config, ...}: {
    imports = [inputs.circus.nixosModules.default];
    services = {
      circus = {
        enable = true;
        server.enable = true;
        evaluator.enable = true;
        queueRunner.enable = true;

        settings = {
          database = {
            url = "postgresql:///circus?host=/run/postgresql&user=circus";
            max_connections = 20;
          };
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
            host = "127.0.0.1";
            port = 3001;
            force_secure_cookies = true;
          };
          queue_runner = {
            build_timeout = 15000;
            workers = 4;
            local_systems = ["aarch64-linux"];
            local_features = ["nixos-test" "big-parallel" "kvm"];
          };
          evaluator = {
            poll_interval = 300;
            restrict_eval = false;
            allow_ifd = false;
            memory_limit_mb = 3072;
            eval_workers = 4;
            max_concurrent_evals = 2;
            systems = ["aarch64-linux"];
          };
          gc = {
            enabled = true;
            max_age_days = 10;
            cleanup_interval = 3600;
          };
          logs = {
            compress = true;
          };
          signing = {
            enabled = true;
            key_file = config.security.nix-secrets.secrets."nix-cache-key".path;
            public_key = "lecache:T6owlM58CGYc8X5xrAMq+IP6ilNWBpWlR8VazPPkjAQ=";
          };
        };
      };
      haproxy = {
        enable = true;
        config = ''
          defaults
            mode http
            option forwardfor
            timeout connect 5s
            timeout client 10m
            timeout server 10m
            timeout tunnel 1h
            timeout http-keep-alive 30s
            timeout http-request 30s

          frontend circus_in
            bind 100.110.83.57:3000
            default_backend circus_out

          backend circus_out
            server local 127.0.0.1:3001
        '';
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
      haproxy = {
        after = ["tailscale-online.service"];
        requires = ["tailscale-online.service"];
        partOf = ["tailscale-online.service"];
      };
    };
  };
}
