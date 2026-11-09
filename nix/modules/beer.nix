{moduleWithSystem, ...}: {
  flake.hjemNixosModules.beer = moduleWithSystem ({inputs'}: {lib, ...}: let
    beer = inputs'.beer.packages.default;
  in {
    packages = [beer];
    systemd.services.beer = {
      description = "Beer resident daemon";
      after = ["graphical-session.target"];
      partOf = ["graphical-session.target"];
      wantedBy = ["graphical-session.target"];
      serviceConfig = {
        ExecStart = "${lib.getExe beer} --server";
        KillMode = "mixed";
        Restart = "on-failure";
        RestartSec = 5;
        TimeoutStopSec = 10;
      };
    };
  });
}
