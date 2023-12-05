{
  inputs,
  lib,
  pkgs,
  ...
}: {
  # TODO: separate using dotfiles/ and users/

  services.nix-daemon.enable = true;
  nixpkgs.config.allowUnfree = lib.mkForce true;
  programs.zsh.enable = true;

  users.users.ibay = {
    name = "ibay";
    home = "/Users/ibay";
  };

  home-manager.users.ibay = {
    pkgs,
    lib,
    inputs,
    config,
    ...
  }: {
    programs.home-manager.enable = true;
    home.stateVersion = "23.11";

    fonts.fontconfig = {
      enable = true;
    };

    programs.zsh = {
      enable = true;
      enableAutosuggestions = true;

      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "vscode"
          "terraform"
          "ansible"
          "kubectl"
          "gh"
          "last-working-dir"
        ];
      };
    };

    programs.kitty = {
      enable = true;
      theme = "Solarized Darcula";
      shellIntegration = {
        enableZshIntegration = true;
      };
      extraConfig = ''
        adjust_line_height 105%
        font_family FiraCode
        font_size 14.0
        confirm_os_window_close 0
      '';
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

    programs.direnv = {
      enable = true;
    };

    programs.git = {
      enable = true;
      userName = "Ismail Bay";
      userEmail = "ismailbay@gmail.com";
    };

    programs.starship = {
      enable = true;

      settings = {
        add_newline = false;
        battery.disabled = true;
        kubernetes.disabled = false;
      };
    };

    home.packages = [
      (pkgs.nerdfonts.override {
        fonts = [
          "FiraCode"
          "JetBrainsMono"
          "DroidSansMono"
          "SpaceMono"
          "RobotoMono"
          "BitstreamVeraSansMono"
        ];
      })
    ];
  };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };

    brews = [
      "mas"
    ];

    casks = [
      "rectangle"
      "sanesidebuttons"
      "intellij-idea-ce"
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
    kubectl
    k9s
    zsh
    kitty
    pre-commit
    alejandra
    go-task
    ansible
    sops
    kubeseal
    kustomize
    kubernetes-helm

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
