{
  inputs,
  self,
  ...
}: {
  flake.nixosModules.headless = {
    config,
    lib,
    pkgs,
    ...
  }: {
    disabledModules = ["programs/tack.nix"];
    imports = [
      inputs.hjem.nixosModules.default
      inputs.nix-secrets.nixosModules.default
      inputs.nixos-core.nixosModules.default
      inputs.tack.nixosModules.default
      self.nixosModules.secret-assertions
      self.nixosModules.substituters
    ];
    boot.zfs.forceImportRoot = lib.mkDefault false;
    environment = {
      sessionVariables = {
        MANPAGER = "nvim -n --cmd 'set laststatus=0 nonumber noruler noshowcmd' +Man!";
        NH_ELEVATION_STRATEGY = "run0";
      };
      systemPackages = with pkgs; [
        age-plugin-fido2-hmac
        alejandra
        atool
        cryptsetup
        e2fsprogs
        eza
        fastfetch
        fd
        file
        gh
        httpie
        hy
        jujutsu
        nixfmt
        nixfmt-tree
        p7zip
        patchelf
        ripgrep
        sbctl
        sshfs
        tree
        usbutils
        waypipe
        wget
        wl-clipboard
        yt-dlp
      ];
    };
    fonts = {
      enableDefaultPackages = false;
      fontDir.enable = true;
      fontconfig = {
        enable = true;
        defaultFonts = {
          emoji = ["Noto Color Emoji"];
          monospace = ["Atkinson Hyperlegible Mono"];
          sansSerif = ["Atkinson Hyperlegible Next"];
          serif = ["Merriweather"];
        };
      };
      packages = with pkgs; [
        atkinson-hyperlegible-mono
        atkinson-hyperlegible-next
        liberation_ttf
        merriweather
        nerd-fonts.jetbrains-mono
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        ubuntu-classic
      ];
    };
    hjem = {
      clobberByDefault = true;
      extraModules = [inputs.hjem-rum.hjemModules.default];
    };
    networking.networkmanager.enable = false;
    nix.channel.enable = false;
    nix = {
      extraOptions = ''
        !include ${config.security.nix-secrets.secrets."gh-token".path}
      '';
      settings = {
        auto-allocate-uids = true;
        auto-optimise-store = true;
        use-cgroups = true;
        experimental-features = [
          "auto-allocate-uids"
          "cgroups"
          "flakes"
          "nix-command"
        ];
        trusted-public-keys = [
          "lecache:T6owlM58CGYc8X5xrAMq+IP6ilNWBpWlR8VazPPkjAQ="
        ];
        trusted-users = [
          "root"
          "@wheel"
        ];
        use-xdg-base-directories = true;
      };
    };
    nixpkgs.config.allowUnfree = true;
    programs = {
      bat.enable = true;
      fish.enable = true;
      git.enable = true;
      gnupg.agent = {
        enable = true;
        enableSSHSupport = false;
      };
      nh = {
        enable = true;
        clean = {
          enable = true;
          extraArgs = "--keep-since 4d --keep 10";
        };
      };
      ssh.startAgent = true;
      tack = {
        enable = true;
        nixConfTokens = true;
      };
      zoxide = {
        enable = true;
        enableFishIntegration = true;
      };
      nano.enable = lib.mkForce false;
    };
    security = {
      loginDefs.settings.UMASK = "002";
      nix-secrets = {
        enable = true;
        extraPackages = [pkgs.age-plugin-fido2-hmac];
        recipientAliases = {
          all-hosts = [
            "ACE"
            "cookie"
            "lenix"
            "murtle"
            "onyx"
            "phoenix"
            "turtle"
            "yubikey"
          ];
          ACE = "age1qa58lk685uwd9s8g3evvh9kyaf48rj0pggnsx6gc8nza4redx52qgrqyc0";
          cookie = "age17tdwsudlll0ykq4xlhpm758nlawnzt43kcefp6af3vkaczperahsqslydt";
          escapepod3 = "age1REPLACE_ME";
          lenix = "age1xpg656d826awgldew9svunr9r4r8rdmf8fz7zgjlgmpd809q5flsavsmkd";
          murtle = "age1eqm8wgfpc8aawaxardpypg5gcdluavplfy7gn2qp9tefwauezs2sd69wvl";
          onyx = "age1vx67nthmpprcv7mws3rvp6wtqe23td8rkxvexhvay0gvsqse0saqquv2fe";
          turtle = "age16wjhsc4uaf0jnucdx649v95ztjy8645smm33w7z47nlr8378r9tsmj5jnm";
          phoenix = "age1nur5twlqsdmlqtjwa2809rpj4wtj9hufayuahy4a8r6ayxfk435q25ufcj";
          yubikey = "age10galsk69w2j2s45e00s2zla77ycrstgu9z7avhdrer2jzj3yj9xqp0np50";
        };
        secrets = {
          "gh-token" = {
            recipients = ["all-hosts"];
            mode = "0444";
          };
          "nix-cache-key".recipients = ["all-hosts"];
        };
        storage = inputs.super-secret;
      };
      pam = {
        enableUMask = true;
        loginLimits = [
          {
            domain = "*";
            type = "soft";
            item = "nofile";
            value = "65535";
          }
          {
            domain = "*";
            type = "hard";
            item = "nofile";
            value = "65535";
          }
        ];
      };
      run0 = {
        enable = true;
        sudo-shim.enable = true;
        persistentAuth = {
          enable = true;
          enableRemote = true;
        };
      };
      sudo.enable = false;
    };
    services = {
      fwupd.enable = true;
      gnome.gnome-keyring.enable = lib.mkForce false;
      openssh = {
        enable = true;
        settings = {
          PermitRootLogin = "no";
        };
      };
    };
    system = {
      nixos-core = {
        enable = true;
        components = {
          bootStage1.enable = false;
          extraUtilsCommand.enable = false;
          initialRamdisk.enable = false;
          nixosInitCompat.enable = true;
        };
      };
      stateVersion = "25.11";
      tools = {
        nixos-rebuild.enable = false;
        nixos-generate-config.enable = false;
        nixos-build-vms.enable = false;
        nixos-install.enable = false;
        nixos-option.enable = false;
      };
    };
    systemd = {
      services."user@".serviceConfig.LimitMEMLOCK = "infinity";
      user.services."dbus-org.freedesktop.secrets".enable = false;
    };
    users.groups."la-famille".gid = 2018;
    xdg.mime = {
      enable = true;
      defaultApplications = {
        "application/x-desktop" = "nvim.desktop";
        "text/markdown" = "nvim.desktop";
        "text/plain" = "nvim.desktop";
      };
    };
  };
}
