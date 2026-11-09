{
  flake.nvfModules.workflow = {
    vim = {
      navigation.harpoon.enable = true;
      terminal = {
        toggleterm = {
          enable = true;
          lazygit.enable = true;
          setupOpts.direction = "float";
        };
      };
      utility = {
        oil-nvim.enable = true;
        surround.enable = true;
      };
    };
  };
}
