# Configuration for my workstation

This repository can reproduce the entirety of my system; including
services, applications and configurations. It should contain everything
necessary for an usable OS without any further configuration.

The configuration is based on my needs, however it does not mention my
details anywhere (except `user.nix`); so it should be usable to anyone
with similar tastes.

Configuration layout is based on [utdemir's dotfiles](https://github.com/utdemir/dotfiles).

## Installation

* Install NixOS as usual.
* Fork and clone this repository.
* Run: `cp home-private.nix{.example,}; cp system-private.nix{.example,}`
* Update `user.nix` with your personal information.
* (IMPORTANT) Update `hardware.nix` based on your hardware.
* Run:

```
./make.sh switch
```

* Play around.
* Tweak `system.nix`, `home.nix` and `dotfiles/` according to your
  personal taste.

## Maintenance

There is a `make.sh` on the repository responsible for common maintenance
tasks.

* `./make.sh build`: Builds the system configuration. Does **not** make any
modifications to your system. Useful to see if your changes evaluate without
problems.
* `./make.sh switch`: Builds the system configuration, adds it to the boot
menu and activates it.
* `./make.sh update`: Updates the `nixpkgs` and `home-manager` revisions, and
builds the system. Run this every few days for an up-to-date system. It also
prints out the GitHub urls of the changes.
* `./make.sh cleanup`: Garbage collects unused derivations, and deletes the
generations older than a week. Run this to get some disk space.
