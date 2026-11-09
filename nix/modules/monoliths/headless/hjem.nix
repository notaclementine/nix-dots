{self, ...}: {
  flake.hjemCommonModules.headless = {
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

  flake.hjemDarwinModules.headless.imports = with self; [
    hjemCommonModules.headless
    hjemDarwinModules.remote-assets
  ];
  flake.hjemNixosModules.headless.imports = with self; [
    hjemCommonModules.headless
    hjemNixosModules.remote-assets
  ];
}
