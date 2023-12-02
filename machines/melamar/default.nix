{ lib, pkgs, ... }:
{
  # TODO: make use of home-manager (user, dotfiles, ...)

  services.nix-daemon.enable = true;
  nixpkgs.config.allowUnfree = lib.mkForce true;
  
  programs.zsh.enable = true;

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
