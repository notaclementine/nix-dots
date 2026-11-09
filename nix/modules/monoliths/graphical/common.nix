{
  flake.commonModules.graphical = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      (mpv.override {youtubeSupport = false;})
      hunspell
      hunspellDicts.en_GB-large
      hunspellDicts.fr-moderne
      zulu
    ];
  };
}
