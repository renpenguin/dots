{ pkgs, lib, config, ... }:

let cfg = config.modules.kitty;

in {
  options.modules.kitty = with lib; {
    enable = mkEnableOption "kitty";
    foreground = mkOption { type = types.str; };
    background = mkOption { type = types.str; };
  };

  config.programs.kitty = {
    enable = cfg.enable;
    shellIntegration.enableZshIntegration = true;
    font = {
      name = "CaskaydiaMono NF";
      package = pkgs.nerd-fonts.caskaydia-mono;
      size = 12;
    };
    settings = {
      enable_audio_bell = false;

      url_color = "#0087bd";
      url_style = "straight";

      foreground = cfg.foreground;
      background = cfg.background;
      background_opacity = 0.9;

      remember_window_size = false;
      initial_window_width = "100c";
      initial_window_height = "32c";
      window_padding_width = 1;

      enabled_layouts = "tall"; 
    };

    keybindings = {
      "alt+up" = "neighbouring_window up";
      "alt+down" = "neighbouring_window down";
      "alt+left" = "neighbouring_window left";
      "alt+right" = "neighbouring_window right";
      "alt+q" = "new_window";
    };

    extraConfig = ''
      mouse_map left click ungrabbed no-op
      mouse_map ctrl+left click ungrabbed mouse_handle_click selection link prompt
    '';
  };
}

