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
      "monitorcontrol"
      "sanesidebuttons"
    ];
  };

  environment.systemPackages = with pkgs; [
    git
    vscode
    jq
    pwgen
    tmux
    neofetch
    neovim
    ripgrep
    direnv
    wget
    iterm2
  ];

}
