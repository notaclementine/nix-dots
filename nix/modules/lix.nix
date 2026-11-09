{
  inputs,
  self,
  ...
}: {
  flake = {
    commonModules.lix = {
      nix.settings.experimental-features = [
        "pipe-operator"
      ];
    };
    darwinModules.lix.imports = [
      inputs.lix.darwinModules.default
      self.commonModules.lix
    ];
    nixosModules.lix.imports = [
      inputs.lix.nixosModules.default
      self.commonModules.lix
    ];
  };
}
