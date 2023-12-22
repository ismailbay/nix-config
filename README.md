# nix-config

## Prerequisites

* [nix](https://nixos.org/download#nix-install-macos)
* git (`xcode-select --install`)

## Build and Upgrade

```shell
# build
nix run .#build
# or build & switch
nix run .#build-switch
```

## Credits
* [Nix Config for MacOS + NixOS by Dustin Lyons](https://github.com/dustinlyons/nixos-config)