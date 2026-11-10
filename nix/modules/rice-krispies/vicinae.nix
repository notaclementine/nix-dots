{
  moduleWithSystem,
  self,
  ...
}: {
  flake = {
    hjemCommonModules.vicinae = moduleWithSystem ({inputs', ...}: {
      packages = [inputs'.vicinae.packages.default];
    });
    hjemDarwinModules.vicinae = moduleWithSystem ({inputs', ...}: {
      config,
      lib,
      ...
    }: {
      imports = [self.hjemCommonModules.vicinae];
      files."Library/LaunchAgents/vicinae.server.plist" = {
        type = "copy";
        permissions = "0644";
        generator = lib.generators.toPlist {escape = true;};
        value = {
          EnvironmentVariables.PATH = "/etc/profiles/per-user/${config.user}/bin:/run/current-system/sw/bin:/usr/bin:/bin:/usr/sbin:/sbin";
          KeepAlive = true;
          Label = "vicinae.server";
          ProgramArguments = [
            (lib.getExe' inputs'.vicinae.packages.default "vicinae")
            "server"
          ];
          RunAtLoad = true;
        };
      };
    });
    hjemNixosModules.vicinae = moduleWithSystem ({inputs', ...}: {lib, ...}: let
      vicinae = inputs'.vicinae.packages.default;
    in {
      imports = [self.hjemCommonModules.vicinae];
      systemd.services.vicinae = {
        enable = true;
        after = ["graphical-session.target"];
        description = "Vicinae server daemon";
        partOf = ["graphical-session.target"];
        serviceConfig = {
          Environment = "USE_LAYER_SHELL=1 PATH=/run/wrappers/bin:/run/current-system/sw/bin:/etc/profiles/per-user/%u/bin";
          ExecStart = "${lib.getExe' vicinae "vicinae"} server";
          Restart = "always";
          RestartSec = 5;
          Type = "simple";
        };
        unitConfig = {
          X-Restart-Triggers = ["${vicinae}/bin/vicinae"];
        };
        wantedBy = ["graphical-session.target"];
      };
      xdg.state.files."vicinae/onboarding.json".text = ''
        {"version":1,"completedAt":"2026-01-01T00:00:00Z"}
      '';
    });
  };
}
