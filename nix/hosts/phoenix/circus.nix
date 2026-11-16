{
  inputs,
  self,
  ...
}: {
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
            rpc = {
              bind = "0.0.0.0:8443";
              cache_substituter = "https://circus.ts.econnah.uk/nix-cache";
              cache_public_key = "lecache:T6owlM58CGYc8X5xrAMq+IP6ilNWBpWlR8VazPPkjAQ=";
              join_tokens = [
                {
                  name = "edgerunners";
                  token_hash = "0dc1a2046a6a4366567708fa987d71bda8fd5162244b07845d6a1c81f5611d5a";
                }
              ];
              tls = {
                cert_file = "${self}/not-nix/other/circus/runner.crt";
                key_file = config.security.nix-secrets.secrets."other/circus/runner-key".path;
                require_client_cert = false;
              };
            };
          };
          evaluator = {
            poll_interval = 300;
            restrict_eval = false;
            allow_ifd = false;
            memory_limit_mb = 3072;
            eval_workers = 4;
            max_concurrent_evals = 2;
            systems = ["aarch64-linux" "x86_64-linux"];
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
      caddy.extraConfig = ''
        http://circus.ts.econnah.uk {
          reverse_proxy 127.0.0.1:3001
        }
      '';
    };

    system.nixos-core.persistence.stores."/persistent".directories = [
      {
        group = "circus";
        owner = "circus";
        target = "/var/lib/circus";
      }
      {
        group = "postgres";
        owner = "postgres";
        target = "/var/lib/postgresql";
      }
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
      "other/circus/runner-key" = {
        group = "circus";
        owner = "circus";
        recipients = ["phoenix" "yubikey"];
      };
      # this ⌄ is just so I can store it
      "other/circus/ca-key" = {
        recipients = ["phoenix" "yubikey"];
      };
      "nix-cache-key" = {
        group = "circus";
        owner = "circus";
      };
    };

    systemd.services = {
      circus-server = {
        serviceConfig.LimitNOFILE = 65536;
      };
      circus-queue-runner = {
        serviceConfig.LimitNOFILE = 65536;
      };
    };

    users.groups.rafware.members = [
      "circus"
      "circus-evaluator"
      "circus-queue-runner"
      "circus-server"
    ];
  };
}
