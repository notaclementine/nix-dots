{
  inputs,
  self,
  ...
}: {
  flake.darwinConfigurations.anapple = inputs.darwin.lib.darwinSystem {
    modules = with self.darwinModules; [
      anapple-config
      clementine-graphical
      graphical
      lix
    ];
  };
}
