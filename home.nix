{ config, pkgs, ... }:
{
  imports = [
    ./nix/dotfiles.nix
    ./home/wm.nix
    ./home/git.nix
    ./home/qutebrowser.nix
    ./home/kitty.nix
    ./home/fish-shell.nix
    ./home/kakoune.nix
  ];

  dotfiles = import ./user.nix;

  home.packages = with pkgs; [
    (callPackage ./scripts {})

    # WM
    acpi
    maim

    # Apps
    chromium
    gimp
    libreoffice
    feh
    xsel
    zathura
    inkscape
    teams
    steam
    virt-manager
    paraview
    pavucontrol
    transmission-qt
    vlc

    # services
    spotify
    whois
    zoom-us
    openconnect

    # Fonts
    hack-font

    # CLI
    curl
    direnv
    dnsutils
    file
    fzf
    graphviz
    htop
    imagemagick
    iw
    jq
    openssl
    pandoc
    pwgen
    lf
    ripgrep
    rsync
    tig
    tree
    units
    unzip
    wget
    zip

    # haskell
    stack
    haskellPackages.cabal-install

    # python
    python37
    python37Packages.virtualenv

    # nix
    nix-prefetch
    patchelf
    nix-top
    nix-tree
    niv
    nixpkgs-fmt
    cachix
  ];

  manual.manpages.enable = true;

  home.file.".profile" = {
    text = ''
      export NIX_PATH=nixpkgs=${pkgs.path}
      export TMPDIR=/tmp
      export TMP=$TMPDIR
      source ${./dotfiles/profile}
    '';
    executable = true;
  };

  news.display = "silent";

  # Force home-manager to use pinned nixpkgs
  _module.args.pkgs = pkgs.lib.mkForce pkgs;
}
