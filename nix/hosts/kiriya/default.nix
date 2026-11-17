{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.kiriya = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      inputs.wsl.nixosModules.default
      clementine-headless
      headless
      kiriya-config
      kiriya-hjem
      lix
      mesa
    ];
  };
}
