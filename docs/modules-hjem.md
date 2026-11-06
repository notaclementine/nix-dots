+++
title = "Nix-Dots - Hjem Modules"
+++

<link rel="icon" type="image/svg+xml" href="/assets/nix.svg">

# Hjem Modules

## aude

User environment configuration for Aude. Configures `git` and `jujutsu` (jj),
sets Neovim as the default editor, and installs applications like LibreOffice,
Signal, and Vesktop.

## beer

Installs beer and adds the daemon in the background. Simple.

## clementine-graphical

Graphical setup for Clémentine. Installs core applications (Obsidian, Halloy,
Vesktop) and provides configuration for IRC.

## clementine-headless

User environment configuration for Clémentine. Sets up SSH keys, configures
`git` with GPG signing, and provides configuration files for version control.

## easyeffects

Installs `easyeffects` and configures it to run automatically in the background
as a systemd service.

## ewan

User environment configuration for Ewan. Configures `git` and `jujutsu` (jj),
sets Neovim as the default editor, and installs core applications.

## graphical

Configures `kitty` (with Neovim scrollback integration) and adds a swaybg
service.

## headless

Provides some defaults like configuring `direnv`, provides `eza` aliases and
gives me Rexiel's `fish` prompt.

## hyprland

Configures the Hyprland Wayland compositor. Sets up environment variables for
cursors and Qt, installs helper utilities (`hyprpicker`, `hyprshot`), sets the
`uwsm` default id, and links the custom Lua configuration.

## kyla

User environment configuration for Kyla. Configures `git` and `jujutsu` (jj),
sets Neovim as the default editor, and installs core applications.

## leo

User environment configuration for Leo. Installs JetBrains IDEs, EduVPN,
Chromium, and Spotify, alongside configuring `git` and `jujutsu` (jj) profiles.

## modprobed-db

Installs `modprobed-db` and configures a systemd service and timer to
automatically snapshot currently loaded kernel modules.

## oledppuccin

Applies the "oledppuccin" (dark/OLED Catppuccin) theme across the user
environment, configuring specific colours for `bat`, `eza`, `fish`, `kitty`, and
`jolt`.

## presets-hyprland

Provides a custom option (`presets.hyprland`) to dynamically load specific
modular Lua configurations (animations, keybinds, rules, settings) into
Hyprland.

## remote-assets

A data module that fetches and exposes remote assets (wallpapers, profile
pictures, and icons) from a custom asset server for use across configurations.

## swaybg

Provides `theme.wallpaper` and `theme.wallpapers` options to manage backgrounds.
Configures a systemd service to apply global or monitor-specific wallpapers
using `swaybg`.

## themes-shared

Contains shared theming components, primarily configuring a highly customised
`fastfetch` output with Nix and system metrics.

## vicinae

Installs the `vicinae` daemon and configures a systemd service to run it in the
background during graphical sessions.
