{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.the86 = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
      clementine-headless
      headless
      mesa
      the86-config
      wireless
    ];
    system = "x86_64-linux";
  };
}
