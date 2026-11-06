{self, ...}: {
  flake = let
    theme = self + "/not-nix/themes/oledppuccin/";
  in {
    hjemModules.oledppuccin = {
      config,
      pkgs,
      ...
    }: let
      gtkTheme = pkgs.magnetic-catppuccin-gtk.override {
        accent = ["mauve"];
        shade = "dark";
        tweaks = ["black"];
      };
      qtTheme = ''
         [Appearance]
        color_scheme_path=${theme}qt.conf
         custom_palette=true
         style=kvantum-dark
      '';
    in {
      imports = [self.hjemModules.themes-shared];
      environment.sessionVariables = {
        BEER_CONFIG = "${config.xdg.config.directory}/beer/beer.toml:${theme}beer.toml";
      };
      packages = [gtkTheme];
      rum.programs.kitty.settings.include = "oledppuccin.conf";
      xdg = {
        config.files = {
          "bat/config".text = "--theme='oledppuccin'";
          "bat/themes/oledppuccin.tmTheme".source = theme + "bat.tmTheme";
          "eza/theme.yml".source = theme + "eza.yml";
          "fish/conf.d/00-theme.fish".text = ''
            fish_config theme choose oledppuccin
          '';
          "fish/themes/oledppuccin.theme".source = theme + "fish.theme";
          "gtk-4.0/assets".source = "${gtkTheme}/share/themes/Catppuccin-GTK-Mauve-Dark-BK/gtk-4.0/assets";
          "gtk-4.0/gtk.css".source = "${gtkTheme}/share/themes/Catppuccin-GTK-Mauve-Dark-BK/gtk-4.0/gtk.css";
          "gtk-4.0/gtk-dark.css".source = "${gtkTheme}/share/themes/Catppuccin-GTK-Mauve-Dark-BK/gtk-4.0/gtk-dark.css";
          "gtk-3.0/settings.ini".text = ''
            [Settings]
            gtk-theme-name=Catppuccin-GTK-Mauve-Dark-BK
            gtk-icon-theme-name=Adwaita
            gtk-font-name=Atkinson Hyperlegible Next 12
            gtk-cursor-theme-name=BreezeX-RosePine-Linux
            gtk-cursor-theme-size=24
            gtk-application-prefer-dark-theme=1
          '';
          "gtk-4.0/settings.ini".text = ''
            [Settings]
            gtk-theme-name=Catppuccin-GTK-Mauve-Dark-BK
            gtk-icon-theme-name=Adwaita
            gtk-font-name=Atkinson Hyperlegible Next 12
            gtk-cursor-theme-name=BreezeX-RosePine-Linux
            gtk-cursor-theme-size=24
            gtk-application-prefer-dark-theme=1
          '';
          "kitty/diff.conf".source = theme + "kitty/diff.conf";
          "kitty/oledppuccin.conf".source = theme + "kitty/oledppuccin.conf";
          "jolt/config.toml" = {
            generator = (pkgs.formats.toml {}).generate "config.toml";
            value = {
              appearance = "dark";
              theme = "oledppuccin";
              refresh_ms = 2000;
              show_graph = true;
              graph_metric = "merged";
              process_count = 50;
              energy_threshold = 0.5;
              merge_mode = true;
              transparent_background = false;
              forecast_window_secs = 300;
              excluded_processes = [];
              log_level = "info";
              history = {
                background_recording = false;
                sample_interval_secs = 60;
                retention_raw_days = 30;
                retention_hourly_days = 180;
                retention_daily_days = 0;
                retention_sessions_days = 90;
                max_database_mb = 500;
              };
              units = {
                energy = "wh";
                temperature = "celsius";
                data_size = "si";
              };
            };
          };
          "jolt/themes/oledppuccin.toml" = {
            generator = (pkgs.formats.toml {}).generate "config.toml";
            value = {
              name = "oledppuccin";
              dark = {
                bg = "#000000";
                dialog_bg = "#313244";
                fg = "#cdd6f4";
                accent = "#89b4fa";
                accent_secondary = "#cba6f7";
                highlight = "#f9e2af";
                muted = "#9399b2";
                success = "#a6e3a1";
                warning = "#fab387";
                danger = "#f38ba8";
                border = "#45475a";
                selection_bg = "#585b70";
                selection_fg = "#cdd6f4";
                graph_line = "#89b4fa";
              };
            };
          };
          "qt5ct/qt5ct.conf".text = qtTheme;
          "qt6ct/qt6ct.conf".text = qtTheme;
          "Kvantum/oledppuccin/oledppuccin.svg".source = theme + "kvantum/oledppuccin.svg";
          "Kvantum/oledppuccin/oledppuccin.kvconfig".source = theme + "kvantum/oledppuccin.kvconfig";
          "Kvantum/kvantum.kvconfig".text = ''
            [General]
             theme=oledppuccin
          '';
        };
        data.files = {
          "PrismLauncher/themes/oledppuccin/theme.json".source = theme + "prismlauncher/theme.json";
          "PrismLauncher/themes/oledppuccin/themeStyle.css".source = theme + "prismlauncher/themeStyle.css";
        };
      };
    };
    nixosModules.oledppuccin = {
      boot = {
        kernelParams = [
          "vt.default_red=0,243,166,249,137,245,148,186,88,243,166,249,137,245,148,166"
          "vt.default_grn=0,139,227,226,180,194,226,194,91,139,227,226,180,194,226,173"
          "vt.default_blu=0,168,161,175,250,231,213,222,112,168,161,175,250,231,213,200"
        ];
        loader.limine = {
          extraConfig = builtins.readFile (theme + "limine.conf");
          style.interface.branding = "";
        };
      };
    };
  };
}
