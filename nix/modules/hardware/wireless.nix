{
  flake.nixosModules.wireless = {
    networking.wireless = {
      enable = false;
      iwd = {
        enable = true;
        settings = {
          General.AddressRandomization = "none";
          Network.EnableIPv6 = true;
          Settings.AutoConnect = true;
        };
      };
    };
    systemd.network = {
      networks."20-wireless" = {
        matchConfig.Type = "wlan";
        networkConfig = {
          DHCP = "ipv4";
          IPv6AcceptRA = true;
        };
        dhcpV4Config.ClientIdentifier = "mac";
        linkConfig.RequiredForOnline = "routable";
      };
      wait-online.anyInterface = true;
    };
    system.nixos-core.persistence.stores."/persistent".directories = [
      "/var/lib/iwd"
    ];
  };
}
