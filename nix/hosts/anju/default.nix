{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.anju = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      #anju-brewery
      #anju-circus
      anju-config
      anju-disko
      anju-hardware
      anju-media
      clementine-headless
      headless
      limine
    ];
  };
}
