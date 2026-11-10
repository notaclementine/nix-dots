{moduleWithSystem, ...}: {
  flake.nixosModules.evilix-config = moduleWithSystem (
    {self', ...}: {
      pkgs,
      lib,
      ...
    }: {
      environment = {
        etc."wsl-session-init.sh" = {
          mode = "0755";
          text = ''
            #!${pkgs.runtimeShell}
            systemctl --user import-environment DISPLAY WAYLAND_DISPLAY XDG_RUNTIME_DIR
            systemctl --user start graphical-session.target
            exec ${pkgs.fish}/bin/fish -l
          '';
        };
        sessionVariables.LD_LIBRARY_PATH = "/usr/lib/wsl/lib";
        systemPackages = with pkgs; [
          self'.packages.nvim-qwerty
          dart-sass
          python3
        ];
      };
      networking = {
        hostName = "evilix";
        firewall.trustedInterfaces = ["loopback0"];
      };
      systemd.user.targets = {
        "graphical-session".unitConfig.RefuseManualStart = false;
        "graphical-session-pre".unitConfig.RefuseManualStart = false;
      };
      nix = {
        extraOptions = lib.mkForce '''';
        settings = {
          cores = 0;
          http-connections = 100;
          max-jobs = 2;
        };
      };
      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      programs = {
        fish.shellInit = ''
          set -gx DOTNET_ROOT $HOME/.dotnet
          fish_add_path $HOME/.dotnet
          fish_add_path $HOME/.dotnet/tools
          fish_add_path "/mnt/c/Users/connor/AppData/Local/Programs/Microsoft VS Code/bin"
        '';
        nh.flake = "/persistent/dotfiles";
        nix-ld = {
          enable = true;
          libraries = with pkgs; [
            stdenv.cc.cc
            stdenv.cc.libc
            zlib
            icu
            openssl
            curl
            libgcc
          ];
        };
        npm.enable = true;
        steam.enable = false;
      };
      security.nix-secrets.enable = lib.mkForce false;
      systemd.network = {
        enable = lib.mkForce false;
        links = lib.mkForce {};
      };
      services.resolved.enable = lib.mkForce false;
      time.timeZone = "Europe/Amsterdam";
      users.users.clementine.hashedPasswordFile = "/persistent/secret/clementine/linux";
      wsl = {
        enable = true;
        defaultUser = "clementine";
        interop.includePath = false;
        useWindowsDriver = true;
        wslConf.automount.options = "metadata,uid=2026,gid=2026";
      };
      xdg.portal = {
        enable = true;
        extraPortals = [pkgs.xdg-desktop-portal-gtk];
        config.common.default = ["gtk"];
      };
    }
  );
}
