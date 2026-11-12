{self, ...}: {
  flake.nixosModules.limine = {
    imports = [self.nixosModules.bootloader];
    boot.loader.limine = {
      enable = true;
      style.wallpapers = [];
    };
  };
}
