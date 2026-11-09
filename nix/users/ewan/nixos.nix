{self, ...}: {
  flake.nixosModules.ewan = {pkgs, ...}: {
    imports = with self.nixosModules; [
      ewan-preservation
      oledppuccin
      self.secretModules.ewan
    ];
    hjem = {
      users.ewan = {
        imports = with self.hjemModules; [ewan];
        enable = true;
        directory = "/home/ewan";
        user = "ewan";
      };
    };
    programs.ydotool.enable = true;
    users = {
      groups.ewan = {
        gid = 2000;
      };
      users.ewan = {
        description = "Ewan Alecks";
        extraGroups = [
          "dialout"
          "la-famille"
          "uucp"
          "wheel"
          "ydotool"
        ];
        group = "ewan";
        isNormalUser = true;
        linger = true;
        shell = pkgs.fish;
        uid = 2000;
      };
    };
  };
}
