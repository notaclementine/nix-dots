{self, ...}: {
  flake.nixosModules.leo = {pkgs, ...}: {
    imports = with self.nixosModules; [
      oledppuccin
    ];
    hjem = {
      users.leo = {
        imports = [self.hjemNixosModules.leo];
        enable = true;
        directory = "/home/leo";
        user = "leo";
      };
    };
    users = {
      groups.leo = {
        gid = 2006;
      };

      users.leo = {
        description = "Leo Chittock";
        extraGroups = [
          "wheel"
          "dialout"
          "uucp"
        ];
        group = "leo";
        isNormalUser = true;
        linger = true;
        shell = pkgs.fish;
        uid = 2006;
      };
    };
  };
}
