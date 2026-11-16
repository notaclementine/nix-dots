{
  inputs,
  self,
  ...
}: {
  flake.nixosModules.circus-agent = {config, ...}: {
    imports = [
      inputs.circus.nixosModules.circus-agent
    ];
    security.nix-secrets.secrets = {
      "other/circus/join-token" = {
        group = "circus-agent";
        owner = "circus-agent";
        recipients = ["onyx" "yubikey"];
      };
    };
    services.circus-agent = {
      enable = true;
      joinTokenFile = config.security.nix-secrets.secrets."other/circus/join-token".path;
      settings.agent = {
        runner_url = "circus+tls://phoenix.wild-beaufort.ts.net:8443";
        tls.ca_file = "${self}/not-nix/other/circus/ca.crt";
        supported_features = ["nixos-test" "big-parallel" "kvm"];
        cores = 0;
      };
    };
    system.nixos-core.persistence.stores."/persistent".directories = [
      {
        group = "circus-agent";
        owner = "circus-agent";
        target = "/var/lib/circus-agent";
      }
    ];
  };
}
