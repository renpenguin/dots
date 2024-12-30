{ pkgs, lib, config, ... }: # Default settings that are to appear on every configuration

with lib;
let cfg = config.system;

in {
  options.system = {
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
    core-packages = {
      enable = mkEnableOption "core-packages";
      fonts.enable = mkEnableOption "fonts";
    };
    fingerprint.enable = mkEnableOption "fingerprint";
  };

  config = mkMerge [
    {
      system.stateVersion = "24.05"; # Do not change under any circumstance
      nix.settings.experimental-features = [ "nix-command" "flakes" ];

      services.automatic-timezoned.enable = true;

      programs.zsh.enable = true;
      users.defaultUserShell = pkgs.zsh;

      programs.neovim.enable = true;
      programs.neovim.defaultEditor = true;
    }

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
      hardware.pulseaudio.extraClientConf = "cookie-file = /tmp/pulse-cookie"; # Remove .pulse-cookie from ~
      environment.systemPackages = [ pkgs.alsa-utils ];
    })

    ## Laptop
    (mkIf cfg.laptop.enable {
      services.power-profiles-daemon.enable = true;
      # services.thermald.enable = true;
      services.logind = if cfg.laptop.ignorePowerKey then { powerKey = "ignore"; } else {};
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
    (mkIf cfg.core-packages.enable {
      environment.systemPackages = with pkgs; [
        killall
        usbutils
        xdg-utils
        unzip
        ffmpeg
      ];

      fonts = mkIf cfg.core-packages.fonts.enable {
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

    (mkIf cfg.fingerprint.enable {
      services.fprintd.enable = true;
      systemd.services.fprintd = {
        wantedBy = [ "multi-user.target" ];
        serviceConfig.Type = "simple";
      };
    })
  ];
}
