{
  inputs,
  self,
  ...
}: {
  flake.nixosModules.asahi = {
    lib,
    pkgs,
    ...
  }: {
    imports = [
      inputs.apple-silicon.nixosModules.apple-silicon-support
      self.nixosModules.laptops
    ];
    boot = {
      kexec.enable = false;
      loader.efi.canTouchEfiVariables = lib.mkForce false;
    };
    environment.systemPackages = with pkgs; [
      asahi-bless
      muvm
    ];
    hardware.asahi.enable = true;
    services.fwupd.enable = lib.mkForce false;
    services.logind.settings.Login.HandleLidSwitch = lib.mkForce "ignore";
  };
}
