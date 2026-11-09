{self, ...}: {
  flake.nixosModules.evilix-hjem = {lib, ...}: {
    hjem.users.clementine = {
      imports = with self.hjemNixosModules; [
        oledppuccin
        remote-assets
      ];
      rum.programs = {
        git = {
          settings = lib.mkForce {};
          ignore = ''
            NuGet.config
          '';
        };
      };
      xdg.config.files = {
        "jj/config.toml".enable = false;
      };
    };
  };
}
