{
  inputs,
  self,
  ...
}: {
  flake.darwinModules.headless = {
    imports = [
      inputs.cade.darwinModules.default
      inputs.hjem.darwinModules.default
      self.commonModules.headless
      self.darwinModules.substituters
    ];
    environment.variables.MANPAGER = "nvim -n --cmd 'set laststatus=0 nonumber noruler noshowcmd' +Man!";
    nix.settings.trusted-users = ["@admin"];
  };
}
