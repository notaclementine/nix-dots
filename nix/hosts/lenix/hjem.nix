{self, ...}: {
  flake.nixosModules.lenix-hjem = {pkgs, ...}: {
    hjem.users.clementine = {
      imports = with self.hjemNixosModules; [
        lenix-hyprland
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
