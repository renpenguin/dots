{ config, pkgs, ... }: {
  # wayland.windowManager.hyprland = {
  #   enable = false;
  #   settings = {};
  # };

  home.packages = with pkgs; [
    # hyprland
    hyprpaper hyprlock hypridle
    xdg-desktop-portal-hyprland
    polkit_gnome
    networkmanagerapplet
    xwaylandvideobridge
    brightnessctl playerctl
    grim slurp hyprpicker jq
    wlogout
    dunst libnotify
    waybar
    wl-clipboard wl-clip-persist wl-clipboard-x11
    fuzzel
    kitty
    adwaita-icon-theme
    hicolor-icon-theme
  ];

  home.file = {
    ".config/hypr".source = ./hypr;
    ".config/waybar".source = ./waybar;
    ".config/wlogout".source = ./wlogout;
    ".config/dunst/dunstrc".source = ./dunstrc;
    ".config/fuzzel/fuzzel.ini".source = ./fuzzel.ini;
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
