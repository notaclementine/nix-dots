{self, ...}: {
  flake.darwinModules = {
    clementine-graphical = {
      imports = with self; [
        commonModules.clementine-graphical
        darwinModules.clementine-headless
      ];
      hjem.users.clementine.imports = [self.hjemDarwinModules.clementine-graphical];
    };
    clementine-headless = {
      imports = [self.commonModules.clementine-headless];
      hjem.users.clementine = {
        imports = [self.hjemDarwinModules.clementine-headless];
        directory = "/Users/clementine";
      };
      system.primaryUser = "clementine";
      users.users.clementine.home = "/Users/clementine";
    };
  };
}
