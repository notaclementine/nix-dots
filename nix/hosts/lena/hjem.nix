{self, ...}: {
  flake.nixosModules.lena-hjem = {pkgs, ...}: {
    hjem.users.clementine = {
      imports = with self.hjemNixosModules; [
        lena-hyprland
        modprobed-db
      ];
      packages = with pkgs; [
        (chromium.override {enableWideVine = true;})
        moonlight-qt
        plezy
      ];
      theme.wallpaper = "frieren-01.png";
    };
  };
}
