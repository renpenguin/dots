{ inputs, pkgs, ... }: {
  imports = [
    ../../modules/system
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    ../../modules/thunar
  ];

  # Use the systemd-boot EFI boot loader.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 0;
  boot.kernelParams = [ "quiet" "loglevel=3" ];
  boot.plymouth.enable = true;
  services.fwupd.enable = true; # Framework BIOS updater

  ## User
  users.users.ren = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "dialout" ];
  };
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users."ren" = import ./home.nix;
  };

  # Login manager
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
      user = "greeter";
    };
  };

  ## System config
  system = {
    network = {
      enable = true;
      hostName = "pingu2";
    };
    audio.enable = true;
    laptop.enable = true;
    printing.enable = true;
    core-packages = {
      enable = true;
      fonts.enable = true;
    };
    fingerprint.enable = true;
  };

  programs.hyprland.enable = true;

  # For Steam
  hardware.graphics.enable32Bit = true;
  hardware.pulseaudio.support32Bit = true;

  # Allow reading serial
  services.udev.extraRules = ''KERNEL=="ttyACM[0-9]*",MODE="0666"'';

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
}
