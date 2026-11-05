{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.phoenix = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      clementine-headless
      headless
      limine
      phoenix-circus
      phoenix-config
      phoenix-hardware
    ];
  };
}
