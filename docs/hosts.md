+++
title = "Nix-Dots - Hosts"
+++

<link rel="icon" type="image/svg+xml" href="assets/nix.svg">

# Hosts

## ACE

An AMD-based laptop belonging to Kyla. It utilises an `f2fs` filesystem with
persistent state management and runs the standard Mesa graphics stack. The
display is configured for a standard 1080p 60Hz built-in panel.

## cookie

A family laptop configured for Aude and Kyla. Powered by an AMD processor and a
Seagate drive, it relies on a BTRFS filesystem that rolls back the root
subvolume to a blank snapshot on every boot, keeping the base system pristine.

## daiya

A headless aarch64 host running inside an Oracle vps, currently is the main
circus builder/database since I haven't switched my homelab itself to nixos but
will later be just a remote aarch64 builder. Only has clementine as a user and
uses BTRFS impermanence like most hosts.

## eighty-six

A minimal NixOS installer ISO (`x86_64-linux`) used for bootstrapping new
machines. Built from the `clementine`, `defaults`, and `mesa` modules with
persistence, `nix-secrets`, and `sudo` password prompts disabled, and root SSH
login enabled for initial setup.

## escapepod3

An Apple Silicon (`aarch64-linux`) laptop configured specifically for Leo.
Unlike the other hosts, it uses a traditional BTRFS partition layout without the
`preservation` module or `nix-secrets`, running the Asahi Linux kernel and
firmware.

## evilix

A wsl host for Clémentine. Runs without `preservation` module. To use via
windows terminal utilise this command:

```
C:\WINDOWS\system32\wsl.exe -d NixOS -u root -e /run/current-system/sw/bin/machinectl shell -E DISPLAY=:0 -E WAYLAND_DISPLAY=wayland-0 -E XDG_RUNTIME_DIR=/run/user/2026 clementine@.host /etc/wsl-session-init.sh
```

## lenix

Clémentine's primary Apple Silicon laptop. It features LUKS full-disk encryption
(`cryptlenix`) and an ephemeral BTRFS root that wipes on boot. It includes
specific overrides for university Wi-Fi (`eduroam`), network analysis tools
(`wireshark`), and game streaming (`moonlight-qt`).

## murtle

An AMD desktop rig configured for Ewan. It features a dual-drive `f2fs` storage
setup (an NVMe boot drive and a secondary Samsung 860 EVO for data) and drives a
dual 1080p 60Hz monitor setup.

## onyx

A high-end workstation and gaming desktop built for Clémentine. It features
Nvidia graphics driving a 1440p 240Hz monitor with variable refresh rate
enabled. The system boots entirely into RAM with a `tmpfs` root, utilises a 2TB
NVMe paired with a 2TB HDD, and is configured to dual-boot Windows 11 via
Limine. It comes loaded with `steam`, `gamescope`, `davinci-resolve`, and full
OBS Studio integrations.

## turtle

A family desktop powered by an Intel CPU and Nvidia graphics, configured for
Aude, Ewan, and Kyla. It drives a mixed-refresh dual-monitor setup (144Hz
primary, 60Hz secondary) and uses a BTRFS root that rolls back to a blank state
on boot. Like Onyx, it is fully equipped with gaming and media production
packages.
