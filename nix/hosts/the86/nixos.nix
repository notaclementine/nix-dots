{
  flake.nixosModules.the86-config = {
    config,
    lib,
    ...
  }: {
    isoImage.squashfsCompression = "gzip -Xcompression-level 1";
    networking.hostName = "nixos-iso";
    system.nixos-core.persistence.enable = lib.mkForce false;
    security = {
      nix-secrets.enable = lib.mkForce false;
      sudo.wheelNeedsPassword = false;
    };
    services = {
      flatpak.enable = lib.mkForce false;
      openssh = {
        openFirewall = lib.mkForce true;
        settings.PermitRootLogin = lib.mkForce "yes";
      };
    };
    users = {
      mutableUsers = lib.mkForce true;
      users = {
        clementine.password = "nixos";
        root = {
          initialHashedPassword = lib.mkForce null;
          openssh.authorizedKeys.keys = config.users.users.clementine.openssh.authorizedKeys.keys;
          password = "nixos";
        };
      };
    };
  };
}
