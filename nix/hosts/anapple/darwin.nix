{self, ...}: {
  flake.darwinModules.anapple-config = {
    system.configurationRevision = self.rev or self.dirtyRev or null;
    system.stateVersion = 6;
    nixpkgs.hostPlatform = "aarch64-darwin";
  };
}
