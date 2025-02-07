{ pkgs, inputs, lib, ... }: {
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
    ../../rices/dark-blue
    ../../modules/shell
    ../../modules/neovim
    ../../themes/Vesktop
  ];

  home.stateVersion = "24.05"; # Don't change under any circumstance
  nixpkgs.config.allowUnfreePredicate = _: true;
  programs.home-manager.enable = true; # Let Home Manager install and manage itself.

  home.sessionPath = [ "$HOME/.cargo/bin" ];

  home.packages = with pkgs; [
    firefox
    obsidian
    blender
    rustdesk
    gimp

    vscode
    gcc rustup python3
    godot_4

    thunderbird
    synology-drive-client

    baobab
    vlc

    obs-studio
    osu-lazer-bin
    steam
    lunar-client
  ];

  xdg.desktopEntries = lib.attrsets.genAttrs [
    "nm-connection-editor" "nixos-manual"
    "thunar-volman-settings" "thunar-settings" "thunar-bulk-rename"
  ] (name: {name = ""; noDisplay = true; });
}
