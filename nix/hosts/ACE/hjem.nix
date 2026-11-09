{self, ...}: {
  flake.nixosModules.ACE-hjem = {pkgs, ...}: {
    hjem.users = {
      kyla = {
        imports = with self.hjemNixosModules; [
          ACE-hyprland
        ];
        packages = with pkgs; [
          mixxx
          plezy
          spotify
        ];
        theme.wallpaper = "point_break-01.png";
      };
    };
  };
}
