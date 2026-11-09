{self, ...}: {
  flake.hjemNixosModules.leo = {pkgs, ...}: {
    imports = with self.hjemNixosModules; [
      graphical
      oledppuccin
      vicinae
    ];
    environment.sessionVariables.EDITOR = "nvim";
    packages = with pkgs; [
      (chromium.override {enableWideVine = true;})
      eduvpn-client
      jetbrains.idea
      jetbrains.rider
      libreoffice
      obsidian
      prismlauncher
      signal-desktop
      spotifyd
      vesktop
      vscode
    ];
  };
}
