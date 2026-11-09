{
  lib,
  flake-parts-lib,
  moduleLocation,
  ...
}: let
  inherit
    (lib)
    mapAttrs
    mkOption
    optionalAttrs
    types
    ;

  mkModulesOption = {
    name,
    class ? null,
    description,
  }:
    mkOption {
      apply = mapAttrs (
        k: v:
          {
            imports = [v];
            _file = "${toString moduleLocation}#${name}.${k}";
            key = "${toString moduleLocation}#${name}.${k}";
          }
          // optionalAttrs (class != null) {_class = class;}
      );
      default = {};
      inherit description;
      type = types.lazyAttrsOf types.deferredModule;
    };
in {
  options = {
    flake = flake-parts-lib.mkSubmoduleOptions {
      hjemModules = mkModulesOption {
        name = "hjemModules";
        class = "hjem";
        description = ''
          hjem configuration modules.
          You may use this for reusable pieces of hjem configuration so that they can be referenced across different host configurations.
        '';
      };

      nvfModules = mkModulesOption {
        name = "nvfModules";
        class = "nvf";
        description = ''
          NVF configuration modules.

          You may use this for reusable pieces of Neovim configuration, plugins,
          and themes so that they can be referenced across different host configurations.
        '';
      };

      secretModules = mkModulesOption {
        name = "secretModules";
        class = "nixos";
        description = ''
          Optional per-host `nix-secrets` declarations. `nix-secrets`
          attempts to decrypt every secret declared for a host's
          evaluated config, regardless of `recipients` — a host that
          isn't a recipient still fails activation rather than
          skipping it. Put secrets that only some hosts should even
          attempt here, and only import the relevant ones on the
          hosts that are actual recipients, instead of declaring
          them unconditionally in a shared module.
        '';
      };
    };
  };
}
