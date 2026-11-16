{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.onyx = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      circus-agent
      clementine-graphical
      graphical
      hyprland
      limine
      lix
      nvidia
      onyx-config
      onyx-disko
      onyx-hardware
      onyx-hjem
      preservation
    ];
  };
}
