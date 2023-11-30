{ pkgs, ... }:
{

  services.nix-daemon.enable = true;
  
  programs.zsh.enable = true;

  homebrew = {
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };
    enable = true;
    
    casks = [
      "rectangle"
      "monitorcontrol"
      "sanesidebuttons"
    ];
  };
}
