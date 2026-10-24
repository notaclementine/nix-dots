{self, ...}: {
  flake.nixosModules.kyla = {pkgs, ...}: {
    imports = with self.nixosModules; [
      kyla-preservation
      oledppuccin
      self.secretModules.kyla
    ];
    hjem = {
      users.kyla = {
        imports = with self.hjemModules; [kyla];
        enable = true;
        directory = "/home/kyla";
        user = "kyla";
      };
    };
    users = {
      groups.kyla = {
        gid = 2001;
      };

      users.kyla = {
        description = "Kyla Alecks";
        extraGroups = [
          "dialout"
          "la-famille"
          "uucp"
          "wheel"
        ];
        group = "kyla";
        isNormalUser = true;
        linger = true;
        shell = pkgs.fish;
        uid = 2001;
      };
    };
  };
}
