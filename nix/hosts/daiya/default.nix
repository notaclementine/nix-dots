{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.daiya = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      inputs.brewery.nixosModules.default
      clementine-headless
      daiya-brewery
      daiya-circus
      daiya-config
      daiya-hardware
      headless
      limine
    ];
  };
}
