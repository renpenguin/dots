{ inputs, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    ../../modules/system
    ../../modules/thunar
  ];

  # Use the systemd-boot EFI boot loader.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 0;
  boot.kernelParams = [ "quiet" "loglevel=3" ];
  boot.plymouth.enable = true;

  services.openssh.enable = true;

  users.users.ren = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "audio" ];
  };
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users."ren" = import ./home.nix;
  };

  hardware.graphics.enable = true;
  security.polkit.enable = true;

  ## System config
  system = {
    network = {
      enable = true;
      hostName = "minibox";
    };
    pipewire.enable = true;
    laptop.enable = true;
    core-packages = {
      enable = true;
      fonts.enable = true;
    };
  };
}

