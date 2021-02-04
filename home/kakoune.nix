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
      kak-lsp
      python-language-server
      haskellPackages.haskell-language-server
    ];

    file.".config/kak/kakrc".source = ../dotfiles/kak/kakrc;
    file.".config/kak/scripts/lf.kak".source = ../dotfiles/kak/scripts/lf.kak;
    file.".config/kak-lsp/kak-lsp.toml".source = ../dotfiles/kak-lsp/kak-lsp.toml;
  };
}
