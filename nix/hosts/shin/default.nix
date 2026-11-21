{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.shin = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      circus-agent
      clementine-graphical
      graphical
      hyprland
      limine
      lix
      nvidia
      preservation
      shin-config
      shin-disko
      shin-hardware
      shin-hjem
    ];
  };
}
