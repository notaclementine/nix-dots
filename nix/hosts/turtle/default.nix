{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.turtle = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      aude
      ewan
      graphical
      hyprland
      kyla
      limine
      lix
      nvidia
      turtle-config
      turtle-hardware
      turtle-hjem
    ];
  };
}
