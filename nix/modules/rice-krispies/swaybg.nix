{
  flake.hjemModules.swaybg = {
    config,
    lib,
    pkgs,
    remoteAssets,
    ...
  }: let
    cfg = config.theme;
    multiWallpaperArgs = lib.concatStringsSep " " (
      lib.mapAttrsToList (output: file: "-o ${output} -i ${remoteAssets.wallpapers.${file}} -m fill") cfg.wallpapers
    );
  in {
    options.theme = {
      wallpaper = lib.mkOption {
        default = null;
        description = "Picture to apply to all monitors.";
        type = lib.types.nullOr lib.types.str;
      };

      wallpapers = lib.mkOption {
        default = {};
        type = lib.types.attrsOf lib.types.str;
        example = {
          "eDP-1" = "frieren-01.png";
          "DP-1" = "jjk-01.png";
        };
        description = "Wallpapers per monitor.";
      };
    };

    config = lib.mkIf (cfg.wallpaper != null || cfg.wallpapers != {}) {
      packages = [pkgs.swaybg];
      systemd.services.swaybg = {
        enable = true;
        after = ["graphical-session.target"];
        description = "Wayland wallpaper daemon";
        partOf = ["graphical-session.target"];
        serviceConfig = {
          ExecStart =
            if cfg.wallpaper != null
            then "${pkgs.swaybg}/bin/swaybg -i ${remoteAssets.wallpapers.${cfg.wallpaper}} -m fill"
            else "${pkgs.swaybg}/bin/swaybg ${multiWallpaperArgs}";
          Restart = "always";
        };
        wantedBy = ["graphical-session.target"];
      };
    };
  };
}
