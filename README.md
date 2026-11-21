# nix-dots

My very own dotfiles, if you've been here before you may have seen that I used
to have proper documentation for this. As with all great projects I came to the
realisation that documentation is a myth made up by big tech to lower ur
productivity.

Yeah but basically I was updating too much stuff so changing the docs was
annoying and afaik no one read them anyway so they have gone byebye. They will
be so dearly missed... just not by me.

## Overview

Here's a little overview of my setup just so things make sense. I use
[flake-parts](https://flake.parts/) heavily in order to modulise things between
hosts. I have declared these modules below:

```
commonModules
darwinModules
nixosModules
hjemCommonModules
hjemDarwinModules
hjemNixosModules
nvfModules
secretModules
```

Firstly `commonModules` and `hjemCommonModules` don't really mean anything they
are just code that is shared between some other kind of module. Their
counterparts are mostly self explanitory right? basically hosts only import the
named module that matches their architecture so I don't need to keep checking if
a host can import a commonModule, this leads to me needing to write some import
wrappers but who cares.

`nvfModules` modules are modules for [nvf](https://nvf.notashelf.dev/) `:3c` I
blame Kojima.

`secretModules` a subset of `nixosModules` for my secrets, they are required so
I don't accidentally import secrets I can't decrypt.

and there you have it, very simple, makes complete sense, I'm sure nothing else
needs explained.

## Pictures

Pictures are basically obligatory so here you go.
![app-launcher](https://assets.econnah.uk/nix/readme/app-launcher.png)
![fetch](https://assets.econnah.uk/nix/readme/fetch.png)

## Credits

I will be updating this soon with a bunch of people I am grateful for, just give
me a few weeks I need to sort out my domain and stuff.

## License

See [LICENSE](./LICENSE).
