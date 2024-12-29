{ inputs, pkgs, ... }: {
  imports = [
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

  networking.hostName = "pingu2";
  networking.networkmanager.enable = true;
  systemd.services.NetworkManager-wait-online.enable = false; # Avoid waiting for network on boot

  services.udev.extraRules = ''KERNEL=="ttyACM[0-9]*",MODE="0666"''; # Allow reading serial

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "24.05"; # Do not change under any circumstance

  time.timeZone = "Europe/London";

  # User
  users.users.ren = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "dialout" ];
  };
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "ren" = import ./home.nix;
    };
  };

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;

  programs.hyprland.enable = true;

  # Core packages
  environment.systemPackages = with pkgs; [
    killall
    alsa-utils
    usbutils
    xdg-utils
    unzip
    ffmpeg

    adwaita-icon-theme
    hicolor-icon-theme
  ];

  # For Steam
  hardware.graphics.enable32Bit = true;
  hardware.pulseaudio.support32Bit = true;

  fonts.packages = with pkgs; [
    nerd-fonts.caskaydia-cove
    nerd-fonts.caskaydia-mono
    cantarell-fonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    cantarell-fonts
    font-awesome
    fira-code
    fira-code-symbols
  ];

  # Sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  hardware.pulseaudio.enable = false;

  # Fingerprint
  systemd.services.fprintd = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "simple";
  };
  services.fprintd.enable = true;

  # Login manager
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
      user = "greeter";
    };
  };

  # Printing
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Laptop
  services.power-profiles-daemon.enable = true;
  # services.thermald.enable = true;

  services.logind.powerKey = "ignore";

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
}
