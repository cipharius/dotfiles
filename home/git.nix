{ config, pkgs, ... }:

{
  config = {
    home.packages = with pkgs; [
      git-lfs
      gitAndTools.hub
      gitAndTools.gh
    ];

    programs.git = {
      enable = true;
      userName = config.dotfiles.name;
      userEmail = config.dotfiles.email;
      aliases = {
        co = "checkout";
        st = "status -sb";
      };
      delta = {
        enable = true;
      };
      extraConfig = {
        init = {
          defaultBranch = "main";
        };
        "pull" = {
          ff = "only";
        };
        "commit" = {
          verbose = "true";
        };
        "filter \"lfs\"" = {
          process = "git-lfs filter-process";
          required = true;
          clean = "git-lfs clean -- %f";
          smudge = "git-lfs smudge -- %f";
        };
        url = {
          "ssh://git@github.com/" = { insteadOf = https://github.com/; };
        };
        hub = {
          protocol = "git";
        };
        advice = {
          detachedHead = false;
        };
      };
    };
  };
}
