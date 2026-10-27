{self, ...}: {
  flake.nixosModules.graphical = {
    config,
    lib,
    pkgs,
    ...
  }: let
    inherit (lib) optionalAttrs;
  in {
    imports = with self.nixosModules; [headless];
    environment = {
      etc."tuigreet/config.toml".source = "${self}/not-nix/presets/tuigreet.toml";
      sessionVariables = {
        NIXOS_OZONE_WL = "1";
        PROTON_ENABLE_WAYLAND = "1";
      };
      variables = {
        QT_STYLE_OVERRIDE = lib.mkForce null;
      };
      systemPackages = with pkgs; [
        (mpv.override {youtubeSupport = false;})
        alsa-utils
        distrobox
        firefox
        gimp
        hunspell
        hunspellDicts.en_GB-large
        hunspellDicts.fr-moderne
        imv
        libinput
        liblc3
        matugen
        mesa-demos
        pavucontrol
        pulseaudio
        qpwgraph
        vulkan-tools
        zulu
      ];
    };
    programs = {
      dconf.enable = true;
      firefox.enable = true;
      gamemode.enable = true;
      steam = {
        enable = lib.mkDefault true;
        extraPackages = with pkgs; [
          hyprpicker
          hyprshot
          rose-pine-cursor
          rose-pine-hyprcursor
        ];
        extraCompatPackages = with pkgs; [
          proton-ge-bin
        ];
        # fazzi da goat https://gitlab.com/fazzi/nixohess/
        package = pkgs.steam.override {
          extraEnv.DBUS_SYSTEM_BUS_ADDRESS = "";
        };
      };
    };
    qt = {
      enable = true;
      platformTheme = "qt5ct";
      style = "kvantum";
    };
    security = {
      pam.services = {
        greetd.oo7.enable = false; # for now
        login.oo7.enable = lib.mkForce false;
      };
      rtkit.enable = true;
      soteria.enable = true;
    };
    services = {
      flatpak.enable = lib.mkDefault true;
      greetd = {
        enable = true;
        useTextGreeter = true;
        settings.default_session = {
          user = "greeter";
          command = "${lib.getExe pkgs.tuigreet}";
        };
      };
      libinput.enable = true;
      oo7.enable = true;
      pipewire = {
        enable = true;
        pulse.enable = true;
        wireplumber.enable = true;
      };
      stash-clipboard.enable = true;
    };
    virtualisation = {
      vmVariant = {
        boot.kernelParams = ["video=2560x1440@240"];
        virtualisation.cores = 4;
        virtualisation.memorySize = 10240;
      };
    };
    xdg = {
      mime.defaultApplications = {
        "application/pdf" = "firefox.desktop";
        "text/html" = "firefox.desktop";
        "video/mp4" = "mpv.desktop";
        "video/mpeg" = "mpv.desktop";
        "video/quicktime" = "mpv.desktop";
        "video/webm" = "mpv.desktop";
        "video/x-flv" = "mpv.desktop";
        "video/x-matroska" = "mpv.desktop";
        "video/x-msvideo" = "mpv.desktop";
        "x-scheme-handler/about" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/terminal" = "kitty.desktop";
        "x-scheme-handler/unknown" = "firefox.desktop";
      };
      terminal-exec = {
        enable = true;
        settings.default = [
          "kitty.desktop"
        ];
      };
    };
  };
}
