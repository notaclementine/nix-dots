{
  flake.hjemModules.vicinae = {
    lib,
    osConfig,
    pkgs,
    ...
  }: {
    packages = with pkgs; [vicinae];
    systemd.services.vicinae = {
      enable = true;
      after = ["graphical-session.target"];
      description = "Vicinae server daemon";
      partOf = ["graphical-session.target"];
      serviceConfig = {
        Environment = "USE_LAYER_SHELL=1 PATH=/run/wrappers/bin:/run/current-system/sw/bin:/etc/profiles/per-user/%u/bin";
        ExecStart = "${lib.getExe' pkgs.vicinae "vicinae"} server";
        Restart = "always";
        RestartSec = 5;
        Type = "simple";
      };
      unitConfig = {
        X-Restart-Triggers = ["${pkgs.vicinae}/bin/vicinae"];
      };
      wantedBy = ["graphical-session.target"];
    };
    xdg.state.files."vicinae/onboarding.json".text = ''
      {"version":1,"completedAt":"2026-01-01T00:00:00Z"}
    '';
  };
}
