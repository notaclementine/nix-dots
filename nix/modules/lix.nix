{inputs, ...}: {
  flake.nixosModules.lix = {
    imports = [inputs.lix.nixosModules.default];
    nix.settings.experimental-features = [
      "pipe-operator"
    ];
  };
}
