{
  flake.secretModules = {
    aude = {
      security.nix-secrets.secrets = {
        "aude/linux" = {
          neededForUsers = true;
          recipients = [
            "cookie"
            "turtle"
            "yubikey"
          ];
        };
      };
    };
  };
}
