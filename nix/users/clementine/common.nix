{
  flake.commonModules = {
    clementine-graphical = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        yubikey-manager
      ];
    };
    clementine-headless = {pkgs, ...}: {
      hjem.users.clementine = {
        enable = true;
        user = "clementine";
      };
      users.users.clementine = {
        description = "Clémentine Alecks";
        openssh.authorizedKeys.keys = [
          "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIILd7radoI+ZnYz/NKDVLBDH8zFdq6r2I/gP0HuZGs0gAAAABHNzaDo= ssh:"
        ];
        shell = pkgs.fish;
      };
    };
  };
}
