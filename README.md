# nix-config

## Prerequisites

* [nix](https://nixos.org/download#nix-install-macos)
* [brew](http://brew.sh/)
* git (`xcode-select --install`)

## Build and Upgrade

```shell
# build
nix build .#darwinConfigurations.ibay-macbook.system \
           --extra-experimental-features 'nix-command flakes'
# or build & switch
./result/sw/bin/darwin-rebuild switch --flake .#ibay-macbook
```

## Credits
* [Nix Darwin Kickstarter by Ryan Yin](https://github.com/ryan4yin/nix-darwin-kickstarter/tree/main)
* [Nix Config for MacOS + NixOS by Dustin Lyons](https://github.com/dustinlyons/nixos-config)
