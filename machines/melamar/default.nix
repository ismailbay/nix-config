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
    jq
  ];

}
