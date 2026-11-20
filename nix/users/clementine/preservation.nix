{
  flake.nixosModules.clementine-preservation = {
    system.nixos-core.persistence.stores."/persistent".users.clementine.directories = [
      ".config/Epic"
      ".config/halloy"
      ".config/heroic"
      ".config/lazyspotify"
      ".config/libreoffice"
      ".config/moe.sable.client.electron"
      ".config/mozilla"
      ".config/obs-studio"
      ".config/obsidian"
      ".config/spotify"
      ".config/vicinae"
      ".java"
      ".local/share/PrismLauncher"
      ".local/share/Terraria"
      ".local/share/com.edde746.plezy"
      ".local/share/direnv"
      ".local/share/heroic"
      ".local/share/moe.sable.client"
      ".local/share/moe.sable.client-account-a1"
      ".local/share/qalculate"
      ".local/share/robrix"
      ".local/share/vicinae"
    ];
  };
}
