{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.lena = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      asahi
      clementine-graphical
      hyprland
      lena-config
      lena-hardware
      lena-hjem
      limine
      lix
      preservation
      self.secretModules.clementine-eduroam
    ];
  };
}
