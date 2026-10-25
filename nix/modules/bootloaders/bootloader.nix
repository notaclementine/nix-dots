{
  flake.nixosModules.bootloader = {lib, ...}: {
    boot.loader.efi.canTouchEfiVariables = lib.mkDefault true;
  };
}
