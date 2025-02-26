{ pkgs, ... }: 
let 
  yazi-plugins = pkgs.fetchFromGitHub {
		owner = "yazi-rs";
		repo = "plugins";
		rev = "8945e543ebbaa25de155b7101a917eba007252f2";
		hash = "sha256-ko/vvItKtQSz5rbP3TMb4R1bywW2q8hj7E/A++vhVqQ=";
	};
in {
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "y";

    settings = {
      opener.play = [
        { run = ''${./viv.sh} "$@"''; orphan = true; for = "unix"; }
      ];
    };

    plugins = {
      chmod = "${yazi-plugins}/chmod.yazi";
      full-border = "${yazi-plugins}/full-border.yazi";
			max-preview = "${yazi-plugins}/max-preview.yazi";
			mount = "${yazi-plugins}/mount.yazi";
			starship = pkgs.fetchFromGitHub {
				owner = "Rolv-Apneseth";
				repo = "starship.yazi";
				rev = "d1cd0a38aa6a2c2e86e62a466f43e415f781031e";
				sha256 = "sha256-XiEsykudwYmwSNDO41b5layP1DqVa89e6Emv9Qf0mz0=";
			};
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
          on = "T";
					run = "plugin max-preview";
					desc = "Maximize or restore the preview pane";
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
