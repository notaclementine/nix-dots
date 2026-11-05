+++
title = "Nix-Dots - NixOS Modules"
+++

<link rel="icon" type="image/svg+xml" href="assets/nix.svg">

# NixOS Modules

## asahi

Configures the system for Apple Silicon hardware. Disables `kexec` and `fwupd`,
prevents EFI variable modification, configures lid switch behaviour, and
installs utilities like `asahi-bless` and `muvm`.

## aude

System-level user configuration for Aude. Defines user IDs, shell preferences,
and supplementary groups (including `wheel` and `la-famille`), whilst enabling
Tailscale and importing user-specific preservation and secret modules.

## aude-preservation

Configures impermanence state persistence specifically for Aude.

## bootloader

A core module that enables initrd systemd and allows the bootloader to touch EFI
variables.

## clementine

System-level user configuration for Clémentine. Defines user IDs, groups, and
SSH keys. Enables `pcscd`, `udev` rules for YubiKey personalisation, and
Tailscale.

## clementine-preservation

Configures impermanence state persistence specifically for Clémentine.

## ewan

System-level user configuration for Ewan. Defines user IDs and groups, enables
Tailscale, and authorises `ydotool` usage.

## ewan-preservation

Configures impermanence state persistence specifically for Ewan.

## graphical

Inherits from headless but adds stuff required for graphical hosts, such as
pipewire, oo7, flatpaks and steam.

## headless

The foundational system profile. Defines baseline packages, fonts, Nix settings,
SSH, XDG defaults, and system-wide secrets management. Disables NetworkManager
in favour of explicit networking.

## hyprland

Enables the Hyprland desktop environment at the system level, including XWayland
support and UWSM integration.

## kyla

System-level user configuration for Kyla. Defines user IDs and groups, and
enables Tailscale routing features.

## kyla-preservation

Configures impermanence state persistence specifically for Kyla.

## laptops

Configures power management and networking for portable devices. Sets up `iwd`
and `dhcpcd`, enables Bluetooth and power-profiles-daemon, and persists
networking state.

## leo

System-level user configuration for Leo. Defines user IDs, shell preferences,
and supplementary groups.

## limine

Configures Limine as the system bootloader, integrating with the base bootloader
module and explicitly clearing default wallpapers.

## mesa

Enables 32-bit and 64-bit hardware graphics acceleration via Mesa.

## nvidia

Configures the system for Nvidia GPUs. Enables modesetting and the open-source
drivers, forces the XServer video driver to `nvidia`, and configures CUDA binary
caches.

## oledppuccin

Configures system-level theming, setting specific virtual terminal (VT) colours
and modifying the Limine bootloader interface branding.

## preservation

The core impermanence module. Maps critical system directories (Flatpak,
Tailscale, logs, SSH host keys) and standard user directories to a `/persistent`
volume, ensuring data survives ephemeral root wipes.

## secret-assertions

Validates `nix-secrets` configuration during evaluation. Ensures the host has a
valid recipient alias and asserts that it can decrypt all assigned secrets,
failing the build if unreadable secrets are present.

## substituters

Configures global Nix binary caches (Cachix) and their trusted public keys for
faster package fetching.
