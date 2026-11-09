{self, ...}: {
  flake.nixosModules.murtle-hjem = {pkgs, ...}: {
    hjem.users = {
      ewan = {
        imports = with self.hjemNixosModules; [
          murtle-hyprland
        ];
        packages = with pkgs; [
          plezy
        ];
        theme.wallpaper = "frieren-03.png";
      };
    };
  };
}
