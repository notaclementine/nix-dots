{
  flake.nixosModules.preservation = {
    config,
    lib,
    ...
  }: let
    normalUsers = lib.filterAttrs (_name: user: user.isNormalUser) config.users.users;
  in {
    boot.tmp.useTmpfs = false;
    system.nixos-core.persistence = {
      enable = true;

      stores."/persistent" = {
        directories = [
          "/var/lib/flatpak"
          "/var/lib/sbctl"
          "/var/lib/tailscale"
          "/var/log"
          {
            target = "/var/lib/systemd/network";
            owner = "systemd-network";
            group = "systemd-network";
          }
        ];

        users =
          lib.mapAttrs (_name: _: {
            directories = [
              ".cache/bat"
              ".config/Signal"
              ".config/easyeffects"
              ".config/jj/repos"
              ".config/vesktop"
              ".local/share/Steam"
              ".local/share/applications"
              ".local/share/fish"
              ".local/share/flatpak"
              ".local/share/icons"
              ".local/share/jolt"
              ".local/share/keyrings"
              ".local/share/modprobed-db"
              ".local/share/nvim"
              ".local/share/zoxide"
              ".local/state/wireplumber"
              ".ssh"
              ".steam"
              ".var/app"
              "Desktop"
              "Documents"
              "Downloads"
              "Music"
              "Pictures"
              "Videos"
            ];
          })
          normalUsers;
      };
    };
    services.openssh.hostKeys = [
      {
        type = "ed25519";
        path = "/persistent/etc/ssh/ssh_host_ed25519_key";
      }
    ];
    systemd.suppressedSystemUnits = ["systemd-machine-id-commit.service"];
  };
}
