{ pkgs, inputs, lib, ... }: {
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
    ../../rices/dark-blue
    ../../modules/shell
    ../../modules/yazi
    ../../modules/neovim
    ../../modules/librewolf
  ];

  home.stateVersion = "24.05"; # Don't change under any circumstance
  nixpkgs.config.allowUnfreePredicate = _: true;
  programs.home-manager.enable = true; # Let Home Manager install and manage itself.

  home.packages = with pkgs; [
    obsidian
    blender
    gimp

    gcc cargo rustc python3
    godot_4

    vesktop
    thunderbird
    nextcloud-client

    baobab display3d
    vlc

    obs-studio
    osu-lazer-bin
    steam
    lunar-client prismlauncher
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhsWithPackages (ps: with ps; [ rust-analyzer rustfmt clang-tools ]);
  };

  xdg.desktopEntries = lib.attrsets.genAttrs [
    "nm-connection-editor" "nixos-manual"
    "thunar-volman-settings" "thunar-settings" "thunar-bulk-rename"
  ] (name: {name = ""; noDisplay = true; });
}
