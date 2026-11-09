{self, ...}: {
  flake.nixosModules.laptops = {
    lib,
    pkgs,
    ...
  }: {
    imports = with self.nixosModules; [
      graphical
      wireless
    ];
    environment.systemPackages = with pkgs; [
      brightnessctl
      jolt-tui
    ];
    hardware.bluetooth.enable = true;
    powerManagement.enable = true;
    system.nixos-core.persistence.stores."/persistent".directories = [
      "/var/lib/bluetooth"
    ];
    services.logind.settings.Login.HandleLidSwitch = lib.mkDefault "suspend-then-hibernate";
    services.power-profiles-daemon.enable = true;
  };
}
