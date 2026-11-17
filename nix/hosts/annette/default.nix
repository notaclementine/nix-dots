{
  inputs,
  self,
  ...
}: {
  flake.darwinConfigurations.annette = inputs.darwin.lib.darwinSystem {
    modules = with self.darwinModules; [
      annette-config
      clementine-graphical
      graphical
      lix
    ];
  };
}
