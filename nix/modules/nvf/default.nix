{
  flake.nvfModules.defaults = {
    pkgs,
    lib,
    ...
  }: {
    vim = {
      options = {
        expandtab = true;
        shiftwidth = 4;
        tabstop = 4;
      };
      autocomplete.blink-cmp = {
        enable = true;
        friendly-snippets.enable = true;
        setupOpts = {
          snippets = {
            expand = lib.generators.mkLuaInline ''
              function(snippet)
                require('luasnip').lsp_expand(snippet)
              end
            '';
          };
        };
      };
      binds.whichKey.enable = true;
      clipboard.providers.wl-copy.enable = true;
      extraPlugins = {
        kitty-scrollback = {
          package = pkgs.vimPlugins.kitty-scrollback-nvim;
          setup = ''
            require('kitty-scrollback').setup({
            })
          '';
        };
        smear-cursor = {
          package = pkgs.vimPlugins.smear-cursor-nvim;

          setup =
            /*
            lua
            */
            ''
              require("smear_cursor").setup({
                  legacy_computing_symbols_support = true,
                  scroll_buffer_space = true,
                  smear_between_buffers = true,
                  smear_between_neighbor_lines = true,
                  smear_insert_mode = true,
                  stiffness = 0.8,
                  trailing_stiffness = 0.6,
                  stiffness_insert_mode = 0.7,
                  trailing_stiffness_insert_mode = 0.7,
                  damping = 0.95,
                  damping_insert_mode = 0.95,
                  distance_stop_animating = 0.5,
                  time_interval = 7,
              })
            '';
        };
      };
      filetree.neo-tree.enable = true;
      git = {
        enable = true;
        gitsigns.enable = true;
      };
      languages = {
        bash.enable = true;
        csharp = {
          enable = true;
          lsp.servers = ["roslyn-ls"];
          extensions.roslyn-nvim = {
            enable = true;
            setupOpts = {
              filewatching = "off";
            };
          };
        };
        enableExtraDiagnostics = true;
        enableFormat = true;
        enableTreesitter = true;
        fish.enable = true;
        java.enable = true;
        json = {
          enable = true;
          format.type = ["biome"];
        };
        lua.enable = true;
        markdown.enable = true;
        nix = {
          enable = true;
          format.type = ["alejandra" "injected"];
        };
        python.enable = true;
        rust.enable = true;
        xml.enable = true;
      };
      lsp = {
        enable = true;
        formatOnSave = true;
        lightbulb.enable = true;
        trouble.enable = true;
      };
      preventJunkFiles = true;
      searchCase = "smart";
      snippets.luasnip.enable = true;
      statusline.lualine.enable = true;
      tabline.nvimBufferline.enable = true;
      telescope.enable = true;
      theme = {
        enable = true;
        name = "catppuccin";
        style = "mocha";
        transparent = true;
      };
      treesitter = {
        enable = true;
        context.enable = true;
      };
      undoFile.enable = true;
      viAlias = true;
      vimAlias = true;
    };
  };
}
