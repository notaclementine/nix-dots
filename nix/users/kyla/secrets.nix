{
  flake.secretModules = {
    kyla = {
      security.nix-secrets.secrets = {
        "kyla/linux" = {
          neededForUsers = true;
          recipients = [
            "ACE"
            "cookie"
            "turtle"
            "yubikey"
          ];
        };
      };
    };
  };
}
