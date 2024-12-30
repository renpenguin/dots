{ inputs, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    ../../modules/system
    ../../modules/thunar
  ];

  ## System config
  modules.system = {
    boot.enable = true;
    mainUser = {
      enable = true;
      name = "ren";
      home = ./home.nix;
    };
    network = {
      enable = true;
      hostName = "minibox";
    };
    audio.enable = true;
    laptop.enable = true;
    corePackages = {
      enable = true;
      fonts.enable = true;
    };
  };

  services.logind.powerKey = "suspend";
  services.logind.lidSwitch = "ignore";
  hardware.graphics.enable = true;
  security.polkit.enable = true;

  services.openssh.enable = true;
}
