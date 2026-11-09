{self, ...}: {
  flake.nixosModules.cookie-hjem = {pkgs, ...}: {
    hjem.users = {
      aude = {
        imports = with self.hjemNixosModules; [
          cookie-hyprland
        ];
        packages = with pkgs; [
          plezy
          spotify
        ];
        theme.wallpaper = "your_name-01.png";
      };
      kyla = {
        imports = with self.hjemNixosModules; [
          cookie-hyprland
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
