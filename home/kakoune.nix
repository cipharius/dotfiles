{ config, pkgs, ... }:

{
  config.home = {
    packages = with pkgs; [ kakoune ];

    file.".config/kak/kakrc".source = ../dotfiles/kak/kakrc;
  };
}
