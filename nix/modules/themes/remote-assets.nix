{self, ...}: {
  flake.hjemCommonModules.remote-assets = {
    lib,
    pkgs,
    ...
  }: {
    _module.args.remoteAssets = {
      other = {
        "thirsty.png" = pkgs.fetchurl {
          hash = "sha256-zOe7RUEBDd7Abum6sm0msUdorZkAJiPCJDHpnWvCvCQ=";
          url = "https://assets.econnah.uk/nix/other/thirsty.png";
        };
      };
      profile-pics = {
        "clementine.jpg" = pkgs.fetchurl {
          hash = "sha256-jvghKg73h6+QyaEb/yNcJrt5EJSlMnL2NMuOiKRXgmY=";
          url = "https://assets.econnah.uk/nix/profile-pics/clementine.jpg";
        };
        "leo.png" = pkgs.fetchurl {
          hash = "sha256-w9cHmg3SyIAXv1j14sNvl2JAY2CwOarJXVs2Ym4eYmE=";
          url = "https://assets.econnah.uk/nix/profile-pics/leo.png";
        };
      };
      wallpapers = {
        "86-01.png" = pkgs.fetchurl {
          hash = "sha256-mV1clUbd3m11VXJPLCNV4D3UE+SAekaKTWA/zuAwX/w=";
          url = "https://assets.econnah.uk/nix/wallpapers/86-01.png";
        };
        "86-02.png" = pkgs.fetchurl {
          hash = "sha256-xptg1+4yx52PkJqosfQmqsKSghWVR/sRo/sK17GCdkM=";
          url = "https://assets.econnah.uk/nix/wallpapers/86-02.png";
        };
        "darling_in_the_franxx-01.png" = pkgs.fetchurl {
          hash = "sha256-GJXSwYN/xCHL/TDKyEfd5GfpX8rgpb1+PFgdH0qVcr0=";
          url = "https://assets.econnah.uk/nix/wallpapers/darling_in_the_franxx-01.png";
        };
        "frieren-01.png" = pkgs.fetchurl {
          hash = "sha256-hO9frS8rKtoQ2wdEYTbc3bWg8cOJdlyQ9Hof6PdgRcQ=";
          url = "https://assets.econnah.uk/nix/wallpapers/frieren-01.png";
        };
        "frieren-02.png" = pkgs.fetchurl {
          hash = "sha256-kem0UYXhZJGBgyMYEpYOdqOaGZ08ac10MMjU4Nkam+8=";
          url = "https://assets.econnah.uk/nix/wallpapers/frieren-02.png";
        };
        "frieren-03.png" = pkgs.fetchurl {
          hash = "sha256-PAR+lDkmVteqqQ1Sap62VQ6s2Ie19QNGylcvz0kLCp0=";
          url = "https://assets.econnah.uk/nix/wallpapers/frieren-03.png";
        };
        "frieren-04.png" = pkgs.fetchurl {
          hash = "sha256-BGm9o2j1kjJkPtE0Q8WZJoWOfDn60j9WTNH+G/2x884=";
          url = "https://assets.econnah.uk/nix/wallpapers/frieren-04.png";
        };
        "jjk-01.png" = pkgs.fetchurl {
          hash = "sha256-SxPfDv/FhIHo62gs/lpN7xDJ3ZwU8LhJXFtiRwCQRvg=";
          url = "https://assets.econnah.uk/nix/wallpapers/jjk-01.png";
        };
        "jjk-02.png" = pkgs.fetchurl {
          hash = "sha256-eEDBo7HeCGi/MJtisBHF+MEIb8qDm9VQ3py0WgvirjU=";
          url = "https://assets.econnah.uk/nix/wallpapers/jjk-02.png";
        };
        "jjk-03.png" = pkgs.fetchurl {
          hash = "sha256-A5nAHyrB/2L9Mzl0OD1simJEckTBYA8i7pw4oMZbHWg=";
          url = "https://assets.econnah.uk/nix/wallpapers/jjk-03.png";
        };
        "mountains-01.jpg" = pkgs.fetchurl {
          hash = "sha256-HiLEDE5fifOxYTExMSuisExVdAf/c+iBc7/vXxsW4Gs=";
          url = "https://assets.econnah.uk/nix/wallpapers/mountains-01.jpg";
        };
        "point_break-01.png" = pkgs.fetchurl {
          hash = "sha256-lEazfPNeisETcoxowUoK6ixhYfUN0Ci3Fg1MszzUedU=";
          url = "https://assets.econnah.uk/nix/wallpapers/point_break-01.png";
        };
        "tensura-01.png" = pkgs.fetchurl {
          hash = "sha256-tGkqw7p6pdC8l6++xPwrHrz6wtYfS1e1u0R/5glto5w=";
          url = "https://assets.econnah.uk/nix/wallpapers/tensura-01.png";
        };
        "tensura-02.png" = pkgs.fetchurl {
          hash = "sha256-MAmo4O9RmBI+Jj85tbSdpWAubaBawmIoSfZcjNVdgn0=";
          url = "https://assets.econnah.uk/nix/wallpapers/tensura-02.png";
        };
        "ultrakill-01.png" = pkgs.fetchurl {
          hash = "sha256-OtPvmv3X9pqj1JtFOWjwPqTbzK1kzCXXFI54zsxIyw8=";
          url = "https://assets.econnah.uk/nix/wallpapers/ultrakill-01.png";
        };
        "weathering_with_you-01.png" = pkgs.fetchurl {
          hash = "sha256-tD1Qfj3HcrLajI1RykCd4wysAZv37qy4ZtLknDJ7ybA=";
          url = "https://assets.econnah.uk/nix/wallpapers/weathering_with_you-01.png";
        };
        "your_name-01.png" = pkgs.fetchurl {
          hash = "sha256-Z5mMsNiRAqdUlwOAY38ICXKqVDLZaZE4eRj+76OSY+4=";
          url = "https://assets.econnah.uk/nix/wallpapers/your_name-01.png";
        };
        "your_name-02.png" = pkgs.fetchurl {
          hash = "sha256-DKLfkT/3FzF4OOPdUqkKl5OOqrU3IofiQeop2jLwp+Q=";
          url = "https://assets.econnah.uk/nix/wallpapers/your_name-02.png";
        };
      };
    };
  };

  flake.hjemDarwinModules.remote-assets.imports = [self.hjemCommonModules.remote-assets];
  flake.hjemNixosModules.remote-assets.imports = [self.hjemCommonModules.remote-assets];
}
