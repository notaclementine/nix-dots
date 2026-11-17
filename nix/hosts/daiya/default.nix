{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.daiya = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      circus-agent
      clementine-headless
      daiya-config
      daiya-hardware
      headless
      limine
    ];
  };
}
