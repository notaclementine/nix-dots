{self, ...}: {
  flake.hjemModules = {
    graphical = {pkgs, ...}: {
      imports = with self.hjemModules; [
        easyeffects
        headless
        swaybg
      ];
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
      xdg.config.files = {
        "xdg-terminals.list".text = ''
          kitty.desktop
        '';
      };
    };
    headless = {
      imports = with self.hjemModules; [
        remote-assets
      ];
      rum.programs = {
        fish.enable = true;
        git = {
          enable = true;
          ignore = ''
            .direnv
          '';
        };
        kitty = {
          enable = true;
          integrations.fish.enable = true;
        };
      };
      xdg.config.files = {
        "fish/conf.d/eza.fish".text =
          /*
          fish
          */
          ''
            abbr -a --position command l "eza --group-directories-first --git --no-time -lahg"
            abbr -a --position command la "eza -a"
            abbr -a --position command lc "eza --code"
            abbr -a --position command ll "eza --group-directories-first --git --no-time -lg"
            abbr -a --position command lla "eza --group-directories-first --git --no-time -lag"
            abbr -a --position command ls eza
            abbr -a --position command lt "eza -T"
          '';
        "fish/conf.d/rexies_prompt.fish".source = "${self}/not-nix/presets/fish/rexies_prompt.fish";
      };
    };
  };
}
