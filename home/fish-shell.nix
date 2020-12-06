{ config, pkgs, ... }:

{
  config = {
    home.packages = with pkgs; [ fish ];

    home.file.".config/fish/fish_variables".source = ../dotfiles/fish/fish_variables;
    home.file.".config/fish/functions/fish_prompt.fish".source = ../dotfiles/fish/functions/fish_prompt.fish;
    home.file.".config/fish/conf.d/environment.fish".source = ../dotfiles/fish/conf.d/environment.fish;
 };
}
