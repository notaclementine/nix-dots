{self, ...}: {
  flake.darwinModules.graphical = {pkgs, ...}: {
    imports = with self; [
      commonModules.graphical
      darwinModules.headless
    ];
    environment.systemPackages = [pkgs.firefox];
  };
}
