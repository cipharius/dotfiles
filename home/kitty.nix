{ config, pkgs, ... }:

{
  config = {
    home.packages = [ pkgs.kitty ];

    home.file.".config/kitty/kitty.conf".source = ../dotfiles/kitty/kitty.conf;
  };
}
