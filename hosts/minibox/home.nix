{ pkgs, inputs, ... }: {
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
    ../../rices/light-blue
    ../../modules/kitty
    ../../modules/shell
    ../../modules/neovim
  ];

  home.username = "ren";
  home.homeDirectory = "/home/ren";

  home.stateVersion = "24.05"; # Don't change under any circumstance
  nixpkgs.config.allowUnfreePredicate = _: true;
  programs.home-manager.enable = true; # Let Home Manager install and manage itself.

  home.packages = with pkgs; [
    firefox
    obsidian
    gimp

    gcc rustup python3
  ];
}
