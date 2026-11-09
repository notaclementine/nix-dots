{self, ...}: {
  flake.nixosModules.nvidia = {
    imports = [self.nixosModules.mesa];
    hardware.nvidia = {
      modesetting.enable = true;
      open = true;
    };
    nixpkgs.config.cudaSupport = true;
    services.xserver.videoDrivers = ["nvidia"];
  };
}
