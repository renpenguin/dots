{ pkgs, ... }: {
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "y";
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

  home.packages = with pkgs; [ imv ffmpeg p7zip ];
}
