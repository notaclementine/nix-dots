{
  inputs,
  self,
  ...
}: {
  perSystem = {
    pkgs,
    system,
    ...
  }: {
    _module.args = {
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    };
    packages = {
      nvim-qwerty =
        (inputs.nvf.lib.neovimConfiguration {
          inherit pkgs;
          modules = with self.nvfModules; [
            defaults
            notes
            ui
            workflow
          ];
        }).neovim;
    };
  };
}
