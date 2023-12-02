{ inputs, lib, pkgs, ... }:
{
  # TODO: separate using dotfiles/ and users/
  
  services.nix-daemon.enable = true;
  nixpkgs.config.allowUnfree = lib.mkForce true;
  programs.zsh.enable = true;

  users.users.ibay = {
    name = "ibay";
    home = "/Users/ibay";
  };

  home-manager.users.ibay = { pkgs, lib, inputs, config, ... }:
  {
    programs.home-manager.enable = true;
    home.stateVersion = "23.11";

    programs.zsh = {
      enable = true;
      enableAutosuggestions = true;

      oh-my-zsh = {
        enable = true;
        plugins = [
            "git" "vscode" "terraform" "ansible" "kubectl" "gh" "last-working-dir"
        ];
        theme = "steeef";
      };
    };

    programs.kitty = {
      enable = true;
      theme = "Solarized Darcula";
      shellIntegration = {
        enableZshIntegration = true;
      };
    };

    programs.tmux = {
      enable = true;
      sensibleOnTop = false;
      extraConfig = ''
        set -g default-terminal "xterm-256color"
        set -ag terminal-overrides ",xterm-256color:RGB"
        set -g status-keys vi
        set -g set-titles-string ' #{pane_title} '
        set -g mouse on
        set-option -g visual-activity off
        set-option -g visual-bell off
        set-option -g visual-silence off
        set-window-option -g monitor-activity off
        set-option -g bell-action none
      '';
    };
  };
  
  homebrew = {
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };
    enable = true;

    brews = [
      "mas"
    ];
    
    casks = [
      "rectangle"
      "sanesidebuttons"
    ];
  };

  environment.systemPackages = with pkgs; [
    git
    jq
    pwgen
    tmux
    neofetch
    neovim
    ripgrep
    direnv
    wget
    htop
    terraform
    k9s
    zsh
    kitty

    # apps with gui
    monitorcontrol
    iterm2
    vscode
  ];

  system = {
    defaults = {
      finder = {
        FXDefaultSearchScope = "SCcf";
        AppleShowAllExtensions = true;
        FXEnableExtensionChangeWarning = false;
        FXPreferredViewStyle = "Nlsv";
        ShowStatusBar = true;
        ShowPathbar = false;
      };
      dock = {
        tilesize = 48;
        orientation = "left";
      };
      NSGlobalDomain = {
        "com.apple.sound.beep.volume" = 0.000;
        InitialKeyRepeat = 13;
        KeyRepeat = 2;
      };
    };
  };
}
