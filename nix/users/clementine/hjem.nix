{self, ...}: {
  flake.hjemCommonModules = {
    clementine-graphical = {pkgs, ...}: {
      packages = with pkgs; [
        halloy
        librespot
        obsidian
        prismlauncher
        signal-desktop
        vesktop
      ];
    };
    clementine-headless = {pkgs, ...}: {
      environment.sessionVariables.EDITOR = "nvim";
      files = {
        ".ssh/config" = {
          permissions = "0600";
          source = "${self}/not-nix/clementine/ssh/config";
          type = "copy";
        };
        ".ssh/id_ed25519_sk_rk.pub" = {
          permissions = "0644";
          source = "${self}/not-nix/clementine/ssh/id_ed25519_sk_rk.pub";
          type = "copy";
        };
      };
      rum.programs.git = {
        settings = {
          commit = {
            gpgSign = true;
          };
          core = {
            editor = "nvim";
          };
          diff = {
            tool = "vimdiff";
          };
          gpg = {
            format = "ssh";
          };
          init = {
            defaultBranch = "main";
          };
          pull = {
            ff = "only";
          };
          push = {
            autoSetupRemote = true;
          };
          user = {
            email = "git@econnah.uk";
            name = "Clémentine";
            signingkey = "~/.ssh/id_ed25519_sk_rk.pub";
          };
        };
      };
      xdg.config.files = {
        "jj/config.toml" = {
          generator = (pkgs.formats.toml {}).generate "config.toml";
          value = {
            aliases = {
              pull-pr = {
                definition = [
                  "util"
                  "exec"
                  "--"
                  "bash"
                  "-c"
                  "set -euo pipefail; git fetch $0 pull/$1/head:$2"
                ];
                doc = "A convenient alias to pull a pr $1 from remote $0 into branch $2";
              };
            };
            signing = {
              backend = "ssh";
              key = "~/.ssh/id_ed25519_sk_rk.pub";
              sign-all = false;
            };
            template-aliases = {
              "format_short_signature(signature)" = ''
                coalesce(signature.name(), name_placeholder)
              '';
            };
            ui = {
              default-command = "log";
              diff-editor = ":builtin";
              editor = "nvim";
              merge-editor = ":builtin";
            };
            merge-tools = {
              kitty-diff = {
                program = "kitten";
                diff-args = [
                  "diff"
                  "$left"
                  "$right"
                ];
              };
            };
            revsets = {
              git-sign-on-push = "~signed() & mine()";
            };
            user = {
              email = "git@econnah.uk";
              name = "Clémentine";
            };
          };
        };
      };
    };
  };

  flake.hjemDarwinModules = {
    clementine-graphical.imports = with self; [
      hjemCommonModules.clementine-graphical
      hjemDarwinModules.graphical
      hjemDarwinModules.vicinae
    ];
    clementine-headless.imports = with self; [
      hjemCommonModules.clementine-headless
      hjemDarwinModules.headless
      hjemDarwinModules.oledppuccin
    ];
  };

  flake.hjemNixosModules = {
    clementine-graphical = {
      osConfig,
      pkgs,
      ...
    }: {
      imports = with self; [
        hjemCommonModules.clementine-graphical
        hjemNixosModules.graphical
        hjemNixosModules.vicinae
      ];
      packages = with pkgs; [
        (lazyspotify.override {withOo7 = true;})
        libreoffice
        osu-lazer
      ];
      xdg.config.files = {
        "halloy/config.toml" = {
          generator = (pkgs.formats.toml {}).generate "config.toml";
          value = {
            servers = {
              asahi = {
                channels = [
                  "#asahi"
                  "#asahi-dev"
                  "#asahi-alt"
                ];
                nickname = "eConnah";
                server = "irc.oftc.net";
              };
              nixos = {
                channels = ["#nixos"];
                nickname = "eConnah";
                sasl.plain = {
                  password_file = osConfig.security.nix-secrets.secrets."clementine/halloy".path;
                  username = "eConnah";
                };
                server = "irc.libera.chat";
              };
            };
          };
        };
        "lazyspotify/config.yml".text = ''
          auth:
            client_id: a05e9b38cd3e420a87ca1d09b26b7179
        '';
        "vesktop/settings/settings.json".source = "${self}/not-nix/clementine/vesktop/settings.json";
      };
    };
    clementine-headless.imports = with self; [
      hjemCommonModules.clementine-headless
      hjemNixosModules.headless
      hjemNixosModules.oledppuccin
    ];
  };
}
