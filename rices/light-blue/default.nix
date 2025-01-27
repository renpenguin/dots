{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    sway
    foot wmenu i3blocks grim
    brightnessctl
    dconf
  ];

  home.file = {
    ".config/sway/config".source = ./sway-config;
    ".config/i3blocks/config".source = ./i3blocks-config;
  };

  gtk = {
    enable = true;
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

    theme.name = "Adwaita-dark";
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    font = {
      name = "Cantarell";
      size = 11;
    };
  };

  # Cursor
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.catppuccin-cursors.macchiatoDark;
    name = "catppuccin-macchiato-dark-cursors";
    size = 24;
  };
}
