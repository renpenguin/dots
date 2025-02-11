{ pkgs, ... }: {
  programs.zsh.initExtra = ''source ${./yazisetup.sh}'';

  home.packages = with pkgs; [ imv ffmpeg p7zip ];

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      opener.play = [
        { run = ''${./viv.sh} "$@"''; orphan = true; for = "unix"; }
      ];
    };
    keymap = {
      manager.prepend_keymap = [
        {
          on  = "y";
          run = [ ''shell -- for path in "$@"; do echo "file://$path"; done | wl-copy -t text/uri-list'' "yank" ];
        }
      ];
    };
  };
}
