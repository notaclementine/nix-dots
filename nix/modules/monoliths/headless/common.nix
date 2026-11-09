{inputs, ...}: {
  flake.commonModules.headless = {
    lib,
    pkgs,
    ...
  }: let
    inherit (pkgs.stdenv.hostPlatform) system;
  in {
    environment.systemPackages = with pkgs; [
      inputs.dix.packages.${system}.default
      inputs.rom.packages.${system}.default
      age-plugin-fido2-hmac
      alejandra
      atool
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
      ripgrep
      tree
      wget
      yt-dlp
    ];
    fonts.packages = with pkgs; [
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
    hjem = {
      clobberByDefault = true;
      extraModules = [
        inputs.hjem-rum.hjemModules.default
        ({pkgs, ...}: {
          _module.args.pkgs = lib.mkDefault pkgs;
        })
      ];
    };
    nix = {
      channel.enable = false;
      settings = {
        experimental-features = [
          "flakes"
          "nix-command"
        ];
        trusted-public-keys = [
          "lecache:T6owlM58CGYc8X5xrAMq+IP6ilNWBpWlR8VazPPkjAQ="
        ];
        use-xdg-base-directories = true;
      };
    };
    nixpkgs.config.allowUnfree = true;
    programs = {
      cade.enable = true;
      fish.enable = true;
      gnupg.agent = {
        enable = true;
        enableSSHSupport = false;
      };
    };
    services.tailscale.enable = true;
  };
}
