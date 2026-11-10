{
  flake.nixosModules.wireless = {
    networking.wireless = {
      enable = false;
      iwd = {
        enable = true;
        settings = {
          General = {
            AddressRandomization = "none";
            EnableNetworkConfiguration = true;
          };
          Network = {
            EnableIPv6 = true;
            NameResolvingService = "systemd";
          };
          Settings.AutoConnect = true;
        };
      };
    };

    systemd.network = {
      networks."20-wireless" = {
        matchConfig.Type = "wlan";
        networkConfig = {
          DHCP = "no";
          IPv6AcceptRA = false;
          KeepConfiguration = "yes";
        };
        linkConfig.RequiredForOnline = "routable";
      };
      wait-online.anyInterface = true;
    };

    system.nixos-core.persistence.stores."/persistent".directories = [
      "/var/lib/iwd"
    ];
  };
}
