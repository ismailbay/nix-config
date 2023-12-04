# nix-config

## Prerequisites

* [nix](https://nixos.org/download#nix-install-macos)
* git
* [homebrew](https://brew.sh) or any other package manager

Set hostname to match the configuration.

## Build and Upgrade

e.g. for host `melamar`:

```shell
nix build .#darwinConfigurations.melamar.system
./result/sw/bin/darwin-rebuild switch --flake .
```

## Generations

```shell
# list builds
darwin-rebuild --list-generations

```