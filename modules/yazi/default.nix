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

    plugins = with pkgs.yaziPlugins; {
      chmod = chmod;
      full-border = full-border;
			mount = mount;
      starship = starship;
    };

    initLua = ''
			require("full-border"):setup()
      require("starship"):setup()
		'';

    keymap = {
      manager.prepend_keymap = [
        {
          on  = "y";
          run = [ ''shell -- for path in "$@"; do echo "file://$path"; done | wl-copy -t text/uri-list'' "yank" ];
          desc = "Copy file to Wayland clipboard";
        }
        {
          on = "M";
          run = "plugin mount";
          desc = "View drive mounting options";
        }
				{
          on = ["c" "m"];
					run = "plugin chmod";
					desc = "Chmod on selected files";
				}
      ];
    };
  };

  home.packages = with pkgs; [ 
    imv ffmpeg p7zip 
    starship
  ];
}
