{ lib, pkgs, ... }:
{

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

}
