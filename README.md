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
* Ensure that you are using a Nix version with `flake` support, and set
  a hostname to your computer:

  ```
  nix.package = pkgs.nixFlakes;
  networking.hostName = "mycomputer";
  ```

* Fork and clone this repository.
* Update `user.nix` with your personal information, including the hostname
  set above.
* (IMPORTANT) Update `hardware.nix` based on your hardware.
  * Hint: Use your `/etc/nixos/hardware-configuration.nix` as a reference.
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

## Docs

Below some tips for the tools I'm using, and my rationale for using them.
They are not comprehensive, so consult their own documentation to use them
effectively.

---

### Operating System: NixOS

All this configuration revolves around using [NixOS](https://nixos.org/)
operating system and the [Nix](https://nixos.org/nix) programming language.

Nix provides a declarative way to declare your system, and has enough theory
behind to have purity and rollbacks trivial.

The way I use Nix/NixOS slightly differs from the common usage:

* I use [home-manager](https://github.com/rycee/home-manager) to manage
my dotfiles. This gives me a fully-reproducible and programmable system.
* I don't use channels and `NIX_PATH`. I understand the rationale behind
them, but I think they make things less obviously deterministic (action
at a distance).  So I prefer to always pin `nixpkgs` and don't use
`< ... >` syntax at all.
* I follow the `master` branch of `nixpkgs`. The main reason is that
I like to have the latest & greatest packages on my system. I found it
quite stable, and I can just reboot the system to a previous generation
if there is a major issue.

---

### Window Manager: i3

I use [i3](https://i3wm.org/) as the window manager. It is fast and does
its jobs well.

`i3` is my *only* window manager. So; I do not use terminal-multiplexers,
applications with tabs/panes/frames/buffers etc.

* Configuration: [home/wm.nix]()
* Keybindings:
  * Holding `Super` shows the status bar & system tray.
  * `Super+enter`: open terminal
  * `Super+d`: command runner
  * `Super+s`: open given query in DuckDuckGo (useful with
  [bangs](https://duckduckgo.com/bang))
  * `Super+shift+q`: quit focused application
  * `Super+<arrow>`: focus on windows
  * `Super+shift+<arrow>`: move windows
  * `Super+backspace`: Lock screen
  * `Super+f`: Toggle full-screen

---

### Shell: fish

I use `fish`. I have some amount of customisation, but nothing unusual. Comes
with a handful of useful plugins.

* Configuration: [home/shell.nix]()
* Keybindings:
  * `Ctrl+r`: Uses `fzf` to do a history search.
  * `r`: Opens `ranger`.
  * `tmp`: cd's to a temporary directory.

---

### Terminal Emulator: kitty

I use [kitty](https://github.com/kovidgoyal/kitty), with minimal
features. I find it sufficiently simple, easy to configure, and it has a
`hints` feature I use quite frequently. However its main developer is
a bit mean, so I am keen to switch to a new terminal emulator; however
I couldn't figure out a easy way to get hints without using `tmux`.

* Configuration: [dotfiles/kitty.conf]()
* Keybindings:
  * `ctrl+shift+{c,p}`: copy/paste selection
  * `ctrl+shift+l`: opens the scrollback buffer with less
  * `ctrl+shift+p`: adds hints to file-path looking things on the screen
  for easier selection.
  * `ctrl+shift+u`: same thing for urls.
  * `ctrl+shift+h`: same thing for hashes.
  * `ctrl+shift+{+,-}`: increase/decrease font size.

---

### Editor: kakoune

I spend a lot of time editing text, so it took me quite a long time to
settle on using [kakoune](https://github.com/mawww/kakoune). I think
it's the only usable editor adhering to the UNIX philosophy.

Surprisingly, I only have about 30 lines of configuration for it, they
just add a few keybindings, make it always use the system clipboard,
and change a few visuals.

Even if I am a software developer using multiple programming ecosystems
daily; I do not have programming-specific configuration on my editor. I
use `kakoune` solely for editing code, and have an another terminal
window open which runs/typechecks the project continuously.

* Executable: `kak`
* Configuration: [dotfiles/kakrc]()
* See the configuration file and Kakoune docs for the keybindings.

---

### Web Browser: qutebrowser

I use [qutebrowser](https://qutebrowser.org/) as my web browser. It is
a keyboard-oriented minimal web browser using QtWebEngine (WebKit). The
only customisation I make makes it use separate windows as tabs and
makes it use `kakoune` as editor. Also, **javascript is disabled by
default**, see the keybindings to disable it per-host basis (or just
modify the configuration).

Actually, I would prefer to use Firefox with some addons & customisation
to make it keyboard-oriented & disabling tabs. However currently there
is no easy way to configure Firefox easily & install addons without using
the GUI. There are some ongoing work adding this functionality to nixpkgs,
I will consider switching when they are merged.

* Configuration: [dotfiles/qutebrowser/config.py]()
* Keybindings:
  * `ctrl+v`: passthrough mode (send keystrokes directly to the website)
  * `shift+esc`: disable passthrough mode
  * `o`: open a website
  * `f`: add hints to the links
  * `F`: add hints to the links (open in new window)
  * `tsh`: toggle javascript for the current host for current session
  * `tSh`: toggle javascript for the current host permanently
---

### Password Manager: pass

I use [password-store](https://www.passwordstore.org/) to manage my
passwords and OTP's, and use its git integration to sync them to a
private Git repository.

Checkout its documentation for the usage, I don't have any special
configuration for it. However, there are a few helpers:

* `super+p` keybinding open a menu with your passwords, and you can
choose to copy either the password or the OTP token (if available)
to your clipboard.
* There is a `qr2pass` script on your `$PATH` which will take a screenshot
of your screen containing a barcode for an OTP and adds it to the given
password file; so you can use it to generate OTP tokens.
* There is an additional `pass rotate` command which shows you the oldest
password you have.

---

### Other tools

I also use tons of other tools for various purposes.

Checkout [./home.nix]() to see them all.

---

### FAQ

1. Opening {images,pdfs,videos,documents}

   * `sxiv` for images
   * `zathura` for pdfs
   * `mpv` for videos
   * `soffice` for office documents

2. Installing an application

   Add a line to [./home.nix](). Do not use `nix-env`.

3. External monitors

   * You can use `arandr` to interactively configure monitors.
   * If you have a setup you frequently use, use
   [autorandr](https://github.com/wertarbyte/autorandr) to save it.

4. Software development

   I don't use an IDE and I was never able to configure Vim or Emacs to
   work reliably and uniformly on different programming languages and
   build systems. So, here is the setup I use:

   * I open three terminal windows (a big one on the left, two small ones
   on the right.
   * I execute the editor on the left, `ranger` on the top-right and make
   the compilation output available on the bottom-right. It looks like this:

     ```
     +--------+--------+
     |        | ranger |
     |        |        |
     + editor +--------+
     |        | watch  |
     |        |        |
     +--------+--------+
     ```

   * I use the `ranger` window for browsing the other files or using `rg` to
   search for definitions, or for any auxiliary things I do using a terminal.
   * On bottom-right, I figure out a way to have the compilation output available.
   Here are some examples:

     * **Haskell**: Use [ghcid](https://github.com/ndmitchell/ghcid).
     * **Scala**: Use `~ compile` command on `sbt`.
     * Interpreted languages: Use [entr](http://eradman.com/entrproject/)
     to continuously run the interpreter:
       * `fd '.*.py' | entr -c python main.py`
       * `fd | entr -c nix-build --show-trace`
       * `echo slides.md | entr -c pandoc -t beamer slides.md -o slides.pdf`

5. Autostarting applications

   * If it is a simple command running as your user, put a line to
   [dotfiles/i3/autostart.sh]().
   * If it is a system daemon, put it to `system.nix`; either using an
   available NixOS module or as a custom `systemd` service.

6. Something else

   If you have a problem, probably I had faced it before. Just
   [open an issue](https://github.com/utdemir/dotfiles/issues) and I will
   get back to you.
