{ pkgs, ... }: {
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  environment.systemPackages = with pkgs; [ imv file-roller xfce.exo ];

  programs.xfconf.enable = true;

  services.tumbler.enable = true;
  services.gvfs.enable = true;
}
