{self, ...}: {
  flake.hjemCommonModules.graphical = {pkgs, ...}: {
    rum.programs = {
      kitty = {
        settings = {
          action_alias = "kitty_scrollback_nvim kitten ${pkgs.vimPlugins.kitty-scrollback-nvim}/python/kitty_scrollback_nvim.py";
          allow_remote_control = "socket-only";
          listen_on = "unix:/tmp/kitty";
          map = [
            "kitty_mod+g kitty_scrollback_nvim --config ksb_builtin_last_cmd_output"
            "kitty_mod+h kitty_scrollback_nvim"
          ];
          mouse_map = "ctrl+shift+right press ungrabbed mouse_select_command_output : kitty_scrollback_nvim --config ksb_builtin_last_visited_cmd_output";
          scrollback_lines = 10000;
        };
      };
    };
  };

  flake.hjemDarwinModules.graphical.imports = with self; [
    hjemCommonModules.graphical
    hjemDarwinModules.headless
  ];
  flake.hjemNixosModules.graphical = {
    imports = with self; [
      hjemCommonModules.graphical
      hjemNixosModules.beer
      hjemNixosModules.easyeffects
      hjemNixosModules.headless
      hjemNixosModules.swaybg
    ];
    xdg.config.files = {
      "xdg-terminals.list".text = ''
        kitty.desktop
      '';
    };
  };
}
