{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.phoenix = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      inputs.brewery.nixosModules.default
      clementine-headless
      headless
      limine
      phoenix-brewery
      phoenix-circus
      phoenix-config
      phoenix-hardware
    ];
  };
}
