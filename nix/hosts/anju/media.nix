{
  flake.nixosModules.anju-media = {
    lib,
    pkgs,
    ...
  }: {
    users = {
      groups.media.gid = 500;
      users = {
        jellyfin = {
          uid = 501;
          extraGroups = ["video" "render"];
        };
        qbittorrent.uid = 502;
      };
    };

    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        vpl-gpu-rt
        intel-compute-runtime
      ];
    };

    services = {
      jellyfin = {
        enable = true;
        group = "media";
        openFirewall = true;
      };
      qbittorrent = {
        enable = true;
        group = "media";
      };
      radarr = {
        enable = true;
        group = "media";
      };
      sonarr = {
        enable = true;
        group = "media";
      };
    };

    systemd = {
      services = {
        jellyfin.serviceConfig.UMask = lib.mkForce "0002";
        qbittorrent.serviceConfig.UMask = lib.mkForce "0002";
        radarr.serviceConfig.UMask = lib.mkForce "0002";
        sonarr.serviceConfig.UMask = lib.mkForce "0002";
      };
    };

    system.nixos-core.persistence.stores."/persistent".directories = [
      {
        target = "/var/lib/jellyfin";
        owner = "jellyfin";
        group = "media";
      }
      {
        target = "/var/lib/qbittorrent";
        owner = "qbittorrent";
        group = "media";
      }
      {
        target = "/var/lib/radarr";
        owner = "radarr";
        group = "media";
      }
      {
        target = "/var/lib/sonarr";
        owner = "sonarr";
        group = "media";
      }
    ];
  };
}
