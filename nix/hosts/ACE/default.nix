{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.ACE = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      ACE-config
      ACE-hardware
      ACE-hjem
      hyprland
      kyla
      laptops
      limine
      lix
      mesa
    ];
  };
}
