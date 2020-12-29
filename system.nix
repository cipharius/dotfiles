{ config, pkgs, ... }:
let
  getName = drv:
    if builtins.hasAttr "pname" drv
    then drv.pname
    else if builtins.hasAttr "name" drv
    then (builtins.parseDrvName drv.name).name
    else throw "Cannot figure out name of: ${drv}";
in
{
  imports = [
    ./nix/dotfiles.nix
  ];

  dotfiles = import ./user.nix;
  networking.hostName = config.dotfiles.hostname;

  nixpkgs = {
    config = {
      allowUnfreePredicate = pkg:
        builtins.elem
          (getName pkg)
          [
            "spotify"
            "spotify-unwrapped"
            "teams"
            "slack"
            "zoom-us"
            "faac" # required for zoom
            "steam"
            "steam-original"
            "steam-runtime"
          ];
    };
    overlays = [
      (import ./overlay.nix)
    ];
  };

  nix = {
    package = pkgs.nixUnstable;

    binaryCaches = [
      "https://utdemir.cachix.org"
      "https://hs-nix-template.cachix.org"
    ];
    binaryCachePublicKeys = [
      "utdemir.cachix.org-1:mDgucWXufo3UuSymLuQumqOq1bNeclnnIEkD4fFMhsw="
      "hs-nix-template.cachix.org-1:/YbjZCrYAw7d9ayLayk7ZhBdTEkR10ZFmFuOq6ZJo4c="
    ];
    trustedUsers = [ "root" config.dotfiles.username ];
    autoOptimiseStore = true;
    nixPath = [
      "nixpkgs=${pkgs.path}"
    ];

    daemonNiceLevel = 19;
    gc.automatic = true;
    optimise.automatic = true;
    extraOptions = ''
      builders-use-substitutes = true
      experimental-features = flakes nix-command
    '';
  };

  networking.dhcpcd.enable = false;
  networking.networkmanager.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
      font = "Lat2-Terminus16";
      keyMap = "us";
  };
  time.timeZone = "Europe/Riga";

  environment.systemPackages = with pkgs; [ vim git ];

  boot.cleanTmpDir = true;

  services.logind.lidSwitch = "ignore";

  services.xserver = {
    enable = true;
    autorun = true;
    xkbOptions = "caps:escape";

    desktopManager.xterm.enable = true;

    displayManager = {
      autoLogin = {
        enable = true;
        user = config.dotfiles.username;
      };

      lightdm = {
        enable = true;
        greeter.enable = false;
      };
    };
  };

  services.earlyoom = {
    enable = true;
    freeMemThreshold = 5;
  };

  services.printing.enable = true;

  virtualisation.docker = {
      enable = true;
  };

  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
  };
  hardware.opengl.driSupport32Bit = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  documentation.nixos.enable = true;


  users.extraUsers.${config.dotfiles.username} = {
    home = "/home/${config.dotfiles.username}";
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" "video" "docker" "input" ];
    shell = "${pkgs.fish}/bin/fish";
  };

  home-manager.users.${config.dotfiles.username} = args: import ./home.nix (args // { inherit pkgs; });

  system.stateVersion = "20.09";
}
