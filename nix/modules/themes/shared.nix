{self, ...}: {
  flake.hjemCommonModules.themes-shared = {remoteAssets, ...}: {
    xdg.config.files."fastfetch/config.jsonc" = {
      generator = builtins.toJSON;
      value = {
        "$schema" = "https://raw.githubusercontent.com/fastfetch-cli/fastfetch/dev/doc/json_schema.json";
        display = {
          separator = " : ";
        };
        logo = {
          height = 14;
          padding = {
            right = 1;
            top = 1;
          };
          position = "left";
          source = "${remoteAssets.other."thirsty.png"}";
          type = "kitty-direct";
          width = 31;
        };
        modules = [
          "break"
          {
            key = "  ";
            keyColor = "cyan";
            text = "splash=$(hyprctl splash);echo $splash";
            type = "command";
          }
          {
            format = "┌───────────────────────────────┐";
            type = "custom";
          }
          {
            format = "{2}";
            key = "   OS";
            keyColor = "blue";
            type = "os";
          }
          {
            format = "{2}";
            key = "   Kernel";
            keyColor = "magenta";
            type = "kernel";
          }
          {
            key = "   Arch";
            keyColor = "magenta";
            text = "arch=$(uname -m);page=$(getconf PAGESIZE);echo $arch - $page KiB";
            type = "command";
          }
          {
            format = "{2}";
            key = "   WM";
            keyColor = "cyan";
            type = "wm";
          }
          {
            format = "└───────────────────────────────┘";
            type = "custom";
          }
          "break"
          {
            format = "{7}{8}/{6}";
            key = "  󱄅 Nix";
            keyColor = "blue";
            type = "title";
          }
          {
            format = "┌───────────────────────────────┐";
            type = "custom";
          }
          {
            key = "  󰆙 Generation";
            keyColor = "blue";
            text = "gen=$(readlink /nix/var/nix/profiles/system);gen=$(grep -o '[0-9]*' <<< $gen);echo $gen";
            type = "command";
          }
          {
            key = "   Closure Size";
            keyColor = "blue";
            text = "size=$(nix path-info -Sh /run/current-system | awk '{print $2}');echo $size";
            type = "command";
          }
          {
            key = "  󱫐 Uptime ";
            keyColor = "green";
            type = "uptime";
          }
          {
            format = "└───────────────────────────────┘";
            type = "custom";
          }
          "break"
        ];
      };
    };
  };

  flake.hjemDarwinModules.themes-shared.imports = [self.hjemCommonModules.themes-shared];
  flake.hjemNixosModules.themes-shared.imports = [self.hjemCommonModules.themes-shared];
}
