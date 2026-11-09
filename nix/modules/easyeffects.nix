{
  flake.hjemModules.easyeffects = {pkgs, ...}: {
    packages = [pkgs.easyeffects];
    systemd.services.easyeffects = {
      enable = true;
      after = ["graphical-session.target"];
      description = "EasyEffects daemon";
      partOf = ["graphical-session.target"];
      serviceConfig = {
        ExecStart = "${pkgs.easyeffects}/bin/easyeffects --hide-window --service-mode";
        ExecStop = "${pkgs.easyeffects}/bin/easyeffects --quit";
        KillMode = "mixed";
        Restart = "on-failure";
        RestartSec = 5;
        TimeoutStopSec = 10;
      };
      wantedBy = ["graphical-session.target"];
    };
  };
}
