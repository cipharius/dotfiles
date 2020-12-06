{ config, pkgs, ... }:

{
  config = {
    home = {
      packages = [ pkgs.qutebrowser ];

      file.".config/qutebrowser/config.py".source = ../dotfiles/qutebrowser/config.py;
    };
  };
}
