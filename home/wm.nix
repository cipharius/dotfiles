{ config, pkgs, ... }:
{
  config = {
    xsession = {
      enable = true;
      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
        extraPackages = haskellPackages: [
          haskellPackages.xmonad
          haskellPackages."xmonad-contrib"
          haskellPackages."xmonad-extras"
        ];
      };
    };

    home = {
      packages = with pkgs; [
        playerctl
        light
        xmobar
      ];

      file.".xmonad/xmonad.hs".source = ../dotfiles/xmonad/xmonad.hs;
    };
  };
}
