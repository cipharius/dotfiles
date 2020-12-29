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
        xmobar
        libnotify
      ];

      file.".xmonad/xmonad.hs".source = ../dotfiles/xmonad/xmonad.hs;
    };

    services.dunst = {
      enable = true;
      settings = {
        global = {
          follow = "keyboard";
          geometry = "300x8-0+20";
          indicate_hidden = true;
          shrink = false;
          notification_height = 50;
          separator_height = 1;
          padding = 8;
          horizontal_padding = 8;
          frame_width = 1;
          frame_color = "#dcdccc";
          seperator_color = "frame";
          idle_threshold = 120;
          font = "DejaVu Sans Mono 8";
          line_height = 0;
        };
        urgency_low = {
          background = "#707280";
          foreground = "#707280";
          timeout = 10;
        };
        urgency_normal = {
          background = "#506070";
          foreground = "#ffffff";
          timeout = 10;
        };
        urgency_critical = {
          background = "#cc9393";
          foreground = "#ffffff";
          timeout = 0;
        };
      };
    };
  };
}
