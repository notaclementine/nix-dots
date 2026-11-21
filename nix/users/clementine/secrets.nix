{
  flake.secretModules = {
    clementine-headless = {
      security.nix-secrets.secrets = {
        "clementine/linux" = {
          neededForUsers = true;
          recipients = [
            "daiya"
            "lena"
            "shin"
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
            "shin"
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
