{self, ...}: {
  flake.nixosModules = {
    clementine-graphical = {pkgs, ...}: {
      imports = [
        self.nixosModules.clementine-headless
        self.secretModules.clementine-graphical
      ];
      environment.systemPackages = with pkgs; [
        yubikey-manager
      ];
      hjem.users.clementine.imports = [self.hjemModules.clementine-graphical];
      services = {
        pcscd.enable = true;
        udev.packages = with pkgs; [
          yubikey-personalization
        ];
      };
    };
    clementine-headless = {pkgs, ...}: {
      imports = [
        self.nixosModules.clementine-preservation
        self.nixosModules.oledppuccin
        self.secretModules.clementine-headless
      ];
      hjem = {
        users.clementine = {
          imports = [self.hjemModules.clementine-headless];
          enable = true;
          directory = "/home/clementine";
          user = "clementine";
        };
      };
      users = {
        groups.clementine = {
          gid = 2026;
        };

        users.clementine = {
          description = "Clémentine Alecks";
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
          openssh.authorizedKeys.keys = [
            "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIILd7radoI+ZnYz/NKDVLBDH8zFdq6r2I/gP0HuZGs0gAAAABHNzaDo= ssh:"
          ];
          shell = pkgs.fish;
          uid = 2026;
        };
      };
    };
  };
}
