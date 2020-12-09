{ config, pkgs, ... }:

{
  config.home = {
    packages = with pkgs; [
      (kakoune.override {
        configure = {
          plugins = [
            kakounePlugins.kak-ansi
            kak-prelude
            kak-connect
          ];
        };
      })
    ];

    file.".config/kak/kakrc".source = ../dotfiles/kak/kakrc;
    file.".config/kak/scripts/lf.kak".source = ../dotfiles/kak/scripts/lf.kak;
  };
}
