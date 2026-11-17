{
  flake.secretModules = {
    clementine-headless = {
      security.nix-secrets.secrets = {
        "clementine/linux" = {
          neededForUsers = true;
          recipients = [
            "lena"
            "onyx"
            "daiya"
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
            "lena"
            "onyx"
            "yubikey"
          ];
        };
      };
    };
    clementine-eduroam = {
      security.nix-secrets.secrets."clementine/wifi/eduroam".recipients = ["lena" "yubikey"];
    };
  };
}
