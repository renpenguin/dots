{ pkgs, inputs, ... }: {
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
    ../../rices/light-blue
    ../../modules/shell
    ../../modules/neovim
  ];

  home.stateVersion = "24.05"; # Don't change under any circumstance
  nixpkgs.config.allowUnfreePredicate = _: true;
  programs.home-manager.enable = true; # Let Home Manager install and manage itself.

  home.packages = with pkgs; [
    gimp
    gcc cargo rustc python3
  ];
}
