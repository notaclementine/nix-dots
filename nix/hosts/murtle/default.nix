{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.murtle = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      ewan
      graphical
      hyprland
      limine
      lix
      mesa
      murtle-config
      murtle-hardware
      murtle-hjem
    ];
  };
}
