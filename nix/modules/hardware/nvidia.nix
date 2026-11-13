{self, ...}: {
  flake.nixosModules.nvidia = {
    imports = [self.nixosModules.mesa];
    hardware.nvidia = {
      branch = "bleeding_edge";
      modesetting.enable = true;
      open = true;
    };
    nixpkgs.config.cudaSupport = true;
    services.xserver.videoDrivers = ["nvidia"];
  };
}
