{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";

    enableCompletion = true;
    autosuggestion.enable = false;
    syntaxHighlighting.enable = true;

    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --fast --flake";
      search-packages = "nix repl --expr 'import <nixpkgs>{}'";
      bg-run = "hyprctl dispatch exec --";

      clear = "echo -n '\\e[H\\e[3J'";
      cls   = "clear";
      lst   = "ls -TL2";
      lstn  = "ls -TL";
    };

    initExtra = ''
      setopt auto_pushd
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word
      bindkey '^[[Z' reverse-menu-complete

      autoload -U colors && colors
      PS1="[%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%~%{$reset_color%}]# "
    '';

    history = {
      ignoreDups = true;
      size = 10000;
      path = "$HOME/.cache/zsh_history";
    };

    oh-my-zsh = {
      enable = true;
      plugins = ["git" "thefuck"];
      theme = "robbyrussell";
    };
  };

  home.shellAliases.nixdiff = "${pkgs.nvd}/bin/nvd diff $(\\ls -d1v /nix/var/nix/profiles/system-*-link|tail -n 2)";

  programs.fzf.enable = true;
  programs.thefuck.enable = true;

  programs.ripgrep.enable = true;
  home.shellAliases.grep = "rg";

  programs.bat.enable = true;
  home.shellAliases.cat = "bat";

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    icons = "auto";
  };
  home.shellAliases.ls = "eza -h";

  programs.git = {
    enable = true;
    userName  = "Red Penguin";
    userEmail = "redpenguin777@yahoo.com";
    extraConfig = {
      init.defaultBranch = "master";
      advice.addIgnoredFile = false;
      credential.helper = "manager";
      credential.credentialStore = "cache";
    };
  };
  home.packages = [ pkgs.git-credential-manager ];

  programs.fastfetch.enable = true;
  home.file.".config/fastfetch".source = ./fastfetch;
  home.shellAliases.fetch   = "clear && fastfetch";
  home.shellAliases.minifetch   = "clear && fastfetch --config ${./fastfetch/startup.jsonc}";

  programs.btop = {
    enable = true;
    extraConfig = ''
      color_theme = "tokyo-night";
      theme_background = False
    '';
  };
  xdg.desktopEntries.btop = { name = ""; noDisplay = true; };

  programs.cava.enable = true;
  home.file.".config/cava".source = ./cava;
}
