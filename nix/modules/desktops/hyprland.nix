{inputs, ...}: {
  flake = {
    hjemModules.hyprland = {
      config,
      lib,
      pkgs,
      ...
    }: let
      inherit (lib) mkOption types;
    in {
      options.custom.hyprland.extraLuaConfig = mkOption {
        default = "";
        description = "Lua snippets that will be merged into hyprland.lua";
        type = types.lines;
      };

      config = {
        custom.hyprland.extraLuaConfig =
          lib.mkBefore
          /*
          lua
          */
          ''
            mod = "SUPER"
            browser = "firefox"
            terminal = "kitty -1"

            hl.env("QT_QPA_PLATFORM", "wayland;xcb")
            hl.on("hyprland.start", function()
                hl.exec_cmd("uwsm app -- kitty --start-as=hidden -1")
            end)
          '';
        environment.sessionVariables = {
          HYPRCURSOR_SIZE = "24";
          HYPRCURSOR_THEME = "rose-pine-hyprcursor";
          XCURSOR_SIZE = "24";
          XCURSOR_THEME = "BreezeX-RosePine-Linux";
        };
        packages = with pkgs; [
          hyprpicker
          hyprshot
          rose-pine-cursor
          rose-pine-hyprcursor
          xrandr
        ];
        rum.desktops.hyprland.enable = true;
        xdg.config.files = {
          "hypr/hyprland.lua".text = config.custom.hyprland.extraLuaConfig;
          "uwsm/default-id".text = ''
            hyprland-uwsm.desktop
          '';
          "uwsm/env-hyprland".text = ''
            systemctl --user import-environment XDG_SESSION_ID
          '';
        };
      };
    };
    nixosModules.hyprland = {
      disabledModules = ["programs/hyprland.nix"];
      imports = [inputs.hyprland.nixosModules.default];
      programs = {
        hyprland = {
          enable = true;
          withUWSM = true;
        };
        uwsm.enable = true;
      };
      environment.sessionVariables.TUIGREET_SESSION_COMMAND = "uwsm start default";
    };
  };
}
