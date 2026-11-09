{
  flake.nixosModules.aude-preservation = {
    system.nixos-core.persistence.stores."/persistent".users.aude.directories = [
      ".config/Epic"
      ".config/libreoffice"
      ".config/mozilla"
      ".config/obsidian"
      ".config/spotify"
      ".config/vicinae"
      ".local/share/PrismLauncher"
      ".local/share/Terraria"
      ".local/share/com.edde746.plezy"
      ".local/share/direnv"
      ".local/share/qalculate"
      ".local/share/vicinae"
    ];
  };
}
