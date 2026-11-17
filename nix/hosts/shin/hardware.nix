{
  flake.nixosModules.shin-hardware = {
    lib,
    modulesPath,
    ...
  }: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];
    environment.etc."machine-id".text = "31f55b32c18b4599ae98e2c4a54a1110\n";
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  };
}
