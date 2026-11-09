+++
title = "Nix-Dots - Bonjour"
+++

<link rel="icon" type="image/svg+xml" href="assets/nix.svg">

# Bonjour

You must be here because you heard that...

::: {.tip}

nix fixes this

:::

and here is the documentation for the fix that I use.

## Style

I have a very minimal style no bars, no panels only the background and an app
launcher. All my hosts are themed with Catppuccin Mocha, oled variant but the
dots themselves support inserting different themes... in theory.

![app-launcher](https://assets.econnah.uk/nix/readme/app-launcher.png)
![fetch](https://assets.econnah.uk/nix/readme/fetch.png)

## Architecture

This is a dendritic flake: almost every file under `nix/` is a small,
self-contained module that attaches itself to the flake's output tree, rather
than being wired together by hand in `flake.nix`.

### Assimilate (Hivemind)

`flake.nix` only does one thing: it runs a recursive function called
`assimilate`. This imports all code inside `nix/` into the hivemind.

```nix
assimilate = d:
  builtins.readDir d
  |> builtins.mapAttrs (name: type:
    if type == "directory"
    then assimilate (d + "/${name}")
    else [(d + "/${name}")])
  |> builtins.attrValues
  |> builtins.concatLists;
```

`assimilate` natively walks `nix/` and imports every file it finds as a
flake-parts module. This means adding a new host, hjem module, or NixOS module
is just a new file.

### Dependency Management (Tack)

Normal Nix flakes use a `flake.lock` with an `inputs` block. This configuration
doesn't, could that mean something... Instead it uses this glorious creation
[tack](https://github.com/manic-systems/tack).

Inputs are declared in `.tack/pins.toml` and locked via `.tack/pins.lock.json`.
Tack allows for powerful features like global `exclude_follow` rules and
recursive input omission (`omit_inputs`). This optimises the dependency closure
size by removing garbage.

### One file, one concern

Host specific modules are generally named `<host>-config.nix`,
`<host>-hardware.nix`, `<host>-hjem.nix`, `<host>-disko.nix`, and combined in a
small `default.nix` that calls `nixpkgs.lib.nixosSystem`. Shared building blocks
(defaults, hyprland, oledppuccin, and so on) live in their own files and are
pulled in by name.

### Registries

After adding more modules to my config beside the original `nixosModule` I'm now
actually more confused on the source of the nixosModule as I see it exists
outside flake parts as do darwinModules and other ones. So why am I defining
darwinModules? who knows, I certainly don't. Here are the extra modules I have
defined:

- `flake.darwinModules` — nix-darwin configuration, tagged `_class = "darwin"`.
- `flake.commonModules` — These are simply for shared code they are never to be
  imported by a host directly. This is to stop me needing to check if a host can
  even use the module every time, so when defining commonModules you(only I code
  this really) must make wrappers for the hosts that can use them.
- `flake.hjemNixosModules`, `flake.hjemDarwinModules` — reusable
  [hjem](https://github.com/feel-co/hjem) user configurations quite obvious by
  the name any new module system will need another one defined.
- `flake.hjemCommonModules` same as commonModules but for hjem really. All three
  hjem registries are tagged `_class = "hjem"`.
- `flake.nvfModules` — reusable Neovim configuration, tagged `_class = "nvf"`,
  composed together in the `nvim-qwerty` package.
- `flake.secretModules` optional, per-user nix-secrets declarations.

### Composing a host

A typical host file looks like:

```nix
flake.nixosConfigurations.<host> = inputs.nixpkgs.lib.nixosSystem {
  modules = with self.nixosModules; [
    defaults
    hyprland
    limine
    <host>-config
    <host>-hardware
    <host>-hjem
    # ...per-user modules (clementine, kyla, aude, ewan, leo)...
  ];
```

## Secrets

Secrets are managed with
[nix-secrets](https://github.com/unnamed-systems/nix-secrets), an age-based
secrets module. Two things are worth understanding before touching it: recipient
aliases, and why secrets are split into per-user modules.

### Recipient aliases

`security.nix-secrets.recipientAliases` (set once, in `defaults`) maps a host
name to its age public key, plus an `all-hosts` alias covering every real
machine. Each secret declares which aliases can decrypt it via `recipients`,
e.g.:

```nix
security.nix-secrets.secrets."clementine/linux" = {
  neededForUsers = true;
  recipients = ["ACE" "cookie" "lenix" "murtle" "onyx" "turtle" "yubikey"];
};
```

`hostRecipientAlias` (from the `secret-assertions` module) lets a host use a
different alias than its `networking.hostName`, though every current host uses
its own hostname.

### Why secrets are split per user

nix-secrets attempts to decrypt every secret declared for a host's evaluated
config, regardless of whether that host is actually a recipient — a host that
isn't listed still fails activation instead of just skipping the secret. To
avoid every host trying (and failing) to decrypt secrets for users it doesn't
have, each user's secrets live in their own `flake.secretModules.<user>` entry
(clementine, clementine-eduroam, ewan, kyla, aude), and only the NixOS modules
for hosts that actually have that user import the relevant one — e.g.
`self.secretModules.clementine` is only imported by the clementine NixOS module,
which in turn is only imported by hosts with a clementine account.

`clementine-eduroam` is a good example of splitting even further: it holds a
single secret (`clementine/wifi/eduroam`) scoped to lenix and yubikey only,
because no other host needs eduroam credentials.

### secret-assertions

The `secret-assertions` module (flagged in its own source as AI-generated — read
it carefully before changing it) runs at evaluation time and fails the build,
rather than failing silently at activation, if:

- the host's recipient alias isn't present in `recipientAliases`, or
- any secret declared in that host's config lists `recipients` that don't
  include the host's alias (i.e. a secret that would fail to decrypt at
  runtime).

This turns a runtime activation failure into a build-time error, which is the
main reason to prefer importing scoped `secretModules` over adding secrets
directly to `defaults`.

### escapepod3 is the exception

escapepod3 explicitly disables nix-secrets

## Building these docs

You can use the provided `.envrc` or manually enter the docs devshell with
`nix develop`. Run each of these commands in a seperate terminal:

```
darkhttpd build
watchexec --exts md,css,toml -- ndg html
```
