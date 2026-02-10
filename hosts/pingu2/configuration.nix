{ inputs, pkgs, ... }: {
  imports = [
    ../../modules/system
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    ../../modules/thunar
  ];

  ## System config
  modules.system = {
    boot.enable = true;
    mainUser = {
      enable = true;
      name = "ren";
      home = ./home.nix;
      extraGroups = [ "video" "dialout" ];
    };
    network = {
      enable = true;
      hostName = "pingu2";
    };
    bluetooth.enable = true;
    audio.enable = true;
    laptop.enable = true;
    printing.enable = true;
    corePackages = {
      enable = true;
      fonts.enable = true;
    };
    fingerprint.enable = true;
  };

  # Login manager
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd start-hyprland";
      user = "greeter";
    };
  };

  programs.hyprland.enable = true;

  # For Steam
  hardware.graphics.enable32Bit = true;
  services.pulseaudio.support32Bit = true;

  services.udev.extraRules = ''
    KERNEL=="ttyACM[0-9]*",MODE="0666"
    ACTION=="add", SUBSYSTEM=="pci", DRIVER=="pcieport", ATTR{power/wakeup}="disabled",
  '';

  services.gnome.gnome-keyring.enable = true;
  # services.fwupd.enable = true; # Framework BIOS updater
  services.openssh.enable = true; # SSH
}
