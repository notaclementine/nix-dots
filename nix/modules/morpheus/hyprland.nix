{self, ...}: {
  flake.hjemModules.presets-hyprland = {
    config,
    lib,
    ...
  }: let
    presets = config.presets.hyprland;
  in {
    options.presets.hyprland = lib.mkOption {
      default = [];
      description = "List of hyprland presets to import.";
      type = lib.types.listOf (
        lib.types.enum [
          "animations"
          "keybinds"
          "rules"
          "settings"
        ]
      );
    };
    config = lib.mkIf (presets != []) {
      custom.hyprland.extraLuaConfig = ''
        ${lib.concatStringsSep "\n" (map (preset: "require('${preset}')") presets)}
      '';
      xdg.config.files = lib.mkMerge (
        map (preset: {
          "hypr/${preset}.lua".source = "${self}/not-nix/presets/hyprland/${preset}.lua";
        })
        presets
      );
    };
  };
}
