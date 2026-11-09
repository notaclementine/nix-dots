{
  flake.nixosModules.mesa = {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
