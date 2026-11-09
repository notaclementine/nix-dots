{self, ...}: {
  flake.nixosModules = {
    clementine-graphical = {pkgs, ...}: {
      imports = with self; [
        commonModules.clementine-graphical
        nixosModules.clementine-headless
        secretModules.clementine-graphical
      ];
      hjem.users.clementine.imports = [self.hjemNixosModules.clementine-graphical];
      services = {
        pcscd.enable = true;
        udev.packages = with pkgs; [
          yubikey-personalization
        ];
      };
    };
    clementine-headless = {
      imports = with self; [
        commonModules.clementine-headless
        nixosModules.clementine-preservation
        nixosModules.oledppuccin
        secretModules.clementine-headless
      ];
      hjem.users.clementine = {
        imports = [self.hjemNixosModules.clementine-headless];
        directory = "/home/clementine";
      };
      users = {
        groups.clementine = {
          gid = 2026;
        };

        users.clementine = {
          extraGroups = [
            "dialout"
            "input"
            "la-famille"
            "uucp"
            "wheel"
          ];
          group = "clementine";
          isNormalUser = true;
          linger = true;
          uid = 2026;
        };
      };
    };
  };
}
