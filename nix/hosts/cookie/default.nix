{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.cookie = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      aude
      cookie-config
      cookie-hardware
      cookie-hjem
      hyprland
      kyla
      laptops
      limine
      lix
      mesa
    ];
  };
}
