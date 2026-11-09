{
  flake.secretModules = {
    clementine-headless = {
      security.nix-secrets.secrets = {
        "clementine/linux" = {
          neededForUsers = true;
          recipients = [
            "lenix"
            "onyx"
            "phoenix"
            "yubikey"
          ];
        };
      };
    };
    clementine-graphical = {
      security.nix-secrets.secrets = {
        "clementine/halloy" = {
          group = "clementine";
          owner = "clementine";
          recipients = [
            "lenix"
            "onyx"
            "yubikey"
          ];
        };
      };
    };
    clementine-eduroam = {
      security.nix-secrets.secrets."clementine/wifi/eduroam".recipients = ["lenix" "yubikey"];
    };
  };
}
