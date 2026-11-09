# THIS IS AI GENERATED BE WARNED
{
  flake.nixosModules.secret-assertions = {
    config,
    lib,
    ...
  }: let
    inherit (config.networking) hostName;
    nixSecretsEnabled = config.security.nix-secrets.enable;

    hostAlias =
      if config.security.nix-secrets.hostRecipientAlias != null
      then config.security.nix-secrets.hostRecipientAlias
      else hostName;

    hostKey = config.security.nix-secrets.recipientAliases.${hostAlias} or null;

    keysFor = k:
      if builtins.isList k
      then k
      else [k];

    undecryptable =
      lib.filterAttrs (
        _name: secret: !(lib.any (k: lib.elem k secret.recipients) (keysFor hostKey))
      )
      config.security.nix-secrets.secrets;
  in {
    options.security.nix-secrets.hostRecipientAlias = lib.mkOption {
      default = null;
      description = "Recipient alias representing this host, if it differs from networking.hostName.";
      type = lib.types.nullOr lib.types.str;
    };

    config.assertions = lib.mkIf nixSecretsEnabled [
      {
        assertion = hostKey != null;
        message = ''
          No recipient alias '${hostAlias}' found in security.nix-secrets.recipientAliases
          for host '${hostName}'. Set security.nix-secrets.hostRecipientAlias if the alias
          name differs from the hostname.
        '';
      }
      {
        assertion = undecryptable == {};
        message = ''
          Host '${hostName}' has secrets declared it cannot decrypt (missing from
          recipients, so activation would fail): ${toString (lib.attrNames undecryptable)}
        '';
      }
    ];
  };
}
