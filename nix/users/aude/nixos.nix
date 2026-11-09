{self, ...}: {
  flake.nixosModules.aude = {pkgs, ...}: {
    imports = with self.nixosModules; [
      aude-preservation
      oledppuccin
      self.secretModules.aude
    ];
    hjem = {
      users.aude = {
        imports = with self.hjemModules; [aude];
        enable = true;
        directory = "/home/aude";
        user = "aude";
      };
    };
    users = {
      groups.aude = {
        gid = 1220;
      };

      users.aude = {
        description = "Aude Alecks";
        extraGroups = [
          "dialout"
          "la-famille"
          "uucp"
          "wheel"
        ];
        group = "aude";
        isNormalUser = true;
        linger = true;
        shell = pkgs.fish;
        uid = 1220;
      };
    };
  };
}
