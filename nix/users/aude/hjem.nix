{self, ...}: {
  flake.hjemModules.aude = {pkgs, ...}: {
    imports = with self.hjemModules; [
      graphical
      oledppuccin
      vicinae
    ];
    environment.sessionVariables.EDITOR = "nvim";
    packages = with pkgs; [
      libreoffice
      prismlauncher
      signal-desktop
      vesktop
    ];
    rum.programs.git = {
      settings = {
        core = {
          editor = "nvim";
        };
        diff = {
          tool = "vimdiff";
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
          name = "Aude Alecks";
        };
      };
    };
    xdg.config.files = {
      "jj/config.toml" = {
        generator = (pkgs.formats.toml {}).generate "config.toml";
        value = {
          alias = {
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

          template-aliases = {
            "format_short_signature(signature)" = ''
              coalesce(signature.name(), name_placeholder)
            '';
          };
          ui = {
            default-command = "log";
            diff-editor = ":builtin";
            diff-formatter = [
              "kitten"
              "diff"
              "$left"
              "$right"
            ];
            editor = "nvim";
            merge-editor = ":builtin";
          };
          user = {
            name = "Aude Alecks";
          };
        };
      };
    };
  };
}
