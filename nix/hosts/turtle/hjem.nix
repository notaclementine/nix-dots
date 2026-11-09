{self, ...}: {
  flake.nixosModules.turtle-hjem = {pkgs, ...}: {
    hjem.users = {
      aude = {
        imports = with self.hjemNixosModules; [
          turtle-hyprland
        ];
        packages = with pkgs; [
          plezy
          spotify
        ];
        theme.wallpaper = "your_name-01.png";
      };
      ewan = {
        imports = with self.hjemNixosModules; [
          turtle-hyprland
        ];
        packages = with pkgs; [
          plezy
          spotify
        ];
        theme.wallpapers = {
          "DP-1" = "jjk-02.png";
          "HDMI-A-1" = "jjk-03.png";
        };
      };
      kyla = {
        imports = with self.hjemNixosModules; [
          turtle-hyprland
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
