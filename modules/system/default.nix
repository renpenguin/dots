{ pkgs, lib, config, inputs, ... }: # Default settings that are to appear on every configuration

let cfg = config.modules.system;
in with lib; {
  options.modules.system = {
    boot = {
      enable = mkEnableOption "boot";
      kernel = mkOption { type = types.raw; default = pkgs.linuxPackages_latest; };
    };
    mainUser = {
      enable = mkEnableOption "mainUser";
      name = mkOption { type = types.str; };
      extraGroups = mkOption {
        type = types.listOf types.str;
        default = [];
        description = "A main user is added to the wheel, networkmanager (if system.network is enabled) and audio (if system.audio is enabled) groups. You can add more groups here";
      };
      home = mkOption { type = types.path; };
    };
	  network = {
      enable = mkEnableOption "network";
      hostName = mkOption { type = types.str; };
    };
    audio.enable = mkEnableOption "audio";
    laptop = {
      enable = mkEnableOption "laptop";
      ignorePowerKey = mkOption {
        type = types.bool;
        default = true;
      };
    };
    printing.enable = mkEnableOption "printing";
    corePackages = {
      enable = mkEnableOption "corePackages";
      fonts.enable = mkEnableOption "fonts";
    };
    fingerprint.enable = mkEnableOption "fingerprint";
    qmk.enable = mkEnableOption "QMK and Via";
  };

  config = mkMerge [
    {
      system.stateVersion = "24.05"; # Do not change under any circumstance
      nix.settings.experimental-features = [ "nix-command" "flakes" ];

      # services.automatic-timezoned.enable = true;
      time.timeZone = "Europe/London";

      programs.zsh.enable = true;
      users.defaultUserShell = pkgs.zsh;

      programs.neovim.enable = true;
      programs.neovim.defaultEditor = true;
    }

    (mkIf cfg.boot.enable {
      boot.kernelPackages = cfg.boot.kernel;
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      boot.loader.timeout = 0;
      boot.kernelParams = [ "quiet" "loglevel=3" ];
      boot.plymouth.enable = true;
    })

    ## Main user setup
    (mkIf cfg.mainUser.enable {
      users.users."${cfg.mainUser.name}" = {
        isNormalUser = true;
        extraGroups = mkMerge [
          [ "wheel" ]
          (mkIf cfg.network.enable [ "networkmanager" ])
          (mkIf cfg.audio.enable [ "audio" ])
          cfg.mainUser.extraGroups
        ];
      };
      home-manager = {
        extraSpecialArgs = { inherit inputs; };
        users."${cfg.mainUser.name}" = import cfg.mainUser.home;
      };
    })

    ## Network
    (mkIf cfg.network.enable {
      networking.hostName = cfg.network.hostName;
      networking.networkmanager.enable = true;
      systemd.services.NetworkManager-wait-online.enable = false; # Avoid waiting for network on boot
    })

    ## Sound
    (mkIf cfg.audio.enable {
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
      };
      services.pulseaudio.extraClientConf = "cookie-file = /tmp/pulse-cookie"; # Remove .pulse-cookie from ~
      environment.systemPackages = [ pkgs.alsa-utils ];
    })

    ## Laptop
    (mkIf cfg.laptop.enable {
      services.power-profiles-daemon.enable = true;
      # services.thermald.enable = true;
      services.logind = mkIf cfg.laptop.ignorePowerKey { powerKey = "ignore"; };
    })

    ## Printing
    (mkIf cfg.printing.enable {
      services.printing.enable = true;
      services.avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };
    })

    ## Core Packages
    (mkIf cfg.corePackages.enable {
      environment.systemPackages = with pkgs; [
        killall
        usbutils
        xdg-utils
        unzip
        ffmpeg
      ];

      fonts = mkIf cfg.corePackages.fonts.enable {
        packages = with pkgs; [
          cantarell-fonts
          noto-fonts-cjk-sans
          font-awesome
          openmoji-color
          nerd-fonts.caskaydia-cove
          nerd-fonts.caskaydia-mono
        ];

        fontconfig = {
          hinting.autohint = true;
          defaultFonts = {
            emoji = [ "OpenMoji Color" ];
          };
        };
      };
    })

    ## Fingerprint
    (mkIf cfg.fingerprint.enable {
      services.fprintd.enable = true;
      systemd.services.fprintd = {
        wantedBy = [ "multi-user.target" ];
        serviceConfig.Type = "simple";
      };
    })

    ## QMK and Via
    (mkIf cfg.qmk.enable {
      environment.systemPackages = [ pkgs.via ];
      services.udev.packages = [ pkgs.via ];
      hardware.keyboard.qmk.enable = true;
    })
  ];
}
